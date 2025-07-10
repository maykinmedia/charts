# maykin-cg-stack

![Version: 0.0.2](https://img.shields.io/badge/Version-0.0.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Maykin Common Ground components

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://maykinmedia.github.io/charts/ | opennotificaties | 1.3.0 |
| https://maykinmedia.github.io/charts/ | openzaak | 1.3.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.configuration.notificatiesApi | string | `"http://opennotificaties.example.nl/api/v1/"` |  |
| global.configuration.notificatiesDomain | string | `"notificaties.example.nl"` |  |
| global.configuration.notificatiesOpenzaakClientId | string | `"notif-client-id"` |  |
| global.configuration.notificatiesOpenzaakSecret | string | `"notif-secret"` |  |
| global.configuration.openzaakAutorisatiesApi | string | `"https://openzaak.example.nl/autorisaties/api/v1/"` |  |
| global.configuration.openzaakDomain | string | `"openzaak.example.com"` |  |
| global.configuration.openzaakNotificatiesClientId | string | `"oz-client-id"` |  |
| global.configuration.openzaakNotificatiesSecret | string | `"oz-secret"` |  |
| global.configuration.organization | string | `"Gemeente Example"` |  |
| opennotificaties.affinity | object | `{}` |  |
| opennotificaties.autoscaling.enabled | bool | `false` |  |
| opennotificaties.autoscaling.maxReplicas | int | `100` |  |
| opennotificaties.autoscaling.minReplicas | int | `1` |  |
| opennotificaties.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| opennotificaties.autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| opennotificaties.azureVaultSecret.contentType | string | `""` |  |
| opennotificaties.azureVaultSecret.objectName | string | `""` |  |
| opennotificaties.azureVaultSecret.secretName | string | `"{{ .Values.existingSecret }}"` |  |
| opennotificaties.azureVaultSecret.vaultName | string | `nil` |  |
| opennotificaties.configuration.cronjob.historyLimit | int | `1` |  |
| opennotificaties.configuration.cronjob.resources | object | `{}` |  |
| opennotificaties.configuration.cronjob.schedule | string | `"0 0 * * *"` | Schedule to run the clean logged notifications cronjob |
| opennotificaties.configuration.enabled | bool | `true` |  |
| opennotificaties.configuration.notificaties.enabled | bool | `true` |  |
| opennotificaties.configuration.notificaties.openzaakNotifcationClientId | string | `"oz-client-id"` |  |
| opennotificaties.configuration.notificaties.openzaakNotificationSecret | string | `"oz-secret"` |  |
| opennotificaties.configuration.openzaakAuthorization.ApiRoot | string | `"http://opennotificaties.example.nl/api/v1/"` |  |
| opennotificaties.configuration.openzaakAuthorization.enabled | bool | `true` |  |
| opennotificaties.configuration.openzaakAuthorization.notifcationOpenzaakSecret | string | `"notif-secret"` |  |
| opennotificaties.configuration.openzaakAuthorization.notificationOpenzaakClientId | string | `"notif-client-id"` |  |
| opennotificaties.configuration.sites.enabled | bool | `true` |  |
| opennotificaties.configuration.sites.notificatiesDomain | string | `"notificaties.example.nl"` |  |
| opennotificaties.configuration.sites.organization | string | `"Gemeente Example"` |  |
| opennotificaties.configuration.superuser.email | string | `""` |  |
| opennotificaties.configuration.superuser.password | string | `""` |  |
| opennotificaties.configuration.superuser.username | string | `""` |  |
| opennotificaties.enabled | bool | `true` |  |
| opennotificaties.existingSecret | string | `nil` |  |
| opennotificaties.extraEnvVars | list | `[]` | Array with extra environment variables to add |
| opennotificaties.extraIngress | list | `[]` | Specify extra ingresses, for example if you have multiple ingress classes |
| opennotificaties.extraVerifyCerts | string | `""` | Path to extra certificates or CA (root) certificates, comma seperated Warning, If the file does not exist the pod(s) will not start |
| opennotificaties.extraVolumeMounts | list | `[]` | Optionally specify extra list of additional volumeMounts |
| opennotificaties.extraVolumes | list | `[]` | Optionally specify extra list of additional volumes |
| opennotificaties.flower.enabled | bool | `true` |  |
| opennotificaties.flower.livenessProbe.failureThreshold | int | `6` |  |
| opennotificaties.flower.livenessProbe.initialDelaySeconds | int | `60` |  |
| opennotificaties.flower.livenessProbe.periodSeconds | int | `10` |  |
| opennotificaties.flower.livenessProbe.successThreshold | int | `1` |  |
| opennotificaties.flower.livenessProbe.timeoutSeconds | int | `5` |  |
| opennotificaties.flower.podLabels | object | `{}` |  |
| opennotificaties.flower.readinessProbe.failureThreshold | int | `6` |  |
| opennotificaties.flower.readinessProbe.initialDelaySeconds | int | `30` |  |
| opennotificaties.flower.readinessProbe.periodSeconds | int | `10` |  |
| opennotificaties.flower.readinessProbe.successThreshold | int | `1` |  |
| opennotificaties.flower.readinessProbe.timeoutSeconds | int | `5` |  |
| opennotificaties.flower.replicaCount | int | `1` |  |
| opennotificaties.flower.resources | object | `{}` |  |
| opennotificaties.fullnameOverride | string | `""` |  |
| opennotificaties.image.pullPolicy | string | `"IfNotPresent"` |  |
| opennotificaties.image.repository | string | `"openzaak/open-notificaties"` |  |
| opennotificaties.image.tag | string | `""` |  |
| opennotificaties.imagePullSecrets | list | `[]` |  |
| opennotificaties.ingress.annotations | object | `{}` |  |
| opennotificaties.ingress.className | string | `""` |  |
| opennotificaties.ingress.enabled | bool | `false` |  |
| opennotificaties.ingress.hosts | list | `[]` | ingress hosts |
| opennotificaties.ingress.tls | list | `[]` |  |
| opennotificaties.livenessProbe.failureThreshold | int | `6` |  |
| opennotificaties.livenessProbe.initialDelaySeconds | int | `60` |  |
| opennotificaties.livenessProbe.periodSeconds | int | `10` |  |
| opennotificaties.livenessProbe.successThreshold | int | `1` |  |
| opennotificaties.livenessProbe.timeoutSeconds | int | `5` |  |
| opennotificaties.nameOverride | string | `""` |  |
| opennotificaties.nodeSelector | object | `{}` |  |
| opennotificaties.pdb.create | bool | `false` |  |
| opennotificaties.pdb.maxUnavailable | string | `""` |  |
| opennotificaties.pdb.minAvailable | int | `1` |  |
| opennotificaties.persistence.enabled | bool | `true` |  |
| opennotificaties.persistence.existingClaim | string | `nil` |  |
| opennotificaties.persistence.mediaMountSubpath | string | `"opennotificaties/media"` |  |
| opennotificaties.persistence.size | string | `"512Mi"` |  |
| opennotificaties.persistence.storageClassName | string | `""` |  |
| opennotificaties.podAnnotations | object | `{}` |  |
| opennotificaties.podLabels | object | `{}` |  |
| opennotificaties.podSecurityContext.fsGroup | int | `1000` |  |
| opennotificaties.rabbitmq.auth.erlangCookie | string | `""` |  |
| opennotificaties.rabbitmq.auth.password | string | `""` |  |
| opennotificaties.rabbitmq.auth.username | string | `"user"` |  |
| opennotificaties.rabbitmq.clustering.enabled | bool | `false` |  |
| opennotificaties.rabbitmq.persistence.enabled | bool | `false` |  |
| opennotificaties.rabbitmq.persistence.existingClaim | string | `nil` |  |
| opennotificaties.rabbitmq.persistence.size | string | `"1Gi"` |  |
| opennotificaties.rabbitmq.rbac.create | bool | `false` |  |
| opennotificaties.rabbitmq.resources | object | `{}` |  |
| opennotificaties.readinessProbe.failureThreshold | int | `6` |  |
| opennotificaties.readinessProbe.initialDelaySeconds | int | `30` |  |
| opennotificaties.readinessProbe.periodSeconds | int | `10` |  |
| opennotificaties.readinessProbe.successThreshold | int | `1` |  |
| opennotificaties.readinessProbe.timeoutSeconds | int | `5` |  |
| opennotificaties.redis.architecture | string | `"standalone"` |  |
| opennotificaties.redis.auth.enabled | bool | `false` |  |
| opennotificaties.redis.master.persistence.enabled | bool | `false` |  |
| opennotificaties.redis.master.resources.requests.cpu | string | `"10m"` |  |
| opennotificaties.redis.master.resources.requests.memory | string | `"20Mi"` |  |
| opennotificaties.replicaCount | int | `1` |  |
| opennotificaties.resources | object | `{}` |  |
| opennotificaties.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| opennotificaties.securityContext.readOnlyRootFilesystem | bool | `false` |  |
| opennotificaties.securityContext.runAsNonRoot | bool | `true` |  |
| opennotificaties.securityContext.runAsUser | int | `1000` |  |
| opennotificaties.service.port | int | `80` |  |
| opennotificaties.service.type | string | `"ClusterIP"` |  |
| opennotificaties.serviceAccount.annotations | object | `{}` |  |
| opennotificaties.serviceAccount.automountServiceAccountToken | bool | `true` |  |
| opennotificaties.serviceAccount.create | bool | `true` |  |
| opennotificaties.serviceAccount.name | string | `""` |  |
| opennotificaties.settings.allowedHosts | string | `""` |  |
| opennotificaties.settings.cache.axes | string | `""` | Sets 'CACHE_AXES' var, only required when tags.redis is false |
| opennotificaties.settings.cache.default | string | `""` | Sets 'CACHE_DEFAULT' var, only required when tags.redis is false |
| opennotificaties.settings.celery.brokerUrl | string | `""` | Sets the 'CELERY_BROKER_URL' var, only required when tags.rabbitmq is false |
| opennotificaties.settings.celery.logLevel | string | `"debug"` | Celery loglevel |
| opennotificaties.settings.celery.publishBrokerUrl | string | `""` | Sets the 'PUBLISH_BROKER_URL' var, only required when tags.rabbitmq is false |
| opennotificaties.settings.celery.rabbitmqHost | string | `""` | RabbitMQ server hostname |
| opennotificaties.settings.celery.resultBackend | string | `""` | Sets the 'CELERY_RESULT_BACKEND' var, only required when tags.redis is false |
| opennotificaties.settings.cleanOldNotifications.cronjob.historyLimit | int | `1` |  |
| opennotificaties.settings.cleanOldNotifications.cronjob.resources | object | `{}` |  |
| opennotificaties.settings.cleanOldNotifications.cronjob.schedule | string | `"0 0 * * *"` | Schedule to run the clean logged notifications cronjob |
| opennotificaties.settings.cleanOldNotifications.daysRetained | string | `""` | Number of days to retain logged notifications, default is 30 days |
| opennotificaties.settings.cleanOldNotifications.enabled | bool | `false` | Clean logged notifications |
| opennotificaties.settings.database.host | string | `""` |  |
| opennotificaties.settings.database.name | string | `""` |  |
| opennotificaties.settings.database.password | string | `""` |  |
| opennotificaties.settings.database.port | int | `5432` |  |
| opennotificaties.settings.database.sslmode | string | `"prefer"` |  |
| opennotificaties.settings.database.username | string | `""` |  |
| opennotificaties.settings.debug | bool | `false` |  |
| opennotificaties.settings.djangoSettingsModule | string | `"nrc.conf.docker"` |  |
| opennotificaties.settings.elasticapm.serviceName | string | `""` |  |
| opennotificaties.settings.elasticapm.token | string | `""` |  |
| opennotificaties.settings.elasticapm.url | string | `""` |  |
| opennotificaties.settings.email.host | string | `"localhost"` |  |
| opennotificaties.settings.email.password | string | `""` |  |
| opennotificaties.settings.email.port | int | `25` |  |
| opennotificaties.settings.email.useTLS | bool | `false` |  |
| opennotificaties.settings.email.username | string | `""` |  |
| opennotificaties.settings.environment | string | `""` | sets the 'ENVIRONMENT' variable |
| opennotificaties.settings.flower.basicAuth | string | `""` |  |
| opennotificaties.settings.flower.urlPrefix | string | `""` |  |
| opennotificaties.settings.isHttps | bool | `true` |  |
| opennotificaties.settings.logNotifications | bool | `true` | When set to true notifications are saved to the database and accessible from the admin interface |
| opennotificaties.settings.maxRetries | string | `""` | The maximum number of automatic retries. After this amount of retries, Open Notificaties stops trying to deliver the message. Application default is 5. |
| opennotificaties.settings.numProxies | int | `1` | use 2 if enabling ingress |
| opennotificaties.settings.retryBackoff | string | `""` | If specified, a factor applied to the exponential backoff. This allows you to tune how quickly automatic retries are performed. Application default is 3. |
| opennotificaties.settings.retryBackoffMax | string | `""` | An upper limit to the exponential backoff time. Application default is 48. |
| opennotificaties.settings.secretKey | string | `""` | Generate secret key at https://djecrety.ir/ |
| opennotificaties.settings.sentry.dsn | string | `""` |  |
| opennotificaties.settings.useXForwardedHost | bool | `true` |  |
| opennotificaties.settings.uwsgi.harakiri | string | `""` |  |
| opennotificaties.settings.uwsgi.master | string | `""` |  |
| opennotificaties.settings.uwsgi.maxRequests | string | `""` |  |
| opennotificaties.settings.uwsgi.processes | string | `""` |  |
| opennotificaties.settings.uwsgi.threads | string | `""` |  |
| opennotificaties.tags.rabbitmq | bool | `true` |  |
| opennotificaties.tags.redis | bool | `true` |  |
| opennotificaties.tolerations | list | `[]` |  |
| opennotificaties.worker.autoscaling.enabled | bool | `false` |  |
| opennotificaties.worker.autoscaling.maxReplicas | int | `100` |  |
| opennotificaties.worker.autoscaling.minReplicas | int | `1` |  |
| opennotificaties.worker.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| opennotificaties.worker.autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| opennotificaties.worker.concurrency | int | `4` |  |
| opennotificaties.worker.livenessProbe.failureThreshold | int | `3` |  |
| opennotificaties.worker.livenessProbe.initialDelaySeconds | int | `60` |  |
| opennotificaties.worker.livenessProbe.periodSeconds | int | `10` |  |
| opennotificaties.worker.livenessProbe.successThreshold | int | `1` |  |
| opennotificaties.worker.livenessProbe.timeoutSeconds | int | `5` |  |
| opennotificaties.worker.podLabels | object | `{}` |  |
| opennotificaties.worker.readinessProbe.failureThreshold | int | `3` |  |
| opennotificaties.worker.readinessProbe.initialDelaySeconds | int | `30` |  |
| opennotificaties.worker.readinessProbe.periodSeconds | int | `10` |  |
| opennotificaties.worker.readinessProbe.successThreshold | int | `1` |  |
| opennotificaties.worker.readinessProbe.timeoutSeconds | int | `5` |  |
| opennotificaties.worker.replicaCount | int | `1` |  |
| opennotificaties.worker.resources | object | `{}` |  |
| openzaak.affinity | object | `{}` |  |
| openzaak.autoscaling.enabled | bool | `false` |  |
| openzaak.autoscaling.maxReplicas | int | `100` |  |
| openzaak.autoscaling.minReplicas | int | `1` |  |
| openzaak.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| openzaak.autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| openzaak.azureVaultSecret.contentType | string | `""` |  |
| openzaak.azureVaultSecret.objectName | string | `""` |  |
| openzaak.azureVaultSecret.secretName | string | `"{{ .Values.existingSecret }}"` |  |
| openzaak.azureVaultSecret.vaultName | string | `nil` |  |
| openzaak.configuration.cronjob.historyLimit | int | `1` |  |
| openzaak.configuration.cronjob.resources | object | `{}` |  |
| openzaak.configuration.cronjob.schedule | string | `"0 0 * * *"` | Schedule to run the clean logged notifications cronjob |
| openzaak.configuration.enabled | bool | `true` |  |
| openzaak.configuration.notificaties.ApiRoot | string | `"http://opennotificaties.example.nl/api/v1/"` |  |
| openzaak.configuration.notificaties.enabled | bool | `true` |  |
| openzaak.configuration.notificaties.openzaakNotifcationClientId | string | `"oz-client-id"` |  |
| openzaak.configuration.notificaties.openzaakNotificationSecret | string | `"oz-secret"` |  |
| openzaak.configuration.notificatiesAuthorization.enabled | bool | `true` |  |
| openzaak.configuration.notificatiesAuthorization.notifcationOpenzaakSecret | string | `"notif-secret"` |  |
| openzaak.configuration.notificatiesAuthorization.notificationOpenzaakClientId | string | `"notif-client-id"` |  |
| openzaak.configuration.selectieLijst.AllowedYears[0] | int | `2017` |  |
| openzaak.configuration.selectieLijst.AllowedYears[1] | int | `2020` |  |
| openzaak.configuration.selectieLijst.ApiOas | string | `"https://selectielijst.openzaak.nl/api/v1/schema/openapi.yaml"` |  |
| openzaak.configuration.selectieLijst.ApiRoot | string | `"https://selectielijst.openzaak.nl/api/v1/"` |  |
| openzaak.configuration.selectieLijst.DefaultYear | int | `2020` |  |
| openzaak.configuration.selectieLijst.enabled | bool | `true` |  |
| openzaak.configuration.sites.enabled | bool | `true` |  |
| openzaak.configuration.sites.openzaakDomain | string | `"openzaak.example.com"` |  |
| openzaak.configuration.sites.organization | string | `"Gemeente Example"` |  |
| openzaak.configuration.superuser.email | string | `""` |  |
| openzaak.configuration.superuser.password | string | `""` |  |
| openzaak.configuration.superuser.username | string | `""` |  |
| openzaak.enabled | bool | `true` |  |
| openzaak.existingSecret | string | `nil` |  |
| openzaak.extraDeploy | list | `[]` |  |
| openzaak.extraEnvVars | list | `[]` |  |
| openzaak.extraIngress | list | `[]` | Specify extra ingresses, for example if you have multiple ingress classes |
| openzaak.extraVerifyCerts | string | `""` |  |
| openzaak.extraVolumeMounts | list | `[]` |  |
| openzaak.extraVolumes | list | `[]` |  |
| openzaak.flower.enabled | bool | `true` |  |
| openzaak.flower.livenessProbe.failureThreshold | int | `6` |  |
| openzaak.flower.livenessProbe.initialDelaySeconds | int | `60` |  |
| openzaak.flower.livenessProbe.periodSeconds | int | `10` |  |
| openzaak.flower.livenessProbe.successThreshold | int | `1` |  |
| openzaak.flower.livenessProbe.timeoutSeconds | int | `5` |  |
| openzaak.flower.podLabels | object | `{}` |  |
| openzaak.flower.readinessProbe.failureThreshold | int | `6` |  |
| openzaak.flower.readinessProbe.initialDelaySeconds | int | `30` |  |
| openzaak.flower.readinessProbe.periodSeconds | int | `10` |  |
| openzaak.flower.readinessProbe.successThreshold | int | `1` |  |
| openzaak.flower.readinessProbe.timeoutSeconds | int | `5` |  |
| openzaak.flower.replicaCount | int | `1` |  |
| openzaak.flower.resources | object | `{}` |  |
| openzaak.fullnameOverride | string | `""` |  |
| openzaak.image.pullPolicy | string | `"IfNotPresent"` |  |
| openzaak.image.repository | string | `"openzaak/open-zaak"` |  |
| openzaak.image.tag | string | `""` |  |
| openzaak.imagePullSecrets | list | `[]` |  |
| openzaak.ingress.annotations | object | `{}` |  |
| openzaak.ingress.className | string | `""` |  |
| openzaak.ingress.enabled | bool | `false` |  |
| openzaak.ingress.hosts | list | `[]` | ingress hosts |
| openzaak.ingress.tls | list | `[]` |  |
| openzaak.livenessProbe.failureThreshold | int | `6` |  |
| openzaak.livenessProbe.initialDelaySeconds | int | `60` |  |
| openzaak.livenessProbe.periodSeconds | int | `10` |  |
| openzaak.livenessProbe.successThreshold | int | `1` |  |
| openzaak.livenessProbe.timeoutSeconds | int | `5` |  |
| openzaak.nameOverride | string | `""` |  |
| openzaak.nginx.autoscaling.enabled | bool | `false` |  |
| openzaak.nginx.existingConfigmap | string | `nil` | mount existing nginx vhost config |
| openzaak.nginx.image.pullPolicy | string | `"IfNotPresent"` |  |
| openzaak.nginx.image.repository | string | `"nginxinc/nginx-unprivileged"` |  |
| openzaak.nginx.image.tag | string | `"stable"` |  |
| openzaak.nginx.livenessProbe.failureThreshold | int | `3` |  |
| openzaak.nginx.livenessProbe.initialDelaySeconds | int | `60` |  |
| openzaak.nginx.livenessProbe.periodSeconds | int | `10` |  |
| openzaak.nginx.livenessProbe.successThreshold | int | `1` |  |
| openzaak.nginx.livenessProbe.timeoutSeconds | int | `5` |  |
| openzaak.nginx.podLabels | object | `{}` |  |
| openzaak.nginx.readinessProbe.failureThreshold | int | `3` |  |
| openzaak.nginx.readinessProbe.initialDelaySeconds | int | `30` |  |
| openzaak.nginx.readinessProbe.periodSeconds | int | `10` |  |
| openzaak.nginx.readinessProbe.successThreshold | int | `1` |  |
| openzaak.nginx.readinessProbe.timeoutSeconds | int | `5` |  |
| openzaak.nginx.replicaCount | int | `1` |  |
| openzaak.nginx.resources | object | `{}` |  |
| openzaak.nginx.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| openzaak.nginx.securityContext.readOnlyRootFilesystem | bool | `false` |  |
| openzaak.nginx.securityContext.runAsNonRoot | bool | `true` |  |
| openzaak.nginx.securityContext.runAsUser | int | `101` |  |
| openzaak.nginx.service.annotations | object | `{}` |  |
| openzaak.nginx.service.port | int | `80` |  |
| openzaak.nginx.service.type | string | `"ClusterIP"` |  |
| openzaak.nodeSelector | object | `{}` |  |
| openzaak.pdb.create | bool | `false` |  |
| openzaak.pdb.maxUnavailable | string | `""` |  |
| openzaak.pdb.minAvailable | int | `1` |  |
| openzaak.persistence.enabled | bool | `true` |  |
| openzaak.persistence.existingClaim | string | `nil` |  |
| openzaak.persistence.mediaMountSubpath | string | `"openzaak/media"` |  |
| openzaak.persistence.privateMediaMountSubpath | string | `"openzaak/private_media"` |  |
| openzaak.persistence.size | string | `"1Gi"` |  |
| openzaak.persistence.storageClassName | string | `""` |  |
| openzaak.podAnnotations | object | `{}` |  |
| openzaak.podLabels | object | `{}` |  |
| openzaak.podSecurityContext.fsGroup | int | `1000` |  |
| openzaak.readinessProbe.failureThreshold | int | `6` |  |
| openzaak.readinessProbe.initialDelaySeconds | int | `30` |  |
| openzaak.readinessProbe.periodSeconds | int | `10` |  |
| openzaak.readinessProbe.successThreshold | int | `1` |  |
| openzaak.readinessProbe.timeoutSeconds | int | `5` |  |
| openzaak.redis.architecture | string | `"standalone"` |  |
| openzaak.redis.auth.enabled | bool | `false` |  |
| openzaak.redis.master.persistence.enabled | bool | `false` |  |
| openzaak.redis.master.resources.requests.cpu | string | `"10m"` |  |
| openzaak.redis.master.resources.requests.memory | string | `"20Mi"` |  |
| openzaak.replicaCount | int | `1` |  |
| openzaak.resources | object | `{}` |  |
| openzaak.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| openzaak.securityContext.readOnlyRootFilesystem | bool | `false` |  |
| openzaak.securityContext.runAsNonRoot | bool | `true` |  |
| openzaak.securityContext.runAsUser | int | `1000` |  |
| openzaak.service.port | int | `80` |  |
| openzaak.service.type | string | `"ClusterIP"` |  |
| openzaak.serviceAccount.annotations | object | `{}` |  |
| openzaak.serviceAccount.automountServiceAccountToken | bool | `true` |  |
| openzaak.serviceAccount.create | bool | `true` |  |
| openzaak.serviceAccount.name | string | `""` |  |
| openzaak.settings.allowedHosts | string | `""` |  |
| openzaak.settings.cache.axes | string | `""` |  |
| openzaak.settings.cache.default | string | `""` |  |
| openzaak.settings.cache.portalLocker | string | `""` |  |
| openzaak.settings.celery.brokerUrl | string | `""` |  |
| openzaak.settings.celery.enabled | bool | `true` | Deploy celery (worker), celery is required from openzaak version 1.8.0 |
| openzaak.settings.celery.logLevel | string | `"debug"` |  |
| openzaak.settings.celery.resultBackend | string | `""` |  |
| openzaak.settings.cmis.enabled | bool | `false` |  |
| openzaak.settings.cmis.mapperFile | string | `""` |  |
| openzaak.settings.database.host | string | `"open-zaak-postgresql"` |  |
| openzaak.settings.database.name | string | `"openzaak"` |  |
| openzaak.settings.database.password | string | `"SUPER-SECRET"` |  |
| openzaak.settings.database.port | int | `5432` |  |
| openzaak.settings.database.sslmode | string | `"prefer"` |  |
| openzaak.settings.database.username | string | `"postgres"` |  |
| openzaak.settings.debug | bool | `false` |  |
| openzaak.settings.djangoSettingsModule | string | `"openzaak.conf.docker"` |  |
| openzaak.settings.elasticapm.serviceName | string | `""` |  |
| openzaak.settings.elasticapm.token | string | `""` |  |
| openzaak.settings.elasticapm.url | string | `""` |  |
| openzaak.settings.email.host | string | `"localhost"` |  |
| openzaak.settings.email.password | string | `""` |  |
| openzaak.settings.email.port | int | `25` |  |
| openzaak.settings.email.useTLS | bool | `false` |  |
| openzaak.settings.email.username | string | `""` |  |
| openzaak.settings.environment | string | `""` |  |
| openzaak.settings.flower.basicAuth | string | `""` |  |
| openzaak.settings.flower.urlPrefix | string | `""` |  |
| openzaak.settings.isHttps | bool | `true` |  |
| openzaak.settings.jwtExpiry | int | `3600` |  |
| openzaak.settings.notificationsDisabled | bool | `false` |  |
| openzaak.settings.numProxies | int | `1` | use 2 if enabling ingress |
| openzaak.settings.secretKey | string | `""` | Generate secret key at https://djecrety.ir/ |
| openzaak.settings.sentry.dsn | string | `""` |  |
| openzaak.settings.useXForwardedHost | bool | `true` |  |
| openzaak.settings.uwsgi.harakiri | string | `""` |  |
| openzaak.settings.uwsgi.master | string | `""` |  |
| openzaak.settings.uwsgi.maxRequests | string | `""` |  |
| openzaak.settings.uwsgi.processes | string | `""` |  |
| openzaak.settings.uwsgi.threads | string | `""` |  |
| openzaak.tags.redis | bool | `true` |  |
| openzaak.tolerations | list | `[]` |  |
| openzaak.worker.autoscaling.enabled | bool | `false` |  |
| openzaak.worker.autoscaling.maxReplicas | int | `100` |  |
| openzaak.worker.autoscaling.minReplicas | int | `1` |  |
| openzaak.worker.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| openzaak.worker.autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| openzaak.worker.concurrency | int | `4` |  |
| openzaak.worker.livenessProbe.failureThreshold | int | `3` |  |
| openzaak.worker.livenessProbe.initialDelaySeconds | int | `60` |  |
| openzaak.worker.livenessProbe.periodSeconds | int | `10` |  |
| openzaak.worker.livenessProbe.successThreshold | int | `1` |  |
| openzaak.worker.livenessProbe.timeoutSeconds | int | `5` |  |
| openzaak.worker.podLabels | object | `{}` |  |
| openzaak.worker.readinessProbe.failureThreshold | int | `3` |  |
| openzaak.worker.readinessProbe.initialDelaySeconds | int | `30` |  |
| openzaak.worker.readinessProbe.periodSeconds | int | `10` |  |
| openzaak.worker.readinessProbe.successThreshold | int | `1` |  |
| openzaak.worker.readinessProbe.timeoutSeconds | int | `5` |  |
| openzaak.worker.replicaCount | int | `1` |  |
| openzaak.worker.resources | object | `{}` |  |
| tags.opennotificaties | bool | `true` |  |
| tags.openzaak | bool | `true` |  |

