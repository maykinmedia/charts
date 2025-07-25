{{- define "application.name" -}}
{{- default .Values.pythonAppName }}
{{- end }}

{{- define "project.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "project.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "project.fullname" -}}
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
Selector labels
*/}}
{{- define "project.selectorLabels" -}}
app.kubernetes.io/name: {{ include "project.name" . }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "project.commonLabels" -}}
helm.sh/chart: {{ include "project.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Project labels
*/}}
{{- define "project.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "project.commonLabels" . }}
{{ include "project.selectorLabels" . }}
{{- end }}


{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "project.workerFullname" -}}
{{ include "project.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "project.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "project.workerFullname" . }}
{{- end }}

{{/*
Create a default fully qualified name for NGINX.
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "project.nginxFullname" -}}
{{ include "project.fullname" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
NGINX selector labels
*/}}
{{- define "project.nginxSelectorLabels" -}}
app.kubernetes.io/name: {{ include "project.nginxFullname" . }}
{{- end }}