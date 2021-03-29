{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "velero.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "velero.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "velero.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account to use for creating or deleting the velero server
*/}}
{{- define "velero.serverServiceAccount" -}}
{{- if .Values.serviceAccount.server.create -}}
    {{ default (printf "%s-%s" (include "velero.fullname" .) "server") .Values.serviceAccount.server.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.server.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name for the credentials secret.
*/}}
{{- define "velero.secretName" -}}
{{- if .Values.credentials.existingSecret -}}
  {{- .Values.credentials.existingSecret -}}
{{- else -}}
  {{ default (include "velero.fullname" .) .Values.credentials.name }}
{{- end -}}
{{- end -}}

{{- define "velero.initContainers" }}
{{- if eq (len .Values.plugins) 0 }}{{- fail "At least one plugin in '.Values.plugins' required. Supported values: aws, azure" }}{{- end }}
      initContainers:
{{- range .Values.plugins }}
{{- if eq . "aws" }}
      - name: velero-plugin-for-aws
        image: {{ $.Values.pluginImages.aws.repository }}:{{ $.Values.pluginImages.aws.tag }}
        imagePullPolicy: IfNotPresent
        volumeMounts:
          - mountPath: /target
            name: plugins
{{- else if eq . "azure" }}
      - name: velero-plugin-for-azure
        image: {{ $.Values.pluginImages.azure.repository }}:{{ $.Values.pluginImages.azure.tag }}
        imagePullPolicy: IfNotPresent
        volumeMounts:
          - mountPath: /target
            name: plugins
{{- end }}
{{- end }}
{{- end }}

{{/*
Create the Velero priority class name.
*/}}
{{- define "velero.priorityClassName" -}}
{{- if .Values.priorityClassName -}}
  {{- .Values.priorityClassName -}}
{{- else -}}
  {{- include "velero.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Create the Restic priority class name.
*/}}
{{- define "velero.restic.priorityClassName" -}}
{{- if .Values.restic.priorityClassName -}}
  {{- .Values.restic.priorityClassName -}}
{{- else -}}
  {{- include "velero.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Create the backup storage location name
*/}}
{{- define "velero.backupStorageLocation.name" -}}
{{- with .Values.configuration.backupStorageLocation -}}
{{ default "default" .name }}
{{- end -}}
{{- end -}}

{{/*
Create the backup storage location provider
*/}}
{{- define "velero.backupStorageLocation.provider" -}}
{{- with .Values.configuration -}}
{{ default .provider .backupStorageLocation.provider }}
{{- end -}}
{{- end -}}

{{/*
Create the volume snapshot location name
*/}}
{{- define "velero.volumeSnapshotLocation.name" -}}
{{- with .Values.configuration.volumeSnapshotLocation -}}
{{ default "default" .name }}
{{- end -}}
{{- end -}}

{{/*
Create the volume snapshot location provider
*/}}
{{- define "velero.volumeSnapshotLocation.provider" -}}
{{- with .Values.configuration -}}
{{ default .provider .volumeSnapshotLocation.provider }}
{{- end -}}
{{- end -}}

{{/*
Helm hooks for Helm v2 CRDs 
*/}}
{{- define "velero.helmhooks.crds" -}}
{{ print "\"helm.sh/hook\": pre-install,pre-upgrade" | indent 4 }}
{{ print "\"helm.sh/hook-delete-policy\": \"before-hook-creation\"" | indent 4 }}
{{- end -}}
