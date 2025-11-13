# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---
## [11.1.1-bb.1] - 2025-11-13

### Updated

- Update registry1.dso.mil/ironbank/opensource/velero/velero v1.17.0 -> v1.17.1
- Updated registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-aws 1.13.0 -> 1.13.1

## [11.1.1-bb.0] - 2025-11-03

### Updated

- Update velero 10.0.7 -> 11.1.1
- Update gluon 0.9.5 -> 0.9.6
- Update ironbank/opensource/nginx/nginx 1.29.2 -> 1.29.3
- Update registry1.dso.mil/ironbank/opensource/nginx/nginx 1.29.2 -> 1.29.3
- Update registry1.dso.mil/ironbank/opensource/velero/velero v1.16.1 -> v1.17.0

## [10.0.7-bb.5] - 2025-10-27

### Updated

- Update allow-velero-test-script NetworkPolicy to ensure it is only created when both networkPolicies.enabled and bbtests.enabled are set to true

## [10.0.7-bb.4] - 2025-10-27

### Updated

- Updated ironbank/opensource/nginx/nginx (source) 1.28.0 -> 1.29.0
- Updated registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-aws 1.12.1 -> 1.13.0
- Updated registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-microsoft-azure 1.12.1 -> 1.13.0
- Updated gluon 0.4.4 -> 0.9.5

## [10.0.7-bb.3] - 2025-10-22

### Changed

- Updated the allow-egress-storage network policy to remove label
- Updated the allow-egress-api network policy to include helm hooks for crd job race condition
- Adds networkpolicy for the velero-test-script pod

## [10.0.7-bb.2] - 2025-10-22

### Changed

- Changed image used for velero-tester to registry1.dso.mil/ironbank/big-bang/devops-tester

## [10.0.7-bb.1] - 2025-07-31

### Changed

- Converted chart to use pass-through method

## [10.0.7-bb.0] - 2025-06-24

### Changed

- Updated chart to 10.0.7
- ironbank/opensource/nginx/nginx 1.27.4 -> 1.28.0
- velero/velero-plugin-for-aws v1.12.0 -> v1.12.1
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-aws v1.12.0 -> v1.12.1
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-microsoft-azure v1.12.0 -> v1.12.1
- registry1.dso.mil/ironbank/opensource/kubernetes/kubectl v1.32.3 -> v1.32.6

## [10.0.1-bb.0] - 2025-04-15

### Changed

- Updated chart to 10.0.1
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-aws v1.11.1 -> v1.12.0
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-microsoft-azure v1.11.1 -> v1.12.0
- velero/velero-plugin-for-aws v1.11.1 -> v1.12.0
- registry1.dso.mil/ironbank/opensource/velero/velero (source) v1.15.2 -> v1.16.1
- registry1.dso.mil/ironbank/opensource/velero/velero (source) 1.15.2 -> 1.16.1

## [8.7.1-bb.1] - 2025-05-13

### Changed

- Fix networkpolicy minio egress bug

## [8.7.1-bb.0] - 2025-04-07

### Changed

- registry1.dso.mil/ironbank/opensource/kubernetes/kubectl (source) v1.31.7 -> v1.32.3

## [8.4.0-bb.3] - 2025-04-03

### Changed

- registry1.dso.mil/ironbank/opensource/kubernetes/kubectl (source) v1.30.9 -> v1.31.7

## [8.4.0-bb.2] - 2025-03-28

### Added

- Added Dynamic Network Policy

## [8.4.0-bb.1] - 2025-03-28

### Changed

- Updated nginx image in test script to 1.27.4

## [8.4.0-bb.0] - 2025-02-20

### Changed

- Updated velero to 8.4.0

## [8.3.0-bb.0] - 2025-01-22

### Added

- registry1.dso.mil/ironbank/opensource/kubernetes/kubectl (source) v1.30.8 -> v1.30.9
- registry1.dso.mil/ironbank/opensource/velero/velero (source) v1.15.1 -> v1.15.2
- registry1.dso.mil/ironbank/opensource/velero/velero (source) 1.15.1 -> 1.15.2

## [8.2.0-bb.1] - 2025-01-16

### Added

- Updated velero/velero-restore-helper v1.15.1 -> v1.15.2

## [8.2.0-bb.0] - 2024-01-08

### Added

