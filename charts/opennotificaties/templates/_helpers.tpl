{{/*
Expand the name opennotificaties the chart.
*/}}
{{- define "opennotificaties.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "opennotificaties.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "opennotificaties.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "opennotificaties.commonLabels" -}}
helm.sh/chart: {{ include "opennotificaties.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
opennotificaties labels
*/}}
{{- define "opennotificaties.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "opennotificaties.commonLabels" . }}
{{ include "opennotificaties.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "opennotificaties.selectorLabels" -}}
app.kubernetes.io/name: {{ include "opennotificaties.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "opennotificaties.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "opennotificaties.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for the worker
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "opennotificaties.workerName" -}}
{{ include "opennotificaties.name" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "opennotificaties.workerFullname" -}}
{{ include "opennotificaties.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Worker labels
*/}}
{{- define "opennotificaties.workerLabels" -}}
{{ include "opennotificaties.commonLabels" . }}
{{ include "opennotificaties.workerSelectorLabels" . }}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "opennotificaties.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "opennotificaties.workerName" . }}
{{- end }}

{{/*
Create a name for the celery beat
We truncate at 56 chars in order to provide space for the "-beat" suffix
*/}}
{{- define "opennotificaties.beatName" -}}
{{ include "opennotificaties.name" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "opennotificaties.beatFullname" -}}
{{ include "opennotificaties.fullname" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Beat labels
*/}}
{{- define "opennotificaties.beatLabels" -}}
{{ include "opennotificaties.commonLabels" . }}
{{ include "opennotificaties.beatSelectorLabels" . }}
{{- end }}

{{/*
Beat selector labels
*/}}
{{- define "opennotificaties.beatSelectorLabels" -}}
app.kubernetes.io/name: {{ include "opennotificaties.beatName" . }}
{{- end }}

{{/*
Create a name for Flower
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "opennotificaties.flowerName" -}}
{{ include "opennotificaties.name" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Create a default fully qualified name for Flower.
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "opennotificaties.flowerFullname" -}}
{{ include "opennotificaties.fullname" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Flower labels
*/}}
{{- define "opennotificaties.flowerLabels" -}}
{{ include "opennotificaties.commonLabels" . }}
{{ include "opennotificaties.flowerSelectorLabels" . }}
{{- end }}

{{/*
Flower selector labels
*/}}
{{- define "opennotificaties.flowerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "opennotificaties.flowerName" . }}
{{- end }}

{{/*
Ingress annotations
*/}}
{{- define "opennotificaties.ingress.annotations" -}}
  {{- range $key, $val := .Values.ingress.annotations }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
{{- end }}

{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "opennotificaties.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "opennotificaties.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}