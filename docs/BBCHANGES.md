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
  tag: <version>
  pullPolicy: IfNotPresent
  imagePullSecrets:
    - private-registry

initContainers:
  - name: velero-plugin-for-aws
    image: registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-aws:<version>
    imagePullPolicy: Always
    volumeMounts:
      - mountPath: /target
        name: plugins
  - name: velero-plugin-for-microsoft-azure
    image: registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-microsoft-azure:<version>
    imagePullPolicy: Always
    volumeMounts:
      - mountPath: /target
        name: plugins
  - name: velero-plugin-for-csi
    image: registry1.dso.mil/ironbank/opensource/velero/velero-plugin-for-csi:<version>
    imagePullPolicy: Always
    volumeMounts:
      - mountPath: /target
        name: plugins

kubectl:
  image:
    repository: registry1.dso.mil/ironbank/big-bang/base
    tag: <version>
  containerSecurityContext:
    capabilities:
      drop:
        - ALL
  resources:
    requests:
      memory: 100Mi
      cpu: 100m
    limits:
      memory: 256Mi
      cpu: 100m
  annotations:
    sidecar.istio.io/inject: "false"
```

Big Bang specific integration is included using bb-common helm library included as a subchart. Additional Velero package specific templates added by big bang are found under the `chart/templates/bigbang` directory.

## Other Modifications

In addition to the Iron Bank and Big Bang changes, the following changes were made to the chart.

- In `chart/values.yaml`, Istio sidecar injection was disabled on the kubectl image to allow the `upgrade-crds.yaml` and `cleanup-crds.yaml` jobs to succeed:

```yaml
kubectl:
  annotations:
    sidecar.istio.io/inject: "false"
```