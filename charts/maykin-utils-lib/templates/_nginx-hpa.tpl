{{- define "maykinUtilsLib.nginxHpa" -}}
{{- if .Values.nginx.autoscaling.enabled }}
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{ include "project.nginxFullname" . }}
  labels:
    {{- include "project.nginxSelectorLabels" . | nindent 4 }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ include "project.nginxFullname" . }}
  minReplicas: {{ .Values.nginx.autoscaling.minReplicas }}
  maxReplicas: {{ .Values.nginx.autoscaling.maxReplicas }}
  metrics:
    {{- if .Values.nginx.autoscaling.targetCPUUtilizationPercentage }}
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: {{ .Values.nginx.autoscaling.targetCPUUtilizationPercentage }}
    {{- end }}
    {{- if .Values.nginx.autoscaling.targetMemoryUtilizationPercentage }}
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: {{ .Values.nginx.autoscaling.targetMemoryUtilizationPercentage }}
    {{- end }}
  {{- with .Values.nginx.autoscaling.behavior }}
  behavior:
    {{- toYaml . | nindent 4 }}
  {{- end }} 
{{- end }}
{{- end -}}