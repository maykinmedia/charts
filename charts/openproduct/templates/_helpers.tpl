{{/*
Expand the name openproduct the chart.
*/}}
{{- define "openproduct.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "openproduct.fullname" -}}
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
{{- define "openproduct.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "openproduct.commonLabels" -}}
helm.sh/chart: {{ include "openproduct.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
openproduct labels
*/}}
{{- define "openproduct.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "openproduct.commonLabels" . }}
{{ include "openproduct.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "openproduct.selectorLabels" -}}
app.kubernetes.io/name: {{ include "openproduct.name" . }}
{{- end }}

{{/*
Create a name for the worker
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openproduct.workerName" -}}
{{ include "openproduct.name" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openproduct.workerFullname" -}}
{{ include "openproduct.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Worker labels
*/}}
{{- define "openproduct.workerLabels" -}}
{{ include "openproduct.commonLabels" . }}
{{ include "openproduct.workerSelectorLabels" . }}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "openproduct.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openproduct.workerName" . }}
{{- end }}

{{/*
Create a name for Flower
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "openproduct.flowerName" -}}
{{ include "openproduct.name" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Create a default fully qualified name for Flower.
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "openproduct.flowerFullname" -}}
{{ include "openproduct.fullname" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Flower labels
*/}}
{{- define "openproduct.flowerLabels" -}}
{{ include "openproduct.commonLabels" . }}
{{ include "openproduct.flowerSelectorLabels" . }}
{{- end }}

{{/*
Flower selector labels
*/}}
{{- define "openproduct.flowerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openproduct.flowerName" . }}
{{- end  }}

{{/*
Create a name for Beat
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "openproduct.beatName" -}}
{{ include "openproduct.name" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Create a default fully qualified name for the beat.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openproduct.beatFullname" -}}
{{ include "openproduct.fullname" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Beat labels
*/}}
{{- define "openproduct.beatLabels" -}}
{{ include "openproduct.commonLabels" . }}
{{ include "openproduct.beatSelectorLabels" . }}
{{- end }}

{{/*
Beat selector labels
*/}}
{{- define "openproduct.beatSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openproduct.beatName" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "openproduct.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "openproduct.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for Config cronjob
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "openproduct.configName" -}}
{{ include "openproduct.name" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
Create a default fully qualified name for config.
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "openproduct.configFullname" -}}
{{ include "openproduct.fullname" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
config labels
*/}}
{{- define "openproduct.configLabels" -}}
{{ include "openproduct.commonLabels" . }}
{{ include "openproduct.configSelectorLabels" . }}
{{- end }}

{{/*
config selector labels
*/}}
{{- define "openproduct.configSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openproduct.configName" . }}
{{- end }}

{{/*
Ingress annotations
*/}}
{{- define "openproduct.ingress.annotations" -}}
  {{- range $key, $val := .Values.ingress.annotations }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
{{- end }}

{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "openproduct.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "openproduct.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}
