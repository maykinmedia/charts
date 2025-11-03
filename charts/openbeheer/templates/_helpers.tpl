{{/*
Expand the name openbeheer the chart.
*/}}
{{- define "openbeheer.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "openbeheer.fullname" -}}
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
{{- define "openbeheer.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "openbeheer.commonLabels" -}}
helm.sh/chart: {{ include "openbeheer.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
openbeheer labels
*/}}
{{- define "openbeheer.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "openbeheer.commonLabels" . }}
{{ include "openbeheer.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "openbeheer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "openbeheer.name" . }}
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "openbeheer.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "openbeheer.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for Config job
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "openbeheer.configName" -}}
{{ include "openbeheer.name" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
Create a default fully qualified name for config.
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "openbeheer.configFullname" -}}
{{ include "openbeheer.fullname" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
config labels
*/}}
{{- define "openbeheer.configLabels" -}}
{{ include "openbeheer.commonLabels" . }}
{{ include "openbeheer.configSelectorLabels" . }}
{{- end }}

{{/*
config selector labels
*/}}
{{- define "openbeheer.configSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openbeheer.configName" . }}
{{- end }}

{{/*
Ingress annotations
*/}}
{{- define "openbeheer.ingress.annotations" -}}
  {{- range $key, $val := .Values.ingress.annotations }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
{{- end }}

{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "openbeheer.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "openbeheer.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}

{{/*
Create a name for NGINX
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "openbeheer.nginxName" -}}
{{ include "openbeheer.name" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
Create a default fully qualified name for NGINX.
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "openbeheer.nginxFullname" -}}
{{ include "openbeheer.fullname" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
NGINX labels
*/}}
{{- define "openbeheer.nginxLabels" -}}
{{ include "openbeheer.commonLabels" . }}
{{ include "openbeheer.nginxSelectorLabels" . }}
{{- end }}

{{/*
NGINX selector labels
*/}}
{{- define "openbeheer.nginxSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openbeheer.nginxName" . }}
{{- end }}
