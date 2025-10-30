{{/*
Expand the name openforms the chart.
*/}}
{{- define "openforms.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "openforms.fullname" -}}
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
{{- define "openforms.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "openforms.commonLabels" -}}
helm.sh/chart: {{ include "openforms.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Openforms labels
*/}}
{{- define "openforms.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "openforms.commonLabels" . }}
{{ include "openforms.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "openforms.selectorLabels" -}}
app.kubernetes.io/name: {{ include "openforms.fullname" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "openforms.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "openforms.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for NGINX
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "openforms.nginxName" -}}
{{ include "openforms.name" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
Create a default fully qualified name for NGINX.
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "openforms.nginxFullname" -}}
{{ include "openforms.fullname" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
NGINX labels
*/}}
{{- define "openforms.nginxLabels" -}}
{{ include "openforms.commonLabels" . }}
{{ include "openforms.nginxSelectorLabels" . }}
{{- end }}

{{/*
NGINX selector labels
*/}}
{{- define "openforms.nginxSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openforms.nginxFullname" . }}
{{- end }}

{{/*
Create a name for the worker
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openforms.workerName" -}}
{{ include "openforms.name" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openforms.workerFullname" -}}
{{ include "openforms.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Worker labels
*/}}
{{- define "openforms.workerLabels" -}}
{{ include "openforms.commonLabels" . }}
{{ include "openforms.workerSelectorLabels" . }}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "openforms.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openforms.workerFullname" . }}
{{- end }}

{{/*
Create a name for the celery beat
We truncate at 56 chars in order to provide space for the "-beat" suffix
*/}}
{{- define "openforms.beatName" -}}
{{ include "openforms.name" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openforms.beatFullname" -}}
{{ include "openforms.fullname" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Beat labels
*/}}
{{- define "openforms.beatLabels" -}}
{{ include "openforms.commonLabels" . }}
{{ include "openforms.beatSelectorLabels" . }}
{{- end }}

{{/*
Beat selector labels
*/}}
{{- define "openforms.beatSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openforms.beatFullname" . }}
{{- end }}

{{/*
Create a name for Flower
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "openforms.flowerName" -}}
{{ include "openforms.name" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Create a default fully qualified name for Flower.
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "openforms.flowerFullname" -}}
{{ include "openforms.fullname" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Flower labels
*/}}
{{- define "openforms.flowerLabels" -}}
{{ include "openforms.commonLabels" . }}
{{ include "openforms.flowerSelectorLabels" . }}
{{- end }}

{{/*
Flower selector labels
*/}}
{{- define "openforms.flowerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openforms.flowerFullname" . }}
{{- end }}

{{/*
Create a name for Config cronjob
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "openforms.configName" -}}
{{ include "openforms.name" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
Create a default fully qualified name for config.
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "openforms.configFullname" -}}
{{ include "openforms.fullname" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
config labels
*/}}
{{- define "openforms.configLabels" -}}
{{ include "openforms.commonLabels" . }}
{{ include "openforms.configSelectorLabels" . }}
{{- end }}

{{/*
config selector labels
*/}}
{{- define "openforms.configSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openforms.configName" . }}
{{- end }}

{{/*
Ingress annotations
*/}}
{{- define "openforms.ingress.annotations" -}}
  {{- range $key, $val := .Values.ingress.annotations }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
{{- end }}

{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "openforms.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "openforms.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}


{{/*
Check if OpenForms version meets minimum requirement for static file serving
Usage:
{{ include "openforms.staticFileServingSupported" . }}
*/}}
{{- define "openforms.staticFileServingSupported" -}}
{{- $currentVersion := .Values.image.tag | default .Chart.AppVersion -}}
{{- $minVersion := "3.3.0" -}}
{{- /* Extract semantic version (e.g. 3.3.1) from tags like "all-extensions-3.3.1" */ -}}
{{- $semver := regexFind "\\d+\\.\\d+\\.\\d+" $currentVersion -}}
{{- if $semver -}}
  {{- if semverCompare (printf ">=%s" $minVersion) $semver -}}
true
  {{- else -}}
false
  {{- end -}}
{{- else -}}
false
{{- end -}}
{{- end -}}
