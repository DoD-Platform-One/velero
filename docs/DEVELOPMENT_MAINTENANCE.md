# Big Bang Velero Package Maintenance Guide

1. **Start from the Renovate branch**

    Checkout the branch created by Renovate. This includes updated image tags and related version changes. You can work directly on the renovate/ironbank branch.

2. **Review upstream changes**

    Go to the [upstream chart repo](https://github.com/vmware-tanzu/helm-charts/tree/main/charts/velero) and identify the target chart version.
    Always start with the latest version to pick up recent patches. Review release notes [here](https://github.com/vmware-tanzu/helm-charts/releases).

3. **Update chart version and dependencies**

    Update `version` in `Chart.yaml`, appending `-bb.X` to the upstream version
    Update all dependencies in `chart/Chart.yaml` to match the latest upstream versions

4. **Update dependencies and lock file**

    Run:
      helm dependency update ./chart

5. **Update changelog**

    Add a new entry in `CHANGELOG.md` that includes:
    - Updated Velero chart version (e.g., `x.x.x`)
    - Updated image versions (from Iron Bank or other sources)
    - Any additional notable changes

6. **Regenerate README**

    Follow the [Gluon README guide](https://repo1.dso.mil/platform-one/big-bang/apps/library-charts/gluon/-/blob/master/docs/bb-package-readme.md) to update `README.md`.

7. **Validate via CI**

    Push your changes and ensure CI passes on the Renovate MR (or create one if needed).
  Address any failures using pipeline logs and coordinate with the team if necessary.

8. **Perform manual testing**

    Run additional validation beyond CI smoke tests to ensure the package functions as expected.

# Testing new Velero version

## Cluster setup
Launch K3D cluster and deploy flux
## Deploy Bigbang

   ⚠️ Note that testing against your local branch or tag is only possible if you edit the overrides file to point to your changes.

From the root of this repo, run the following deploy command :

  ```sh
  helm upgrade -i bigbang ${BIGBANG_REPO_DIR}/chart/ -n bigbang --create-namespace \
  --set registryCredentials.username=${REGISTRY_USERNAME} --set registryCredentials.password=${REGISTRY_PASSWORD} \
  -f https://repo1.dso.mil/big-bang/bigbang/-/raw/master/tests/test-values.yaml \
  -f https://repo1.dso.mil/big-bang/bigbang/-/raw/master/chart/ingress-certs.yaml \
  -f docs/dev-overrides/velero-testing.yaml
  ```

## Validation/Testing Steps

### Setting up
- The above instructions will bring Velero up quickly, by disabling most other bigbang packages aside from Istio and the Monitoring stack. ib_creds.yaml refers to wherever your registryCredentials key is saved.
- Once everything comes up, log in to Minio using the credentials above (minio/minio123 by default) and create a Bucket called velero123 (or whatever you set  under addons.velero.values.configuration.backupStorageLocation[].bucket). This ensures that Veleros backups will have a destination.
- If you encounter an issue where Velero has no deployed releases, you may need to roll back any helm releases and Velero resources before redeploying.

### Backing up a cluster

Velero can be interacted with using its pod:

```
% kubectl get pods -n velero
NAME                            READY   STATUS    RESTARTS   AGE
velero-velero-579bd4f68-6wl4p   2/2     Running   0          3m40s

% kubectl exec -it velero-velero-579bd4f68-6wl4p -n velero -- bash
bash-5.1$ velero backup create goodbackup
bash-5.1$ velero backup create monitoringbackup --include-namespaces=monitoring
```

These backup files will be delivered to Minio, or whatever BackupStorageLocation was chosen. If these backups are not being placed in the Minio bucket, ensure that it was created and named correctly. You can also use `velero backup describe <backupname>` to troubleshoot issues. [Velero Backup Documentation](https://velero.io/docs/v1.10/backup-reference/) can help with taking more fine-grained backups, and [Velero Restore Documentation](https://velero.io/docs/main/restore-reference/) can assist in restoring backups to the same or different clusters.

### Big Bang Integration Testing

As part of your MR that modifies bigbang packages, you should modify the bigbang  [bigbang/tests/test-values.yaml](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/tests/test-values.yaml?ref_type=heads) against your branch for the CI/CD MR testing by enabling your packages. 

To do this, at a minimum, you will need to follow the instructions at [bigbang/docs/developer/test-package-against-bb.md](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/docs/developer/test-package-against-bb.md?ref_type=heads) with changes for Velero enabled (the below is a reference, actual changes could be more depending on what changes where made to Velero in the package MR).

    ```yaml
    addons:
      velero:
        enabled: true
        git:
          tag: null
          branch: <my-package-branch-that-needs-testing>
      ### Additional compononents of Velero should be changed to reflect testing changes introduced in the package MR
    ```

# Modifications made to upstream
This is a high-level list of modifications that Big Bang has made to the upstream helm chart. You can use this as as cross-check to make sure that no modifications were lost during the upgrade process.

## chart/values.yaml

- Added values for `istio`, `networkPolicies`, and `bbtests`
- Changed image to default to Ironbank image
- Set default `podSecurityContext`, `containerSecurityContext`,  and `imagePullSecrets`
- Added commented out values for `serviceMonitor.scheme` and `serviceMonitor.tlsConfig`
- Added values for aws, csi, and azure under the new `plugins` section
- added aws plugin initContainer

## chart/templates/bigbang/

- Network policies added
- Istio mTLS (peerauthentication) resources added
- Grafana dashboard added
- CSI Snapshot class added
