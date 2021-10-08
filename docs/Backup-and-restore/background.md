
# **Background**

Velero gives you the ability to back up and restore your Kubernetes cluster resources and persistent volumes.

You can run Velero with a cloud provider or on-premises. Velero lets you:

- Take backups of your cluster and restore in case of loss.
- Migrate cluster resources to other clusters.
- Replicate your production cluster to development and testing clusters.


This documentation aims to provides guidance on using Velero for BigBang.  The use cases described here will help inform Disaster recovery planning as well as adhoc backup and restore situations.

The following topics are going to be covered.

- [Backup a single namespace](./namespace-backup.md)
- [Backup an application by label selector](./label-based-backup.md)
- [Full cluster backup](./full-cluster-backup.md)
- [Applying a backup schedule](./scheduled-backup.md)
- [Sample manifests](./examples/)
- [Troubleshooting and additional links](./troubleshooting-links.md)
