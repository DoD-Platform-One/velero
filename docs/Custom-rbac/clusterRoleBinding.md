## ClusterRoleBinding

A clusterRoleBinding links a clusterRole with a service account, user, or group, granting permissions across the entire cluster.

## **Use Cases**

This is used to grant Velero permissions across the entire cluster to a specific ServiceAccount or user.

## **Creating a ClusterRoleBinding**

**apiVersion: rbac.authorization.k8s.io/v1**: This specifies the API version for the ClusterRoleBinding resource, which is rbac.authorization.k8s.io/v1. It tells Kubernetes that this resource is part of the RBAC API. This is necessary so Kubernetes knows how to interpret the resource.

**kind**: This define resource as a ClusterRoleBinding

**metadata.name**: Assigns a name to the ClusterRoleBinding.

**subjects**: Specifies the entity (ServiceAccount) that gets the permissions. It binds the velero ServiceAccount in the velero namespace.

**roleRef**: References the ClusterRole to apply the permissions defined in that role.
