## ClusterRole

A clusterRole defines permissions for resources that can apply across all namespaces or the entire cluster.

## ** Use Case**

Namespaces: A clusterRole is needed when Velero needs permissions to interact with resources in multiple namespaces, such as accessing persistent volumes or namespaces during backup and restore.

Non-Namespace Resources: Certain resources in Kubernetes are not tied to any specific namespace, like nodes, persistent volumes, and storage classes. ClusterRole is required to manage these cluster-wide resources because Role is limited to a single namespace.

Cluster-Level access: A System Administrator or cluster operators may need full or partial access to cluster resources. ClusterRole can be used to give precise permissions across the cluster without granting them full administrative access.

## ** Why Use ClusterRole**

Centralized Permission Management:

Using ClusterRole can define permissions in one place and apply them consistently across namespaces or the entire cluster. Useful for roles like view-only access or read/write access.

Least Privilege:

Using ClusterRole allows you to grant specific, minimal permissions across the cluster, rather than defaulting to full admin access, helping enforce security best practices.

## **Creating a ClusterRole**

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
name: example-clusterrole
rules:

- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
- apiGroups: [""]
  resources: ["nodes"]
  verbs: ["get", "list", "watch"]

**apiVersion** : rbac.authorization.k8s.io/v1

Explanation: This specifies the API version for the ClusterRole resource, which is rbac.authorization.k8s.io/v1.

Purpose: The API version tells Kubernetes how to interpret this configuration. In this case, it indicates that this is an RBAC (Role-Based Access Control) resource.

**kind** : ClusterRole

Explanation: This specifies that we are creating a ClusterRole, which is an RBAC resource in Kubernetes.

Purpose: Unlike a Role, which applies to a single namespace, a ClusterRole can apply across all namespaces in the cluster or to resources that are not namespace-specific (such as nodes).

**metadata**

Explanation: This section contains metadata for the ClusterRole, including the name of the role.

name: example-clusterrole: The name of this ClusterRole, which can be referenced by ClusterRoleBindings to assign the role to users, groups, or service accounts.

**rules**

Explanation: This is the core of the ClusterRole definition, where you specify what permissions this role grants.

Each item in the rules list defines a permission rule, specifying which resources can be accessed and what actions (verbs) are allowed on those resources.
Here’s a breakdown of the specific rules in this ClusterRole:

Rule 1: Pods

- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]

apiGroups: [""]:

Explanation: This field specifies the API group the resource belongs to. In this case, [""] represents the "core" or "default" API group, which includes basic resources like pods, services, and configmaps.

resources: ["pods"]:

Explanation: Specifies that this rule applies to pods.

verbs: ["get", "list", "watch"]:

Explanation: Defines the actions (verbs) that can be performed on pods.

get: Allows retrieving details of individual pods.

list: Allows listing all pods within a namespace or across all namespaces, depending on the binding.

watch: Allows monitoring for changes to pods, which is often useful for monitoring or logging tools.

Rule 2: Nodes

- apiGroups: [""]
  resources: ["nodes"]
  verbs: ["get", "list", "watch"]

apiGroups: [""]: Again, this rule applies to the core API group.

resources: ["nodes"]:

Explanation: Specifies that this rule applies to nodes, which is a cluster-wide resource and not tied to any specific namespace.

verbs: ["get", "list", "watch"]:

Explanation: Defines the allowed actions on nodes.

get: Allows retrieving details of individual nodes.

list: Allows listing all nodes in the cluster.

watch: Allows monitoring for changes to nodes.
