{{/* vim: set filetype=mustache: */}}

{{/*
Define the name of the chart/application.
*/}}
{{- define "application.name" -}}
{{- default .Release.Name .Values.applicationName | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains the application name it will be used as a full name.
*/}}
{{- define "application.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Release.Name .Values.applicationName -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Define the image repository.
*/}}
{{- define "application.repository" -}}
{{- required "image.repository is required" .Values.image.repository -}}
{{- end -}}

{{/*
Create the full image reference, failing if repository or tag are not set.
*/}}
{{- define "application.image" -}}
{{- $tag := required "image.tag is required" .Values.image.tag -}}
{{- printf "%s:%s" (include "application.repository" .) $tag -}}
{{- end -}}

{{/*
Define the version of the chart/application.
*/}}
{{- define "application.version" -}}
{{- required "image.tag is required" .Values.image.tag | regexReplaceAll "[^a-zA-Z0-9_\\.\\-]" "-" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Define the namespace of the chart
*/}}
{{- define "application.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride -}}
{{- end -}}

{{/*
Renders a value that contains template.
Usage:
{{ include "application.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "application.tplvalues.render" -}}
    {{- $value := .value -}}
    {{- if or (not $value) (kindIs "invalid" $value) -}}
        {{- "" -}}
    {{- else if typeIs "string" $value -}}
        {{- tpl $value .context -}}
    {{- else -}}
        {{- tpl ($value | toYaml) .context -}}
    {{- end -}}
{{- end -}}

{{/*
Resolve chart version, allowing override for stable snapshot testing.
See: https://github.com/helm-unittest/helm-unittest/issues/197
*/}}
{{- define "application.chartVersion" -}}
{{- .Values.chartVersionOverride | default .Chart.Version -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "application.chart" -}}
{{- printf "%s-%s" .Chart.Name (include "application.chartVersion" .) | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Additional labels from .Values.additionalLabels.
*/}}
{{- define "application.additionalLabels" -}}
{{- with .Values.additionalLabels -}}
{{ include "application.tplvalues.render" (dict "value" . "context" $) }}
{{- end -}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "application.selectorLabels" -}}
app.kubernetes.io/name: {{ include "application.name" . }}
{{- end }}

{{/*
Application labels
*/}}
{{- define "application.labels" -}}
{{ with .Values.componentOverride }}app.kubernetes.io/component: {{ . }}
{{ end -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "application.selectorLabels" . }}
{{ with .Values.partOfOverride }}app.kubernetes.io/part-of: {{ . }}
{{ end -}}
{{ with include "application.version" . }}app.kubernetes.io/version: {{ quote . }}
{{ end -}}
helm.sh/chart: {{ include "application.chart" . }}
{{- with include "application.additionalLabels" . }}
{{ . }}
{{- end }}
{{- end }}

{{/*
Labels for a secondary component (worker, flower, beat, nginx, config)
*/}}
{{- define "application.componentLabels" -}}
app.kubernetes.io/instance: {{ .context.Release.Name }}
app.kubernetes.io/name: {{ .name }}
helm.sh/chart: {{ include "application.chart" .context }}
{{- end }}

{{/*
Service account
*/}}
{{- define "application.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "application.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Worker
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "application.workerName" -}}
{{ include "application.name" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{- define "application.workerFullname" -}}
{{ include "application.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{- define "application.workerLabels" -}}
{{ include "application.componentLabels" (dict "name" (include "application.workerName" .) "context" .) }}
{{- end }}

{{- define "application.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "application.workerName" . }}
{{- end }}

{{/*
Flower
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "application.flowerName" -}}
{{ include "application.name" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{- define "application.flowerFullname" -}}
{{ include "application.fullname" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{- define "application.flowerLabels" -}}
{{ include "application.componentLabels" (dict "name" (include "application.flowerName" .) "context" .) }}
{{- end }}

{{- define "application.flowerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "application.flowerName" . }}
{{- end }}

{{/*
Beat (celery beat)
We truncate at 56 chars in order to provide space for the "-beat" suffix
*/}}
{{- define "application.beatName" -}}
{{ include "application.name" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{- define "application.beatFullname" -}}
{{ include "application.fullname" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{- define "application.beatLabels" -}}
{{ include "application.componentLabels" (dict "name" (include "application.beatName" .) "context" .) }}
{{- end }}

{{- define "application.beatSelectorLabels" -}}
app.kubernetes.io/name: {{ include "application.beatName" . }}
{{- end }}

{{/*
Config job
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "application.configName" -}}
{{ include "application.name" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{- define "application.configFullname" -}}
{{ include "application.fullname" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{- define "application.configLabels" -}}
{{ include "application.componentLabels" (dict "name" (include "application.configName" .) "context" .) }}
{{- end }}

{{- define "application.configSelectorLabels" -}}
app.kubernetes.io/name: {{ include "application.configName" . }}
{{- end }}

{{/*
Ingress annotations
*/}}
{{- define "application.ingress.annotations" -}}
  {{- range $key, $val := .Values.ingress.annotations }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
{{- end }}
