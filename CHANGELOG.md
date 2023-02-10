# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---
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
- Original dashboard sourced from: https://grafana.com/grafana/dashboards/11055-kubernetes-addons-velero-stats which has been modified/updated to use non-deprecated metrics APIs. Hence, included version is not publicly available from any source as it is an adaptation.

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
