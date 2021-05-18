#!/bin/bash
set -e

# need to add specifics and urls
echo "Setup 1: Ensuring MinIO endpoint up and available"
curl -sIS "${MINIO_HOST}" &>/dev/null || export MINIO_DOWN="true"
if [[ ${MINIO_DOWN} == "true" ]]; then
  echo "Setup 1 Failure: Cannot hit MINIO endpoint."
  echo "Debug information (curl response):"
  echo $(curl "${MINIO_HOST}")
  exit 1
fi
echo "Setup 1 Success: MinIO is up is up."

echo "Setup 2: Creating test pod"
kubectl apply -f $TEST_YAML_DIR/ || export KUBECTL_APPLY_FAIL="true"
if [[ ${MINIO_DOWN} == "true" ]]; then
  echo "Setup 2 Failure: Cannot apply pods."
  echo "Debug information:"
  echo $(kubectl apply -f $TEST_YAML_DIR/)
  exit 1
fi
echo "Setup 2 Success: Test pod created."

echo "Waiting for pods to become available"
kubectl wait --for=condition=available --timeout 600s -A deployment --all
kubectl wait --for=condition=ready --timeout 600s -A pods --all --field-selector status.phase=Running
echo "Pods deployed"


echo "Test 1: Create backup."
echo "Cleaning up test backups"
velero delete backup test-backup -n $NAMESPACE --confirm || true
echo "Creating Backup"
velero backup create test-backup --namespace $NAMESPACE --wait --selector app=nginx || export BACKUP_FAILED="true"
if [[ ${BACKUP_FAILED} == "true" ]]; then
  echo "Test 1 Failure: Cannot create backup."
  exit 1
fi
echo "Test 1 Success: Created backup."

echo "Printing backup describe:"
echo $(velero backup describe test-backup -n $NAMESPACE)
echo "Printing logs from backup create:"
echo $(velero backup logs test-backup -n $NAMESPACE)

echo "State before disaster:"
echo -e $(kubectl get all -n $NAMESPACE)

echo "Nginx Logs:"
echo $(kubectl logs --selector app=nginx -n $NAMESPACE)

echo "Setup 3: Simulate disaster. Deleteing pod."
kubectl delete -f $TEST_YAML_DIR/ || export DELETE_FAILED="true"
if [[ ${DELETE_FAILED} == "true" ]]; then
  echo "Setup 3 Failure: Could not delete pod."
  echo "Debug information (kubectl response):"
  echo $(kubectl delete -f $TEST_YAML_DIR/)
  exit 1
fi
echo "Setup 3 Success: Deleted pod and NS."

echo "Test 2: Test restore capacity"
echo "Clearing out restores"
velero delete restore test-backup -n $NAMESPACE --confirm || true
echo "Creating restore"
velero restore create test-backup --from-backup test-backup --wait -n $NAMESPACE  || export RESTORE_FAILED="true"
if [[ ${RESTORE_FAILED} == "true" ]]; then
  echo "Test 2 Failure: Could not restore from backup."
  echo "Debug information (velero response):"
  echo $(velero restore create test-backup --from-backup test-backup --wait -n $NAMESPACE --logtostderr  )
  exit 1
fi
echo "Test 2 Success: Restored pod and NS."

echo "Printing State after restore"
echo -e $(kubectl get all -n $NAMESPACE)

echo "Waiting for pods to become available"
kubectl wait --for=condition=available --timeout 600s -A deployment --all
kubectl wait --for=condition=ready --timeout 600s -A pods --all --field-selector status.phase=Running
echo "Pods deployed"

echo "Test 3: Ensure backup restored pods"
export NGINX_URL="http://my-nginx.${NAMESPACE}.svc"
response=$(curl $NGINX_URL) || export RESTORE_FAILED="true" 
if [[ ${RESTORE_FAILED} == "true" ]]; then
  echo "Test 3 Failure: Could not hit endpoint."
  echo "Debug information (curl response):"
  echo $response
  exit 1
fi
echo "Test 3: Recieved response"
