## Role

A Role is like a ClusterRole but limited to a specific namespace.

## **Use Case**

This is used when to restrict velero's access to resources in a single namespace.

**Creating a Role** :

kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
namespace: example-namespace
name: example-role
rules:

- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]

**kind** : Role

Explanation: This specifies that we are creating a Role, which is an RBAC (Role-Based Access Control) resource in Kubernetes.

Purpose: A Role defines a set of permissions within a specific namespace. Unlike ClusterRole, which applies cluster-wide, Role only applies within the namespace specified in the metadata section.

**apiVersion** : rbac.authorization.k8s.io/v1

Explanation: This specifies the API version for the Role resource, which is rbac.authorization.k8s.io/v1.

Purpose: The API version helps Kubernetes understand how to interpret the configuration. Here, it tells Kubernetes that this is an RBAC resource, which is part of Kubernetes' authorization mechanism.

**metadata**

Explanation: This section contains metadata for the Role, including the namespace and name of the role.

namespace: example-namespace: Specifies the namespace where this role will be applied. This Role will only grant permissions to resources within the example-namespace.

name: example-role: The name of the role, which can be used to refer to this role in a RoleBinding (binding). In this case, the role is called example-role.

**rules**

Explanation: This is the core of the Role definition, where you specify what permissions this role grants.

Details:
Each item in the rules list is a permission rule defining what resources can be accessed and what actions (verbs) can be performed on them.
Here’s a breakdown of this particular rule:

apiGroups : [""]:

Explanation: The apiGroups field specifies the API group the resources belong to. In this case, [""] represents the "core" or "default" API group, which includes basic resources like pods, services, configmaps, etc.

Purpose: Since we’re working with pods, which are part of the core API group, we leave this field empty.

resources: ["pods"]:

Explanation: Specifies the resource type that this role applies to. In this case, it's set to ["pods"], meaning this role provides permissions specifically for pods within the example-namespace.

Purpose: This restricts the role to only managing pods. If you wanted to give permissions for other resources like services or configmaps, you would add them to this list.

verbs: ["get", "list", "watch"]:

Explanation: This field defines the actions that can be performed on the specified resources. Here:

get: Allows retrieving information about individual pods.

list: Allows listing all pods within the namespace.

watch: Allows watching for changes to the pods, which is useful for monitoring tools.

Purpose: These actions are typical for a "read-only" role. By restricting the actions to get, list, and watch, this role only allows viewing pods but not creating, updating, or deleting them.
