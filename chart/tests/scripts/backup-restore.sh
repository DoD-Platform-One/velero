#!/bin/bash
set -e

# DEBUG
set -x
trap 'echo ❌ exit at ${0}:${LINENO}, command was: ${BASH_COMMAND} 1>&2' ERR

RETRY_COUNT=40       # Number of retry attempts
RETRY_DELAY=3       # Delay (in seconds) between retries
CONNECT_TIMEOUT=120   # Maximum time (in seconds) to wait for a connection
RETRY_MAX_TIME=120   # Maximum total time (in seconds) for retries

# Variables used for logic to wait for backup storage location to be available
BSL_RETRY_COUNT=0
BSL_RETRY_MAX=20
BSL_RETRY_DELAY=5
BSL_STATUS=""

echo "Setup 1: Ensuring MinIO endpoint up and available"
if curl --retry $RETRY_COUNT \
        --retry-delay $RETRY_DELAY \
        --retry-connrefused \
        --connect-timeout $CONNECT_TIMEOUT \
        --max-time $RETRY_MAX_TIME \
        -sIS "$MINIO_HOST" &>/dev/null; then
  echo "Setup 1 Success: MinIO is up."
else
  echo "Setup 1 Failure: Cannot hit MinIO endpoint after $RETRY_COUNT attempts."
  echo "Debug information (curl response):"
  curl -v "${MINIO_HOST}"
  exit 1
fi
echo "Setup 1 Success: MinIO is up."

echo "Setup 2: Create MinIO Bucket"
attempt_counter=0
max_attempts=25
until [ $(mc alias set test ${MINIO_HOST} ${MINIO_USER} ${MINIO_PASS} >/dev/null; echo $?) -eq 0 ]; do
  if [ ${attempt_counter} -eq ${max_attempts} ];then
    echo "Setup 2 Failure: Failed to Create MinIO Bucket"
    exit 1
  fi
  attempt_counter=$(($attempt_counter+1))
  sleep 10
done

if [ $(mc ls test/velero >/dev/null; echo $?) -eq 0 ]; then
  echo "Setup 2 Success: MinIO Bucket Exists..Removing existing bucket"
  mc rb --force test/velero || true
fi

mc mb test/velero
mc anonymous set public test/velero
echo "Setup 2 Success: MinIO Bucket Created"

echo "Waiting for BackupStorageLocation 'default' to become available..."

until [ "$BSL_STATUS" == "Available" ]; do
    BSL_RETRY_COUNT=$((BSL_RETRY_COUNT+1))

    if [ $BSL_RETRY_COUNT -gt $BSL_RETRY_MAX ]; then
        echo "❌ Error: Timed out waiting for BSL 'default' to become Available."
        
        # Get the final error message from the BSL
        echo "Previous BSL status:"
        kubectl get bsl default -n $NAMESPACE -o yaml | grep "message:"
        
        # Exit the script with an error
        exit 1
    fi
    
    # Query the .status.phase field.
    # We add '|| true' to prevent the script from exiting if the 'get' command
    # fails (e.g., if the BSL hasn't been created yet).
    BSL_STATUS=$(kubectl get bsl default -n $NAMESPACE -o jsonpath='{.status.phase}' 2>/dev/null || true)

    sleep $BSL_RETRY_DELAY
done

echo "Success: BackupStorageLocation 'default' is Available."

echo "Setup 3: Creating test pod"
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: velero-backup-restore-test
  namespace: $NAMESPACE
  labels:
    app: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
      annotations:
        sidecar.istio.io/inject: "false"
    spec:
      volumes:
        - name: nginx-logs
          persistentVolumeClaim:
            claimName: nginx-logs
      imagePullSecrets:
        - name: private-registry
      containers:
        - image: registry1.dso.mil/ironbank/opensource/nginx/nginx:1.29.3
          name: nginx
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: "/var/log/nginx"
              name: nginx-logs
              readOnly: false
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: nginx-logs
  namespace: $NAMESPACE
  labels:
    app: nginx
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 50Mi
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app: nginx
  name: my-nginx
  namespace: $NAMESPACE
spec:
  ports:
  - port: 80
    targetPort: 8080
  selector:
    app: nginx
EOF
echo "Setup 3 Success: Test pod created."

echo "Waiting for pods to become available"
kubectl wait --for=condition=available --timeout 600s -n $NAMESPACE deployment --all
kubectl wait --for=condition=ready --timeout 600s -n $NAMESPACE pods --all --field-selector status.phase=Running
echo "Pods deployed"

