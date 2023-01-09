# To upgrade the Velero Package

Check the [upstream changelog](url_needed) and the [helm chart upgrade notes](url_needed).

# Upgrading

## Update dependencies

To Do

## Update binaries

Pull assets and commit the binaries as well as the Chart.lock file that was generated.
```
helm dependency update ./chart
```

## Update chart

```chart/Chart.yaml```
- To Do

# Modifications made to upstream
This is a high-level list of modifications that Big Bang has made to the upstream helm chart. You can use this as as cross-check to make sure that no modifications were lost during the upgrade process.

## chart/values.yaml

- Added values for `istio`, `networkPolicies`, and `bbtests`
- Changed image to default to Ironbank image
- Set default `podSecurityContext`, `containerSecurityContext`,  and `imagePullSecrets`
- Added commented out values for `serviceMonitor.scheme` and `serviceMonitor.tlsConfig`

## chart/templates/deployment.yaml

- Added CA bundle conditionally as ENV/volume mount

## chart/templates/cert-secret.yaml

- Added file/secret for CA cert

## chart/templates/upgrade-crds/upgrade-crds.yaml

- Added resources for containers

## chart/templates/bigbang/

- Network policies added
- Istio mTLS (peerauthentication) resources added
- Grafana dashboard added
- CSI Snapshot class added
# Testing new Velero Version

- Deploy Velero as a part of BigBang
```
helm upgrade \
  --install bigbang ./bigbang/chart \
  --create-namespace \
  --namespace bigbang \
  --values ./bigbang/chart/values.yaml \
  --values ./bigbang/chart/ingress-certs.yaml \
  --values ./overrides/ib_creds.yaml \
  --values ./overrides/velero.yaml \
  --values ./overrides/minio.yaml \
  --set monitoring.enabled=true \
  --set kyverno.enabled=false \
  --set kyvernopolicies.enabled=false \
  --set clusterAuditor.enabled=false \
  --set gatekeeper.enabled=false \
  --set twistlock.enabled=false \
  --set eckoperator.enabled=false \
  --set fluentbit.enabled=false \
  --set logging.enabled=false \
  --set jaeger.enabled=false
```
`overrides/velero.yaml`
```
addons:
  velero:
    enabled: true
    plugins:
    - aws
    values:
      image:
        imagePullSecrets:
        - private-registry

      configuration:
        provider: aws
        backupStorageLocation:
          bucket: velero99
          config:
            region: "us-gov-west-1"
            insecureSkipTLSVerify: "true"
            s3ForcePathStyle: "true"
            s3Url: http://minio.minio.svc
        volumeSnapshotLocation:
          provider: aws
          config:
            region: "us-gov-west-1"

      credentials:
        useSecret: true
        secretContents:
          cloud: |
            [default]
            aws_access_key_id = minio
            aws_secret_access_key = minio123

      # Set a service account so that the CRD clean up job has proper permissions to delete CRDs
      serviceAccount:
        server:
          name: velero

      cleanUpCRDs: true

      networkPolicies:
        enabled: true

      bbtests:
        enabled: true
```
`overrides/minio.yaml`
```
addons:
  minioOperator:
    enabled: true

  minio:
    enabled: true
    values:
      tenants:
        pools:
        - servers: 2
          volumesPerServer: 4
          size: 256Mi
          resources:
            requests:
              cpu: 250m
              memory: 2Gi
            limits:
              cpu: 250m
              memory: 2Gi
          securityContext:
            runAsUser: 1001
            runAsGroup: 1001
            fsGroup: 1001
            runAsNonRoot: true
      bbtests:
        enabled: false
        cypress:
          envs:
            cypress_url: 'https://minio.bigbang.dev/login'
        scripts:
          envs:
            MINIO_PORT: ''
            MINIO_HOST: 'https://minio-api.bigbang.dev'
```

- Visit `https://prometheus.bigbang.dev`
- ...more to do...

