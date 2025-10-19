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
Create a name for the worker
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "referentielijsten.workerName" -}}
{{ include "referentielijsten.name" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "referentielijsten.workerFullname" -}}
{{ include "referentielijsten.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Worker labels
*/}}
{{- define "referentielijsten.workerLabels" -}}
{{ include "referentielijsten.commonLabels" . }}
{{ include "referentielijsten.workerSelectorLabels" . }}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "referentielijsten.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "referentielijsten.workerName" . }}
{{- end }}

{{/*
Create a name for Flower
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "referentielijsten.flowerName" -}}
{{ include "referentielijsten.name" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Create a default fully qualified name for Flower.
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "referentielijsten.flowerFullname" -}}
{{ include "referentielijsten.fullname" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Flower labels
*/}}
{{- define "referentielijsten.flowerLabels" -}}
{{ include "referentielijsten.commonLabels" . }}
{{ include "referentielijsten.flowerSelectorLabels" . }}
{{- end }}

{{/*
Flower selector labels
*/}}
{{- define "referentielijsten.flowerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "referentielijsten.flowerName" . }}
{{- end  }}

{{/*
Create a name for Beat
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "referentielijsten.beatName" -}}
{{ include "referentielijsten.name" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Create a default fully qualified name for the beat.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "referentielijsten.beatFullname" -}}
{{ include "referentielijsten.fullname" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Beat labels
*/}}
{{- define "referentielijsten.beatLabels" -}}
{{ include "referentielijsten.commonLabels" . }}
{{ include "referentielijsten.beatSelectorLabels" . }}
{{- end }}

{{/*
Beat selector labels
*/}}
{{- define "referentielijsten.beatSelectorLabels" -}}
app.kubernetes.io/name: {{ include "referentielijsten.beatName" . }}
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
