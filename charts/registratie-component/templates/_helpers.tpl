{{/*
Expand the name registratie-component the chart.
*/}}
{{- define "registratie-component.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "registratie-component.fullname" -}}
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
{{- define "registratie-component.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "registratie-component.commonLabels" -}}
helm.sh/chart: {{ include "registratie-component.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
registratie-component labels
*/}}
{{- define "registratie-component.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "registratie-component.commonLabels" . }}
{{ include "registratie-component.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "registratie-component.selectorLabels" -}}
app.kubernetes.io/name: {{ include "registratie-component.name" . }}
{{- end }}

{{/*
Create a name for the worker
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "registratie-component.workerName" -}}
{{ include "registratie-component.name" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "registratie-component.workerFullname" -}}
{{ include "registratie-component.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Worker labels
*/}}
{{- define "registratie-component.workerLabels" -}}
{{ include "registratie-component.commonLabels" . }}
{{ include "registratie-component.workerSelectorLabels" . }}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "registratie-component.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "registratie-component.workerName" . }}
{{- end }}

{{/*
Create a name for Flower
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "registratie-component.flowerName" -}}
{{ include "registratie-component.name" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Create a default fully qualified name for Flower.
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "registratie-component.flowerFullname" -}}
{{ include "registratie-component.fullname" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Flower labels
*/}}
{{- define "registratie-component.flowerLabels" -}}
{{ include "registratie-component.commonLabels" . }}
{{ include "registratie-component.flowerSelectorLabels" . }}
{{- end }}

{{/*
Flower selector labels
*/}}
{{- define "registratie-component.flowerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "registratie-component.flowerName" . }}
{{- end  }}

{{/*
Create the name of the service account to use
*/}}
{{- define "registratie-component.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "registratie-component.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Ingress annotations
*/}}
{{- define "registratie-component.ingress.annotations" -}}
  {{- range $key, $val := .Values.ingress.annotations }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
{{- end }}

{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "registratie-component.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "registratie-component.tplvalues.render" -}}
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
{{- define "registratie-component.nginxName" -}}
{{ include "registratie-component.name" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
Create a default fully qualified name for NGINX.
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "registratie-component.nginxFullname" -}}
{{ include "registratie-component.fullname" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
NGINX labels
*/}}
{{- define "registratie-component.nginxLabels" -}}
{{ include "registratie-component.commonLabels" . }}
{{ include "registratie-component.nginxSelectorLabels" . }}
{{- end }}

{{/*
NGINX selector labels
*/}}
{{- define "registratie-component.nginxSelectorLabels" -}}
app.kubernetes.io/name: {{ include "registratie-component.nginxName" . }}
{{- end }}