{{/*
Expand the name openorganisatie the chart.
*/}}
{{- define "openorganisatie.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "openorganisatie.fullname" -}}
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
{{- define "openorganisatie.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "openorganisatie.commonLabels" -}}
helm.sh/chart: {{ include "openorganisatie.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
openorganisatie labels
*/}}
{{- define "openorganisatie.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "openorganisatie.commonLabels" . }}
{{ include "openorganisatie.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "openorganisatie.selectorLabels" -}}
app.kubernetes.io/name: {{ include "openorganisatie.name" . }}
{{- end }}

{{/*
Create a name for the worker
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openorganisatie.workerName" -}}
{{ include "openorganisatie.name" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openorganisatie.workerFullname" -}}
{{ include "openorganisatie.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Worker labels
*/}}
{{- define "openorganisatie.workerLabels" -}}
{{ include "openorganisatie.commonLabels" . }}
{{ include "openorganisatie.workerSelectorLabels" . }}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "openorganisatie.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openorganisatie.workerName" . }}
{{- end }}

{{/*
Create a name for Flower
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "openorganisatie.flowerName" -}}
{{ include "openorganisatie.name" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Create a default fully qualified name for Flower.
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "openorganisatie.flowerFullname" -}}
{{ include "openorganisatie.fullname" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Flower labels
*/}}
{{- define "openorganisatie.flowerLabels" -}}
{{ include "openorganisatie.commonLabels" . }}
{{ include "openorganisatie.flowerSelectorLabels" . }}
{{- end }}

{{/*
Flower selector labels
*/}}
{{- define "openorganisatie.flowerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openorganisatie.flowerName" . }}
{{- end  }}

{{/*
Create a name for Beat
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "openorganisatie.beatName" -}}
{{ include "openorganisatie.name" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Create a default fully qualified name for the beat.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openorganisatie.beatFullname" -}}
{{ include "openorganisatie.fullname" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Beat labels
*/}}
{{- define "openorganisatie.beatLabels" -}}
{{ include "openorganisatie.commonLabels" . }}
{{ include "openorganisatie.beatSelectorLabels" . }}
{{- end }}

{{/*
Beat selector labels
*/}}
{{- define "openorganisatie.beatSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openorganisatie.beatName" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "openorganisatie.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "openorganisatie.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for Config job
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "openorganisatie.configName" -}}
{{ include "openorganisatie.name" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
Create a default fully qualified name for config.
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "openorganisatie.configFullname" -}}
{{ include "openorganisatie.fullname" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
config labels
*/}}
{{- define "openorganisatie.configLabels" -}}
{{ include "openorganisatie.commonLabels" . }}
{{ include "openorganisatie.configSelectorLabels" . }}
{{- end }}

{{/*
config selector labels
*/}}
{{- define "openorganisatie.configSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openorganisatie.configName" . }}
{{- end }}

{{/*
Ingress annotations
*/}}
{{- define "openorganisatie.ingress.annotations" -}}
  {{- range $key, $val := .Values.ingress.annotations }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
{{- end }}

{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "openorganisatie.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "openorganisatie.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}
