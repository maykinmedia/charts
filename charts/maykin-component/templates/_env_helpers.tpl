{{/*
Normalises a boolean-like value (bool or string) to True/False.
"true", "1", "yes", "on" (case-insensitive) -> True, any other set value -> False.
Returns an empty string when the value is nil or "", so the caller can omit the variable
and let the application (or /uwsgi.ini) default apply.
Usage:
  {{- with include "application.boolValue" .Values.settings.debug }}
  DEBUG: {{ . | quote }}
  {{- end }}
*/}}
{{- define "application.boolValue" -}}
{{- if and (not (kindIs "invalid" .)) (ne (toString .) "") -}}
{{- if has (toString . | lower) (list "true" "1" "yes" "on") -}}True{{- else -}}False{{- end -}}
{{- end -}}
{{- end -}}
