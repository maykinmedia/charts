{{- define "maykinUtilsLib.workerHpa" -}}
{{- if .Values.worker.autoscaling.enabled }}
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{ include "project.workerFullname" . }}
  labels:
    {{- include "project.workerSelectorLabels" . | nindent 4 }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ include "project.workerFullname" . }}
  minReplicas: {{ .Values.worker.autoscaling.minReplicas }}
  maxReplicas: {{ .Values.worker.autoscaling.maxReplicas }}
  metrics:
    {{- if .Values.worker.autoscaling.targetCPUUtilizationPercentage }}
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: {{ .Values.worker.autoscaling.targetCPUUtilizationPercentage }}
    {{- end }}
    {{- if .Values.worker.autoscaling.targetMemoryUtilizationPercentage }}
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: {{ .Values.worker.autoscaling.targetMemoryUtilizationPercentage }}
    {{- end }}
  {{- with .Values.worker.autoscaling.behavior }}
  behavior:
    {{- toYaml . | nindent 4 }}
  {{- end }} 
{{- end }}
{{- end -}}