echo "Test 1: Create backup."
echo "Cleaning up test backups"
velero delete backup test-backup -n $NAMESPACE --confirm || true
kubectl delete --wait --timeout 10s -n $NAMESPACE Backup/test-backup || true
kubectl delete --wait --timeout 10s -n $NAMESPACE Restores/test-backup || true
echo "Waiting 15 seconds for delete to complete"
sleep 15

kubectl get bsl -n $NAMESPACE -o yaml
echo "Creating Backup"
velero backup create test-backup --namespace $NAMESPACE --wait --selector app=nginx --include-namespaces $NAMESPACE || export BACKUP_FAILED="true"

velero backup describe test-backup -n $NAMESPACE || true
velero backup logs test-backup -n $NAMESPACE  || true

if [[ ${BACKUP_FAILED} == "true" ]]; then
  echo "Test 1 Failure: Cannot create backup."
  echo "Printing backup describe:"
  velero backup describe test-backup -n $NAMESPACE
  echo "Printing logs from backup create:"
  velero backup logs test-backup -n $NAMESPACE
  exit 1
fi

# Use Scheduled backup to test backup creation
if [[ ${SCHEDULED_TESTS} == "true" ]]; then 
  velero backup create --from-schedule $SCHEDULED_BACKUP_NAME --wait || export BACKUP_FAILED="true"
  if [[ ${BACKUP_FAILED} == "true" ]]; then
    echo "Test 1 Failure: Cannot create scheduled backup."
    echo "Printing scheduled backup describe:"
    velero backup describe test-backup -n $NAMESPACE
    echo "Printing logs from scheduled backup create:"
    velero backup logs test-backup -n $NAMESPACE
    exit 1
  fi
fi

echo "Test 1 Success: Created backup and backup from schedule."

echo "State before disaster:"
kubectl get all -n $NAMESPACE

echo "Setup 3: Simulate disaster. Deleteing pod."
kubectl delete --wait --timeout 30s deployment velero-backup-restore-test -n $NAMESPACE || export DELETE_FAILED="true"
kubectl delete --wait --timeout 30s persistentvolumeclaim nginx-logs -n $NAMESPACE || export DELETE_FAILED="true"
kubectl delete --wait --timeout 30s service my-nginx  -n $NAMESPACE || export DELETE_FAILED="true"
if [[ ${DELETE_FAILED} == "true" ]]; then
  echo "Setup 3 Failure: Could not delete test resources."
  exit 1
fi
echo "Setup 3 Success: Deleted all test resources."

echo "Test 2: Test restore capacity"
echo "Clearing out restores"
velero delete restore test-backup -n $NAMESPACE --confirm || true
echo "Creating restore"
velero restore create test-backup --from-backup test-backup --wait -n $NAMESPACE --selector app=nginx || export RESTORE_FAILED="true"
if [[ ${RESTORE_FAILED} == "true" ]]; then
  echo "Test 2 Failure: Could not restore from backup."
  exit 1
fi
echo "Test 2 Success: Restored pod and NS."

velero restore describe test-backup -n $NAMESPACE || true
velero restore logs test-backup -n $NAMESPACE  || true

echo "Printing State after restore"
kubectl get all -n $NAMESPACE

echo "Waiting for pods to become available"
kubectl wait --for=condition=available --timeout 600s -n $NAMESPACE deployment --all
kubectl wait --for=condition=ready --timeout 600s -n $NAMESPACE pods --all --field-selector status.phase=Running
echo "Pods deployed"

echo "Test 3: Ensure backup restored pods"
export NGINX_URL="http://my-nginx"
if curl --retry $RETRY_COUNT \
        --retry-delay $RETRY_DELAY \
        --retry-connrefused \
        --connect-timeout $CONNECT_TIMEOUT \
        --max-time $RETRY_MAX_TIME \
        -sIS "$NGINX_URL" &>/dev/null; then
  echo "Test 3: Recieved response from NGINX"
else
  echo "Test 3 Failure: Cannot hit NGINX endpoint after $RETRY_COUNT attempts."
  echo "Debug information (curl response):"
  curl -v "${NGINX_URL}"
  exit 1
fi

echo "Removing test resources"
mc rb --force test/velero || true
kubectl delete --wait --timeout 10s -n $NAMESPACE Backup/test-backup || true
kubectl delete --wait --timeout 10s -n $NAMESPACE Restores/test-backup || true
kubectl delete --wait --timeout 30s deployment velero-backup-restore-test -n $NAMESPACE || true
kubectl delete --wait --timeout 30s persistentvolumeclaim nginx-logs -n $NAMESPACE || true
kubectl delete --wait --timeout 30s service my-nginx  -n $NAMESPACE || true
