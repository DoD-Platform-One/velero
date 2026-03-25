<!-- Warning: Do not manually edit this file. See notes on gluon + helm-docs at the end of this file for more information. -->
# velero

![Version: 12.0.0-bb.0](https://img.shields.io/badge/Version-12.0.0--bb.0-informational?style=flat-square) ![AppVersion: 1.18.0](https://img.shields.io/badge/AppVersion-1.18.0-informational?style=flat-square) ![Maintenance Track: bb_integrated](https://img.shields.io/badge/Maintenance_Track-bb_integrated-green?style=flat-square)

A Helm chart for velero

## Upstream References

- <https://github.com/vmware-tanzu/velero>

## Upstream Release Notes

- [Find our upstream chart's CHANGELOG here](https://github.com/vmware-tanzu/velero/blob/main/CHANGELOG.md)
- [and our upstream application release notes here](https://github.com/vmware-tanzu/velero/releases)

## Learn More

- [Application Overview](docs/overview.md)
- [Other Documentation](docs/)

## Pre-Requisites

- Kubernetes Cluster deployed
- Kubernetes config installed in `~/.kube/config`
- Helm installed

Kubernetes: `>=1.18.0-0`

Install Helm

https://helm.sh/docs/intro/install/

## Deployment

- Clone down the repository
- cd into directory

```bash
helm install velero chart/
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| domain | string | `"dev.bigbang.mil"` |  |
| openshift | bool | `false` |  |
| istio.enabled | bool | `false` |  |
| istio.sidecar.enabled | bool | `false` |  |
| istio.sidecar.outboundTrafficPolicyMode | string | `"REGISTRY_ONLY"` |  |
| istio.serviceEntries.custom | list | `[]` |  |
| istio.authorizationPolicies.enabled | bool | `false` |  |
| istio.authorizationPolicies.custom | list | `[]` |  |
| istio.mtls.mode | string | `"STRICT"` |  |
| monitoring.enabled | bool | `false` |  |
| networkPolicies.enabled | bool | `false` |  |
| networkPolicies.ingress.to.velero:8085.from.k8s.monitoring-monitoring-kube-prometheus@monitoring/prometheus | bool | `false` |  |
| networkPolicies.egress.from.*.to.k8s.tempo/tempo:9411 | bool | `false` |  |
| networkPolicies.egress.from.*.to.definition.kubeAPI | bool | `true` |  |
| networkPolicies.egress.from.velero-upgrade-crds.podSelector.matchLabels."batch.kubernetes.io/job-name" | string | `"velero-upgrade-crds"` |  |
| networkPolicies.egress.from.velero-upgrade-crds.to.definition.kubeAPI.enabled | bool | `true` |  |
| networkPolicies.egress.from.velero-upgrade-crds.to.definition.kubeAPI.metadata.annotations."helm.sh/hook" | string | `"pre-upgrade"` |  |
| networkPolicies.egress.from.velero-upgrade-crds.to.definition.kubeAPI.metadata.annotations."helm.sh/hook-weight" | string | `"-10"` |  |
| networkPolicies.egress.from.velero-upgrade-crds.to.definition.kubeAPI.metadata.annotations."helm.sh/hook-delete-policy" | string | `"hook-succeeded,hook-failed,before-hook-creation"` |  |
| csi | object | `{"defaultClass":"true","driver":"ebs.csi.aws.com"}` | Velero csi plugin options |
| csi.driver | string | `"ebs.csi.aws.com"` | Driver to use for Velero csi plugin. Default: "ebs.csi.aws.com" |
| csi.defaultClass | string | `"true"` | Set Velero VolumeSnapshotClass to default. Supported values: "true"/"false" |
| upstream.image.repository | string | `"registry1.dso.mil/ironbank/opensource/velero/velero"` |  |
| upstream.image.tag | string | `"v1.18.0"` |  |
| upstream.image.pullPolicy | string | `"Always"` |  |
| upstream.image.imagePullSecrets[0] | string | `"private-registry"` |  |
| upstream.nameOverride | string | `"velero"` |  |
| upstream.fullnameOverride | string | `"velero"` |  |
| upstream.resources.requests.cpu | string | `"100m"` |  |
| upstream.resources.requests.memory | string | `"100Mi"` |  |
| upstream.resources.limits.cpu | string | `"1000m"` |  |
| upstream.resources.limits.memory | string | `"512Mi"` |  |
| upstream.upgradeJobResources.requests.cpu | string | `"100m"` |  |
| upstream.upgradeJobResources.requests.memory | string | `"256Mi"` |  |
| upstream.upgradeJobResources.limits.cpu | string | `"100m"` |  |
| upstream.upgradeJobResources.limits.memory | string | `"256Mi"` |  |
| upstream.podSecurityContext.runAsUser | int | `65534` |  |
| upstream.podSecurityContext.runAsGroup | int | `65534` |  |
| upstream.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| upstream.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| upstream.containerSecurityContext.readOnlyRootFilesystem | bool | `true` |  |
| upstream.initContainers[0].name | string | `"velero-plugin-for-aws"` |  |
| upstream.initContainers[0].image | string | `"registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-aws:v1.14.0"` |  |
| upstream.initContainers[0].imagePullPolicy | string | `"Always"` |  |
| upstream.initContainers[0].volumeMounts[0].mountPath | string | `"/target"` |  |
| upstream.initContainers[0].volumeMounts[0].name | string | `"plugins"` |  |
| upstream.initContainers[0].resources.requests.memory | string | `"100Mi"` |  |
| upstream.initContainers[0].resources.requests.cpu | string | `"100m"` |  |
| upstream.initContainers[0].resources.limits.memory | string | `"512Mi"` |  |
| upstream.initContainers[0].resources.limits.cpu | string | `"500m"` |  |
| upstream.initContainers[0].securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| upstream.metrics.prometheusRule.spec[0].alert | string | `"VeleroVeleroJobAbsent"` |  |
| upstream.metrics.prometheusRule.spec[0].annotations.message | string | `""` |  |
| upstream.metrics.prometheusRule.spec[0].expr | string | `"absent(up{job=\"velero-velero\", namespace=\"velero\"})"` |  |
| upstream.metrics.prometheusRule.spec[0].for | string | `"10m"` |  |
| upstream.metrics.prometheusRule.spec[0].labels.severity | string | `"critical"` |  |
| upstream.metrics.prometheusRule.spec[1].alert | string | `"VeleroBackupPartialFailures"` |  |
| upstream.metrics.prometheusRule.spec[1].annotations.message | string | `"Velero backup job ( {{`{{`}} $labels.job {{`}}`}} ) has {{`{{`}} $value \| humanizePercentage {{`}}`}} partially failed backups."` |  |
| upstream.metrics.prometheusRule.spec[1].expr | string | `"velero_backup_partial_failure_total{job!=\"\"} / velero_backup_attempt_total{job!=\"\"} > 0"` |  |
| upstream.metrics.prometheusRule.spec[1].for | string | `"10m"` |  |
| upstream.metrics.prometheusRule.spec[1].labels.severity | string | `"warning"` |  |
| upstream.metrics.prometheusRule.spec[2].alert | string | `"VeleroBackupFailures"` |  |
| upstream.metrics.prometheusRule.spec[2].annotations.message | string | `"Velero backup job ( {{`{{`}} $labels.job {{`}}`}} ) has {{`{{`}} $value \| humanizePercentage {{`}}`}} failed backups."` |  |
| upstream.metrics.prometheusRule.spec[2].expr | string | `"velero_backup_failure_total{job!=\"\"} / velero_backup_attempt_total{job!=\"\"} > 0"` |  |
| upstream.metrics.prometheusRule.spec[2].for | string | `"10m"` |  |
| upstream.metrics.prometheusRule.spec[2].labels.severity | string | `"critical"` |  |
| upstream.metrics.prometheusRule.spec[3].alert | string | `"VeleroBackupValidationFailures"` |  |
| upstream.metrics.prometheusRule.spec[3].annotations.message | string | `"Velero backup job ( {{`{{`}} $labels.job {{`}}`}} ) has {{`{{`}} $value \| humanizePercentage {{`}}`}} failed backup validations."` |  |
| upstream.metrics.prometheusRule.spec[3].expr | string | `"velero_backup_validation_failure_total{job!=\"\"} / velero_backup_attempt_total{job!=\"\"} > 0"` |  |
| upstream.metrics.prometheusRule.spec[3].for | string | `"10m"` |  |
| upstream.metrics.prometheusRule.spec[3].labels.severity | string | `"critical"` |  |
| upstream.metrics.prometheusRule.spec[4].alert | string | `"VeleroBackupDeletionFailures"` |  |
| upstream.metrics.prometheusRule.spec[4].annotations.message | string | `"Velero backup job ( {{`{{`}} $labels.job {{`}}`}} ) has {{`{{`}} $value \| humanizePercentage {{`}}`}} failed backup deletions."` |  |
| upstream.metrics.prometheusRule.spec[4].expr | string | `"velero_backup_deletion_failure_total{job!=\"\"} / velero_backup_deletion_attempt_total{job!=\"\"} > 0"` |  |
| upstream.metrics.prometheusRule.spec[4].for | string | `"10m"` |  |
| upstream.metrics.prometheusRule.spec[4].labels.severity | string | `"critical"` |  |
| upstream.metrics.prometheusRule.spec[5].alert | string | `"VeleroBackupItemErrors"` |  |
| upstream.metrics.prometheusRule.spec[5].annotations.message | string | `"Velero backup job ( {{`{{`}} $labels.job {{`}}`}} ) has item errors."` |  |
| upstream.metrics.prometheusRule.spec[5].expr | string | `"velero_backup_items_errors{job!=\"\"} > 0"` |  |
| upstream.metrics.prometheusRule.spec[5].for | string | `"10m"` |  |
| upstream.metrics.prometheusRule.spec[5].labels.severity | string | `"critical"` |  |
| upstream.metrics.prometheusRule.spec[6].alert | string | `"VeleroCSISnapshotFailures"` |  |
| upstream.metrics.prometheusRule.spec[6].annotations.message | string | `"Velero CSI snapshot job ( {{`{{`}} $labels.job {{`}}`}} ) has {{`{{`}} $value \| humanizePercentage {{`}}`}} failed CSI snapshots."` |  |
| upstream.metrics.prometheusRule.spec[6].expr | string | `"velero_csi_snapshot_failure_total{job!=\"\"} / velero_csi_snapshot_attempt_total{job!=\"\"} > 0"` |  |
| upstream.metrics.prometheusRule.spec[6].for | string | `"10m"` |  |
| upstream.metrics.prometheusRule.spec[6].labels.severity | string | `"critical"` |  |
| upstream.metrics.prometheusRule.spec[7].alert | string | `"VeleroRestorePartialFailures"` |  |
| upstream.metrics.prometheusRule.spec[7].annotations.message | string | `"Velero restore job ( {{`{{`}} $labels.job {{`}}`}} ) has {{`{{`}} $value \| humanizePercentage {{`}}`}} partially failed restores."` |  |
| upstream.metrics.prometheusRule.spec[7].expr | string | `"velero_restore_partial_failure_total{job!=\"\"} / velero_restore_attempt_total{job!=\"\"} > 0"` |  |
| upstream.metrics.prometheusRule.spec[7].for | string | `"10m"` |  |
| upstream.metrics.prometheusRule.spec[7].labels.severity | string | `"warning"` |  |
| upstream.metrics.prometheusRule.spec[8].alert | string | `"VeleroRestoreFailures"` |  |
| upstream.metrics.prometheusRule.spec[8].annotations.message | string | `"Velero restore job ( {{`{{`}} $labels.job {{`}}`}} ) has {{`{{`}} $value \| humanizePercentage {{`}}`}} failed restores."` |  |
| upstream.metrics.prometheusRule.spec[8].expr | string | `"velero_restore_failed_total{job!=\"\"} / velero_restore_attempt_total{job!=\"\"} > 0"` |  |
| upstream.metrics.prometheusRule.spec[8].for | string | `"10m"` |  |
| upstream.metrics.prometheusRule.spec[8].labels.severity | string | `"critical"` |  |
| upstream.metrics.prometheusRule.spec[9].alert | string | `"VeleroRestoreValidationFailures"` |  |
| upstream.metrics.prometheusRule.spec[9].annotations.message | string | `"Velero restore job ( {{`{{`}} $labels.job {{`}}`}} ) has {{`{{`}} $value \| humanizePercentage {{`}}`}} failed restore validations."` |  |
| upstream.metrics.prometheusRule.spec[9].expr | string | `"velero_restore_validation_failed_total{job!=\"\"} / velero_restore_attempt_total{job!=\"\"} > 0"` |  |
| upstream.metrics.prometheusRule.spec[9].for | string | `"10m"` |  |
| upstream.metrics.prometheusRule.spec[9].labels.severity | string | `"critical"` |  |
| upstream.metrics.prometheusRule.spec[10].alert | string | `"VeleroVolumeSnapshotFailures"` |  |
| upstream.metrics.prometheusRule.spec[10].annotations.message | string | `"Velero volume snapshot job ( {{`{{`}} $labels.job {{`}}`}} ) has {{`{{`}} $value \| humanizePercentage {{`}}`}} failed volume snapshots."` |  |
| upstream.metrics.prometheusRule.spec[10].expr | string | `"velero_volume_snapshot_failure_total{job!=\"\"} / velero_volume_snapshot_attempt_total{job!=\"\"} > 0"` |  |
| upstream.metrics.prometheusRule.spec[10].for | string | `"10m"` |  |
| upstream.metrics.prometheusRule.spec[10].labels.severity | string | `"critical"` |  |
| upstream.kubectl.image.repository | string | `"registry1.dso.mil/ironbank/big-bang/base"` |  |
| upstream.kubectl.image.tag | string | `"2.1.0"` |  |
| upstream.kubectl.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| upstream.kubectl.resources.requests.memory | string | `"100Mi"` |  |
| upstream.kubectl.resources.requests.cpu | string | `"100m"` |  |
| upstream.kubectl.resources.limits.memory | string | `"256Mi"` |  |
| upstream.kubectl.resources.limits.cpu | string | `"100m"` |  |
| upstream.kubectl.annotations."sidecar.istio.io/inject" | string | `"false"` |  |
| upstream.nodeAgent.resources.requests.cpu | string | `"100m"` |  |
| upstream.nodeAgent.resources.requests.memory | string | `"100Mi"` |  |
| upstream.nodeAgent.resources.limits.cpu | string | `"1000m"` |  |
| upstream.nodeAgent.resources.limits.memory | string | `"1024Mi"` |  |
| upstream.nodeAgent.podSecurityContext.runAsUser | int | `0` |  |
| upstream.nodeAgent.podSecurityContext.fsGroup | int | `1337` |  |
| upstream.nodeAgent.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| bbtests.enabled | bool | `false` |  |
| bbtests.scripts.image | string | `"registry1.dso.mil/ironbank/big-bang/devops-tester:1.1"` |  |
| bbtests.scripts.envs.SCHEDULED_BACKUP_NAME | string | `"{{ include \"velero.fullname\" . \| trim }}-scheduled-backup"` |  |
| bbtests.scripts.envs.SCHEDULED_TEST | string | `"false"` |  |
| bbtests.scripts.secretEnvs[0].name | string | `"NAMESPACE"` |  |
| bbtests.scripts.secretEnvs[0].valueFrom.fieldRef.fieldPath | string | `"metadata.namespace"` |  |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.

---

_This file is programatically generated using `helm-docs` and some BigBang-specific templates. The `gluon` repository has [instructions for regenerating package READMEs](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md)._

