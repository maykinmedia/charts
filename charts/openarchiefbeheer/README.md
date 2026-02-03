# Open Archiefbeheer Chart

Opstellen, beheren en uitvoeren van vernietigingslijsten, voor gebruik met Zaakgericht werken

![Version: 2.0.0-rc.2](https://img.shields.io/badge/Version-2.0.0--rc.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.0.0-rc.2](https://img.shields.io/badge/AppVersion-2.0.0--rc.2-informational?style=flat-square)

## Introduction

This chart can be used to deploy Open Archiefbeheer on a Kubernetes cluster using the Helm package manager.

* [Source code](https://github.com/maykinmedia/open-archiefbeheer)
* [Documentation](https://open-archiefbeheer.readthedocs.io/en/latest/)
* [Docker image](https://hub.docker.com/r/maykinmedia/open-archiefbeheer/)
* [Changelog](https://github.com/maykinmedia/open-archiefbeheer/blob/main/CHANGELOG.rst)

## Quickstart

```bash
helm repo add maykinmedia https://maykinmedia.github.io/charts/
helm install openarchiefbeheer maykinmedia/openarchiefbeheer
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 2.31.4 |
| https://charts.bitnami.com/bitnami | redis | 22.0.1 |

## Configuration and installation details

### Django specific configuration

**Secret key**

Django makes use of a secret key to provide cryptographic signing.
This key should be set to a unique, unpredictable value.
Without the `SECRET_KEY` environment variable, the application will not start.

The key can be configured with the value `settings.secretKey`. You can use a [web tool](https://djecrety.ir/) to generate it.

**Warning**: Running with a known secret key defeats many of Django’s security protections and can lead to privilege escalation and remote code execution vulnerabilities.

### Automatic configuration

The application can be automatically configured with `django-setup-configuration`.
To enable the automatic configuration, the following values should be set:

```yaml
global:
  configuration:
    enabled: true

configuration:
  enabled: true
  job:
    enabled: true
```

The yaml data needed to configure the application should be provided in the value `configuration.data`. To see
how to configure, see the Open Archiefbeheer [example](https://github.com/maykinmedia/open-archiefbeheer/blob/397d26b0db69ac368bbfdc8ab689d61f61f8eefc/backend/src/openarchiefbeheer/config/setup_configuration/fixtures/data.yaml).

### Nginx configuration

Open Archiefbeheer is a Single Page App (SPA), therefore the Nginx configuration is a bit different from that of other Maykin components.

All requests to paths starting with `/admin|oidc|static|assets|api/` are routed to the Django backend.
On the other hand, all other requests result in loading of the `/static/frontend/index.html` template which retrieves the JS and the CSS of the React frontend.
All paths are then handled by the `react-router`.

Since the frontend is not served by Django, it does add CSP headers to the responses in the same way as the backend.
For this reason, Nginx adds CSP headers to responses where they are not already present.

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
| beat.enabled | bool | `true` |  |
| beat.livenessProbe | object | `{}` |  |
| beat.podLabels | object | `{}` |  |
| beat.readinessProbe | object | `{}` |  |
| beat.replicaCount | int | `1` |  |
| beat.resources | object | `{}` |  |
| configuration.data | string | `""` |  |
| configuration.enabled | bool | `false` |  |
| configuration.job.backoffLimit | int | `6` |  |
| configuration.job.enabled | bool | `true` | Run the setup configuration command as a job |
| configuration.job.resources | object | `{}` |  |
| configuration.job.restartPolicy | string | `"OnFailure"` |  |
| configuration.job.ttlSecondsAfterFinished | int | `0` | 0 Will clean the job after it is finished |
| configuration.secrets | object | `{}` |  |
| existingConfigurationSecrets | string | `nil` |  |
| existingSecret | string | `nil` |  |
| extraEnvVars | list | `[]` |  |
| extraIngress | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| flower.enabled | bool | `true` |  |
| flower.livenessProbe | object | `{}` |  |
| flower.podLabels | object | `{}` |  |
| flower.readinessProbe | object | `{}` |  |
| flower.replicaCount | int | `1` |  |
| flower.resources | object | `{}` |  |
| flower.service.port | int | `80` |  |
| flower.service.type | string | `"ClusterIP"` |  |
| fullnameOverride | string | `""` |  |
| global.configuration.enabled | bool | `false` |  |
| global.configuration.secrets | object | `{}` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"maykinmedia/open-archiefbeheer"` |  |
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
| nginx.autoscaling.enabled | bool | `false` |  |
| nginx.existingConfigmap | string | `nil` |  |
| nginx.extraVolumeMounts | list | `[]` |  |
| nginx.extraVolumes | list | `[]` |  |
| nginx.image.pullPolicy | string | `"IfNotPresent"` |  |
| nginx.image.repository | string | `"nginxinc/nginx-unprivileged"` |  |
| nginx.image.tag | string | `"stable"` |  |
| nginx.livenessProbe | object | `{}` |  |
| nginx.podLabels | object | `{}` |  |
| nginx.readinessProbe | object | `{}` |  |
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
| persistence.mediaMountSubpath | string | `"openarchiefbeheer/media"` |  |
| persistence.privateMediaMountSubpath | string | `"openarchiefbeheer/private_media"` |  |
| persistence.size | string | `"1Gi"` |  |
| persistence.storageClassName | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| pythonAppName | string | `"openarchiefbeheer"` |  |
| readinessProbe.failureThreshold | int | `6` |  |
| readinessProbe.initialDelaySeconds | int | `30` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| redis.architecture | string | `"standalone"` |  |
| redis.auth.enabled | bool | `false` |  |
| redis.image | object | `{"registry":"docker.io","repository":"redis","tag":"8.0"}` | Redis image configuration - Migration from Bitnami to official Redis image         |
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
| serviceAccount.automountServiceAccountToken | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| settings.allowedHosts | string | `""` |  |
| settings.cache.axes | string | `""` |  |
| settings.cache.choices | string | `""` |  |
| settings.cache.default | string | `""` |  |
| settings.celery.brokerUrl | string | `""` |  |
| settings.celery.logLevel | string | `"debug"` |  |
| settings.celery.resultBackend | string | `""` |  |
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
| settings.database.username | string | `""` |  |
| settings.debug | bool | `false` |  |
| settings.djangoSettingsModule | string | `"openarchiefbeheer.conf.docker"` |  |
| settings.email.defaultFrom | string | `""` |  |
| settings.email.host | string | `"localhost"` |  |
| settings.email.password | string | `""` |  |
| settings.email.port | int | `25` |  |
| settings.email.useTLS | bool | `false` |  |
| settings.email.username | string | `""` |  |
| settings.environment | string | `""` |  |
| settings.frontend.apiPath | string | `"/api/v1"` |  |
| settings.frontend.apiUrl | string | `""` |  |
| settings.frontend.zaakUrlTemplate | string | `""` |  |
| settings.frontendUrl | string | `""` |  |
| settings.logging.level | string | `"INFO"` | Controls the log levels of project code and of the OIDC library.  Possible values: NOTSET, DEBUG, INFO, WARNING, ERROR, CRITICAL. |
| settings.logging.toStdout | bool | `false` | Controls whether the logs are output to standard output or to a file |
| settings.oidcRenewIdTokenExpirySeconds | int | `900` | OIDC token renewal settings (15 minutes = 900 seconds) IMPORTANT: This value must equal sessionCookieAge to prevent timeout mismatches If values differ, users may experience unexpected logouts when one expires before the other |
| settings.postDestructionVisibilityPeriod | string | `"7"` | Number of days for which destruction lists will be visible after successfull destruction. |
| settings.relatedCountDisabled | bool | `false` | If true, the inline presentation of the related objects will be disabled. This reduces load on external registers and improves performance. |
| settings.requestsReadTimeout | string | `"30"` |  |
| settings.retry.backoffFactor | string | `""` |  |
| settings.retry.statusForcelist | string | `""` |  |
| settings.retry.total | string | `""` |  |
| settings.secretKey | string | `""` | Generate secret key at https://djecrety.ir/ |
| settings.sentry.dsn | string | `""` |  |
| settings.sessionCookieAge | int | `900` | Session cookie age in seconds (15 minutes = 900 seconds) IMPORTANT: This value must equal oidcRenewIdTokenExpirySeconds to prevent timeout mismatches If values differ, users may experience unexpected logouts when one expires before the other |
| settings.throttling.enable | bool | `true` |  |
| settings.throttling.rateAnonymous | string | `"2500/hour"` |  |
| settings.throttling.rateUser | string | `"15000/hour"` |  |
| settings.uwsgi.harakiri | string | `""` |  |
| settings.uwsgi.master | string | `""` |  |
| settings.uwsgi.maxRequests | string | `""` |  |
| settings.uwsgi.processes | string | `""` |  |
| settings.uwsgi.threads | string | `""` |  |
| settings.waitingPeriod | string | `"7"` | Number of days to wait before destroying a list. Defaults to 7 in the application. |
| tags.redis | bool | `true` |  |
| tolerations | list | `[]` |  |
| worker.autoscaling.enabled | bool | `false` |  |
| worker.autoscaling.maxReplicas | int | `100` |  |
| worker.autoscaling.minReplicas | int | `1` |  |
| worker.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| worker.autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| worker.concurrency | int | `4` |  |
| worker.label | string | `"1"` |  |
| worker.livenessProbe.enabled | bool | `false` |  |
| worker.livenessProbe.exec.command[0] | string | `"/app/liveness/liveness-probe.sh"` |  |
| worker.livenessProbe.failureThreshold | int | `3` |  |
| worker.livenessProbe.initialDelaySeconds | int | `60` |  |
| worker.livenessProbe.periodSeconds | int | `30` |  |
| worker.livenessProbe.successThreshold | int | `1` |  |
| worker.livenessProbe.timeoutSeconds | int | `10` |  |
| worker.name | string | `""` |  |
| worker.podLabels | object | `{}` |  |
| worker.queueName | string | `""` |  |
| worker.replicaCount | int | `1` |  |
| worker.resources | object | `{}` |  |
