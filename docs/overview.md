# Velero

## Overview

This package contains an extensible and configurable installation of Velero based on the upstream chart provided by vmware-tanzu.

## Velero

Velero is an open source tool to safely backup and restore, perform disaster recovery, and migrate Kubernetes cluster resources and persistent volumes. Velero has two main components: a command line interface (CLI) and a server-side Kubernetes deployment.

## How it works

Each Velero operation (on-demand backup, scheduled backup, restoration) is a custom resource that is defined with a Kubernetes custom resource definition, or CRD, and stored in `etcd`. Velero includes controllers that process the CRDs to back up and restore resources. You can back up or restore all objects in your cluster, or you can filter objects by type, namespace, or label.

Data protection is a chief concern for application owners who want to make sure that they can restore a cluster to a known good state, recover from a crashed cluster, or migrate to a new environment. Velero provides those capabilities.
