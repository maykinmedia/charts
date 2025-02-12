{{/*
Expand the name openklant the chart.
*/}}
{{- define "openklant.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "openklant.fullname" -}}
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
{{- define "openklant.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "openklant.commonLabels" -}}
helm.sh/chart: {{ include "openklant.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
openklant labels
*/}}
{{- define "openklant.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "openklant.commonLabels" . }}
{{ include "openklant.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "openklant.selectorLabels" -}}
app.kubernetes.io/name: {{ include "openklant.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "openklant.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "openklant.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for Config cronjob
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "openklant.configName" -}}
{{ include "openklant.name" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
Create a default fully qualified name for config.
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "openklant.configFullname" -}}
{{ include "openklant.fullname" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
config labels
*/}}
{{- define "openklant.configLabels" -}}
{{ include "openklant.commonLabels" . }}
{{ include "openklant.configSelectorLabels" . }}
{{- end }}

{{/*
config selector labels
*/}}
{{- define "openklant.configSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openklant.configName" . }}
{{- end }}

{{/*
Create a name for NGINX
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "openklant.nginxName" -}}
{{ include "openklant.name" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
Create a default fully qualified name for NGINX.
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "openklant.nginxFullname" -}}
{{ include "openklant.fullname" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
NGINX labels
*/}}
{{- define "openklant.nginxLabels" -}}
{{ include "openklant.commonLabels" . }}
{{ include "openklant.nginxSelectorLabels" . }}
{{- end }}

{{/*
NGINX selector labels
*/}}
{{- define "openklant.nginxSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openklant.nginxName" . }}
{{- end }}
    
{{/*
Create a name for the worker
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openklant.workerName" -}}
{{ include "openklant.name" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openklant.workerFullname" -}}
{{ include "openklant.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Worker labels
*/}}
{{- define "openklant.workerLabels" -}}
{{ include "openklant.commonLabels" . }}
{{ include "openklant.workerSelectorLabels" . }}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "openklant.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openklant.workerName" . }}
{{- end }}

{{/*
Ingress annotations
*/}}
{{- define "openklant.ingress.annotations" -}}
  {{- range $key, $val := .Values.ingress.annotations }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
{{- end }}

{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "openklant.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "openklant.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}