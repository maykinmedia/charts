# Referentielijsten Chart

De Referentielijsten API is een generieke API voor eenvoudige herbruikebare lijsten

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.6.0](https://img.shields.io/badge/AppVersion-0.6.0-informational?style=flat-square)

## Introduction

This chart can be used to deploy Referentielijsten on a Kubernetes cluster using the Helm package manager.

* [Source code](https://github.com/maykinmedia/referentielijsten/)
* [Documentation](https://referentielijsten-api.readthedocs.io/en/latest/)
* [Docker image](https://hub.docker.com/r/maykinmedia/referentielijsten-api)
* [Changelog](https://referentielijsten-api.readthedocs.io/en/latest/changelog.html)

## Quickstart

```bash
helm repo add maykinmedia https://maykinmedia.github.io/charts/
helm install referentielijsten maykinmedia/referentielijsten
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 2.31.4 |
| https://charts.bitnami.com/bitnami | redis | 22.0.1 |
| https://maykinmedia.github.io/charts/ | maykin-utils-lib | 0.2.1 |

## Configuration and installation details

### Django specific configuration

**Secret key**

Django makes use of a secret key to provide cryptographic signing.
This key should be set to a unique, unpredictable value.
Without the `SECRET_KEY` environment variable, the application will not start.

The key can be configured with the value `settings.secretKey`. You can use a [web tool](https://djecrety.ir/) to generate it.

**Warning**: Running with a known secret key defeats many of Django’s security protections and can lead to privilege escalation and remote code execution vulnerabilities.

### Environment variables

For a full overview of the available environment variables and their meaning,
see the the Referentielijsten [documentation](https://referentielijsten-api.readthedocs.io/en/latest/installation/config.html).

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
how to configure, see the Referentielijsten [documetation](https://referentielijsten-api.readthedocs.io/en/latest/installation/setup_configuration.html).

### Sentry

Referentielijsten makes use of [Sentry](https://sentry.io/welcome/) for automatic reporting of errors.
In order to configure it, the value `settings.sentry.dsn` needs to be set. To see where to find the `DSN`, see
the [Sentry documentation](https://docs.sentry.io/concepts/key-terms/dsn-explainer/#where-to-find-your-data-source-name-dsn). 

```yaml
settings:
  sentry:
    dsn: "https://public@sentry.example.com/1"
```

The value of the `DSN` is considered sensitive, so it should be handled as a secret.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.behaviour | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| azureVaultSecret.contentType | string | `""` |  |
| azureVaultSecret.objectName | string | `""` |  |
| azureVaultSecret.secretName | string | `"{{ .Values.existingSecret }}"` |  |
| azureVaultSecret.vaultName | string | `nil` |  |
| configuration.data | string | `""` |  |
| configuration.enabled | bool | `false` |  |
| configuration.job.backoffLimit | int | `6` |  |
| configuration.job.enabled | bool | `false` | Run the setup configuration command as a job |
| configuration.job.resources | object | `{}` |  |
| configuration.job.restartPolicy | string | `"OnFailure"` |  |
| configuration.job.ttlSecondsAfterFinished | int | `0` | 0 Will clean the job after it is finished |
| configuration.overwrite | bool | `true` |  |
| configuration.secrets | object | `{}` |  |
| configurationSecretsName | string | `""` |  |
| existingConfigurationSecrets | string | `nil` |  |
| existingSecret | string | `nil` |  |
| extraEnvVars | list | `[]` | Array with extra environment variables to add |
| extraIngress | list | `[]` | Specify extra ingresses, for example if you have multiple ingress classes |
| extraVolumeMounts | list | `[]` | Optionally specify extra list of additional volumeMounts |
| extraVolumes | list | `[]` | Optionally specify extra list of additional volumes |
| fullnameOverride | string | `""` |  |
| global.configuration.enabled | bool | `false` |  |
| global.configuration.overwrite | bool | `true` |  |
| global.configuration.secrets | object | `{}` |  |
| global.settings.databaseHost | string | `""` | Global databasehost, overrides setting.database.host |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"maykinmedia/referentielijsten-api"` |  |
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
| persistence.mediaMountSubpath | string | `"referentielijsten/media"` |  |
| persistence.privateMediaMountSubpath | string | `"referentielijsten/private_media"` |  |
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
| redis.image | object | `{"registry":"docker.io","repository":"redis","tag":"8.0"}` | Redis image configuration - Migration from Bitnami to official Redis image         |
| redis.master.persistence.enabled | bool | `true` |  |
| redis.master.persistence.size | string | `"8Gi"` |  |
| redis.master.persistence.storageClass | string | `""` |  |
| redis.master.resources.requests.cpu | string | `"250m"` |  |
| redis.master.resources.requests.memory | string | `"256Mi"` |  |
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
| settings.cache.default | string | `""` |  |
| settings.cors | object | `{"allowAllOrigins":false,"allowedOriginRegexes":"","allowedOrigins":"","extraAllowHeaders":""}` | CORS (Cross-Origin Resource Sharing) settings |
| settings.cors.allowAllOrigins | bool | `false` | Allow cross-domain access from any client |
| settings.cors.allowedOriginRegexes | string | `""` | Allowed origin regex patterns (comma-separated). Same as CORS_ALLOWED_ORIGINS, but supports regular expressions |
| settings.cors.allowedOrigins | string | `""` | Explicitly list allowed origins (comma-separated). Example: http://localhost:3000,https://some-app.gemeente.nl |
| settings.cors.extraAllowHeaders | string | `""` | Extra headers allowed in cross-domain requests (comma-separated). By default, Authorization, Accept-Crs and Content-Crs are already included |
| settings.csp | object | `{"extraDefaultSrc":"","extraFormAction":"","extraImgSrc":"","formAction":"","objectSrc":"","reportPercentage":0,"reportUri":""}` | Content Security Policy settings |
| settings.csp.extraDefaultSrc | string | `""` | Extra default source URLs for CSP other than 'self'. Used for img-src, style-src and script-src (comma-separated) |
| settings.csp.extraFormAction | string | `""` | Additional form-action sources (comma-separated) |
| settings.csp.extraImgSrc | string | `""` | Extra img-src sources (comma-separated) |
| settings.csp.formAction | string | `""` | Override the default form-action sources (comma-separated) |
| settings.csp.objectSrc | string | `""` | object-src sources (comma-separated) |
| settings.csp.reportPercentage | float | `0` | Fraction (between 0 and 1) of requests to include report-uri directive |
| settings.csp.reportUri | string | `""` | URI for CSP report-uri directive |
| settings.database.db_conn_max_age | int | `60` |  |
| settings.database.db_pool.db_pool_max_idle | int | `600` |  |
| settings.database.db_pool.db_pool_max_lifetime | int | `3600` |  |
| settings.database.db_pool.db_pool_max_size | int | `4` |  |
| settings.database.db_pool.db_pool_max_waiting | int | `0` |  |
| settings.database.db_pool.db_pool_min_size | int | `4` |  |
| settings.database.db_pool.db_pool_num_workers | int | `3` |  |
| settings.database.db_pool.db_pool_reconnect_timeout | int | `300` |  |
| settings.database.db_pool.db_pool_timeout | int | `30` |  |
| settings.database.db_pool.enabled | bool | `false` |  |
| settings.database.host | string | `""` |  |
| settings.database.name | string | `""` |  |
| settings.database.password | string | `""` |  |
| settings.database.port | int | `5432` |  |
| settings.database.sslmode | string | `"prefer"` |  |
| settings.database.username | string | `""` |  |
| settings.debug | bool | `false` |  |
| settings.disable2fa | bool | `false` | Disable two factor authentication |
| settings.djangoSettingsModule | string | `"referentielijsten.conf.docker"` |  |
| settings.elasticapm.serviceName | string | `""` |  |
| settings.elasticapm.token | string | `""` |  |
| settings.elasticapm.transactionSampleRate | float | `0.1` | By default, the agent will sample every transaction (e.g. request to your service). To reduce overhead and storage requirements, set the sample rate to a value between 0.0 and 1.0 |
| settings.elasticapm.url | string | `""` |  |
| settings.email.defaultFrom | string | `""` |  |
| settings.email.host | string | `"localhost"` |  |
| settings.email.password | string | `""` |  |
| settings.email.port | int | `25` |  |
| settings.email.useTLS | bool | `false` |  |
| settings.email.username | string | `""` |  |
| settings.environment | string | `""` | sets the 'ENVIRONMENT' variable |
| settings.isHttps | bool | `true` |  |
| settings.logging | object | `{"enableStructlogRequests":true,"formatConsole":"json","level":"INFO","outgoingRequests":{"dbSave":false,"dbSaveBody":true,"emitBody":true,"maxAge":7},"queries":false,"requests":false,"stdout":true}` | Logging configuration |
| settings.logging.enableStructlogRequests | bool | `true` | Enable structured logging of requests |
| settings.logging.formatConsole | string | `"json"` | The format for the console logging handler, possible options: json, plain_console |
| settings.logging.level | string | `"INFO"` | Control the verbosity of logging output. Available values are CRITICAL, ERROR, WARNING, INFO and DEBUG |
| settings.logging.outgoingRequests.dbSave | bool | `false` | Whether to save outgoing request logs to database |
| settings.logging.outgoingRequests.dbSaveBody | bool | `true` | Whether to save request bodies to database |
| settings.logging.outgoingRequests.emitBody | bool | `true` | Whether to emit request bodies in logs |
| settings.logging.outgoingRequests.maxAge | int | `7` | Maximum age of request logs in database (days) |
| settings.logging.queries | bool | `false` | Enable (query) logging at the database backend level. Note that you must also set DEBUG=1, which should be done very sparingly! |
| settings.logging.requests | bool | `false` | Enable logging of the outgoing requests. This must be enabled along with LOG_OUTGOING_REQUESTS_DB_SAVE to save outgoing request logs in the database. |
| settings.logging.stdout | bool | `true` | Whether to log to stdout or not |
| settings.secretKey | string | `""` | Generate secret key at https://djecrety.ir/ |
| settings.sentry.dsn | string | `""` |  |
| settings.siteDomain | string | `""` | Defines the primary domain where the application is hosted. Defaults to "" |
| settings.useXForwardedHost | bool | `false` |  |
| settings.uwsgi.harakiri | string | `""` |  |
| settings.uwsgi.master | string | `""` |  |
| settings.uwsgi.maxRequests | string | `""` |  |
| settings.uwsgi.processes | string | `""` |  |
| settings.uwsgi.threads | string | `""` |  |
| tags.redis | bool | `true` |  |
| tolerations | list | `[]` |  |