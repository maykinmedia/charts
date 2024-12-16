{{/*
Expand the name openarchiefbeheer the chart.
*/}}
{{- define "openarchiefbeheer.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "openarchiefbeheer.fullname" -}}
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
{{- define "openarchiefbeheer.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "openarchiefbeheer.commonLabels" -}}
helm.sh/chart: {{ include "openarchiefbeheer.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
openarchiefbeheer labels
*/}}
{{- define "openarchiefbeheer.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "openarchiefbeheer.commonLabels" . }}
{{ include "openarchiefbeheer.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "openarchiefbeheer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "openarchiefbeheer.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "openarchiefbeheer.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "openarchiefbeheer.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for Config cronjob
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "openarchiefbeheer.configName" -}}
{{ include "openarchiefbeheer.name" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
Create a default fully qualified name for config.
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "openarchiefbeheer.configFullname" -}}
{{ include "openarchiefbeheer.fullname" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
config labels
*/}}
{{- define "openarchiefbeheer.configLabels" -}}
{{ include "openarchiefbeheer.commonLabels" . }}
{{ include "openarchiefbeheer.configSelectorLabels" . }}
{{- end }}

{{/*
config selector labels
*/}}
{{- define "openarchiefbeheer.configSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openarchiefbeheer.configName" . }}
{{- end }}

{{/*
Create a name for NGINX
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "openarchiefbeheer.nginxName" -}}
{{ include "openarchiefbeheer.name" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
Create a default fully qualified name for NGINX.
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "openarchiefbeheer.nginxFullname" -}}
{{ include "openarchiefbeheer.fullname" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
NGINX labels
*/}}
{{- define "openarchiefbeheer.nginxLabels" -}}
{{ include "openarchiefbeheer.commonLabels" . }}
{{ include "openarchiefbeheer.nginxSelectorLabels" . }}
{{- end }}

{{/*
NGINX selector labels
*/}}
{{- define "openarchiefbeheer.nginxSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openarchiefbeheer.nginxName" . }}
{{- end }}

{{/*
Create a name for the worker
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openarchiefbeheer.workerName" -}}
{{ include "openarchiefbeheer.name" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openarchiefbeheer.workerFullname" -}}
{{ include "openarchiefbeheer.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Worker labels
*/}}
{{- define "openarchiefbeheer.workerLabels" -}}
{{ include "openarchiefbeheer.commonLabels" . }}
{{ include "openarchiefbeheer.workerSelectorLabels" . }}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "openarchiefbeheer.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openarchiefbeheer.workerName" . }}
{{- end }}

{{/*
Create a name for Flower
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "openarchiefbeheer.flowerName" -}}
{{ include "openarchiefbeheer.name" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Create a default fully qualified name for Flower.
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "openarchiefbeheer.flowerFullname" -}}
{{ include "openarchiefbeheer.fullname" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Flower labels
*/}}
{{- define "openarchiefbeheer.flowerLabels" -}}
{{ include "openarchiefbeheer.commonLabels" . }}
{{ include "openarchiefbeheer.flowerSelectorLabels" . }}
{{- end }}

{{/*
Flower selector labels
*/}}
{{- define "openarchiefbeheer.flowerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openarchiefbeheer.flowerName" . }}
{{- end }}

{{/*
Ingress annotations
*/}}
{{- define "openarchiefbeheer.ingress.annotations" -}}
  {{- range $key, $val := .Values.ingress.annotations }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
{{- end }}

{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "openarchiefbeheer.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "openarchiefbeheer.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}

{{/*
Create a name for the celery beat
We truncate at 56 chars in order to provide space for the "-beat" suffix
*/}}
{{- define "openarchiefbeheer.beatName" -}}
{{ include "openarchiefbeheer.name" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Create a default fully qualified name for celery beat.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openarchiefbeheer.beatFullname" -}}
{{ include "openarchiefbeheer.fullname" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Beat labels
*/}}
{{- define "openarchiefbeheer.beatLabels" -}}
{{ include "openarchiefbeheer.commonLabels" . }}
{{ include "openarchiefbeheer.beatSelectorLabels" . }}
{{- end }}

{{/*
Beat selector labels
*/}}
{{- define "openarchiefbeheer.beatSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openarchiefbeheer.beatFullname" . }}
{{- end }}