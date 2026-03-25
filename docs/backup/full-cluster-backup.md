# **Full cluster backup and restore**

With velero , you are able to do a full disaster recovery.  In this case backing up a cluster and restoring all the api objects and associated volumes. 

Before doing a cluster migration with velero please consider the following 

* The cluster versions MUST match 
* The velero server versions MUST match 
* In the case of Bigbang , the flux versions MUST match 
* Ideally , the cloud providers should match , however velero is able to do cross cloud provider migration with [restic](https://velero.io/docs/v1.6/restic/#docs). Note however that support is in beta.

With these caveats in mind , we can proceed with the cluster migration. 

At a high level the steps are;

*    Backup the source cluster 
        *  exclude the following namespaces [ kube-system,flux,velero]
*    Copy the secret used by the velero account into a file 
        * This secret is used to enable connection for the new cluster to the bucket used to store backups 
*    Create a shell cluster with only the velero server and flux installed 
* Create a [BackupStorageLocation](https://velero.io/docs/v1.6/api-types/backupstoragelocation/) and [VolumeSnapshotLocation](https://velero.io/docs/v1.6/api-types/volumesnapshotlocation/) crd in the destination cluster that points to the same location as the source cluster. 
* Confirm that the destination cluster can see the backups created by the source cluster. 
* Initiate a restore on the destination cluster. 
* Perform validation and ensure that objects restored and are running correctly. 

### **Before we begin**

We are going to be using two clusters for the migration. 
```ubuntu@ip-172-31-32-130:~$ kubectl config get-contexts
CURRENT   NAME                                            CLUSTER               AUTHINFO                    NAMESPACE
        dr-dogfood-admin@dr-dogfood                     dr-dogfood            dr-dogfood-admin
          integration-dogfood-admin@integration-dogfood   integration-dogfood   integration-dogfood-admin   velero 
```
We have a source cluster `integration-dogfood` and a destination cluster `dr-dogfood`. 

Both clusters are on the same version  

```
ubuntu@ip-172-31-32-130:~$ ktx integration-dogfood-admin@integration-dogfood
Switched to context "integration-dogfood-admin@integration-dogfood".
ubuntu@ip-172-31-32-130:~$ kubectl version --short
Client Version: v1.19.0
Server Version: v1.20.6
ubuntu@ip-172-31-32-130:~$ ktx dr-dogfood-admin@dr-dogfood
Switched to context "dr-dogfood-admin@dr-dogfood".
ubuntu@ip-172-31-32-130:~$ kubectl version --short
Client Version: v1.19.0
Server Version: v1.20.6
```

We confirm the image versions of velero in both clusters 
```
ubuntu@ip-172-31-32-130:~$ kubectl get pods -n velero -o jsonpath="{.items[*].spec.containers[*].image}" |tr -s '[[:space:]]' '\n' |sort |uniq -c
      1 registry1.dso.mil/ironbank/opensource/istio/proxyv2:1.9.8
      1 registry1.dso.mil/ironbank/opensource/velero/velero:v1.6.2
      1 velero/velero:v1.6.3
ubuntu@ip-172-31-32-130:~$ ktx integration-dogfood-admin@integration-dogfood
Switched to context "integration-dogfood-admin@integration-dogfood".
ubuntu@ip-172-31-32-130:~$ kubectl get pods -n velero -o jsonpath="{.items[*].spec.containers[*].image}" |tr -s '[[:space:]]' '\n' |sort |uniq -c
      1 registry1.dso.mil/ironbank/opensource/istio/proxyv2:1.9.8
      1 registry1.dso.mil/ironbank/opensource/velero/velero:v1.6.2
```

We also compare the the versions of flux in both clusters 
```
ubuntu@ip-172-31-32-130:~$ ktx integration-dogfood-admin@integration-dogfood
Switched to context "integration-dogfood-admin@integration-dogfood".
ubuntu@ip-172-31-32-130:~$ kubectl get pods -n flux-system  -o jsonpath="{.items[*].spec.containers[*].image}" |tr -s '[[:space:]]' '\n' |sort |uniq -c
      1 registry1.dso.mil/ironbank/fluxcd/helm-controller:v0.11.0
      1 registry1.dso.mil/ironbank/fluxcd/kustomize-controller:v0.13.0
      1 registry1.dso.mil/ironbank/fluxcd/notification-controller:v0.15.0
      1 registry1.dso.mil/ironbank/fluxcd/source-controller:v0.14.0
ubuntu@ip-172-31-32-130:~$ ktx dr-dogfood-admin@dr-dogfood
Switched to context "dr-dogfood-admin@dr-dogfood".
ubuntu@ip-172-31-32-130:~$ kubectl get pods -n flux-system  -o jsonpath="{.items[*].spec.containers[*].image}" |tr -s '[[:space:]]' '\n' |sort |uniq -c
      1 registry1.dso.mil/ironbank/fluxcd/helm-controller:v0.11.0
      1 registry1.dso.mil/ironbank/fluxcd/kustomize-controller:v0.13.0
      1 registry1.dso.mil/ironbank/fluxcd/notification-controller:v0.15.0
      1 registry1.dso.mil/ironbank/fluxcd/source-controller:v0.14.0
```

Both clusters are deployed in AWS using [Konvoy](https://archive-docs-old.d2iq.com/dkp/konvoy/2.2/choose-infrastructure/aws/quick-start-aws/). 

Now that we have satisfied the pre reqs we can go ahead with the migration. 

## Back up the source cluster 

We assume here that you have a source cluster with velero up and running with credentials that enable it connect to a bucket which will contain the backups 

* To create a full backup on the source cluster (integration-dogfood), we will run the command 
```
velero backup create flux-exclude-namespace --exclude-namespaces=kube-system,flux-system,velero,default --storage-location mybackupstoragelocation
```

In this command, we are exluding the kube-system,flux , velero and default namespaces. You can exclude any namespaces by adding it to the comma separated list. 

To confirm the backup succeeded , run the command 
`velero backup get $backupname`

```
ubuntu@ip-172-31-32-130:~$ velero backup get flux-exclude-namespace
NAME                     STATUS      ERRORS   WARNINGS   CREATED                         EXPIRES   STORAGE LOCATION          SELECTOR
flux-exclude-namespace   Completed   0        0          2021-09-28 15:08:19 +0000 UTC   27d       mybackupstoragelocation   <none>
```

The important things to look out for are "STATUS" and "ERRORS' , this tells you if the backup was successful or not.  You should see a status of "Completed" with no errors before proceeding.  

### Copy secret from source cluster 

Velero uses a secret to containing credentials to access the bucet containing backups. This secret will be needed by the destination cluster cluster 

```
ubuntu@ip-172-31-32-130:~$ k get secret -n velero velero-iam --template={{.data.cloud}} | base64 -d > velcreds.txt
ubuntu@ip-172-31-32-130:~$ cat velcreds.txt
[default]
aws_access_key_id=RANDOMNUMBERS
aws_secret_access_key=EVENMORERANDOMNUMBERSMASHEDTOGETHER
```
The text file containing the creds will be used to create a secret in the destination cluster (dr-dogfood).

### Install Velero and create a backup storage location 

Earlier , we made the assumption that velero had already been installed in the destnation cluster. However , for completeness , you can run this command to install velero in the destination cluster 
```
velero install --provider aws --plugins velero/velero-plugin-for-aws --bucket bbotest  --backup-location-config region=us-gov-west-1 --snapshot-location-config region=us-gov-west-1 --secret-file velcreds.txt
```
Where bucket is the storage bucket referenced by the source cluster, region is the region where the bucket is located , and the secret file is the name of the file we created from exporting the secret. 

If successfully installed , you should see a secret in the destination cluster called "cloud-credentials" which contains the credentials needed to access the bucket containing backups. 

### Create a backup and Storage location that points to the source

As mentioned earlier , we have to create on the destination cluster , 2 crds - [BackupStorageLocation](https://velero.io/docs/v1.6/api-types/backupstoragelocation/) and [VolumeSnapshotLocation](https://velero.io/docs/v1.6/api-types/volumesnapshotlocation/) which  point to the same location as the source cluster. 

The following manifests need to be created 

#### crds

<details><summary>BackupStorageLocation</summary>
<p>

```yaml
apiVersion: velero.io/v1
kind: BackupStorageLocation
metadata:
  name: mybackupstoragelocation
  namespace: velero
spec:
  backupSyncPeriod: 2m0s
  provider: aws
  objectStorage:
    bucket: bbotest
  credential:
    name: cloud-credentials
    key: cloud
  config:
    region: us-gov-west-1
    profile: "default"
```

</p>
</details>

The `name` should match the `storagelocation` in the source cluster. The `provider` should be the same , the `bucket` should be the same `bucket`  referenced by the source cluster. The `credential` section should reference the secret created in the destantion cluster and the `key` containing the credentials values. The `profile` should be the same profile referenced in the secret. 

<details><summary>VolumeSnapshotLocation</summary>
<p>

```yaml
apiVersion: velero.io/v1
kind: VolumeSnapshotLocation
metadata:
  name: myvolumesnapshotlocation
  namespace: velero
spec:
  provider: aws
  config:
    region: us-gov-west-1
    profile: "default"

```

</p>
</details>

The volume snapshot object references a `provider` , `region` and `profile` which shuld match what is in the source cluster. 

Confirm that the destination cluster can see the backup AND snapshot locations configured in the source. 

```
ubuntu@ip-172-31-32-130:~$ velero  get backup-location
NAME                      PROVIDER   BUCKET/PREFIX   PHASE       LAST VALIDATED                  ACCESS MODE   DEFAULT
mybackupstoragelocation   aws        bbotest         Available   2021-10-01 17:31:44 +0000 UTC   ReadWrite
ubuntu@ip-172-31-32-130:~$ velero get snapshot-location
NAME                       PROVIDER
myvolumesnapshotlocation   aws
ubuntu@ip-172-31-32-130:~$ ktx
Switched to context "dr-dogfood-admin@dr-dogfood".
ubuntu@ip-172-31-32-130:~$ velero get snapshot-location
NAME                       PROVIDER
default                    aws
myvolumesnapshotlocation   aws
ubuntu@ip-172-31-32-130:~$ velero  get backup-location
NAME                      PROVIDER   BUCKET/PREFIX   PHASE       LAST VALIDATED                  ACCESS MODE   DEFAULT
default                   aws        bbotest         Available   2021-10-01 17:32:57 +0000 UTC   ReadWrite     true
mybackupstoragelocation   aws        bbotest         Available   2021-10-01 17:32:57 +0000 UTC   ReadWrite
ubuntu@ip-172-31-32-130:~$
```

From the output we can see that the destination cluster can see the backup location and the  snapshot location.  One final check is to query for backups from the destination cluster. 

```
ubuntu@ip-172-31-32-130:~$ ktx dr-dogfood-admin@dr-dogfood
Switched to context "dr-dogfood-admin@dr-dogfood".
ubuntu@ip-172-31-32-130:~$ velero backup get
NAME                               STATUS      ERRORS   WARNINGS   CREATED                         EXPIRES   STORAGE LOCATION          SELECTOR
flux-exclude-namespace             Completed   0        0          2021-09-28 15:08:19 +0000 UTC   26d       default                   <none>
flux-system                        Completed   0        0          2021-09-28 13:35:07 +0000 UTC   26d       default                   <none>
gitbackup                          Completed   0        0          2021-09-29 23:44:07 +0000 UTC   28d       default                   application=gitlab
mybackup                           Completed   0        0          2021-09-29 23:22:40 +0000 UTC   28d       mybackupstoragelocation   <none>
stest-20210926225855               Completed   0        0          2021-09-26 22:58:55 +0000 UTC   25d       default                   <none>
```

From the output you can see that the destination cluster has access to all the backups taken by the source cluster and as such can perform a restore using any of them. 

### **Initiate a restore**
The next step is to initate a restore on the destination cluster. 

```
velero restore create  flux-test  --from-backup flux-exclude-namespace
```

This will initiate a restore called `flux-test` using the `flux-exclude-namespace`  created from the source cluster.

### **Validate the installation**

Run some basic checks and validate the installation 

<details><summary>Pod Validation </summary>
<p>

```
kubectl get pods --all-namespaces -o json  | jq -r '.items[] | select(.status.phase = "Ready" or ([ .status.conditions[] | select(.type == "Ready") ] | length ) == 1 ) | .metadata.namespace + "/" + .metadata.name'
anchore/anchore-anchore-engine-analyzer-948bf69c5-j4p9b
anchore/anchore-anchore-engine-analyzer-948bf69c5-stbj5
anchore/anchore-anchore-engine-api-846ff78b8d-ft42h
anchore/anchore-anchore-engine-catalog-85f7f56d84-t5qbg
anchore/anchore-anchore-engine-policy-776fcf87d6-mf2pk
anchore/anchore-anchore-engine-simplequeue-546f96dc9f-wspdp
anchore/anchore-engine-upgrade-56gck
anchore/anchore-postgresql-6cc688ff54-mv9xt
argocd/argocd-argocd-application-controller-55649bc89b-v8srw
argocd/argocd-argocd-dex-server-d5888f96f-2hc5j
argocd/argocd-argocd-redis-bb-master-0
argocd/argocd-argocd-redis-bb-replicas-0
argocd/argocd-argocd-redis-bb-replicas-1
argocd/argocd-argocd-repo-server-668b778d94-2x6g2
argocd/argocd-argocd-server-84db64f469-ksmzb
argocd/redis-clean-upgrade-xnn55
ebscsiprovisioner/ebs-csi-controller-5757494575-62jjb
ebscsiprovisioner/ebs-csi-controller-5757494575-sknld
ebscsiprovisioner/ebs-csi-node-552hx
ebscsiprovisioner/ebs-csi-node-mxnr4
ebscsiprovisioner/ebs-csi-node-pkz7c
ebscsiprovisioner/ebs-csi-node-qnb2g
eck-operator/elastic-operator-0
flux-system/helm-controller-66cd66c8c5-7mxwr
flux-system/kustomize-controller-7b87fdd54f-lprqb
flux-system/notification-controller-585cd4cd84-xpn6z
flux-system/source-controller-5995bc4d45-5k2gh
gatekeeper-system/gatekeeper-audit-544674965b-4bfph
gatekeeper-system/gatekeeper-controller-manager-767b76448f-ckbvv
gatekeeper-system/gatekeeper-controller-manager-767b76448f-hxh9t
gatekeeper-system/gatekeeper-controller-manager-767b76448f-rzm4k
gitlab/gitlab-gitaly-0
gitlab/gitlab-gitlab-exporter-9945f54d7-cqsvp
gitlab/gitlab-gitlab-shell-67cc5789bd-55zml
gitlab/gitlab-gitlab-shell-67cc5789bd-jh2vc
gitlab/gitlab-migrations-2-kb5qn
gitlab/gitlab-minio-57d656bcc6-qphlf
gitlab/gitlab-minio-create-buckets-2-fx6cc
gitlab/gitlab-postgresql-0
gitlab/gitlab-redis-master-0
gitlab/gitlab-registry-548454b7c-4dmwm
gitlab/gitlab-registry-548454b7c-5nsml
gitlab/gitlab-runner-gitlab-runner-db7bbb6d4-5llml
gitlab/gitlab-sidekiq-all-in-1-v1-d85c5c557-vzbss
gitlab/gitlab-task-runner-688f85db85-qzhck
gitlab/gitlab-webservice-default-6598cfd455-7wkh8
gitlab/gitlab-webservice-default-6598cfd455-bxrn8
istio-operator/istio-operator-86b75869d7-74rpj
istio-system/istiod-754799c557-bm9xb
istio-system/public-ingressgateway-5784bc5f9c-p5vpl
jaeger/jaeger-69799db98-vz56s
jaeger/jaeger-jaeger-jaeger-operator-76f99ff6f4-nwdsv
kiali/bb-kiali-kiali-svc-patch-qkrqb
kiali/kiali-f888478b6-mvw72
kiali/kiali-kiali-kiali-operator-85d9cd8df8-nmpqq
konvoy/auto-provisioning-cm-6d477ccd99-4vbqq
konvoy/auto-provisioning-tfcb-694f68b69d-fpld5
konvoy/auto-provisioning-webhook-fc4c69798-nk5fb
kube-system/calico-kube-controllers-5c4bc597f-rdjqp
kube-system/calico-node-4xmv4
kube-system/calico-node-98hzr
kube-system/calico-node-ct6zh
kube-system/calico-node-f8w9n
kube-system/calico-node-sc8z7
kube-system/coredns-74ff55c5b-b85zt
kube-system/coredns-74ff55c5b-stpth
kube-system/etcd-ip-10-0-194-151.us-gov-west-1.compute.internal
kube-system/kube-apiserver-ip-10-0-194-151.us-gov-west-1.compute.internal
kube-system/kube-controller-manager-ip-10-0-194-151.us-gov-west-1.compute.internal
kube-system/kube-proxy-482lq
kube-system/kube-proxy-4ndhq
kube-system/kube-proxy-m6q4c
kube-system/kube-proxy-mtwc5
kube-system/kube-proxy-wncgh
kube-system/kube-scheduler-ip-10-0-194-151.us-gov-west-1.compute.internal
kubeaddons/kubeaddons-controller-manager-558b96466c-h89wn
logging/bb-logging-ek-upgrade-mb6ct
logging/logging-ek-es-data-0
logging/logging-ek-es-master-0
logging/logging-ek-kb-7dd8f7d79-6hcqp
logging/logging-ek-kb-7dd8f7d79-95rww
logging/logging-ek-kb-7dd8f7d79-ht4ql
logging/logging-fluent-bit-8cwh2
logging/logging-fluent-bit-nrfxx
logging/logging-fluent-bit-rhss5
logging/logging-fluent-bit-ts448
logging/opa-collector-565754766c-84jm9
mattermost-operator/mattermost-operator-59d8b4c8d-nx4qt
minio-operator/minio-operator-566597bcff-zbwjs
monitoring/alertmanager-monitoring-monitoring-kube-alertmanager-0
monitoring/monitoring-monitoring-grafana-68458d8f46-9476r
monitoring/monitoring-monitoring-kube-operator-857cbfd4c-jh5sv
monitoring/monitoring-monitoring-kube-state-metrics-75954d876b-jdxh6
monitoring/monitoring-monitoring-prometheus-node-exporter-fp5fl
monitoring/monitoring-monitoring-prometheus-node-exporter-j9s8b
monitoring/monitoring-monitoring-prometheus-node-exporter-q62bt
monitoring/monitoring-monitoring-prometheus-node-exporter-r565d
monitoring/monitoring-monitoring-prometheus-node-exporter-vxrj5
monitoring/prometheus-monitoring-monitoring-kube-prometheus-0
nexus-repository-manager/nexus-repository-manager-7c457c6c99-9fmbr
sonarqube/sonarqube-postgresql-0
sonarqube/sonarqube-sonarqube-785b5f5648-w9kq7
velero/velero-55ff8d446-c72tn
velero/velero-velero-7dd4999c99-djtzh
```

</p>
</details>

<details><summary>Persistent Volumes validation</summary>
<p>

```
kubectl get pvc -A
NAMESPACE                  NAME                                           STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS           AGE
anchore                    anchore-postgresql                             Bound    pvc-3952ca08-8db7-4b2f-b61a-b4e8de3a97d0   20Gi       RWO            awsebssciprovisioner   2d7h
argocd                     redis-data-argocd-argocd-redis-bb-master-0     Bound    pvc-913bcd51-4217-47b7-b907-25fc42d66a43   8Gi        RWO            awsebssciprovisioner   2d7h
argocd                     redis-data-argocd-argocd-redis-bb-replicas-0   Bound    pvc-7c1b0157-c20a-481f-8d42-81c3970c05e1   8Gi        RWO            awsebssciprovisioner   2d7h
argocd                     redis-data-argocd-argocd-redis-bb-replicas-1   Bound    pvc-7b2ed397-6053-4d68-919d-f533e0b74556   8Gi        RWO            awsebssciprovisioner   2d7h
gitlab                     data-gitlab-postgresql-0                       Bound    pvc-07284c49-be0b-4b17-8b18-0b9b328163e0   8Gi        RWO            awsebssciprovisioner   2d7h
gitlab                     gitlab-minio                                   Bound    pvc-8bb6e963-cade-4759-a331-5dad02893c2e   10Gi       RWO            awsebssciprovisioner   2d7h
gitlab                     redis-data-gitlab-redis-master-0               Bound    pvc-7d1e23cc-0293-4352-b6d0-f2c6609de238   8Gi        RWO            awsebssciprovisioner   2d7h
gitlab                     repo-data-gitlab-gitaly-0                      Bound    pvc-7b03e72d-693c-4bf2-8dfa-6cf94cdae97c   50Gi       RWO            awsebssciprovisioner   2d7h
logging                    elasticsearch-data-logging-ek-es-data-0        Bound    pvc-4bdb7163-016f-453f-832f-e7500313b8fa   5Gi        RWO            awsebssciprovisioner   2d7h
logging                    elasticsearch-data-logging-ek-es-master-0      Bound    pvc-93e41e33-266d-48fe-80a2-ce526c13e9b8   5Gi        RWO            awsebssciprovisioner   2d7h
nexus-repository-manager   nexus-repository-manager-data                  Bound    pvc-6709e19a-ab15-420e-97a5-e8701cf81b1b   8Gi        RWO            awsebssciprovisioner   2d7h
sonarqube                  data-sonarqube-postgresql-0                    Bound    pvc-b0b80e0a-558a-477b-a125-79b591ffb40a   20Gi       RWO            awsebssciprovisioner   2d7h

```




