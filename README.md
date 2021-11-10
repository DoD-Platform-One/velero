# velero

![Version: 2.23.6-bb.2](https://img.shields.io/badge/Version-2.23.6--bb.2-informational?style=flat-square) ![AppVersion: 1.6.3](https://img.shields.io/badge/AppVersion-1.6.3-informational?style=flat-square)

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
| image.tag | string | `"v1.6.3"` |  |
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
| initContainers | list | `[]` |  |
| podSecurityContext | object | `{}` |  |
| containerSecurityContext | object | `{}` |  |
| priorityClassName | string | `""` |  |
| tolerations | list | `[]` |  |
| affinity | object | `{}` |  |
| nodeSelector | object | `{}` |  |
| extraVolumes | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| metrics.enabled | bool | `true` |  |
| metrics.port | int | `8085` |  |
| metrics.scrapeInterval | string | `"30s"` |  |
| metrics.scrapeTimeout | string | `"10s"` |  |
| metrics.service.annotations | object | `{}` |  |
| metrics.service.labels | object | `{}` |  |
| metrics.podAnnotations."prometheus.io/scrape" | string | `"true"` |  |
| metrics.podAnnotations."prometheus.io/port" | string | `"8085"` |  |
| metrics.podAnnotations."prometheus.io/path" | string | `"/metrics"` |  |
| metrics.serviceMonitor.enabled | bool | `false` |  |
| metrics.serviceMonitor.additionalLabels | object | `{}` |  |
| kubectl.image.repository | string | `"registry1.dso.mil/ironbank/opensource/kubernetes-1.21/kubectl"` |  |
| kubectl.image.tag | string | `"v1.21.1"` |  |
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
| configuration.backupStorageLocation.config | object | `{}` |  |
| configuration.volumeSnapshotLocation.name | string | `nil` |  |
| configuration.volumeSnapshotLocation.provider | string | `nil` |  |
| configuration.volumeSnapshotLocation.config | object | `{}` |  |
| configuration.backupSyncPeriod | string | `nil` |  |
| configuration.resticTimeout | string | `nil` |  |
| configuration.restoreResourcePriorities | string | `nil` |  |
| configuration.restoreOnlyMode | string | `nil` |  |
| configuration.clientQPS | string | `nil` |  |
| configuration.clientBurst | string | `nil` |  |
| configuration.disableControllers | string | `nil` |  |
| configuration.extraEnvVars | object | `{}` |  |
| configuration.features | string | `nil` |  |
| configuration.logLevel | string | `nil` |  |
| configuration.logFormat | string | `nil` |  |
| configuration.defaultVolumesToRestic | string | `nil` |  |
| rbac.create | bool | `true` |  |
| rbac.clusterAdministrator | bool | `true` |  |
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
| deployRestic | bool | `false` |  |
| restic.podVolumePath | string | `"/var/lib/kubelet/pods"` |  |
| restic.privileged | bool | `false` |  |
| restic.priorityClassName | string | `""` |  |
| restic.resources.requests.cpu | string | `"1000m"` |  |
| restic.resources.requests.memory | string | `"1024Mi"` |  |
| restic.resources.limits.cpu | string | `"1000m"` |  |
| restic.resources.limits.memory | string | `"1024Mi"` |  |
| restic.tolerations | list | `[]` |  |
| restic.annotations | object | `{}` |  |
| restic.labels | object | `{}` |  |
| restic.extraVolumes | list | `[]` |  |
| restic.extraVolumeMounts | list | `[]` |  |
| restic.dnsPolicy | string | `"ClusterFirst"` |  |
| restic.podSecurityContext.runAsUser | int | `0` |  |
| restic.containerSecurityContext | object | `{}` |  |
| restic.nodeSelector | object | `{}` |  |
| schedules | object | `{}` |  |
| configMaps | object | `{}` |  |
| istio.enabled | bool | `false` |  |
| monitoring.enabled | bool | `false` |  |
| networkPolicies.enabled | bool | `false` |  |
| networkPolicies.ingressLabels.app | string | `"istio-ingressgateway"` |  |
| networkPolicies.ingressLabels.istio | string | `"ingressgateway"` |  |
| networkPolicies.controlPlaneCidr | string | `"0.0.0.0/0"` |  |
| csi | object | `{"defaultClass":"true","driver":"ebs.csi.aws.com"}` | Velero csi plugin options |
| csi.driver | string | `"ebs.csi.aws.com"` | Driver to use for Velero csi plugin. Default: "ebs.csi.aws.com" |
| csi.defaultClass | string | `"true"` | Set Velero VolumeSnapshotClass to default. Supported values: "true"/"false" |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.
