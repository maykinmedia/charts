# openinwoner

![Version: 0.9.4](https://img.shields.io/badge/Version-0.9.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.3](https://img.shields.io/badge/AppVersion-1.3-informational?style=flat-square)

Platform voor gemeenten en overheden om producten inzichtelijker en toegankelijker te maken voor inwoners.

## TL;DR

```console
helm repo add my-repo https://maykinmedia.github.io/charts/
helm install my-release my-repo/openinwoner
```
## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | elasticsearch | 19.5.11 |
| https://charts.bitnami.com/bitnami | redis | 17.3.14 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| elasticsearch.coordinating.replicaCount | int | `1` |  |
| elasticsearch.data.persistence.enabled | bool | `false` |  |
| elasticsearch.data.persistence.size | string | `"8Gi"` |  |
| elasticsearch.data.replicaCount | int | `1` |  |
| elasticsearch.ingest.enabled | bool | `false` |  |
| elasticsearch.master.masterOnly | bool | `true` |  |
| elasticsearch.master.persistence.enabled | bool | `false` |  |
| elasticsearch.master.persistence.size | string | `""` |  |
| elasticsearch.master.replicaCount | int | `1` |  |
| elasticsearch.master.resources.limits | object | `{}` |  |
| elasticsearch.master.resources.requests.cpu | string | `"25m"` |  |
| elasticsearch.master.resources.requests.memory | string | `"256Mi"` |  |
| existingSecret | string | `nil` |  |
| extraEnvVars | list | `[]` | Array with extra environment variables to add |
| extraVolumeMounts | list | `[]` | Optionally specify extra list of additional volumeMounts |
| extraVolumes | list | `[]` | Optionally specify extra list of additional volumes |
| fullnameOverride | string | `""` |  |
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
| nginx.config.clientMaxBodySize | string | `"10M"` |  |
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
| nodeSelector | object | `{}` |  |
| persistence.enabled | bool | `true` |  |
| persistence.existingClaim | string | `nil` |  |
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
| redis.master.persistence.enabled | bool | `false` |  |
| redis.master.resources.requests.cpu | string | `"10m"` |  |
| redis.master.resources.requests.memory | string | `"20Mi"` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `1000` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| settings.allowedHosts | string | `""` |  |
| settings.cache.axes | string | `""` | Sets 'CACHE_AXES' var, only required when tags.redis is false |
| settings.cache.default | string | `""` | Sets 'CACHE_DEFAULT' var, only required when tags.redis is false |
| settings.database.host | string | `""` |  |
| settings.database.name | string | `""` |  |
| settings.database.password | string | `""` |  |
| settings.database.port | int | `5432` |  |
| settings.database.sslmode | string | `"prefer"` |  |
| settings.database.username | string | `""` |  |
| settings.debug | bool | `false` |  |
| settings.djangoSettingsModule | string | `"open_inwoner.conf.docker"` |  |
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
| settings.secretKey | string | `""` | Generate secret key at https://djecrety.ir/ |
| settings.sentry.dsn | string | `""` |  |
| settings.twoFactorAuthentication | bool | `true` |  |
| settings.useXForwardedHost | bool | `true` |  |
| settings.uwsgi.harakiri | string | `""` |  |
| settings.uwsgi.master | bool | `false` |  |
| settings.uwsgi.maxRequests | string | `""` |  |
| settings.uwsgi.processes | string | `""` |  |
| settings.uwsgi.threads | string | `""` |  |
| tags.elasticsearch | bool | `true` |  |
| tags.redis | bool | `true` |  |
| tolerations | list | `[]` |  |

