# **Background**

Velero uses Role-Based Access Control (RBAC) in Kubernetes to manage permissions for its operations across the cluster. RBAC defines which users or service accounts have access to certain resources and the actions they can perform on those resources. In Kubernetes, RBAC resources like ClusterRole, ClusterRoleBinding, Role, and RoleBinding are used to define and apply permissions.

This document provides guidance on creating custom RBAC templates for Velero and explains when and why each RBAC component might be needed.

The main RBAC components needed to configure for Velero:

- ClusterRole
- ClusterRoleBinding
- Role
- RoleBinding

**Best Practices**
Recommend using the principle of least privilege.
Describe how to limit access based on job role and necessity.
Include tips for managing and auditing RBAC configurations.

**Troubleshooting and Common Issues**
List some common issues that users might encounter and solutions.
Example: Access denied due to misconfigured roles or bindings.
