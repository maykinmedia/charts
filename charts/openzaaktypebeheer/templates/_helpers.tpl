{{/*
Expand the name of the chart.
*/}}
{{- define "openzaaktypebeheer.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "openzaaktypebeheer.fullname" -}}
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
{{- define "openzaaktypebeheer.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "openzaaktypebeheer.commonLabels" -}}
helm.sh/chart: {{ include "openzaaktypebeheer.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Labels
*/}}
{{- define "openzaaktypebeheer.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "openzaaktypebeheer.commonLabels" . }}
{{ include "openzaaktypebeheer.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "openzaaktypebeheer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "openzaaktypebeheer.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "openzaaktypebeheer.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "openzaaktypebeheer.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for NGINX
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "openzaaktypebeheer.nginxName" -}}
{{ include "openzaaktypebeheer.name" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
Create a default fully qualified name for NGINX.
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "openzaaktypebeheer.nginxFullname" -}}
{{ include "openzaaktypebeheer.fullname" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
NGINX labels
*/}}
{{- define "openzaaktypebeheer.nginxLabels" -}}
{{ include "openzaaktypebeheer.commonLabels" . }}
{{ include "openzaaktypebeheer.nginxSelectorLabels" . }}
{{- end }}

{{/*
NGINX selector labels
*/}}
{{- define "openzaaktypebeheer.nginxSelectorLabels" -}}
app.kubernetes.io/name: {{ include "openzaaktypebeheer.nginxFullname" . }}
{{- end }}