- registry1.dso.mil/ironbank/opensource/velero/velero (source) v1.15.0 -> v1.15.1
- registry1.dso.mil/ironbank/opensource/velero/velero (source) 1.15.0 -> 1.15.1
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-microsoft-azure (source) v1.11.0 -> v1.11.1

## [8.1.0-bb.1] - 2024-12-27

### Added

- velero/velero-plugin-for-aws v1.11.0 -> v1.11.1
- velero/velero-restore-helper v1.15.0 -> v1.15.1

## [8.1.0-bb.0] - 2024-12-12

### Added

- Updated velero to 8.1.0
- Updated registry1.dso.mil/ironbank/opensource/kubernetes/kubectl (source) v1.30.7 -> v1.30.8

## [7.2.2-bb.4] - 2024-12-04

### Added

- Updated ironbank/opensource/nginx/nginx (source) 1.27.2 -> 1.27.3

## [7.2.2-bb.3] - 2024-11-25

### Added

- Updated registry1.dso.mil/ironbank/opensource/kubernetes/kubectl Docker tag to v1.30.7
- Added the maintenance track annotation and badge

## [7.2.2-bb.2] - 2024-11-15

### Added

- Added changes to BBCHANGES
- Added custom clusterole and clusterrolebindg to template bigbang
- Updated rules

## [7.2.2-bb.1] - 2024-11-07

### Changed

- Updated velero-restore-helper v1.14.1 -> v1.15.0
- Updated registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-microsoft-azure v1.10.1 -> v1.11.0
- Updated registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-aws v1.10.1 -> v1.11.0
- Updated registry1.dso.mil/ironbank/opensource/velero/velero 1.14.1 -> 1.15.0

## [7.2.2-bb.0] - 2024-10-31

### Changed

- Upgrade to upstream chart version 7.2.2

## [7.2.1-bb.5] - 2024-10-30

### Changed

- Fixed caCert issue preventing tls certs from being used with Backupstoragelocations

## [7.2.1-bb.4] - 2024-10-25

### Removed

- Reverted old Kiali Label commits

## [7.2.1-bb.3] - 2024-10-24

### Changed

- Updated registry1.dso.mil/ironbank/opensource/kubernetes/kubectl v1.30.5 -> v1.30.6

## [7.2.1-bb.2] - 2024-10-10

### Changed

- Updated registry1.dso.mil/ironbank/opensource/nginx/nginx to 1.27.2

## [7.2.1-bb.1] - 2024-09-25

### Changed

- Updated registry1.dso.mil/ironbank/opensource/kubernetes/kubectl v1.29.9 -> v1.30.5

## [7.2.1-bb.0] - 2024-09-17

### Changed

- Updated registry1.dso.mil/ironbank/opensource/kubernetes/kubectl v1.29.8 -> v1.29.9
- Updated chart to 7.2.1

## [7.1.5-bb.1] - 2024-09-12

### Changed

- Changed label in `node-agent` Daemonset to allow for templated values (`chart/templates/node-agent-daemonset.yaml`)

## [7.1.5-bb.0] - 2024-08-30

### Updated

- Updated velero version to 7.1.5
- velero/velero-plugin-for-aws v1.9.2 -> v1.10.1
- velero/velero-restore-helper v1.13.2 -> v1.14.1

## [6.7.0-bb.10] - 2024-08-27

### Updated

- Removed previous kiali label epic changes and updated to new pattern

## [6.7.0-bb.9] - 2024-08-21

### Changed

- Updated registry1.dso.mil/ironbank/opensource/kubernetes/kubectl v1.29.7 -> v1.29.8
- Updated ironbank/opensource/nginx/nginx 1.26.1 -> 1.26.2

## [6.7.0-bb.8] - 2024-08-15

### Changed

- Updated the service entries to include minio, and made dynamic with domain

## [6.7.0-bb.7] - 2024-08-02

### Changed

- Updated kubectl to v1.29.7
- URL fixes in DEVELOPMENT_MAINTENANCE.md

## [6.7.0-bb.6] - 2024-08-02

### Changed

- Updated test-values.yaml file to remove duplicate values that are already set in the chart defaults

## [6.7.0-bb.5] - 2024-08-01

### Added

- Added `bigbang.labels` helper function to authservice under `templates/bigbang`
- Added call to `bigbang.labels` function in pod template section of `chart/templates/deployment.yaml`

## [6.7.0-bb.4] - 2024-07-16

### Changed

- Removed shared auth policies

## [6.7.0-bb.3] - 2024-07-10

