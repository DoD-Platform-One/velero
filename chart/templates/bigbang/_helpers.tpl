{{/*
Common labels
*/}}
{{- define "velero.labels" -}}
helm.sh/chart: {{ include "velero.chart" . }}
{{ include "velero.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "velero.selectorLabels" -}}
app.kubernetes.io/name: {{ include "velero.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
