{{- define "maykinhelmlib.celeryEnvConfigmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "project.fullname" . }}-worker-{{ .Values.worker.label | default "celery" }}
data: 
  CELERY_WORKER_QUEUE: {{ .Values.worker.queueName | default "" }}
  CELERY_WORKER_NAME: {{ .Values.worker.name | default "" }}
{{- end -}}