### Changed

- Added bigbang test integration within DEVELOPMENT_MAINTENANCE.md

## [6.7.0-bb.2] - 2024-06-18

### Changed

- registry1.dso.mil/ironbank/opensource/velero/velero v1.13.2 -> v1.14.0
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-microsoft-azure v1.9.2 -> v1.10.0

## [6.7.0-bb.1] - 2024-06-27

### Changed

- Fixed duplicate exportTo attribute in serviceentry.yaml

## [6.7.0-bb.0] - 2024-06-18

### Changed

- Updated to latest chart version `6.7.0`
- velero/velero-plugin-for-aws v1.9.2 -> v1.10.0
- velero/velero-restore-helper v1.13.2 -> v1.14.0
- registry1.dso.mil/ironbank/opensource/kubernetes/kubectl v1.29.5 -> v1.29.9
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-aws v1.9.2 -> v1.10.0

## [6.6.0-bb.0] - 2024-06-05

### Changed

- Updated to latest chart version `6.6.0`
- ironbank/opensource/nginx/nginx 1.26.0 -> 1.26.1

## [6.4.0-bb.0] - 2024-05-20

### Changed

- Updated to latest chart version `6.4.0`
- registry1.dso.mil/ironbank/opensource/kubernetes/kubectl v1.29.4 -> v1.29.5

## [6.1.0-bb.0] - 2024-05-15

### Changed

- Updated to latest chart version `6.1.0`
- ironbank/opensource/nginx/nginx 1.25.4 -> 1.26.0
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-csi v0.7.0 -> v0.7.1

## [6.0.0-bb.6] - 2024-04-29

### Changed

- registry1.dso.mil/ironbank/opensource/kubernetes/kubectl v1.29.3 -> v1.29.4
- registry1.dso.mil/ironbank/opensource/velero/velero v1.13.1 -> v1.13.2
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-aws v1.9.1 -> v1.9.2
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-microsoft-azure v1.9.1 -> v1.9.2

## [6.0.0-bb.5] - 2024-04-24

### Changed

- velero/velero-plugin-for-aws v1.9.1 -> v1.9.2
- velero/velero-plugin-for-csi v0.7.0 -> v0.7.1
- velero/velero-restore-helper v1.13.1 -> v1.13.2

## [6.0.0-bb.4] - 2024-04-10

### Changed

- Update dependency registry1.dso.mil/ironbank/opensource/kubernetes/kubectl to v1.29.3

## [6.0.0-bb.3] - 2024-04-03

### Added

- Added custom network policies

## [6.0.0-bb.2] - 2024-03-26

### Changed

- Adding Sidecar to deny egress that is external to istio services
- Adding customServiceEntries to allow egress to override sidecar

## [6.0.0-bb.1] - 2024-03-20

### Changed

- ironbank/opensource/nginx/nginx 1.25.3 -> 1.25.4
- registry1.dso.mil/ironbank/opensource/kubernetes/kubectl v1.28.6 -> v1.28.8
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-aws v1.9.0 -> v1.9.1
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-microsoft-azure v1.9.0 -> v1.9.1
- velero/velero-plugin-for-aws v1.9.0 -> v1.9.1

## [6.0.0-bb.0] - 2024-02-05

### Changed

- registry1.dso.mil/ironbank/opensource/velero/velero v1.12.3 -> v1.13.1
- registry1.dso.mil/ironbank/opensource/velero/velero 1.12.3 -> 1.13.1
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-aws v1.8.2 -> v1.9.0
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-csi v0.6.3 -> v0.7.0
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-microsoft-azure v1.8.2 -> v1.9.0
- velero/velero-plugin-for-aws v1.8.2 -> v1.9.0
- velero/velero-plugin-for-csi v0.6.3 -> v0.7.0
- velero/velero-restore-helper v1.12.3 -> v1.13.1

## [5.2.2-bb.2] - 2024-03-04

### Changed

- Openshift update for deploying Velero into Openshift cluster

## [5.2.2-bb.1] - 2024-02-08

### Added

- Added istio `allow-nothing` policy
- Added istio `monitoring-authz` policy
- Added istio `tempo-authz` policy
- Added istio `allow-http-envoy-prom` policy
- Added istio `allow-http` policy
- Added istio custom policy template

## [5.2.2-bb.0] - 2024-01-31

### Changed

