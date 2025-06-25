# openzaaktypebeheer

![Version: 0.1.9](https://img.shields.io/badge/Version-0.1.9-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.2](https://img.shields.io/badge/AppVersion-0.1.2-informational?style=flat-square)

An app to manage the relations between 'zaaktypen' and 'informatieobjecttypen'.

**Homepage:** <https://github.com/maykinmedia/open-zaaktypebeheer>

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
| azureVaultSecret.contentType | string | `""` |  |
| azureVaultSecret.objectName | string | `""` |  |
| azureVaultSecret.secretName | string | `"{{ .Values.existingSecret }}"` |  |
| azureVaultSecret.vaultName | string | `nil` |  |
| existingSecret | string | `nil` |  |
| extraIngress | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"maykinmedia/open-zaaktypebeheer"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts | list | `[]` |  |
| ingress.tls | list | `[]` |  |
| nameOverride | string | `""` |  |
| nginx.autoscaling.enabled | bool | `false` |  |
| nginx.existingConfigmap | string | `nil` |  |
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
| nginx.service.port | int | `8080` |  |
| nginx.service.type | string | `"ClusterIP"` |  |
| nodeSelector | object | `{}` |  |
| persistence.enabled | bool | `true` |  |
| persistence.existingClaim | string | `nil` |  |
| persistence.mediaMountSubpath | string | `"openzaaktypebeheer/media"` |  |
| persistence.size | string | `"1Gi"` |  |
| persistence.storageClassName | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| redis.architecture | string | `"standalone"` |  |
| redis.auth.enabled | bool | `false` |  |
| redis.master.persistence.enabled | bool | `true` |  |
| redis.master.persistence.size | string | `"8Gi"` |  |
| redis.master.persistence.storageClass | string | `""` |  |
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
| settings.cache.axes | string | `""` |  |
| settings.cache.default | string | `""` |  |
| settings.cookie.csrfCookieSamesite | string | `"Lax"` |  |
| settings.cookie.csrfCookieSecure | bool | `true` |  |
| settings.cookie.sessionCookieSamesite | string | `"Lax"` |  |
| settings.cookie.sessionCookieSecure | bool | `true` |  |
| settings.cors.allowAllOrigins | bool | `false` |  |
| settings.cors.allowedOrigins | string | `""` |  |
| settings.cors.allowedOriginsRegexes | string | `""` |  |
| settings.cors.extraAllowHeaders | string | `""` |  |
| settings.csrf.trustedOrigins | string | `""` |  |
| settings.database.host | string | `""` |  |
| settings.database.name | string | `""` |  |
| settings.database.password | string | `""` |  |
| settings.database.port | int | `5432` |  |
| settings.database.sslmode | string | `"prefer"` |  |
| settings.database.user | string | `""` |  |
| settings.djangoSettingsModule | string | `"open_zaaktypebeheer.conf.docker"` |  |
| settings.email.defaultFrom | string | `""` |  |
| settings.email.host | string | `"localhost"` |  |
| settings.email.hostPassword | string | `""` |  |
| settings.email.hostUser | string | `""` |  |
| settings.email.port | int | `25` |  |
| settings.email.useTLS | bool | `false` |  |
| settings.enableAdminNavSidebar | bool | `false` |  |
| settings.environment | string | `""` |  |
| settings.isDebug | bool | `false` |  |
| settings.isHttps | bool | `true` |  |
| settings.logStdout | bool | `false` |  |
| settings.oidc.redirectAllowedHosts | string | `""` |  |
| settings.secretKey | string | `""` | Generate secret key at https://djecrety.ir/ |
| settings.sentry.dsn | string | `""` |  |
| settings.subpath | string | `nil` |  |
| settings.throttling.enable | bool | `true` |  |
| settings.throttling.rateAnonymous | string | `"2500/hour"` |  |
| settings.throttling.rateUser | string | `"15000/hour"` |  |
| settings.twoFactorAuthentication.forceOtpAdmin | bool | `true` |  |
| settings.twoFactorAuthentication.patchAdmin | bool | `true` |  |
| settings.ui.viteBaseApiUrl | string | `""` |  |
| tags.redis | bool | `true` |  |
| tolerations | list | `[]` |  |

