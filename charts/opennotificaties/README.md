# opennotificaties

![Version: 1.9.2](https://img.shields.io/badge/Version-1.9.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.9.0](https://img.shields.io/badge/AppVersion-1.9.0-informational?style=flat-square)

API voor het routeren van notificaties

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 2.27.0 |
| https://charts.bitnami.com/bitnami | rabbitmq | 11.7.1 |
| https://charts.bitnami.com/bitnami | redis | 17.3.14 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.behavior | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| azureVaultSecret.contentType | string | `""` |  |
| azureVaultSecret.objectName | string | `""` |  |
| azureVaultSecret.secretName | string | `"{{ .Values.existingSecret }}"` |  |
| azureVaultSecret.vaultName | string | `nil` |  |
| beat.livenessProbe.failureThreshold | int | `6` |  |
| beat.livenessProbe.initialDelaySeconds | int | `60` |  |
| beat.livenessProbe.periodSeconds | int | `10` |  |
| beat.livenessProbe.successThreshold | int | `1` |  |
| beat.livenessProbe.timeoutSeconds | int | `5` |  |
| beat.podLabels | object | `{}` |  |
| beat.readinessProbe.failureThreshold | int | `6` |  |
| beat.readinessProbe.initialDelaySeconds | int | `30` |  |
| beat.readinessProbe.periodSeconds | int | `10` |  |
| beat.readinessProbe.successThreshold | int | `1` |  |
| beat.readinessProbe.timeoutSeconds | int | `5` |  |
| beat.replicaCount | int | `1` |  |
| beat.resources | object | `{}` |  |
| configuration.data | string | `""` |  |
| configuration.enabled | bool | `false` |  |
| configuration.initContainer.enabled | bool | `true` | Run the setup configuration command in a init container |
| configuration.job.backoffLimit | int | `6` |  |
| configuration.job.enabled | bool | `false` | Run the setup configuration command as a job |
| configuration.job.resources | object | `{}` |  |
| configuration.job.restartPolicy | string | `"OnFailure"` |  |
| configuration.overwrite | bool | `true` |  |
| configuration.secrets | object | `{}` |  |
| configuration.superuser.email | string | `""` |  |
| configuration.superuser.password | string | `""` |  |
| configuration.superuser.username | string | `""` |  |
| configurationSecretsName | string | `""` |  |
| existingConfigurationSecrets | string | `nil` |  |
| existingSecret | string | `nil` |  |
| extraEnvVars | list | `[]` | Array with extra environment variables to add |
| extraIngress | list | `[]` | Specify extra ingresses, for example if you have multiple ingress classes |
| extraVerifyCerts | string | `""` | Path to extra certificates or CA (root) certificates, comma seperated Warning, If the file does not exist the pod(s) will not start |
| extraVolumeMounts | list | `[]` | Optionally specify extra list of additional volumeMounts |
| extraVolumes | list | `[]` | Optionally specify extra list of additional volumes |
| flower.enabled | bool | `false` |  |
| flower.livenessProbe.failureThreshold | int | `6` |  |
| flower.livenessProbe.initialDelaySeconds | int | `60` |  |
| flower.livenessProbe.periodSeconds | int | `10` |  |
| flower.livenessProbe.successThreshold | int | `1` |  |
| flower.livenessProbe.timeoutSeconds | int | `5` |  |
| flower.podLabels | object | `{}` |  |
| flower.readinessProbe.failureThreshold | int | `6` |  |
| flower.readinessProbe.initialDelaySeconds | int | `30` |  |
| flower.readinessProbe.periodSeconds | int | `10` |  |
| flower.readinessProbe.successThreshold | int | `1` |  |
| flower.readinessProbe.timeoutSeconds | int | `5` |  |
| flower.replicaCount | int | `1` |  |
| flower.resources | object | `{}` |  |
| fullnameOverride | string | `""` |  |
| global.configuration.enabled | bool | `false` |  |
| global.configuration.overwrite | bool | `true` |  |
| global.configuration.secrets | object | `{}` |  |
| global.settings.databaseHost | string | `""` | Global databasehost, overrides setting.database.host |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"openzaak/open-notificaties"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts | list | `[]` | ingress hosts |
| ingress.tls | list | `[]` |  |
| livenessProbe.failureThreshold | int | `6` |  |
| livenessProbe.initialDelaySeconds | int | `60` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| pdb.create | bool | `false` |  |
| pdb.maxUnavailable | string | `""` |  |
| pdb.minAvailable | int | `1` |  |
| persistence.enabled | bool | `true` |  |
| persistence.existingClaim | string | `nil` |  |
| persistence.mediaMountSubpath | string | `"opennotificaties/media"` |  |
| persistence.size | string | `"512Mi"` |  |
| persistence.storageClassName | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| rabbitmq.auth.erlangCookie | string | `""` |  |
| rabbitmq.auth.password | string | `""` |  |
| rabbitmq.auth.username | string | `"user"` |  |
| rabbitmq.clustering.enabled | bool | `false` |  |
| rabbitmq.persistence.enabled | bool | `false` |  |
| rabbitmq.persistence.existingClaim | string | `nil` |  |
| rabbitmq.persistence.size | string | `"1Gi"` |  |
| rabbitmq.rbac.create | bool | `false` |  |
| rabbitmq.resources | object | `{}` |  |
| readinessProbe.failureThreshold | int | `6` |  |
| readinessProbe.initialDelaySeconds | int | `30` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| redis.architecture | string | `"standalone"` |  |
| redis.auth.enabled | bool | `false` |  |
| redis.master.persistence.enabled | bool | `true` |  |
| redis.master.persistence.size | string | `"8Gi"` |  |
| redis.master.persistence.storageClass | string | `""` |  |
| redis.master.resources.requests.cpu | string | `"250m"` |  |
| redis.master.resources.requests.memory | string | `"256Mi"` |  |
| replicaCount | int | `2` |  |
| resources | object | `{}` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `1000` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automountServiceAccountToken | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| settings.allowedHosts | string | `""` |  |
| settings.cache.axes | string | `""` | Sets 'CACHE_AXES' var, only required when tags.redis is false |
| settings.cache.default | string | `""` | Sets 'CACHE_DEFAULT' var, only required when tags.redis is false |
| settings.celery.brokerUrl | string | `""` | Sets the 'CELERY_BROKER_URL' var, only required when tags.rabbitmq is false |
| settings.celery.logLevel | string | `"debug"` | Celery loglevel |
| settings.celery.publishBrokerUrl | string | `""` | Sets the 'PUBLISH_BROKER_URL' var, only required when tags.rabbitmq is false |
| settings.celery.rabbitmqHost | string | `""` | RabbitMQ server hostname |
| settings.celery.resultBackend | string | `""` | Sets the 'CELERY_RESULT_BACKEND' var, only required when tags.redis is false |
| settings.celery.resultExpires | int | `3600` | Sets the 'CELERY_RESULT_EXPIRES' var |
| settings.cleanOldNotifications.cronjob.historyLimit | int | `1` |  |
| settings.cleanOldNotifications.cronjob.resources | object | `{}` |  |
| settings.cleanOldNotifications.cronjob.schedule | string | `"0 0 * * *"` | Schedule to run the clean logged notifications cronjob |
| settings.cleanOldNotifications.daysRetained | string | `""` | Number of days to retain logged notifications, default is 30 days |
| settings.cleanOldNotifications.enabled | bool | `false` | Clean logged notifications |
| settings.database.db_conn_max_age | string | `""` |  |
| settings.database.db_pool.db_pool_max_idle | string | `""` |  |
| settings.database.db_pool.db_pool_max_lifetime | string | `""` |  |
| settings.database.db_pool.db_pool_max_size | string | `""` |  |
| settings.database.db_pool.db_pool_max_waiting | string | `""` |  |
| settings.database.db_pool.db_pool_min_size | string | `""` |  |
| settings.database.db_pool.db_pool_num_workers | string | `""` |  |
| settings.database.db_pool.db_pool_reconnect_timeout | string | `""` |  |
| settings.database.db_pool.db_pool_timeout | string | `""` |  |
| settings.database.db_pool.enabled | bool | `false` |  |
| settings.database.host | string | `""` |  |
| settings.database.name | string | `""` |  |
| settings.database.password | string | `""` |  |
| settings.database.port | int | `5432` |  |
| settings.database.sslmode | string | `"prefer"` |  |
| settings.database.username | string | `""` |  |
| settings.debug | bool | `false` |  |
| settings.disable2fa | bool | `false` | Disable two factor authentication |
| settings.djangoSettingsModule | string | `"nrc.conf.docker"` |  |
| settings.elasticapm.serviceName | string | `""` |  |
| settings.elasticapm.token | string | `""` |  |
| settings.elasticapm.url | string | `""` |  |
| settings.email.defaultFrom | string | `""` |  |
| settings.email.host | string | `"localhost"` |  |
| settings.email.password | string | `""` |  |
| settings.email.port | int | `25` |  |
| settings.email.useTLS | bool | `false` |  |
| settings.email.username | string | `""` |  |
| settings.environment | string | `""` | sets the 'ENVIRONMENT' variable |
| settings.flower.basicAuth | string | `""` |  |
| settings.flower.urlPrefix | string | `""` |  |
| settings.isHttps | bool | `true` |  |
| settings.logNotifications | bool | `true` | When set to true notifications are saved to the database and accessible from the admin interface |
| settings.maxRetries | string | `""` | The maximum number of automatic retries. After this amount of retries, Open Notificaties stops trying to deliver the message. Application default is 5. |
| settings.numProxies | int | `1` | use 2 if enabling ingress |
| settings.requestsTimeout | int | `10` | Timeout in seconds for HTTP requests. |
| settings.retryBackoff | string | `""` | If specified, a factor applied to the exponential backoff. This allows you to tune how quickly automatic retries are performed. Application default is 3. |
| settings.retryBackoffMax | string | `""` | An upper limit to the exponential backoff time. Application default is 48. |
| settings.secretKey | string | `""` | Generate secret key at https://djecrety.ir/ |
| settings.sentry.dsn | string | `""` |  |
| settings.siteDomain | string | `""` | Defines the primary domain where the application is hosted. Defaults to "" |
| settings.useXForwardedHost | bool | `true` |  |
| settings.uwsgi.harakiri | string | `""` |  |
| settings.uwsgi.master | string | `""` |  |
| settings.uwsgi.maxRequests | string | `""` |  |
| settings.uwsgi.processes | string | `""` |  |
| settings.uwsgi.threads | string | `""` |  |
| tags.rabbitmq | bool | `true` |  |
| tags.redis | bool | `true` |  |
| tolerations | list | `[]` |  |
| worker.autoscaling.behavior | object | `{}` |  |
| worker.autoscaling.enabled | bool | `false` |  |
| worker.autoscaling.maxReplicas | int | `100` |  |
| worker.autoscaling.minReplicas | int | `1` |  |
| worker.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| worker.autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| worker.concurrency | int | `4` |  |
| worker.livenessProbe.enabled | bool | `false` |  |
| worker.livenessProbe.exec.command[0] | string | `"/bin/sh"` |  |
| worker.livenessProbe.exec.command[1] | string | `"-c"` |  |
| worker.livenessProbe.exec.command[2] | string | `"celery --workdir src --app nrc.celery inspect --destination celery@${HOSTNAME} active"` |  |
| worker.livenessProbe.failureThreshold | int | `10` |  |
| worker.livenessProbe.initialDelaySeconds | int | `60` |  |
| worker.livenessProbe.periodSeconds | int | `50` |  |
| worker.livenessProbe.successThreshold | int | `1` |  |
| worker.livenessProbe.timeoutSeconds | int | `15` |  |
| worker.maxWorkerLivenessDelta | string | `""` |  |
| worker.pdb.create | bool | `false` |  |
| worker.pdb.maxUnavailable | string | `""` |  |
| worker.pdb.minAvailable | int | `1` |  |
| worker.podLabels | object | `{}` |  |
| worker.replicaCount | int | `2` |  |
| worker.resources | object | `{}` |  |
| worker.resources | object | `{}` |  |

