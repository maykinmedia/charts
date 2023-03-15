{{/*
Expand the name openzaak the chart.
*/}}
{{- define "openzaak.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "openzaak.fullname" -}}
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
{{- define "openzaak.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "openzaak.commonLabels" -}}
helm.sh/chart: {{ include "openzaak.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
openzaak labels
*/}}
{{- define "openzaak.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "openzaak.commonLabels" . }}
{{ include "openzaak.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "openzaak.selectorLabels" -}}
app.kubernetes.io/name: {{ include "openzaak.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "openzaak.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "openzaak.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for NGINX
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "openzaak.nginxName" -}}
{{ include "openzaak.name" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
Create a default fully qualified name for NGINX.
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "openzaak.nginxFullname" -}}
{{ include "openzaak.fullname" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
NGINX labels
*/}}
{{- define "openzaak.nginxLabels" -}}
{{ include "openzaak.commonLabels" . }}
{{ include "openzaak.nginxSelectorLabels" . }}
{{- end }}

{{/*
NGINX selector labels
*/}}
{{- define "openzaak.nginxSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openzaak.nginxName" . }}
{{- end }}

{{/*
Create a name for the worker
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openzaak.workerName" -}}
{{ include "openzaak.name" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openzaak.workerFullname" -}}
{{ include "openzaak.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Worker labels
*/}}
{{- define "openzaak.workerLabels" -}}
{{ include "openzaak.commonLabels" . }}
{{ include "openzaak.workerSelectorLabels" . }}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "openzaak.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openzaak.workerName" . }}
{{- end }}

{{/*
Create a name for the celery beat
We truncate at 56 chars in order to provide space for the "-beat" suffix
*/}}
{{- define "openzaak.beatName" -}}
{{ include "openzaak.name" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openzaak.beatFullname" -}}
{{ include "openzaak.fullname" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Beat labels
*/}}
{{- define "openzaak.beatLabels" -}}
{{ include "openzaak.commonLabels" . }}
{{ include "openzaak.beatSelectorLabels" . }}
{{- end }}

{{/*
Beat selector labels
*/}}
{{- define "openzaak.beatSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openzaak.beatName" . }}
{{- end }}

{{/*
Create a name for Flower
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "openzaak.flowerName" -}}
{{ include "openzaak.name" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Create a default fully qualified name for Flower.
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "openzaak.flowerFullname" -}}
{{ include "openzaak.fullname" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Flower labels
*/}}
{{- define "openzaak.flowerLabels" -}}
{{ include "openzaak.commonLabels" . }}
{{ include "openzaak.flowerSelectorLabels" . }}
{{- end }}

{{/*
Flower selector labels
*/}}
{{- define "openzaak.flowerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openzaak.flowerName" . }}
{{- end }}

{{/*
Ingress annotations
*/}}
{{- define "openzaak.ingress.annotations" -}}
  {{- range $key, $val := .Values.ingress.annotations }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
{{- end }}

{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "openzaak.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "openzaak.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}
