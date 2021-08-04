# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---
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
