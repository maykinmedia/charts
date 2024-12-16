{{/*
Expand the name openinwoner the chart.
*/}}
{{- define "openinwoner.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "openinwoner.fullname" -}}
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
{{- define "openinwoner.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "openinwoner.commonLabels" -}}
helm.sh/chart: {{ include "openinwoner.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
openinwoner labels
*/}}
{{- define "openinwoner.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "openinwoner.commonLabels" . }}
{{ include "openinwoner.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "openinwoner.selectorLabels" -}}
app.kubernetes.io/name: {{ include "openinwoner.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "openinwoner.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "openinwoner.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for Config cronjob
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "openinwoner.configName" -}}
{{ include "openinwoner.name" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
Create a default fully qualified name for config.
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "openinwoner.configFullname" -}}
{{ include "openinwoner.fullname" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
config labels
*/}}
{{- define "openinwoner.configLabels" -}}
{{ include "openinwoner.commonLabels" . }}
{{ include "openinwoner.configSelectorLabels" . }}
{{- end }}

{{/*
config selector labels
*/}}
{{- define "openinwoner.configSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openinwoner.configName" . }}
{{- end }}

{{/*
Create a name for NGINX
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "openinwoner.nginxName" -}}
{{ include "openinwoner.name" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
Create a default fully qualified name for NGINX.
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "openinwoner.nginxFullname" -}}
{{ include "openinwoner.fullname" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
NGINX labels
*/}}
{{- define "openinwoner.nginxLabels" -}}
{{ include "openinwoner.commonLabels" . }}
{{ include "openinwoner.nginxSelectorLabels" . }}
{{- end }}

{{/*
NGINX selector labels
*/}}
{{- define "openinwoner.nginxSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openinwoner.nginxName" . }}
{{- end }}

{{/*
Create a name for the worker
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openinwoner.workerName" -}}
{{ include "openinwoner.name" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openinwoner.workerFullname" -}}
{{ include "openinwoner.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Worker labels
*/}}
{{- define "openinwoner.workerLabels" -}}
{{ include "openinwoner.commonLabels" . }}
{{ include "openinwoner.workerSelectorLabels" . }}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "openinwoner.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openinwoner.workerName" . }}
{{- end }}

{{/*
Create a name for the celery beat
We truncate at 56 chars in order to provide space for the "-beat" suffix
*/}}
{{- define "openinwoner.beatName" -}}
{{ include "openinwoner.name" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openinwoner.beatFullname" -}}
{{ include "openinwoner.fullname" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Beat labels
*/}}
{{- define "openinwoner.beatLabels" -}}
{{ include "openinwoner.commonLabels" . }}
{{ include "openinwoner.beatSelectorLabels" . }}
{{- end }}

{{/*
Beat selector labels
*/}}
{{- define "openinwoner.beatSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openinwoner.beatName" . }}
{{- end }}

{{/*
Create a name for Celery Monitor
We truncate at 56 chars in order to provide space for the "-celery-monitor" suffix
*/}}
{{- define "openinwoner.celeryMonitorName" -}}
{{ include "openinwoner.name" . | trunc 56 | trimSuffix "-" }}-celery-monitor
{{- end }}

{{/*
Create a default fully qualified name for celeryMonitor.
We truncate at 56 chars in order to provide space for the "-celeryMonitor" suffix
*/}}
{{- define "openinwoner.celeryMonitorFullname" -}}
{{ include "openinwoner.fullname" . | trunc 56 | trimSuffix "-" }}-celery-monitor
{{- end }}

{{/*
celeryMonitor labels
*/}}
{{- define "openinwoner.celeryMonitorLabels" -}}
{{ include "openinwoner.commonLabels" . }}
{{ include "openinwoner.celeryMonitorSelectorLabels" . }}
{{- end }}

{{/*
celeryMonitor selector labels
*/}}
{{- define "openinwoner.celeryMonitorSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openinwoner.celeryMonitorName" . }}
{{- end }}

{{/*
Ingress annotations
*/}}
{{- define "openinwoner.ingress.annotations" -}}
  {{- range $key, $val := .Values.ingress.annotations }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
{{- end }}

{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "openinwoner.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "openinwoner.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}