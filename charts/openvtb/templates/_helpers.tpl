{{/*
Expand the name openvtb the chart.
*/}}
{{- define "openvtb.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "openvtb.fullname" -}}
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
{{- define "openvtb.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "openvtb.commonLabels" -}}
helm.sh/chart: {{ include "openvtb.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
openvtb labels
*/}}
{{- define "openvtb.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "openvtb.commonLabels" . }}
{{ include "openvtb.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "openvtb.selectorLabels" -}}
app.kubernetes.io/name: {{ include "openvtb.name" . }}
{{- end }}

{{/*
Create a name for the worker
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openvtb.workerName" -}}
{{ include "openvtb.name" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openvtb.workerFullname" -}}
{{ include "openvtb.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Worker labels
*/}}
{{- define "openvtb.workerLabels" -}}
{{ include "openvtb.commonLabels" . }}
{{ include "openvtb.workerSelectorLabels" . }}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "openvtb.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openvtb.workerName" . }}
{{- end }}

{{/*
Create a name for Flower
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "openvtb.flowerName" -}}
{{ include "openvtb.name" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Create a default fully qualified name for Flower.
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "openvtb.flowerFullname" -}}
{{ include "openvtb.fullname" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Flower labels
*/}}
{{- define "openvtb.flowerLabels" -}}
{{ include "openvtb.commonLabels" . }}
{{ include "openvtb.flowerSelectorLabels" . }}
{{- end }}

{{/*
Flower selector labels
*/}}
{{- define "openvtb.flowerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openvtb.flowerName" . }}
{{- end  }}

{{/*
Create a name for Beat
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "openvtb.beatName" -}}
{{ include "openvtb.name" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Create a default fully qualified name for the beat.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openvtb.beatFullname" -}}
{{ include "openvtb.fullname" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Beat labels
*/}}
{{- define "openvtb.beatLabels" -}}
{{ include "openvtb.commonLabels" . }}
{{ include "openvtb.beatSelectorLabels" . }}
{{- end }}

{{/*
Beat selector labels
*/}}
{{- define "openvtb.beatSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openvtb.beatName" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "openvtb.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "openvtb.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for Config job
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "openvtb.configName" -}}
{{ include "openvtb.name" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
Create a default fully qualified name for config.
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "openvtb.configFullname" -}}
{{ include "openvtb.fullname" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
config labels
*/}}
{{- define "openvtb.configLabels" -}}
{{ include "openvtb.commonLabels" . }}
{{ include "openvtb.configSelectorLabels" . }}
{{- end }}

{{/*
config selector labels
*/}}
{{- define "openvtb.configSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openvtb.configName" . }}
{{- end }}

{{/*
Ingress annotations
*/}}
{{- define "openvtb.ingress.annotations" -}}
  {{- range $key, $val := .Values.ingress.annotations }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
{{- end }}

{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "openvtb.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "openvtb.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}
