## RoleBinding

A RoleBinding associates a Role with a ServiceAccount, User, or Group within a specific namespace.

## **Use Case**

This is used to bind velero's namespace specific permissions (defined in a Role) to a ServiceAccount.

**Creating a RoleBinding** :

kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
name: example-rolebinding
namespace: example-namespace
subjects:

- kind: User
  name: example-user
  apiGroup: rbac.authorization.k8s.io
  roleRef:
  kind: Role
  name: example-role
  apiGroup: rbac.authorization.k8s.io

**kind** : RoleBinding

Explanation: This specifies that we are creating a RoleBinding, an RBAC (Role-Based Access Control) resource in Kubernetes.

Purpose: A RoleBinding connects a specific Role with a user, group, or service account within a particular

namespace. Unlike ClusterRoleBinding, which applies across the entire cluster, RoleBinding applies only to a single namespace.

**apiVersion** : rbac.authorization.k8s.io/v1

Explanation: This specifies the API version for the RoleBinding resource, which is rbac.authorization.k8s.io/v1.

Purpose: The API version helps Kubernetes understand how to interpret the configuration. Here, it indicates that this resource is part of the RBAC (authorization) API.

**metadata**

Explanation: This section contains metadata for the RoleBinding, including the name and the namespace where it will be applied.

name: example-rolebinding: The name of this RoleBinding, which can be used to identify it.

namespace: example-namespace: Specifies the namespace where this RoleBinding will apply. It means that this RoleBinding only grants access within the example-namespace.

**subjects**

Explanation: The subjects section defines who will receive the permissions specified by the Role.
Each item in the subject(s) list describes a user, group, or service account that will be bound to the role.

In this case:
kind: User: Indicates that the subject is a user.

name: example-user: The name of the user who will receive the permissions. Here, it is example-user.

apiGroup: rbac.authorization.k8s.io: Specifies the API group. For standard RBAC resources, this is rbac.authorization.k8s.io.

Purpose: This section ensures that the specified user (example-user) will receive the permissions defined in the Role referenced in the roleRef section.

**roleRef**

Explanation: This section specifies the role that will be granted to the subject(s).

kind: Role: Indicates that the binding refers to a Role. Note that RoleBinding can reference both Role (namespace-specific) and ClusterRole (cluster-wide), but in this case, we’re referencing a Role.

name: example-role: The name of the role being referenced, which is example-role. This should match the name of an existing Role in example-namespace.

apiGroup: rbac.authorization.k8s.io: Specifies the API group, which is rbac.authorization.k8s.io for RBAC resources.

Purpose: This section establishes a link between the RoleBinding and the Role defined elsewhere in the namespace, meaning that the permissions defined in example-role are granted to example-user.
