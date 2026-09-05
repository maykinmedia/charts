# Open Notificaties Chart

API voor het routeren van notificaties

![Version: 2.1.0](https://img.shields.io/badge/Version-2.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.2](https://img.shields.io/badge/AppVersion-1.16.2-informational?style=flat-square)

## Introduction

This chart can be used to deploy Open Notificaties on a Kubernetes cluster using the Helm package manager.

* [Source code](https://github.com/open-zaak/open-notificaties/)
* [Documentation](https://open-notificaties.readthedocs.io/)
* [Docker image](https://hub.docker.com/r/openzaak/open-notificaties)
* [Changelog](https://github.com/open-zaak/open-notificaties/blob/main/CHANGELOG.rst)

## Quickstart

```bash
helm repo add maykinmedia https://maykinmedia.github.io/charts/
helm install opennotificaties maykinmedia/opennotificaties
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 2.31.4 |
| https://charts.bitnami.com/bitnami | redis | 22.0.1 |

## Configuration and installation details

### Environment variables

For a full overview of the available environment variables and their meaning,
see the the Open Notificaties [documentation](https://open-notificaties.readthedocs.io/en/stable/installation/configuration/env_config.html).

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
how to configure, see the Open Notificaties [documentation](https://open-notificaties.readthedocs.io/en/stable/installation/configuration/opennotifs_config_cli.html).

### Probes

Open Notificaties x.y.z added new functionality to improve the container health checks for the web application,
the Celery worker, Flower container and Celery beat container. Below you can find additional information about the various checks.

**Web application**

There are now the endpoints `/_healthz/`, `/_healthz/livez/` and `/_healthz/readyz/` which are used for the startup,
liveness and readiness probe respectively.

You can find more information about what these endpoints check [here](https://open-notificaties.readthedocs.io/en/stable/installation/health_checks.html).

Important to note: these endpoints are not reacheable from outside the cluster, Nginx is configured to return 404 for these endpoints.

**Celery worker**

You can read more about the worker health checks in the `maykin-common` documentation [here](https://maykin-django-common.readthedocs.io/en/latest/health_checks.html#celery-worker-health-checks).
Things to note here are:

* For the startup probe, we only check the presence of the readiness file. This is created when the worker is ready to accept work.
Then it is no longer updated and it is cleaned up when the worker shuts down.
* For the liveness probe, we check the presence of the liveness file, which is touched by the internal event loop of the worker every `60 s`
(not a configurable value). We check that the file is not older than `70 s`.
We also perform a ping to check the connection with the broker.

Also note that for the liveness probe we use a script to be able to determine the Celery queue name, which is needed to build the name of the worker to check. Open Notificaties uses by default "default queues",
but since the queue name can be changed with the `extraEnvVar` value, we support custom queue names.

**Celery Beat**

You can read more about the Beat health checks in the `maykin-common` documentation [here](https://maykin-django-common.readthedocs.io/en/latest/health_checks.html#celery-beat-health-checks).

* For the startup probe, we check the presence of a liveness file. This is created when a new beat task is published.
* For the liveness probe we also check the liveness file. However, here we check that it is not older than 2 min, to be sure that Beat can still publish new tasks.

**Celery Flower**

Flower exposes an HTTP endpoint that can be used to verify that the service is up and responding.

* For the readiness probe, we perform an HTTP health check against the Flower web interface (`http://localhost:5555/`) using the `maykin-common health-check` command.
* For the liveness probe, we perform the same HTTP health check to ensure that the Flower web interface is reacheable.

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
| beat.livenessProbe.failureThreshold | int | `3` |  |
| beat.livenessProbe.initialDelaySeconds | int | `60` |  |
| beat.livenessProbe.periodSeconds | int | `60` |  |
| beat.livenessProbe.successThreshold | int | `1` |  |
| beat.livenessProbe.timeoutSeconds | int | `15` |  |
| beat.podLabels | object | `{}` |  |
| beat.probesEnabled | bool | `false` |  |
| beat.replicaCount | int | `1` |  |
| beat.resources | object | `{}` |  |
| beat.startupProbe.failureThreshold | int | `3` |  |
| beat.startupProbe.initialDelaySeconds | int | `60` | The liveness file will be present only once Open-Forms has scheduled a task.  The most frequent task is scheduled every minute. We give time to the pod to start. |
| beat.startupProbe.periodSeconds | int | `60` |  |
| beat.startupProbe.successThreshold | int | `1` |  |
| beat.startupProbe.timeoutSeconds | int | `15` |  |
| configuration.data | string | `""` |  |
| configuration.enabled | bool | `false` |  |
| configuration.job.backoffLimit | int | `0` |  |
| configuration.job.enabled | bool | `false` | Run the setup configuration command as a job |
| configuration.job.resources | object | `{}` |  |
| configuration.job.restartPolicy | string | `"Never"` |  |
| configuration.overwrite | bool | `true` |  |
| configuration.secrets | object | `{}` |  |
| configuration.superuser.email | string | `""` |  |
| configuration.superuser.password | string | `""` |  |
| configuration.superuser.username | string | `""` |  |
| configurationSecretsName | string | `""` |  |
| enableServiceLinks | bool | `false` | Prevents K8s from automatically injecting service related environment variables to the pods |
| existingConfigurationSecrets | string | `nil` |  |
| existingSecret | string | `nil` |  |
| extraEnvVars | list | `[]` | Array with extra environment variables to add |
| extraIngress | list | `[]` | Specify extra ingresses, for example if you have multiple ingress classes |
| extraVerifyCerts | string | `""` | Path to extra certificates or CA (root) certificates, comma seperated Warning, If the file does not exist the pod(s) will not start |
| extraVolumeMounts | list | `[]` | Optionally specify extra list of additional volumeMounts |
| extraVolumes | list | `[]` | Optionally specify extra list of additional volumes |
| flower.enabled | bool | `false` |  |
| flower.livenessProbe.failureThreshold | int | `10` |  |
| flower.livenessProbe.initialDelaySeconds | int | `120` |  |
| flower.livenessProbe.periodSeconds | int | `10` |  |
| flower.livenessProbe.successThreshold | int | `1` |  |
| flower.livenessProbe.timeoutSeconds | int | `5` |  |
| flower.podLabels | object | `{}` |  |
| flower.readinessProbe.failureThreshold | int | `5` |  |
| flower.readinessProbe.initialDelaySeconds | int | `120` |  |
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
| livenessProbe.failureThreshold | int | `10` |  |
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
| readinessProbe.failureThreshold | int | `5` |  |
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
| settings.cache.oidc | string | `""` | Sets 'CACHE_OIDC' var, only required when tags.redis is false |
| settings.celery.brokerUrl | string | `""` | Sets the 'CELERY_BROKER_URL' var |
| settings.celery.logLevel | string | `"debug"` | Celery loglevel |
| settings.celery.publishBrokerUrl | string | `""` | Sets the 'PUBLISH_BROKER_URL' var |
| settings.celery.resultBackend | string | `""` | Sets the 'CELERY_RESULT_BACKEND' var, only required when tags.redis is false |
| settings.celery.resultExpires | int | `3600` | Sets the 'CELERY_RESULT_EXPIRES' var |
| settings.cleanOldNotifications.cronjob.historyLimit | int | `1` |  |
| settings.cleanOldNotifications.cronjob.resources | object | `{}` |  |
| settings.cleanOldNotifications.cronjob.schedule | string | `"0 0 * * *"` | Schedule to run the clean logged notifications cronjob |
| settings.cleanOldNotifications.daysRetained | string | `""` | Number of days to retain logged notifications, default is 30 days |
| settings.cleanOldNotifications.enabled | bool | `false` | Clean logged notifications |
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
| settings.logLevel | string | `"INFO"` | Default value "INFO" ; Available values are CRITICAL, ERROR, WARNING, INFO and DEBUG |
| settings.logNotifications | bool | `true` | When set to true notifications are saved to the database and accessible from the admin interface |
| settings.logOutgoingRequestsDBSave | bool | `false` | Whether or not outgoing request logs should always be saved to the database. Defaults to: False. |
| settings.logOutgoingRequestsDBSaveBody | bool | `false` | Whether or not outgoing request bodies should be saved to the database. Defaults to: False. |
| settings.logOutgoingRequestsMaxAge | int | `7` | The number of days after which request logs should be deleted from the database. Defaults to: 7. |
| settings.logOutgoingRequestsResetDBSaveAfter | int | `60` | After the config has been changed via the admin, reset back to the default LOG_OUTGOING_REQUESTS_DB_SAVE after x minutes. Defaults to: 60. |
| settings.logRequests | bool | `true` | Enable structured logging of requests. Defaults to: True. |
| settings.maxRetries | string | `""` | The maximum number of automatic retries. After this amount of retries, Open Notificaties stops trying to deliver the message. Application default is 5. |
| settings.notificationLimit | int | `500` | The maximum of scheduled notifications to be handled during ``execute_notifications``. |
| settings.notificationSecInterval | int | `20` | The amount of seconds between starting the ``execute_notifications`` task that creates the actual notification request tasks (minimum 5 seconds). |
| settings.numProxies | int | `1` | use 2 if enabling ingress |
| settings.otel.disabled | bool | `true` |  |
| settings.otel.exporterOtlpEndpoint | string | `""` | Network address where to send the metrics to. Examples are: https://otel.example.com:4318 or http://otel-collector.namespace.cluster.svc:4317. |
| settings.otel.exporterOtlpHeaders | list | `[]` | Any additional HTTP headers, for example if you need Basic auth. This is used in the secret.yaml, as it can contain credentials.  |
| settings.otel.exporterOtlpMetricsInsecure | bool | `false` | Is true if the endoint is not protected with TLS. |
| settings.otel.exporterOtlpProtocol | string | `"grpc"` | Controls the wire protocol for the OTLP data. Available options: grpc and http/protobuf. |
| settings.otel.metricExportInterval | int | `60000` | Controls how often (in milliseconds) the metrics are exported. The exports run in a background thread and should not affect the performance of the application.  |
| settings.otel.metricExportTimeout | int | `10000` | Controls the timeout of the requests to the collector (in milliseconds) |
| settings.otel.resourceAttributes | list | `[]` | Resources Attributes can be used to specify additional information about the instance. |
| settings.requestsTimeout | int | `10` | Timeout in seconds for HTTP requests. |
| settings.retryBackoff | string | `""` | If specified, a factor applied to the exponential backoff. This allows you to tune how quickly automatic retries are performed. Application default is 3. |
| settings.retryBackoffMax | string | `""` | An upper limit to the exponential backoff time. Application default is 48. |
| settings.secretKey | string | `""` | Generate secret key at https://djecrety.ir/ |
| settings.sentry.dsn | string | `""` |  |
| settings.siteDomain | string | `""` | Defines the primary domain where the application is hosted. Defaults to "" |
| settings.timeLeeway | int | `0` | Time leeway in seconds for JWT validation timestamps Accounts for clock drift between server and client Default: nil (uses Django default, typically 0 seconds) Recommended: not to increase above 300 seconds |
| settings.useXForwardedHost | bool | `true` |  |
| settings.uwsgi.harakiri | string | `""` |  |
| settings.uwsgi.master | string | `""` |  |
| settings.uwsgi.maxRequests | string | `""` |  |
| settings.uwsgi.processes | string | `""` |  |
| settings.uwsgi.threads | string | `""` |  |
| startupProbe.failureThreshold | int | `30` |  |
| startupProbe.initialDelaySeconds | int | `15` | Total time: 15s initial delay + (30 failures × 10s period) = 315s (5 minutes 15 seconds)     |
| startupProbe.periodSeconds | int | `10` |  |
| startupProbe.successThreshold | int | `1` |  |
| startupProbe.timeoutSeconds | int | `5` |  |
| tags.redis | bool | `true` |  |
| tolerations | list | `[]` |  |
| worker.autoscaling.behavior | object | `{}` |  |
| worker.autoscaling.enabled | bool | `false` |  |
| worker.autoscaling.maxReplicas | int | `100` |  |
| worker.autoscaling.minReplicas | int | `1` |  |
| worker.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| worker.autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| worker.concurrency | int | `100` |  |
| worker.livenessProbe.enabled | bool | `true` |  |
| worker.livenessProbe.failureThreshold | int | `6` |  |
| worker.livenessProbe.initialDelaySeconds | int | `60` |  |
| worker.livenessProbe.periodSeconds | int | `60` |  |
| worker.livenessProbe.successThreshold | int | `1` |  |
| worker.livenessProbe.timeoutSeconds | int | `15` |  |
| worker.pdb.create | bool | `false` |  |
| worker.pdb.maxUnavailable | string | `""` |  |
| worker.pdb.minAvailable | int | `1` |  |
| worker.podLabels | object | `{}` |  |
| worker.replicaCount | int | `2` |  |
| worker.resources | object | `{}` |  |
| worker.resources | object | `{}` |  |
| worker.startupProbe.enabled | bool | `true` |  |
| worker.startupProbe.failureThreshold | int | `3` |  |
| worker.startupProbe.initialDelaySeconds | int | `60` |  |
| worker.startupProbe.periodSeconds | int | `50` |  |
| worker.startupProbe.successThreshold | int | `1` |  |
| worker.startupProbe.timeoutSeconds | int | `10` |  |
