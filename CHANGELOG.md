# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---
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
