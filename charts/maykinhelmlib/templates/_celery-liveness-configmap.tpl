{{- define "maykinhelmlib.celeryLivenessConfigmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "project.fullname" . }}-celery-liveness
data: 
  liveness-probe.sh: |
    #!/bin/bash

    # Exit immediately if a non-zero exit code is returned
    set -e

    QUEUE_NAME=${CELERY_WORKER_QUEUE:-celery}

    # Check if CELERY_WORKER_NAME is set
    if [ -z "$CELERY_WORKER_NAME" ]; then
      # If not set
      WORKER_NAME="${QUEUE_NAME}@${HOSTNAME}"
    else
      # If set and contains the '@' symbol
      if [[ "$CELERY_WORKER_NAME" != *"@"* ]]; then
        # If not, update CELERY_WORKER_NAME to celery@${CELERY_WORKER_NAME}
        WORKER_NAME="celery@${CELERY_WORKER_NAME}"
      else
        WORKER_NAME="${CELERY_WORKER_NAME}"
      fi
    fi

    # Use CELERY_WORKER_NAME to set the --destination flag
    celery --workdir src --app {{ include "application.name" . }}.celery inspect --destination "$WORKER_NAME" active
{{- end -}}