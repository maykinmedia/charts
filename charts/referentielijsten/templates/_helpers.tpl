{{/*
Expand the name referentielijsten the chart.
*/}}
{{- define "referentielijsten.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "referentielijsten.fullname" -}}
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
{{- define "referentielijsten.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "referentielijsten.commonLabels" -}}
helm.sh/chart: {{ include "referentielijsten.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
referentielijsten labels
*/}}
{{- define "referentielijsten.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "referentielijsten.commonLabels" . }}
{{ include "referentielijsten.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "referentielijsten.selectorLabels" -}}
app.kubernetes.io/name: {{ include "referentielijsten.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "referentielijsten.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "referentielijsten.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for Config cronjob
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "referentielijsten.configName" -}}
{{ include "referentielijsten.name" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
Create a default fully qualified name for config.
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "referentielijsten.configFullname" -}}
{{ include "referentielijsten.fullname" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
config labels
*/}}
{{- define "referentielijsten.configLabels" -}}
{{ include "referentielijsten.commonLabels" . }}
{{ include "referentielijsten.configSelectorLabels" . }}
{{- end }}

{{/*
config selector labels
*/}}
{{- define "referentielijsten.configSelectorLabels" -}}
app.kubernetes.io/name: {{ include "referentielijsten.configName" . }}
{{- end }}

{{/*
Ingress annotations
*/}}
{{- define "referentielijsten.ingress.annotations" -}}
  {{- range $key, $val := .Values.ingress.annotations }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
{{- end }}

{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "referentielijsten.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "referentielijsten.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}
