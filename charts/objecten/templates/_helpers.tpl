{{/*
Expand the name objecten the chart.
*/}}
{{- define "objecten.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "objecten.fullname" -}}
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
{{- define "objecten.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "objecten.commonLabels" -}}
helm.sh/chart: {{ include "objecten.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
objecten labels
*/}}
{{- define "objecten.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "objecten.commonLabels" . }}
{{ include "objecten.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "objecten.selectorLabels" -}}
app.kubernetes.io/name: {{ include "objecten.name" . }}
{{- end }}

{{/*
Create a name for the worker
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "objecten.workerName" -}}
{{ include "objecten.name" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "objecten.workerFullname" -}}
{{ include "objecten.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Worker labels
*/}}
{{- define "objecten.workerLabels" -}}
{{ include "objecten.commonLabels" . }}
{{ include "objecten.workerSelectorLabels" . }}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "objecten.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "objecten.workerName" . }}
{{- end }}

{{/*
Create a name for Flower
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "objecten.flowerName" -}}
{{ include "objecten.name" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Create a default fully qualified name for Flower.
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "objecten.flowerFullname" -}}
{{ include "objecten.fullname" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Flower labels
*/}}
{{- define "objecten.flowerLabels" -}}
{{ include "objecten.commonLabels" . }}
{{ include "objecten.flowerSelectorLabels" . }}
{{- end }}

{{/*
Flower selector labels
*/}}
{{- define "objecten.flowerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "objecten.flowerName" . }}
{{- end  }}

{{/*
Create the name of the service account to use
*/}}
{{- define "objecten.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "objecten.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for Config cronjob
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "objecten.configName" -}}
{{ include "objecten.name" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
Create a default fully qualified name for config.
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "objecten.configFullname" -}}
{{ include "objecten.fullname" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
config labels
*/}}
{{- define "objecten.configLabels" -}}
{{ include "objecten.commonLabels" . }}
{{ include "objecten.configSelectorLabels" . }}
{{- end }}

{{/*
config selector labels
*/}}
{{- define "objecten.configSelectorLabels" -}}
app.kubernetes.io/name: {{ include "objecten.configName" . }}
{{- end }}

{{/*
Ingress annotations
*/}}
{{- define "objecten.ingress.annotations" -}}
  {{- range $key, $val := .Values.ingress.annotations }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
{{- end }}

{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "objecten.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "objecten.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}
