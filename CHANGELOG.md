# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---
## [2.21.1-bb.0]
### Updated
- bumped Helm chart version to 2.21.1
- realigned Helm chart to use `.Values.initContainers` like upstream chart
- bumped Registry1 Velero image tag to 1.6.0

## [2.14.8-bb.0]
### Added
- added initial tag for Velero
- added CI testing using Helm library and bash script