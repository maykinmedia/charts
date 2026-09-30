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
Additional common labels
*/}}
{{- define "application.additionalLabels" -}}
{{- if .Values.additionalLabels }}
{{ include "application.tplvalues.render" ( dict "value" .Values.additionalLabels "context" $ ) }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "application.commonLabels" -}}
helm.sh/chart: {{ include "application.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Application labels
*/}}
{{- define "application.labels" -}}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with include "application.version" . }}
app.kubernetes.io/version: {{ quote . }}
{{- end }}
{{- if .Values.componentOverride }}
app.kubernetes.io/component: {{ .Values.componentOverride }}
{{- end }}
{{- if .Values.partOfOverride }}
app.kubernetes.io/part-of: {{ .Values.partOfOverride }}
{{- end }}
{{ include "application.additionalLabels" . }}
{{ include "application.commonLabels" . }}
{{ include "application.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "application.selectorLabels" -}}
app.kubernetes.io/name: {{ include "application.name" . }}
{{- end }}

{{/*
Create a name for the worker
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "application.workerName" -}}
{{ include "application.name" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "application.workerFullname" -}}
{{ include "application.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Worker labels
*/}}
{{- define "application.workerLabels" -}}
{{ include "application.commonLabels" . }}
{{ include "application.workerSelectorLabels" . }}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "application.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "application.workerName" . }}
{{- end }}

{{/*
Create a name for Flower
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "application.flowerName" -}}
{{ include "application.name" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Create a default fully qualified name for Flower.
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "application.flowerFullname" -}}
{{ include "application.fullname" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Flower labels
*/}}
{{- define "application.flowerLabels" -}}
{{ include "application.commonLabels" . }}
{{ include "application.flowerSelectorLabels" . }}
{{- end }}

{{/*
Flower selector labels
*/}}
{{- define "application.flowerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "application.flowerName" . }}
{{- end  }}

{{/*
Create a name for Beat
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "application.beatName" -}}
{{ include "application.name" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Create a default fully qualified name for the beat.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "application.beatFullname" -}}
{{ include "application.fullname" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Beat labels
*/}}
{{- define "application.beatLabels" -}}
{{ include "application.commonLabels" . }}
{{ include "application.beatSelectorLabels" . }}
{{- end }}

{{/*
Beat selector labels
*/}}
{{- define "application.beatSelectorLabels" -}}
app.kubernetes.io/name: {{ include "application.beatName" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "application.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "application.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for Config job
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "application.configName" -}}
{{ include "application.name" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
Create a default fully qualified name for config.
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "application.configFullname" -}}
{{ include "application.fullname" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
Config labels
*/}}
{{- define "application.configLabels" -}}
{{ include "application.commonLabels" . }}
{{ include "application.configSelectorLabels" . }}
{{- end }}

{{/*
Config selector labels
*/}}
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
