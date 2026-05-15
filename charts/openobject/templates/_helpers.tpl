{{/*
Expand the name openobject the chart.
*/}}
{{- define "openobject.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "openobject.fullname" -}}
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
{{- define "openobject.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "openobject.commonLabels" -}}
helm.sh/chart: {{ include "openobject.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
openobject labels
*/}}
{{- define "openobject.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "openobject.commonLabels" . }}
{{ include "openobject.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "openobject.selectorLabels" -}}
app.kubernetes.io/name: {{ include "openobject.name" . }}
{{- end }}

{{/*
Create a name for the worker
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openobject.workerName" -}}
{{ include "openobject.name" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openobject.workerFullname" -}}
{{ include "openobject.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Worker labels
*/}}
{{- define "openobject.workerLabels" -}}
{{ include "openobject.commonLabels" . }}
{{ include "openobject.workerSelectorLabels" . }}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "openobject.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openobject.workerName" . }}
{{- end }}

{{/*
Create a name for Flower
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "openobject.flowerName" -}}
{{ include "openobject.name" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Create a default fully qualified name for Flower.
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "openobject.flowerFullname" -}}
{{ include "openobject.fullname" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Flower labels
*/}}
{{- define "openobject.flowerLabels" -}}
{{ include "openobject.commonLabels" . }}
{{ include "openobject.flowerSelectorLabels" . }}
{{- end }}

{{/*
Flower selector labels
*/}}
{{- define "openobject.flowerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openobject.flowerName" . }}
{{- end  }}

{{/*
Create a name for Beat
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "openobject.beatName" -}}
{{ include "openobject.name" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Create a default fully qualified name for the beat.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "openobject.beatFullname" -}}
{{ include "openobject.fullname" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Beat labels
*/}}
{{- define "openobject.beatLabels" -}}
{{ include "openobject.commonLabels" . }}
{{ include "openobject.beatSelectorLabels" . }}
{{- end }}

{{/*
Beat selector labels
*/}}
{{- define "openobject.beatSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openobject.beatName" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "openobject.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "openobject.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for Config job
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "openobject.configName" -}}
{{ include "openobject.name" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
Create a default fully qualified name for config.
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "openobject.configFullname" -}}
{{ include "openobject.fullname" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
config labels
*/}}
{{- define "openobject.configLabels" -}}
{{ include "openobject.commonLabels" . }}
{{ include "openobject.configSelectorLabels" . }}
{{- end }}

{{/*
config selector labels
*/}}
{{- define "openobject.configSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openobject.configName" . }}
{{- end }}

{{/*
Ingress annotations
*/}}
{{- define "openobject.ingress.annotations" -}}
  {{- range $key, $val := .Values.ingress.annotations }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
{{- end }}

{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "openobject.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "openobject.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}