- registry1.dso.mil/ironbank/opensource/kubernetes/kubectl v1.28.4 -> v1.28.6
- registry1.dso.mil/ironbank/opensource/velero/velero v1.12.2 -> v1.12.3
- registry1.dso.mil/ironbank/opensource/velero/velero 1.12.2 -> 1.12.3
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-csi v0.6.2 -> v0.6.3
- velero/velero-plugin-for-csi v0.6.2 -> v0.6.3
- velero/velero-restore-helper v1.12.2 -> v1.12.3

## [5.1.6-bb.0] - 2023-12-06

### Changed

- Updated to latest chart version `5.1.6`
- registry1.dso.mil/ironbank/opensource/velero/velero v1.12.1 -> v1.12.2
- registry1.dso.mil/ironbank/opensource/velero/velero 1.12.1 -> 1.12.2
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-aws v1.8.0 -> v1.8.2
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-csi v0.6.1 -> v0.6.2
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-microsoft-azure v1.8.0 -> v1.8.2
- velero/velero-plugin-for-csi v0.6.1 -> v0.6.2
- velero/velero-restore-helper v1.12.1 -> v1.12.2

## [5.1.3-bb.2] - 2023-11-25

### Changed

- Updated kubectl chart chart dependancy to `1.28.4`
- Updated velero-plugin-for-aws dependency to `1.8.2`

## [5.1.3-bb.1] - 2023-11-15

### Changed

- Updated kubectl chart chart dependancy to `1.28.3`

## [5.1.3-bb.0] - 2023-11-01

### Changed

- Updated to latest chart version `5.1.3`
- bump `controller-gen.kubebuilder.io/version:` to `v0.13.0`
- ironbank/opensource/nginx/nginx 1.25.2 -> 1.25.3
- registry1.dso.mil/ironbank/opensource/velero/velero v1.12.0 -> v1.12.1
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-csi v0.6.0 -> v0.6.1
- velero/velero-plugin-for-csi v0.6.0 -> v0.6.1
- velero/velero-restore-helper v1.12.0 -> v1.12.1

## [5.1.0-bb.0] - 2023-10-18

### Changed

- registry1.dso.mil/ironbank/opensource/kubernetes/kubectl 1.27.6 -> v1.27.3
- registry1.dso.mil/ironbank/opensource/velero/velero v1.11.1 -> v1.12.0
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-aws v1.7.1 -> v1.8.0
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-csi v0.5.1 -> v0.6.0
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-microsoft-azure v1.7.1 -> v1.8.0
- velero/velero-plugin-for-aws v1.7.1 -> v1.8.0
- velero/velero-plugin-for-csi v0.5.1 -> v0.6.0
- velero/velero-restore-helper v1.11.1 -> v1.12.0

## [5.0.2-bb.5] - 2023-10-18

### Changed

- OSCAL version update from 1.0.0 to 1.1.1

## [5.0.2-bb.4] - 2023-10-11

### Changed

- Added testing for scheduled backups

## [5.0.2-bb.3] - 2023-10-11

### Changed

- Fixing changelog entries

## [5.0.2-bb.2] - 2023-09-20

### Changed

- ironbank/opensource/nginx/nginx 1.25.1 -> 1.25.2
- registry1.dso.mil/bigbang-ci/velero-tester 1.0.0 -> 1.1.0
- registry1.dso.mil/ironbank/opensource/kubernetes/kubectl 1.27.4 -> 1.27.6
- Updated Gluon 0.3.1 -> 0.4.1

## [5.0.2-bb.1]

### Changed

- added Kopia integration volumes into the node-agent Daemonset and the Velero Deployment

## [5.0.2-bb.0]

### Changed

- ironbank/opensource/nginx/nginx 1.23.3 -> 1.25.1
- registry1.dso.mil/ironbank/opensource/kubernetes/kubectl v1.26.4 -> 1.27.4
- registry1.dso.mil/ironbank/opensource/velero/velero v1.11.0 -> v1.11.1
- registry1.dso.mil/ironbank/opensource/velero/velero 1.11.0 -> 1.11.1
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-aws v1.7.0 -> v1.7.1
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-csi v0.5.0 -> v0.5.1
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-microsoft-azure v1.7.0 -> v1.7.1
- velero/velero-plugin-for-aws v1.7.0 -> v1.7.1
- velero/velero-plugin-for-csi v0.5.0 -> v0.5.1
- velero/velero-restore-helper v1.11.0 -> v1.11.1

