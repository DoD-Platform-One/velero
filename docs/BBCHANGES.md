# Changes needed for Iron Bank Images and Big Bang

Due to how Big Bang is making use of Velero, there were values and chart changes that needed to be made.
Additionally, the Iron Bank images function in slightly different ways than upstream DockerHub images, so additional
modifications were made to support their use.

This provides a log of these changes to make updates from upstream faster.

## Iron Bank Modifications

All images were updated to be from Iron Bank. Additionally, an image pull secret was specified to enable Big Bang to pull them correctly. In the values file:

```yaml
image:
  repository: registry1.dso.mil/ironbank/opensource/velero/velero
  tag: v1.7.0
  pullPolicy: IfNotPresent
  imagePullSecrets:
    - private-registry

initContainers:
  - name: velero-plugin-for-aws
    image: registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-aws:v1.2.0
    imagePullPolicy: IfNotPresent
    volumeMounts:
      - mountPath: /target
        name: plugins
  - name: velero-plugin-for-microsoft-azure
    image: registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-microsoft-azure:v1.2.0
    imagePullPolicy: IfNotPresent
    volumeMounts:
      - mountPath: /target
        name: plugins
  - name: velero-plugin-for-csi
    image: registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-csi:v0.1.2
    imagePullPolicy: IfNotPresent
    volumeMounts:
      - mountPath: /target
        name: plugins

kubectl:
  image:
    repository: registry1.dso.mil/ironbank/opensource/kubernetes-1.21/kubectl
    tag: v1.21.1

configMaps:
  restic-restore-action-config:
    data:
      image: registry1.dso.mil/ironbank/opensource/velero/velero-restic-restore-helper:v1.7.0
```

## Big Bang Modifications

Added at the bottom of the values file are changes to support Istio, monitoring, and optional network policies.

```yaml
istio:
  enabled: false

monitoring:
  enabled: false

networkPolicies:
  enabled: false
  ingressLabels:
    app: istio-ingressgateway
    istio: ingressgateway
  controlPlaneCidr: 0.0.0.0/0
```

All chart changes are located under the `chart/templates/bigbang` directory. In summary:

- Optional creation of network policies

As additional Big Bang changes are made they should be added in these spots and this doc updated to reflect that.

## Other Modifications

In addition to the Iron Bank and Big Bang changes, the following changes were made to the chart.

- In `chart/values.yaml`, Istio sidecar injection was disabled on the kubectl image to allow the `upgrade-crds.yaml` and `cleanup-crds.yaml` jobs to succeed:

```yaml
kubectl:
  annotations:
    sidecar.istio.io/inject: "false"
```

- To support CA bundle trusting, `chart/templates/cert-secret.yaml` was added and `chart/templates/deployment.yaml` was modified to utilize this cert:

```yaml
spec:
  template:
    spec:
      containers:
          volumeMounts:
            {{- if not (empty .Values.configuration.backupStorageLocation.caCert) }}
            - name: cacert
              subPath: ca-bundle.crt
              mountPath: /etc/ssl/certs/ca-bundle.crt
            {{- end }}
          env:
            {{- if not (empty .Values.configuration.backupStorageLocation.caCert) }}
            {{- if eq $provider "aws" }}
            - name: AWS_CA_BUNDLE
              value: /etc/ssl/certs/ca-bundle.crt
            {{- else if eq $provider "azure" }}
            - name: REQUESTS_CA_BUNDLE
              value: /etc/ssl/certs/ca-bundle.crt
            {{- end }}
            {{- end }}
      volumes:
        {{- if not (empty .Values.configuration.backupStorageLocation.caCert) }}
        - name: cabundle
          secret:
            secretName: {{ include "velero.secretName" . }}-cabundle
        {{- end }}
```

- Velero default RBAC modification. Previous role has full access (\*) to all API groups, resources, and verbs, allowing unrestricted access to cluster resources. This updated role is now restricted to specific resources and actions needed for Velero to deploy with default rbac in both the core Kubernetes API and the velero.io API group.

```yaml
{{- if .Values.rbac.create }}
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: velero-default-rbac-role
  namespace: {{ .Release.Namespace }}
  labels:
    app.kubernetes.io/component: server
    app.kubernetes.io/name: {{ include "velero.name" . }}
    app.kubernetes.io/instance: {{ .Release.Name }}
    app.kubernetes.io/managed-by: {{ .Release.Service }}
    helm.sh/chart: {{ include "velero.chart" . }}
rules:
  - apiGroups: [""]
    resources: ["pods", "persistentvolumeclaims", "namespaces", "secrets", "services"]
    verbs: ["get", "list", "watch", "create", "delete"]
  - apiGroups: ["apps"]
    resources: ["daemonsets", "replicasets", "statefulsets", "deployments", "services"]
    verbs: ["get", "list", "watch", "delete"]
  - apiGroups: ["autoscaling"]
    resources: ["horizontalpodautoscalers"]
    verbs: ["get", "list", "create", "watch", "delete"]
  - apiGroups: ["batch"]
    resources: ["cronjobs", "jobs"]
    verbs: ["get", "list", "create", "watch"]
  - apiGroups: ["velero.io"]
    resources: [""]
    verbs: ["create", "get", "list", "update", "patch", "delete", "watch"]
{{- end }}
```
