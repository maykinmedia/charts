# openforms

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.0.1](https://img.shields.io/badge/AppVersion-2.0.1-informational?style=flat-square)

Snel en eenvoudig slimme formulieren bouwen en publiceren

## Requirements

| Repository | Name | Version |
|------------|------|---------|
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
| beat.enabled | bool | `true` |  |
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
| beat.service.port | int | `80` |  |
| beat.service.type | string | `"ClusterIP"` |  |
| existingSecret | string | `nil` |  |
| extraEnvVars | list | `[]` | extraEnvVars Array with extra environment variables to add to openforms e.g: extraEnvVars:   - name: FOO     value: "bar" |
| extraVerifyCerts | string | `""` | Path to extra certificates or CA (root) certificates, comma seperated If the file does not exist the pod(s) will not start e.g. extraVerifyCerts: /etc/ssl/certs/extra-certs/staatdernederlandeng1.pem |
| extraVolumeMounts | list | `[]` | extraVolumeMounts Optionally specify extra list of additional volumeMounts e.g: extraVolumeMounts:  - name: verify-certs    mountPath: /etc/ssl/certs/extra-certs/ |
| extraVolumes | list | `[]` | extraVolumes Optionally specify extra list of additional volumes e.g: extraVolumes:   - name: verify-certs     configMap:       name: verify-certs |
| flower.enabled | bool | `true` |  |
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
| flower.service.port | int | `80` |  |
| flower.service.type | string | `"ClusterIP"` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"openformulieren/open-forms"` |  |
| image.tag | string | `""` | uses .Chart.AppVersion by default |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"openformulieren.gemeente.nl"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.ingressClassName | string | `""` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.failureThreshold | int | `6` |  |
| livenessProbe.initialDelaySeconds | int | `60` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| nameOverride | string | `""` |  |
| nginx.autoscaling.enabled | bool | `false` |  |
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
| settings.allowedHosts | string | `"openformulieren.gemeente.nl"` |  |
| settings.baseUrl | string | `"https://openformulieren.gemeente.nl"` |  |
| settings.cache | object | `{"axes":"openforms-redis-master-0:6379/0","default":"openforms-redis-master-0:6379/0","portalLocker":"openforms-redis-master-0:6379/0"}` | These settings only take effect when tags.redis is set to false |
| settings.celery | object | `{"brokerUrl":"redis://openforms-redis-master:6379/1","logLevel":"debug","resultBackend":"redis://openforms-redis-master:6379/1"}` | These settings only take effect when tags.redis is set to false |
| settings.cookieSamesite | string | `""` | Choises Strict or Lax |
| settings.cors.allowAllOrigins | bool | `false` | if defining the cors hosts, always include the own URL!   |
| settings.cors.allowedOrigins | list | `[]` |  |
| settings.csp.extraDefaultSrc | list | `[]` |  |
| settings.csp.extraImgSrc | list | `[]` |  |
| settings.csp.reportSave | bool | `false` |  |
| settings.csrf.trustedOrigins | list | `[]` |  |
| settings.database.host | string | `"postgres.gemeente.nl"` |  |
| settings.database.name | string | `"openforms"` |  |
| settings.database.password | string | `"SUPER-SECRET"` |  |
| settings.database.port | int | `5432` |  |
| settings.database.sslmode | string | `"prefer"` |  |
| settings.database.username | string | `"openforms"` |  |
| settings.debug | bool | `false` |  |
| settings.djangoSettingsModule | string | `"openforms.conf.docker"` |  |
| settings.elasticapm.token | string | `""` |  |
| settings.elasticapm.url | string | `""` |  |
| settings.email.defaultFrom | string | `"noreply@gemeente.nl"` |  |
| settings.email.host | string | `"localhost"` |  |
| settings.email.password | string | `""` |  |
| settings.email.port | int | `25` |  |
| settings.email.useTLS | bool | `false` |  |
| settings.email.username | string | `""` |  |
| settings.environment | string | `nil` |  |
| settings.flower.basicAuth | string | `""` |  |
| settings.flower.urlPrefix | string | `""` |  |
| settings.isHttps | bool | `true` |  |
| settings.maxFileUpload | string | `"50M"` |  |
| settings.numProxies | int | `1` |  |
| settings.secretKey | string | `"SOME-RANDOM-SECRET"` |  |
| settings.sentry.dsn | string | `""` |  |
| settings.throttling.enable | bool | `true` |  |
| settings.throttling.rateAnonymous | string | `""` |  |
| settings.throttling.ratePolling | string | `""` |  |
| settings.throttling.rateUser | string | `""` |  |
| settings.twoFactorAuthentication | bool | `true` |  |
| settings.uwsgi.harakiri | string | `""` |  |
| settings.uwsgi.master | bool | `false` |  |
| settings.uwsgi.maxRequests | string | `""` |  |
| settings.uwsgi.processes | string | `""` |  |
| settings.uwsgi.threads | string | `""` |  |
| tags.redis | bool | `true` |  |
| tolerations | list | `[]` |  |
| worker.autoscaling.enabled | bool | `false` |  |
| worker.autoscaling.maxReplicas | int | `100` |  |
| worker.autoscaling.minReplicas | int | `1` |  |
| worker.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| worker.autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| worker.concurrency | int | `4` |  |
| worker.livenessProbe.failureThreshold | int | `3` |  |
| worker.livenessProbe.initialDelaySeconds | int | `60` |  |
| worker.livenessProbe.periodSeconds | int | `10` |  |
| worker.livenessProbe.successThreshold | int | `1` |  |
| worker.livenessProbe.timeoutSeconds | int | `5` |  |
| worker.podLabels | object | `{}` |  |
| worker.readinessProbe.failureThreshold | int | `3` |  |
| worker.readinessProbe.initialDelaySeconds | int | `30` |  |
| worker.readinessProbe.periodSeconds | int | `10` |  |
| worker.readinessProbe.successThreshold | int | `1` |  |
| worker.readinessProbe.timeoutSeconds | int | `5` |  |
| worker.replicaCount | int | `1` |  |
| worker.resources | object | `{}` |  |

