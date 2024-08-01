{{/*
Bigbang labels
*/}}
{{- define "bigbang.labels" -}}
app: {{ template "velero.name" . }}
{{- if .Chart.AppVersion }}
version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end }}