## [4.0.3-bb.0]

### Changed

- registry1.dso.mil/ironbank/opensource/velero/velero v1.10.2 -> v1.11.0
- registry1.dso.mil/ironbank/opensource/velero/velero 1.10.2 -> 1.11.0
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-aws v1.6.1 -> v1.7.0
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-csi v0.4.2 -> v0.5.0
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-microsoft-azure v1.6.1 -> v1.7.0
- velero/velero-plugin-for-aws v1.6.1 -> v1.7.0
- velero/velero-plugin-for-csi v0.4.2 -> v0.5.0
- velero/velero-restore-helper v1.10.2 -> v1.11.0

## [3.1.5-bb.1]

### Changed

- registry1.dso.mil/ironbank/opensource/kubernetes/kubectl patch v1.26.3 -> v1.26.4

## [3.1.5-bb.0]

### Changed

- registry1.dso.mil/ironbank/opensource/kubernetes/kubectl patch v1.26.2 -> v1.26.3
- registry1.dso.mil/ironbank/opensource/velero/velero patch v1.10.1 -> v1.10.2
- registry1.dso.mil/ironbank/opensource/velero/velero patch 1.10.1 -> 1.10.2
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-csi patch v0.4.1 -> v0.4.2
- velero/velero-plugin-for-csi patch v0.4.1 -> v0.4.2
- velero/velero-restore-helper patch v1.10.1 -> v1.10.2

## [3.1.2-bb.2]

### Changed

- Updated nginx to `1.23.3` and kubectl to `1.26.2`

## [3.1.2-bb.1]

### Changed

- Fixed mismatch between volume and mount for caCert

## [3.1.2-bb.0]

### Changed

- registry1.dso.mil/ironbank/opensource/kubernetes/kubectl minor v1.25.6 -> v1.26.1
- registry1.dso.mil/ironbank/opensource/velero/velero patch v1.10.0 -> v1.10.1
- registry1.dso.mil/ironbank/opensource/velero/velero patch 1.10.0 -> 1.10.1
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-aws patch v1.6.0 -> v1.6.1
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-csi patch v0.4.0 -> v0.4.1
- registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-microsoft-azure patch v1.6.0 -> v1.6.1
- velero/velero-plugin-for-aws patch v1.6.0 -> v1.6.1
- velero/velero-plugin-for-csi patch v0.4.0 -> v0.4.1
- velero/velero-restore-helper patch v1.10.0 -> v1.10.1

## [3.1.0-bb.3]

### Changed

- Updated kubectl to `1.25.6`

## [3.1.0-bb.2]

### Changed

- Added aws, azure, and csi plugin configuration options

## [3.1.0-bb.1]

### Changed

- Switch tester image to bigbang-ci source

## [3.1.0-bb.0]

### Changed

- Updated to latest chart version `3.1.0` (support for 1.10.0)

## [2.32.5-bb.0]

### Update

- Updated velero to `1.10.0`, upstream chart version `velero-2.32.5`, nginx to `1.23.2`, kubectl to `1.25.5`, and azure plugin to `1.6.0`

## [2.32.2-bb.0]

### Update

- Updated velero to `1.9.3`, upstream chart version `velero-2.32.2`, kubectl to `1.25.4`, and azure plugin to `1.5.2`

## [2.31.8-bb.5]

### Changed

- Added prometheusRule alerts for common velero failures

## [2.31.8-bb.4]

### Changed

- Added helm annotations for images in use

## [2.31.8-bb.3]

### Update

- updated velero plugins to latest IB versions

## [2.31.8-bb.2]

### Fixed

- Fixed `VolumeSnapshotContent` CRD name for capabilities check

## [2.31.8-bb.1]

### Changed

- Added capabilities check for CRDs on csi-snapshot-class

## [2.31.8-bb.0]

### Changed

- Updated to latest chart 2.31.8
- Updated velero to 1.9.2

## [2.31.3-bb.2]

### Added

- Added support for tlsConfig and scheme values in the serviceMonitor

### Removed

- Removed mTLS exception for metrics

## [2.31.3-bb.1]

### Changed

- Enabled drop all capabilities
- Updated gluon to 0.3.0

## [2.31.3-bb.0]

### Changed

- Updated to latest chart 2.31.3
- Updated velero to 1.9.1

## [2.30.1-bb.2]

### Added

