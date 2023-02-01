# velero

![Version: 3.1.0-bb.3](https://img.shields.io/badge/Version-3.1.0--bb.3-informational?style=flat-square) ![AppVersion: 1.10.0](https://img.shields.io/badge/AppVersion-1.10.0-informational?style=flat-square)

A Helm chart for velero

## Upstream References
* <https://github.com/vmware-tanzu/velero>

* <https://github.com/vmware-tanzu/velero>

## Learn More
* [Application Overview](docs/overview.md)
* [Other Documentation](docs/)

## Pre-Requisites

* Kubernetes Cluster deployed
* Kubernetes config installed in `~/.kube/config`
* Helm installed

Kubernetes: `>=1.16.0-0`

Install Helm

https://helm.sh/docs/intro/install/

## Deployment

* Clone down the repository
* cd into directory
```bash
helm install velero chart/
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.repository | string | `"registry1.dso.mil/ironbank/opensource/velero/velero"` |  |
| image.tag | string | `"v1.10.0"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.imagePullSecrets[0] | string | `"private-registry"` |  |
| annotations | object | `{}` |  |
| labels | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| resources.requests.cpu | string | `"1000m"` |  |
| resources.requests.memory | string | `"512Mi"` |  |
| resources.limits.cpu | string | `"1000m"` |  |
| resources.limits.memory | string | `"512Mi"` |  |
| dnsPolicy | string | `"ClusterFirst"` |  |
| plugins.csi.enabled | bool | `false` |  |
| plugins.csi.name | string | `"velero-plugin-for-csi"` |  |
| plugins.csi.image.repository | string | `"registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-csi"` |  |
| plugins.csi.image.tag | string | `"v0.4.0"` |  |
| plugins.csi.container.imagePullPolicy | string | `"IfNotPresent"` |  |
| plugins.csi.container.volumeMounts[0].mountPath | string | `"/target"` |  |
| plugins.csi.container.volumeMounts[0].name | string | `"plugins"` |  |
| plugins.csi.container.resources.requests.memory | string | `"512Mi"` |  |
| plugins.csi.container.resources.requests.cpu | string | `"100m"` |  |
| plugins.csi.container.resources.limits.memory | string | `"512Mi"` |  |
| plugins.csi.container.resources.limits.cpu | string | `"100m"` |  |
| plugins.csi.container.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| plugins.aws.enabled | bool | `false` |  |
| plugins.aws.name | string | `"velero-plugin-for-aws"` |  |
| plugins.aws.image.repository | string | `"registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-aws"` |  |
| plugins.aws.image.tag | string | `"v1.6.0"` |  |
| plugins.aws.container.imagePullPolicy | string | `"IfNotPresent"` |  |
| plugins.aws.container.volumeMounts[0].mountPath | string | `"/target"` |  |
| plugins.aws.container.volumeMounts[0].name | string | `"plugins"` |  |
| plugins.aws.container.resources.requests.memory | string | `"512Mi"` |  |
| plugins.aws.container.resources.requests.cpu | string | `"100m"` |  |
| plugins.aws.container.resources.limits.memory | string | `"512Mi"` |  |
| plugins.aws.container.resources.limits.cpu | string | `"100m"` |  |
| plugins.aws.container.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| plugins.azure.enabled | bool | `false` |  |
| plugins.azure.name | string | `"velero-plugin-for-microsoft-azure"` |  |
| plugins.azure.image.repository | string | `"registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-microsoft-azure"` |  |
| plugins.azure.image.tag | string | `"v1.6.0"` |  |
| plugins.azure.container.imagePullPolicy | string | `"IfNotPresent"` |  |
| plugins.azure.container.volumeMounts[0].mountPath | string | `"/target"` |  |
| plugins.azure.container.volumeMounts[0].name | string | `"plugins"` |  |
| plugins.azure.container.resources.requests.memory | string | `"512Mi"` |  |
| plugins.azure.container.resources.requests.cpu | string | `"100m"` |  |
| plugins.azure.container.resources.limits.memory | string | `"512Mi"` |  |
| plugins.azure.container.resources.limits.cpu | string | `"100m"` |  |
| plugins.azure.container.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| initContainers | string | `nil` |  |
| podSecurityContext.runAsUser | int | `65534` |  |
| podSecurityContext.runAsGroup | int | `65534` |  |
| containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| containerSecurityContext.readOnlyRootFilesystem | bool | `true` |  |
| lifecycle | object | `{}` |  |
| priorityClassName | string | `""` |  |
| terminationGracePeriodSeconds | int | `3600` |  |
| tolerations | list | `[]` |  |
| affinity | object | `{}` |  |
| nodeSelector | object | `{}` |  |
| dnsConfig | object | `{}` |  |
| extraVolumes | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraObjects | list | `[]` |  |
| metrics.enabled | bool | `true` |  |
| metrics.scrapeInterval | string | `"30s"` |  |
| metrics.scrapeTimeout | string | `"10s"` |  |
| metrics.service.annotations | object | `{}` |  |
| metrics.service.labels | object | `{}` |  |
| metrics.podAnnotations."prometheus.io/scrape" | string | `"true"` |  |
| metrics.podAnnotations."prometheus.io/port" | string | `"8085"` |  |
| metrics.podAnnotations."prometheus.io/path" | string | `"/metrics"` |  |
| metrics.serviceMonitor.enabled | bool | `false` |  |
| metrics.serviceMonitor.annotations | object | `{}` |  |
| metrics.serviceMonitor.additionalLabels | object | `{}` |  |
| metrics.prometheusRule.enabled | bool | `false` |  |
| metrics.prometheusRule.additionalLabels | object | `{}` |  |
| metrics.prometheusRule.spec[0].alert | string | `"VeleroVeleroJobAbsent"` |  |
| metrics.prometheusRule.spec[0].annotations.message | string | `""` |  |
| metrics.prometheusRule.spec[0].expr | string | `"absent(up{job=\"velero-velero\", namespace=\"velero\"})"` |  |
| metrics.prometheusRule.spec[0].for | string | `"10m"` |  |
| metrics.prometheusRule.spec[0].labels.severity | string | `"critical"` |  |
| metrics.prometheusRule.spec[1].alert | string | `"VeleroBackupPartialFailures"` |  |
| metrics.prometheusRule.spec[1].annotations.message | string | `"Velero backup job ( {{`{{`}} $labels.job {{`}}`}} ) has {{`{{`}} $value \| humanizePercentage {{`}}`}} partially failed backups."` |  |
| metrics.prometheusRule.spec[1].expr | string | `"velero_backup_partial_failure_total{job!=\"\"} / velero_backup_attempt_total{job!=\"\"} > 0"` |  |
| metrics.prometheusRule.spec[1].for | string | `"10m"` |  |
| metrics.prometheusRule.spec[1].labels.severity | string | `"warning"` |  |
| metrics.prometheusRule.spec[2].alert | string | `"VeleroBackupFailures"` |  |
| metrics.prometheusRule.spec[2].annotations.message | string | `"Velero backup job ( {{`{{`}} $labels.job {{`}}`}} ) has {{`{{`}} $value \| humanizePercentage {{`}}`}} failed backups."` |  |
| metrics.prometheusRule.spec[2].expr | string | `"velero_backup_failure_total{job!=\"\"} / velero_backup_attempt_total{job!=\"\"} > 0"` |  |
| metrics.prometheusRule.spec[2].for | string | `"10m"` |  |
| metrics.prometheusRule.spec[2].labels.severity | string | `"critical"` |  |
| metrics.prometheusRule.spec[3].alert | string | `"VeleroBackupValidationFailures"` |  |
| metrics.prometheusRule.spec[3].annotations.message | string | `"Velero backup job ( {{`{{`}} $labels.job {{`}}`}} ) has {{`{{`}} $value \| humanizePercentage {{`}}`}} failed backup validations."` |  |
| metrics.prometheusRule.spec[3].expr | string | `"velero_backup_validation_failure_total{job!=\"\"} / velero_backup_attempt_total{job!=\"\"} > 0"` |  |
| metrics.prometheusRule.spec[3].for | string | `"10m"` |  |
| metrics.prometheusRule.spec[3].labels.severity | string | `"critical"` |  |
| metrics.prometheusRule.spec[4].alert | string | `"VeleroBackupDeletionFailures"` |  |
| metrics.prometheusRule.spec[4].annotations.message | string | `"Velero backup job ( {{`{{`}} $labels.job {{`}}`}} ) has {{`{{`}} $value \| humanizePercentage {{`}}`}} failed backup deletions."` |  |
| metrics.prometheusRule.spec[4].expr | string | `"velero_backup_deletion_failure_total{job!=\"\"} / velero_backup_deletion_attempt_total{job!=\"\"} > 0"` |  |
| metrics.prometheusRule.spec[4].for | string | `"10m"` |  |
| metrics.prometheusRule.spec[4].labels.severity | string | `"critical"` |  |
| metrics.prometheusRule.spec[5].alert | string | `"VeleroBackupItemErrors"` |  |
| metrics.prometheusRule.spec[5].annotations.message | string | `"Velero backup job ( {{ `{{` }} $labels.job {{ `}}` }} ) has item errors."` |  |
| metrics.prometheusRule.spec[5].expr | string | `"velero_backup_items_errors{job!=\"\"} > 0"` |  |
| metrics.prometheusRule.spec[5].for | string | `"10m"` |  |
| metrics.prometheusRule.spec[5].labels.severity | string | `"critical"` |  |
| metrics.prometheusRule.spec[6].alert | string | `"VeleroCSISnapshotFailures"` |  |
| metrics.prometheusRule.spec[6].annotations.message | string | `"Velero CSI snapshot job ( {{`{{`}} $labels.job {{`}}`}} ) has {{`{{`}} $value \| humanizePercentage {{`}}`}} failed CSI snapshots."` |  |
| metrics.prometheusRule.spec[6].expr | string | `"velero_csi_snapshot_failure_total{job!=\"\"} / velero_csi_snapshot_attempt_total{job!=\"\"} > 0"` |  |
| metrics.prometheusRule.spec[6].for | string | `"10m"` |  |
| metrics.prometheusRule.spec[6].labels.severity | string | `"critical"` |  |
| metrics.prometheusRule.spec[7].alert | string | `"VeleroRestorePartialFailures"` |  |
| metrics.prometheusRule.spec[7].annotations.message | string | `"Velero restore job ( {{`{{`}} $labels.job {{`}}`}} ) has {{`{{`}} $value \| humanizePercentage {{`}}`}} partially failed restores."` |  |
| metrics.prometheusRule.spec[7].expr | string | `"velero_restore_partial_failure_total{job!=\"\"} / velero_restore_attempt_total{job!=\"\"} > 0"` |  |
| metrics.prometheusRule.spec[7].for | string | `"10m"` |  |
| metrics.prometheusRule.spec[7].labels.severity | string | `"warning"` |  |
| metrics.prometheusRule.spec[8].alert | string | `"VeleroRestoreFailures"` |  |
| metrics.prometheusRule.spec[8].annotations.message | string | `"Velero restore job ( {{`{{`}} $labels.job {{`}}`}} ) has {{`{{`}} $value \| humanizePercentage {{`}}`}} failed restores."` |  |
| metrics.prometheusRule.spec[8].expr | string | `"velero_restore_failed_total{job!=\"\"} / velero_restore_attempt_total{job!=\"\"} > 0"` |  |
| metrics.prometheusRule.spec[8].for | string | `"10m"` |  |
| metrics.prometheusRule.spec[8].labels.severity | string | `"critical"` |  |
| metrics.prometheusRule.spec[9].alert | string | `"VeleroRestoreValidationFailures"` |  |
| metrics.prometheusRule.spec[9].annotations.message | string | `"Velero restore job ( {{`{{`}} $labels.job {{`}}`}} ) has {{`{{`}} $value \| humanizePercentage {{`}}`}} failed restore validations."` |  |
| metrics.prometheusRule.spec[9].expr | string | `"velero_restore_validation_failed_total{job!=\"\"} / velero_restore_attempt_total{job!=\"\"} > 0"` |  |
| metrics.prometheusRule.spec[9].for | string | `"10m"` |  |
| metrics.prometheusRule.spec[9].labels.severity | string | `"critical"` |  |
| metrics.prometheusRule.spec[10].alert | string | `"VeleroVolumeSnapshotFailures"` |  |
| metrics.prometheusRule.spec[10].annotations.message | string | `"Velero volume snapshot job ( {{`{{`}} $labels.job {{`}}`}} ) has {{`{{`}} $value \| humanizePercentage {{`}}`}} failed volume snapshots."` |  |
| metrics.prometheusRule.spec[10].expr | string | `"velero_volume_snapshot_failure_total{job!=\"\"} / velero_volume_snapshot_attempt_total{job!=\"\"} > 0"` |  |
| metrics.prometheusRule.spec[10].for | string | `"10m"` |  |
| metrics.prometheusRule.spec[10].labels.severity | string | `"critical"` |  |
| kubectl.image.repository | string | `"registry1.dso.mil/ironbank/opensource/kubernetes/kubectl"` |  |
| kubectl.image.tag | string | `"v1.25.6"` |  |
| kubectl.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| kubectl.resources.requests.memory | string | `"256Mi"` |  |
| kubectl.resources.requests.cpu | string | `"100m"` |  |
| kubectl.resources.limits.memory | string | `"256Mi"` |  |
| kubectl.resources.limits.cpu | string | `"100m"` |  |
| kubectl.annotations."sidecar.istio.io/inject" | string | `"false"` |  |
| kubectl.labels | object | `{}` |  |
| upgradeCRDs | bool | `true` |  |
| cleanUpCRDs | bool | `false` |  |
| configuration.provider | string | `nil` |  |
| configuration.backupStorageLocation.name | string | `nil` |  |
| configuration.backupStorageLocation.provider | string | `nil` |  |
| configuration.backupStorageLocation.bucket | string | `nil` |  |
| configuration.backupStorageLocation.caCert | string | `nil` |  |
| configuration.backupStorageLocation.prefix | string | `nil` |  |
| configuration.backupStorageLocation.default | string | `nil` |  |
| configuration.backupStorageLocation.accessMode | string | `"ReadWrite"` |  |
| configuration.backupStorageLocation.config | object | `{}` |  |
| configuration.volumeSnapshotLocation.name | string | `nil` |  |
| configuration.volumeSnapshotLocation.provider | string | `nil` |  |
| configuration.volumeSnapshotLocation.config | object | `{}` |  |
| configuration.uploaderType | string | `nil` | ------------------ `velero server` default: restic |
| configuration.backupSyncPeriod | string | `nil` |  |
| configuration.fsBackupTimeout | string | `nil` |  |
| configuration.clientBurst | string | `nil` |  |
| configuration.clientPageSize | string | `nil` |  |
| configuration.clientQPS | string | `nil` |  |
| configuration.defaultBackupStorageLocation | string | `nil` |  |
| configuration.defaultBackupTTL | string | `nil` |  |
| configuration.defaultVolumeSnapshotLocations | string | `nil` |  |
| configuration.disableControllers | string | `nil` |  |
| configuration.garbageCollectionFrequency | string | `nil` |  |
| configuration.logFormat | string | `nil` |  |
| configuration.logLevel | string | `nil` |  |
| configuration.metricsAddress | string | `nil` |  |
| configuration.pluginDir | string | `nil` |  |
| configuration.profilerAddress | string | `nil` |  |
| configuration.restoreOnlyMode | string | `nil` |  |
| configuration.restoreResourcePriorities | string | `nil` |  |
| configuration.storeValidationFrequency | string | `nil` |  |
| configuration.terminatingResourceTimeout | string | `nil` |  |
| configuration.features | string | `nil` |  |
| configuration.namespace | string | `nil` |  |
| configuration.extraEnvVars | object | `{}` |  |
| configuration.defaultVolumesToFsBackup | string | `nil` |  |
| configuration.defaultRepoMaintainFrequency | string | `nil` |  |
| rbac.create | bool | `true` |  |
| rbac.clusterAdministrator | bool | `true` |  |
| rbac.clusterAdministratorName | string | `"cluster-admin"` |  |
| serviceAccount.server.create | bool | `true` |  |
| serviceAccount.server.name | string | `nil` |  |
| serviceAccount.server.annotations | string | `nil` |  |
| serviceAccount.server.labels | string | `nil` |  |
| credentials.useSecret | bool | `true` |  |
| credentials.name | string | `nil` |  |
| credentials.existingSecret | string | `nil` |  |
| credentials.secretContents | object | `{}` |  |
| credentials.extraEnvVars | object | `{}` |  |
| credentials.extraSecretRef | string | `""` |  |
| backupsEnabled | bool | `true` |  |
| snapshotsEnabled | bool | `true` |  |
| deployNodeAgent | bool | `false` |  |
| nodeAgent.podVolumePath | string | `"/var/lib/kubelet/pods"` |  |
| nodeAgent.privileged | bool | `false` |  |
| nodeAgent.priorityClassName | string | `""` |  |
| nodeAgent.resources.requests.cpu | string | `"1000m"` |  |
| nodeAgent.resources.requests.memory | string | `"1024Mi"` |  |
| nodeAgent.resources.limits.cpu | string | `"1000m"` |  |
| nodeAgent.resources.limits.memory | string | `"1024Mi"` |  |
| nodeAgent.tolerations | list | `[]` |  |
| nodeAgent.annotations | object | `{}` |  |
| nodeAgent.labels | object | `{}` |  |
| nodeAgent.useScratchEmptyDir | bool | `true` |  |
| nodeAgent.extraVolumes | list | `[]` |  |
| nodeAgent.extraVolumeMounts | list | `[]` |  |
| nodeAgent.extraEnvVars | object | `{}` |  |
| nodeAgent.dnsPolicy | string | `"ClusterFirst"` |  |
| nodeAgent.podSecurityContext.runAsUser | int | `0` |  |
| nodeAgent.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| nodeAgent.lifecycle | object | `{}` |  |
| nodeAgent.nodeSelector | object | `{}` |  |
| nodeAgent.affinity | object | `{}` |  |
| nodeAgent.dnsConfig | object | `{}` |  |
| schedules | object | `{}` |  |
| configMaps | object | `{}` |  |
| istio.enabled | bool | `false` |  |
| istio.mtls | object | `{"mode":"STRICT"}` | Default velero peer authentication |
| istio.mtls.mode | string | `"STRICT"` | STRICT = Allow only mutual TLS traffic, PERMISSIVE = Allow both plain text and mutual TLS traffic |
| monitoring.enabled | bool | `false` |  |
| networkPolicies.enabled | bool | `false` |  |
| networkPolicies.ingressLabels.app | string | `"istio-ingressgateway"` |  |
| networkPolicies.ingressLabels.istio | string | `"ingressgateway"` |  |
| networkPolicies.controlPlaneCidr | string | `"0.0.0.0/0"` |  |
| csi | object | `{"defaultClass":"true","driver":"ebs.csi.aws.com"}` | Velero csi plugin options |
| csi.driver | string | `"ebs.csi.aws.com"` | Driver to use for Velero csi plugin. Default: "ebs.csi.aws.com" |
| csi.defaultClass | string | `"true"` | Set Velero VolumeSnapshotClass to default. Supported values: "true"/"false" |
| bbtests.enabled | bool | `false` |  |
| bbtests.scripts.image | string | `"registry1.dso.mil/bigbang-ci/velero-tester:1.0.0"` |  |
| bbtests.scripts.envs.MINIO_HOST | string | `"http://minio.minio.svc"` |  |
| bbtests.scripts.envs.MINIO_USER | string | `"minio"` |  |
| bbtests.scripts.envs.MINIO_PASS | string | `"minio123"` |  |
| bbtests.scripts.secretEnvs[0].name | string | `"NAMESPACE"` |  |
| bbtests.scripts.secretEnvs[0].valueFrom.fieldRef.fieldPath | string | `"metadata.namespace"` |  |
| bbtests.scripts.additionalVolumes[0].name | string | `"minio-volume"` |  |
| bbtests.scripts.additionalVolumes[0].emptyDir | object | `{}` |  |
| bbtests.scripts.additionalVolumeMounts[0].mountPath | string | `"/.mc"` |  |
| bbtests.scripts.additionalVolumeMounts[0].name | string | `"minio-volume"` |  |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.
