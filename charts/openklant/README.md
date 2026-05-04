# Open Klant Chart

Project dat de Klantinteracties API | https://vng-realisatie.github.io/gemma-zaken/standaard/klantinteracties/index en Contactgegevens API in een enkele applicatie combineert.

![Version: 1.12.0](https://img.shields.io/badge/Version-1.12.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.16.0](https://img.shields.io/badge/AppVersion-2.16.0-informational?style=flat-square)

## Introduction

This chart can be used to deploy Open Klant on a Kubernetes cluster using the Helm package manager.

* [Source code](https://github.com/maykinmedia/open-klant/)
* [Documentation](https://open-klant.readthedocs.io/)
* [Docker image](https://hub.docker.com/r/maykinmedia/open-klant)
* [Changelog](https://github.com/maykinmedia/open-klant/blob/master/CHANGELOG.rst)

## Quickstart

```bash
helm repo add maykinmedia https://maykinmedia.github.io/charts/
helm install openklant maykinmedia/openklant
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 2.31.4 |
| https://charts.bitnami.com/bitnami | redis | 22.0.1 |

## Configuration and installation details

### Environment variables

For a full overview of the available environment variables and their meaning,
see the the Open Klant [documentation](https://open-klant.readthedocs.io/en/stable/installation/config/env_configuration.html).

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
how to configure, see the Open Klant [documentation](https://open-klant.readthedocs.io/en/stable/installation/config/setup_configuration.html).

### Probes

Open Klant 2.16.0 added new functionality to improve the container health checks for the web application, the Celery worker and the Flower container. Below you can find additional information about the various checks.

**Web application**

There are now the endpoints `/_healthz/`, `/_healthz/livez/` and `/_healthz/readyz/` which are used for the startup, liveness and readiness probe respectively. You can find more information about what these endpoints check [here](https://github.com/maykinmedia/open-klant/blob/master/docs/installation/health_checks.rst#http-service).

Important to note: these endpoints are not reacheable from outside the cluster, Nginx is configured to return 404 for these endpoints.

**Celery worker**

You can read more about the worker health checks in the `maykin-common` documentation [here](https://maykin-django-common.readthedocs.io/en/latest/health_checks.html#celery-worker-health-checks). Things to note here are:

* For the startup probe, we only check the presence of the readiness file. This is created when the worker is ready to accept work. Then it is no longer updated and it is cleaned up when the worker shuts down.
* For the liveness probe, we check the presence of the liveness file, which is touched by the internal event loop of the worker every `60 s` (not a configurable value). We check that the file is not older than `70 s`. We also perform a ping to check the connection with the broker.

Also note that for the liveness probe we use a script to be able to determine the Celery queue name, which is needed to build the name of the worker to check. Open Klant uses by default "default queues", but since the queue name can be changed with the `extraEnvVar` value, we support custom queue names.

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
| configuration.data | string | `""` |  |
| configuration.enabled | bool | `false` |  |
| configuration.initContainer.enabled | bool | `false` | Run the setup configuration command in a init container |
| configuration.job.backoffLimit | int | `6` |  |
| configuration.job.enabled | bool | `true` | Run the setup configuration command as a job |
| configuration.job.resources | object | `{}` |  |
| configuration.job.restartPolicy | string | `"OnFailure"` |  |
| configuration.job.ttlSecondsAfterFinished | int | `0` | 0 Will clean the job after it is finished |
| configuration.secrets | object | `{}` |  |
| configurationSecretsName | string | `""` |  |
| existingConfigurationSecrets | string | `nil` |  |
| existingSecret | string | `nil` |  |
| extraDeploy | list | `[]` | Extra objects to deploy (value evaluated as a template) |
| extraEnvVars | list | `[]` | Array with extra environment variables to add |
| extraIngress | list | `[]` | Specify extra ingresses, for example if you have multiple ingress classes |
| extraVolumeMounts | list | `[]` | Optionally specify extra list of additional volumeMounts |
| extraVolumes | list | `[]` | Optionally specify extra list of additional volumes |
| flower.enabled | bool | `true` |  |
| flower.extraVolumeMounts | list | `[]` |  |
| flower.extraVolumes | list | `[]` |  |
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
| global.configuration.secrets | object | `{}` |  |
| global.settings.databaseHost | string | `""` | Global databasehost, overrides setting.database.host |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"maykinmedia/open-klant"` |  |
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
| nginx.autoscaling.enabled | bool | `false` |  |
| nginx.config.clientMaxBodySize | string | `"10M"` |  |
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
| nginx.service.port | int | `80` |  |
| nginx.service.type | string | `"ClusterIP"` |  |
| nodeSelector | object | `{}` |  |
| pdb.create | bool | `false` |  |
| pdb.maxUnavailable | string | `""` |  |
| pdb.minAvailable | int | `1` |  |
| persistence.enabled | bool | `true` |  |
| persistence.existingClaim | string | `nil` |  |
| persistence.mediaMountSubpath | string | `"openklant/media"` |  |
| persistence.privateMediaMountSubpath | string | `"openklant/private_media"` |  |
| persistence.size | string | `"1Gi"` |  |
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
| settings.celery.brokerUrl | string | `""` |  |
| settings.celery.logLevel | string | `"debug"` |  |
| settings.celery.resultBackend | string | `""` |  |
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
| settings.djangoSettingsModule | string | `"openklant.conf.docker"` |  |
| settings.elasticapm.serviceName | string | `""` |  |
| settings.elasticapm.token | string | `""` |  |
| settings.elasticapm.url | string | `""` |  |
| settings.email.defaultFrom | string | `""` |  |
| settings.email.host | string | `"localhost"` |  |
| settings.email.password | string | `""` |  |
| settings.email.port | int | `25` |  |
| settings.email.useTLS | bool | `false` |  |
| settings.email.username | string | `""` |  |
| settings.enableCloudEvents | bool | `false` |  |
| settings.environment | string | `""` | sets the 'ENVIRONMENT' variable |
| settings.isHttps | bool | `true` |  |
| settings.notificationsDisabled | bool | `false` |  |
| settings.notificationsSource | string | `""` | The identifier of this application that will be sent in the notification, e.g. "openklant" |
| settings.otel.disabled | bool | `true` |  |
| settings.otel.exporterOtlpEndpoint | string | `""` | Network address where to send the metrics to. Examples are: https://otel.example.com:4318 or http://otel-collector.namespace.cluster.svc:4317. |
| settings.otel.exporterOtlpHeaders | list | `[]` | Any additional HTTP headers, for example if you need Basic auth. This is used in the secret.yaml, as it can contain credentials.  |
| settings.otel.exporterOtlpMetricsInsecure | bool | `false` | Is true if the endoint is not protected with TLS. |
| settings.otel.exporterOtlpProtocol | string | `"grpc"` | Controls the wire protocol for the OTLP data. Available options: grpc and http/protobuf. |
| settings.otel.metricExportInterval | int | `60000` | Controls how often (in milliseconds) the metrics are exported. The exports run in a background thread and should not affect the performance of the application.  |
| settings.otel.metricExportTimeout | int | `10000` | Controls the timeout of the requests to the collector (in milliseconds) |
| settings.otel.resourceAttributes | list | `[]` | Resources Attributes can be used to specify additional information about the instance. |
| settings.secretKey | string | `""` | Generate secret key at https://djecrety.ir/ |
| settings.sentry.dsn | string | `""` |  |
| settings.siteDomain | string | `""` | Defines the primary domain where the application is hosted. Defaults to "" |
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
| worker.autoscaling.enabled | bool | `false` |  |
| worker.autoscaling.maxReplicas | int | `100` |  |
| worker.autoscaling.minReplicas | int | `1` |  |
| worker.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| worker.autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| worker.concurrency | int | `4` |  |
| worker.livenessProbe.enabled | bool | `false` |  |
| worker.livenessProbe.failureThreshold | int | `6` |  |
| worker.livenessProbe.initialDelaySeconds | int | `60` |  |
| worker.livenessProbe.periodSeconds | int | `60` |  |
| worker.livenessProbe.successThreshold | int | `1` |  |
| worker.livenessProbe.timeoutSeconds | int | `15` |  |
| worker.podLabels | object | `{}` |  |
| worker.replicaCount | int | `2` |  |
| worker.resources | object | `{}` |  |
| worker.startupProbe.enabled | bool | `false` |  |
| worker.startupProbe.failureThreshold | int | `3` |  |
| worker.startupProbe.initialDelaySeconds | int | `60` |  |
| worker.startupProbe.periodSeconds | int | `60` |  |
| worker.startupProbe.successThreshold | int | `1` |  |
| worker.startupProbe.timeoutSeconds | int | `15` |  |