- Added Grafana dasboard JSON & ConfigMap
- Original dashboard sourced from: <https://grafana.com/grafana/dashboards/11055-kubernetes-addons-velero-stats> which has been modified/updated to use non-deprecated metrics APIs. Hence, included version is not publicly available from any source as it is an adaptation.

## [2.30.1-bb.1]

### Fixed

- API version for CSI snapshot class updated to v1

## [2.30.1-bb.0]

### Updated

- KPT'd to upstream `velero-2.30.1`
- Updated velero to 1.9.0
- Updated plugins

## [2.29.0-bb.4]

### Changed

- set the runAsUser/runAsGroup to 65534/65534 -- this is the default for the kyverno docker image.
- set host_pods restic mount to read-only.

## [2.29.0-bb.3]

### Added

- OSCAL UUID updates

## [2.29.0-bb.2]

### Added

- OSCAL Document for NIST 800-53

## [2.29.0-bb.1]

### Updated

- Added Tempo Zipkin Egress Policy

## [2.29.0-bb.0]

### Updated

- Bumped chart version to 2.29.0
- Bumped Velero image tag to v1.8.1
- Bumped Velero aws image tag to v1.4.1
- Bumped Velero azure image tag to v1.4.1
- Bumped Velero helper image tag to v1.8.1

## [2.28.0-bb.1]

### Added

- Add default PeerAuthentication to enable STRICT mTLS

## [2.28.0-bb.0]

### Updated

- Bumped chart version to 2.28.0
- Bumped Velero image tag to v1.8.0
- Bumped Velero aws image tag to v1.4.0
- Bumped Velero azure image tag to v1.4.0
- Bumped Velero helper image tag to v1.8.0

## [2.27.3-bb.3]

### Updated

- Updates for bb helm tests

## [2.27.3-bb.2]

### Updated

- Updated kubectl image repository to point to registry1.dso.mil/ironbank/opensource/kubernetes
- Updated kubectl version to 1.22.2

## [2.27.3-bb.1]

### Updated

- Update Chart.yaml to follow new standardization for release automation
- Added renovate check to update new standardization

## [2.27.3-bb.0]

### Changed

- Updated to Velero 1.7.1 and latest helm chart

## [2.23.6-bb.4]

### Changed

- relocated bbtests

## [2.23.6-bb.3]

### Added

- modify tests to look only in velero NS
- updated images in tests for:
  - minio - for backup/restore
  - kubectl
  - nginx
  - velero
  - velero-plugin-for-aws
  - miniooperator
  - minio

## [2.23.6-bb.2]

### Added

- Added VolumeSnapshotClass if CSI plugin is enabled

## [2.23.6-bb.1]

### Changed

- Moved testing to gluon library

## [2.23.6-bb.0]

### Added

- bumped registry1 velero image tag to 1.6.3
- bumped upstream chart to velero-2.23.6

## [2.23.5-bb.1]

### Added

- Added resource limits and requests to upgrade and cleanup jobs
- Set requests and limits equal to each other
- Added resources to test-values initContainer

## [2.23.5-bb.0]

### Updated

- bumped registry1 velero image tag to 1.6.2
- Updated upstream chart to velero-2.23.5

## [2.23.3-bb.0]

### Updated

- bumped Registry1 Velero image tag to 1.6.1

### Added

- Velero plugin for CSI

## [2.21.1-bb.6]

### Added

- Bigbang network policy to allow prometheus scraping of istio envoy sidecar
- monitoring.enabled to values and scraping net policies to stay in line with bigbang standards

## [2.21.1-bb.5]

### Added

- Helm function in API Egress Network Policy Template to avoid crashes when non 0.0.0.0/0 CIDR is specified

## [2.21.1-bb.4]

### Fixed

- Turned off sidecars for jobs
- Fixed NPs that were blocking job API access

## [2.21.1-bb.3]

### Added

- ENV for Azure CA Bundle trusting

## [2.21.1-bb.2]

### Added

- Trusting of custom CA bundle cert for AWS (secret creation, volume mounting, env setup)
- Note: May only work on AWS due to env name and available upstream docs surrounding this

## [2.21.1-bb.1]

### Added

- Added Optional network policies

## [2.21.1-bb.0]

### Updated

- realigned Helm chart to use `.Values.initContainers` like upstream chart
- bumped Registry1 Velero image tag to 1.6.0

## [2.14.8-bb.0]

### Added

- added initial tag for Velero
- added CI testing using Helm library and bash script
