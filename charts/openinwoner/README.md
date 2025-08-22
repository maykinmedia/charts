# openinwoner

![Version: 1.9.0](https://img.shields.io/badge/Version-1.9.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.32.0](https://img.shields.io/badge/AppVersion-1.32.0-informational?style=flat-square)

Platform voor gemeenten en overheden om producten inzichtelijker en toegankelijker te maken voor inwoners.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 2.31.4 |
| https://charts.bitnami.com/bitnami | elasticsearch | 22.1.5 |
| https://charts.bitnami.com/bitnami | redis | 22.0.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| azureVaultSecret.contentType | string | `""` |  |
| azureVaultSecret.objectName | string | `""` |  |
| azureVaultSecret.secretName | string | `"{{ .Values.existingSecret }}"` |  |
| azureVaultSecret.vaultName | string | `nil` |  |
| beat.podLabels | object | `{}` |  |
| beat.replicaCount | int | `1` |  |
| beat.resources | object | `{}` |  |
| celeryMonitor.podLabels | object | `{}` |  |
| celeryMonitor.replicaCount | int | `1` |  |
| celeryMonitor.resources | object | `{}` |  |
| configuration.data | string | `""` |  |
| configuration.enabled | bool | `false` |  |
| configuration.initContainer.enabled | bool | `false` | Run the setup configuration command in a init container |
| configuration.job.backoffLimit | int | `6` |  |
| configuration.job.enabled | bool | `true` | Run the setup configuration command as a job |
| configuration.job.resources | object | `{}` |  |
| configuration.job.restartPolicy | string | `"OnFailure"` |  |
| configuration.job.ttlSecondsAfterFinished | int | `0` | 0 Will clean the job after it is finished |
| configuration.secrets | object | `{}` |  |
| elasticsearch.coordinating.replicaCount | int | `1` |  |
| elasticsearch.data.persistence.enabled | bool | `true` |  |
| elasticsearch.data.persistence.size | string | `"8Gi"` |  |
| elasticsearch.data.persistence.storageClass | string | `""` |  |
| elasticsearch.data.replicaCount | int | `1` |  |
| elasticsearch.data.resources.limits | object | `{}` |  |
| elasticsearch.data.resources.requests.cpu | string | `"100m"` |  |
| elasticsearch.data.resources.requests.memory | string | `"512Mi"` |  |
| elasticsearch.image.tag | string | `"9.0.3-debian-12-r1"` |  |
| elasticsearch.ingest.enabled | bool | `false` |  |
| elasticsearch.master.masterOnly | bool | `true` |  |
| elasticsearch.master.persistence.enabled | bool | `true` |  |
| elasticsearch.master.persistence.size | string | `"8Gi"` |  |
| elasticsearch.master.persistence.storageClass | string | `""` |  |
| elasticsearch.master.replicaCount | int | `1` |  |
| elasticsearch.master.resources.limits | object | `{}` |  |
| elasticsearch.master.resources.requests.cpu | string | `"100m"` |  |
| elasticsearch.master.resources.requests.memory | string | `"640Mi"` |  |
| existingConfigurationSecrets | string | `nil` |  |
| existingSecret | string | `nil` |  |
| extraDeploy | list | `[]` | Extra objects to deploy (value evaluated as a template) |
| extraEnvVars | list | `[]` | Array with extra environment variables to add |
| extraIngress | list | `[]` |  |
| extraVolumeMounts | list | `[]` | Optionally specify extra list of additional volumeMounts |
| extraVolumes | list | `[]` | Optionally specify extra list of additional volumes |
| fullnameOverride | string | `""` |  |
| global.configuration.enabled | bool | `false` |  |
| global.configuration.secrets | object | `{}` |  |
| global.settings.databaseHost | string | `""` | Global databasehost, overrides setting.database.host |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"maykinmedia/open-inwoner"` |  |
| image.tag | string | `""` | uses .Chart.AppVersion by default |
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
| nginx.autoscaling.enabled | bool | `false` |  |
| nginx.config.basicAuth | object | `{"enabled":false,"users":"usernameexample:$apr1$5QwE2Ysc$ycRucgmLt0iQMMxcnu4CA/"}` | Configure nginx basic authentication, only use if you are unable to set it on your ingress controller |
| nginx.config.basicAuth.enabled | bool | `false` | Enables nginx basic password authentication |
| nginx.config.basicAuth.users | string | `"usernameexample:$apr1$5QwE2Ysc$ycRucgmLt0iQMMxcnu4CA/"` | You need to generate the encrypted basic auth password yourself |
| nginx.config.clientMaxBodySize | string | `"10M"` |  |
| nginx.config.proxyConnectTimeoutSeconds | int | `300` |  |
| nginx.config.proxyReadTimeoutSeconds | int | `300` |  |
| nginx.extraVolumeMounts | list | `[]` |  |
| nginx.extraVolumes | list | `[]` |  |
| nginx.image.pullPolicy | string | `"IfNotPresent"` |  |
| nginx.image.repository | string | `"nginxinc/nginx-unprivileged"` |  |
| nginx.image.tag | string | `"stable"` |  |
| nginx.livenessProbe.failureThreshold | int | `3` |  |
| nginx.livenessProbe.initialDelaySeconds | int | `60` |  |
| nginx.livenessProbe.periodSeconds | int | `10` |  |
| nginx.livenessProbe.successThreshold | int | `1` |  |
| nginx.livenessProbe.timeoutSeconds | int | `5` |  |
| nginx.podLabels | object | `{}` |  |
| nginx.readinessProbe.failureThreshold | int | `3` |  |
| nginx.readinessProbe.initialDelaySeconds | int | `30` |  |
| nginx.readinessProbe.periodSeconds | int | `10` |  |
| nginx.readinessProbe.successThreshold | int | `1` |  |
| nginx.readinessProbe.timeoutSeconds | int | `5` |  |
| nginx.replicaCount | int | `1` |  |
| nginx.resources | object | `{}` |  |
| nginx.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| nginx.securityContext.readOnlyRootFilesystem | bool | `false` |  |
| nginx.securityContext.runAsNonRoot | bool | `true` |  |
| nginx.securityContext.runAsUser | int | `101` |  |
| nginx.service.annotations | object | `{}` |  |
| nginx.service.port | int | `80` |  |
| nginx.service.type | string | `"ClusterIP"` |  |
| nodeSelector | object | `{}` |  |
| pdb.create | bool | `false` |  |
| pdb.maxUnavailable | string | `""` |  |
| pdb.minAvailable | int | `1` |  |
| persistence.enabled | bool | `true` |  |
| persistence.existingClaim | string | `nil` |  |
| persistence.mediaMountSubpath | string | `"openinwoner/media"` |  |
| persistence.privateMediaMountSubpath | string | `"openinwoner/private_media"` |  |
| persistence.size | string | `"1Gi"` |  |
| persistence.storageClassName | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| readinessProbe.failureThreshold | int | `6` |  |
| readinessProbe.initialDelaySeconds | int | `30` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| redis.architecture | string | `"standalone"` |  |
| redis.auth.enabled | bool | `false` |  |
| redis.image | object | `{"registry":"docker.io","repository":"redis","tag":"8.0"}` | Redis image configuration - Migration from Bitnami to official Redis image           |
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
| settings.brpVersion | string | `""` |  |
| settings.cache.axes | string | `""` | Sets 'CACHE_AXES' var, only required when tags.redis is false |
| settings.cache.default | string | `""` | Sets 'CACHE_DEFAULT' var, only required when tags.redis is false |
| settings.celery.brokerUrl | string | `""` |  |
| settings.celery.logLevel | string | `"debug"` |  |
| settings.celery.resultBackend | string | `""` |  |
| settings.database.host | string | `""` |  |
| settings.database.name | string | `""` |  |
| settings.database.password | string | `""` |  |
| settings.database.port | int | `5432` |  |
| settings.database.sslmode | string | `"prefer"` |  |
| settings.database.username | string | `""` |  |
| settings.debug | bool | `false` |  |
| settings.digidMock | string | `""` |  |
| settings.djangoSettingsModule | string | `"open_inwoner.conf.docker"` |  |
| settings.eherkenningMock | string | `""` |  |
| settings.elasticSearchHost | string | `""` | Elasticsearch hostname, only required when tags.elasticsearch is false |
| settings.elasticapm.token | string | `""` |  |
| settings.elasticapm.url | string | `""` |  |
| settings.email.defaultFrom | string | `""` |  |
| settings.email.host | string | `"localhost"` |  |
| settings.email.password | string | `""` |  |
| settings.email.port | int | `25` |  |
| settings.email.useTLS | bool | `false` |  |
| settings.email.username | string | `""` |  |
| settings.environment | string | `nil` |  |
| settings.isHttps | bool | `true` |  |
| settings.loadFixtures | bool | `false` | Will load all fixtures in /app/src/open_inwoner/conf/fixtures/*.json |
| settings.searchInexInitContainer | bool | `false` |  |
| settings.secretKey | string | `""` | Generate secret key at https://djecrety.ir/ |
| settings.secretKeyFallback | string | `""` | This optional setting can be used to rotate a secret key, by moving a new value into secretKey, and moving the previous secretKey into secretKeyFallback.  |
| settings.sentry.dsn | string | `""` |  |
| settings.smsgateway.apikey | string | `""` |  |
| settings.smsgateway.backend | string | `""` | For example "open_inwoner.accounts.gateways.MessageBird" |
| settings.uwsgi.bufferSize | string | `""` |  |
| settings.uwsgi.harakiri | string | `""` |  |
| settings.uwsgi.httpKeepalive | string | `""` |  |
| settings.uwsgi.httpTimeout | string | `""` |  |
| settings.uwsgi.maxRequests | string | `""` |  |
| settings.uwsgi.port | string | `""` |  |
| settings.uwsgi.postBuffering | string | `""` |  |
| settings.uwsgi.processes | string | `""` |  |
| settings.uwsgi.threads | string | `""` |  |
| tags.elasticsearch | bool | `true` |  |
| tags.redis | bool | `true` |  |
| tolerations | list | `[]` |  |
| worker.autoscaling.enabled | bool | `false` |  |
| worker.autoscaling.maxReplicas | int | `100` |  |
| worker.autoscaling.minReplicas | int | `1` |  |
| worker.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| worker.autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| worker.concurrency | int | `4` |  |
| worker.livenessProbe.enabled | bool | `false` |  |
| worker.livenessProbe.exec.command[0] | string | `"/bin/sh"` |  |
| worker.livenessProbe.exec.command[1] | string | `"-c"` |  |
| worker.livenessProbe.exec.command[2] | string | `"celery --workdir src --app open_inwoner.celery inspect --destination celery@${HOSTNAME} active"` |  |
| worker.livenessProbe.failureThreshold | int | `3` |  |
| worker.livenessProbe.initialDelaySeconds | int | `60` |  |
| worker.livenessProbe.periodSeconds | int | `50` |  |
| worker.livenessProbe.successThreshold | int | `1` |  |
| worker.livenessProbe.timeoutSeconds | int | `10` |  |
| worker.maxWorkerLivenessDelta | string | `""` |  |
| worker.podLabels | object | `{}` |  |
| worker.replicaCount | int | `2` |  |
| worker.resources | object | `{}` |  |

