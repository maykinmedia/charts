# Open Zaak Chart

Productiewaardige API's voor Zaakgericht Werken

![Version: 1.15.0](https://img.shields.io/badge/Version-1.15.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.30.0](https://img.shields.io/badge/AppVersion-1.30.0-informational?style=flat-square)

## Introduction

This chart can be used to deploy Open Zaak on a Kubernetes cluster using the Helm package manager.

* [Source code](https://github.com/open-zaak/open-zaak/)
* [Documentation](https://open-zaak.readthedocs.io/)
* [Docker image](https://hub.docker.com/r/openzaak/open-zaak)
* [Changelog](https://github.com/open-zaak/open-zaak/blob/main/CHANGELOG.rst)

## Quickstart

```bash
helm repo add maykinmedia https://maykinmedia.github.io/charts/
helm install openzaak maykinmedia/openzaak
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 2.31.4 |
| https://charts.bitnami.com/bitnami | redis | 22.0.1 |

## Configuration and installation details

### Environment variables

For a full overview of the available environment variables and their meaning,
see the the Open Zaak [documentation](https://open-zaak.readthedocs.io/en/stable/installation/config/env_config.html).

### Probes

Open Zaak 1.30.0 added new functionality to improve the container health checks for the web application,
the Celery worker, Flower container and Celery beat container. Below you can find additional information about the various checks.

**Web application**

There are now the endpoints `/_healthz/`, `/_healthz/livez/` and `/_healthz/readyz/` which are used for the startup,
liveness and readiness probe respectively.

You can find more information about what these endpoints check [here](https://open-zaak.readthedocs.io/en/stable/installation/health_checks.html).

Important to note: these endpoints are not reacheable from outside the cluster, Nginx is configured to return 404 for these endpoints.

**Celery worker**

You can read more about the worker health checks in the `maykin-common` documentation [here](https://maykin-django-common.readthedocs.io/en/latest/health_checks.html#celery-worker-health-checks).
Things to note here are:

* For the startup probe, we only check the presence of the readiness file. This is created when the worker is ready to accept work.
Then it is no longer updated and it is cleaned up when the worker shuts down.
* For the liveness probe, we check the presence of the liveness file, which is touched by the internal event loop of the worker every `60 s`
(not a configurable value). We check that the file is not older than `70 s`.
We also perform a ping to check the connection with the broker.

Also note that for the liveness probe we use a script to be able to determine the Celery queue name, which is needed to build the name of the worker to check. Open Zaak uses by default "default queues",
but since the queue name can be changed with the `extraEnvVar` value, we support custom queue names.

**Celery Beat**

You can read more about the Beat health checks in the `maykin-common` documentation [here](https://maykin-django-common.readthedocs.io/en/latest/health_checks.html#celery-beat-health-checks).

* For the startup probe, we check the presence of a liveness file. This is created when a new beat task is published.
* For the liveness probe we also check the liveness file. However, here we check that it is not older than 2 min, to be sure that Beat can still publish new tasks.

**Celery Flower**

Flower exposes an HTTP endpoint that can be used to verify that the service is up and responding.

* For the readiness probe, we perform an HTTP health check against the Flower web interface (`http://localhost:5555/`) using the `maykin-common health-check` command.
* For the liveness probe, we perform the same HTTP health check to ensure that the Flower web interface is reacheable.

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
how to configure, see the Open Zaak [documentation](https://open-zaak.readthedocs.io/en/stable/installation/config/openzaak_config_cli.html).

## Documenten API backend

Open Zaak supports using three different backends for the Documenten API: the file system, Azure Blob Storage and S3 storage.

In order to configure the backend, use the `settings.documentApiBackend` value and if using the Azure Blob Storage or the S3 storage,
configure the values under `settings.azureBlobStorage` and `settings.s3storage`.

You can find more information about how to specify each value in the [Open Zaak documentation](https://open-zaak.readthedocs.io/en/1.28.1/installation/config/env_config.html#documenten-api).

Note that for Azure Blob storage, your cluster needs to have the Blob storage CSI driver enabled. For S3 storage, your cluster needs to have the Amazon S3 CSI driver enabled.
You can find more information in the Open Zaak documentation for both the [Azure Blob Storage](https://open-zaak.readthedocs.io/en/1.28.1/installation/reference/azure_blob_storage.html) and the [S3 storage](https://open-zaak.readthedocs.io/en/1.28.1/installation/reference/s3_storage.html).

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
| enableServiceLinks | bool | `false` | Prevents K8s from automatically injecting service related environment variables to the pods |
| existingConfigurationSecrets | string | `nil` |  |
| existingSecret | string | `nil` |  |
| extraDeploy | list | `[]` |  |
| extraEnvVars | list | `[]` |  |
| extraIngress | list | `[]` | Specify extra ingresses, for example if you have multiple ingress classes |
| extraVerifyCerts | string | `""` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| flower.enabled | bool | `true` |  |
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
| image.repository | string | `"openzaak/open-zaak"` |  |
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
| nginx.config.clientMaxBodySize | string | `"4G"` | Default client_max_body_size for all endpoints (unless overridden) Examples: "10M", "100M", "1G", "4G", "10G" This is the fallback value when no endpoint-specific override is set     |
| nginx.config.proxyConnectTimeoutSeconds | int | `300` | Proxy connection timeout in seconds How long nginx waits to establish connection with backend   |
| nginx.config.proxyReadTimeoutSeconds | int | `300` | Proxy read timeout in seconds   How long nginx waits for backend response     |
| nginx.existingConfigmap | string | `nil` | mount existing nginx vhost config |
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
| persistence.mediaMountSubpath | string | `"openzaak/media"` |  |
| persistence.privateMediaMountSubpath | string | `"openzaak/private_media"` |  |
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
| settings.azureBlobStorage.accountName | string | `""` |  |
| settings.azureBlobStorage.apiStorageVersion | string | `""` |  |
| settings.azureBlobStorage.clientId | string | `""` |  |
| settings.azureBlobStorage.clientSecret | string | `""` |  |
| settings.azureBlobStorage.connectionTimeout | int | `5` |  |
| settings.azureBlobStorage.container | string | `"openzaak"` |  |
| settings.azureBlobStorage.location | string | `"documenten"` |  |
| settings.azureBlobStorage.tenantId | string | `""` |  |
| settings.azureBlobStorage.urlExpirationTime | int | `60` |  |
| settings.cache.axes | string | `""` |  |
| settings.cache.default | string | `""` |  |
| settings.cache.portalLocker | string | `""` |  |
| settings.celery.brokerUrl | string | `""` |  |
| settings.celery.logLevel | string | `"debug"` |  |
| settings.celery.resultBackend | string | `""` |  |
| settings.celery.resultExpires | int | `3600` |  |
| settings.cmis.enabled | bool | `false` |  |
| settings.cmis.mapperFile | string | `""` |  |
| settings.database.dbConnMaxAge | int | `60` |  |
| settings.database.dbDisableServerSideCursors | bool | `false` | Disable server-side cursors to prevent connection pooling issues Set to true when using transaction pooling to avoid cursor-related errors Warning: the effect of disabling server side cursors on performance has not been thoroughly tested yet Default: false ; Valid values: true, false |
| settings.database.dbPool.dbPoolMaxIdle | int | `600` |  |
| settings.database.dbPool.dbPoolMaxLifetime | int | `3600` |  |
| settings.database.dbPool.dbPoolMaxSize | int | `4` |  |
| settings.database.dbPool.dbPoolMaxWaiting | int | `0` |  |
| settings.database.dbPool.dbPoolMinSize | int | `4` |  |
| settings.database.dbPool.dbPoolNumWorkers | int | `3` |  |
| settings.database.dbPool.dbPoolReconnectTimeout | int | `300` |  |
| settings.database.dbPool.dbPoolTimeout | int | `30` |  |
| settings.database.dbPool.enabled | bool | `false` |  |
| settings.database.host | string | `"open-zaak-postgresql"` |  |
| settings.database.name | string | `"openzaak"` |  |
| settings.database.password | string | `"SUPER-SECRET"` |  |
| settings.database.port | int | `5432` |  |
| settings.database.sslmode | string | `"prefer"` |  |
| settings.database.username | string | `"postgres"` |  |
| settings.debug | bool | `false` |  |
| settings.disable2fa | bool | `false` | Disable two factor authentication |
| settings.djangoSettingsModule | string | `"openzaak.conf.docker"` |  |
| settings.documentApiBackend | string | `"filesystem"` | Backend to use for the Documenten API. Supported values: filesystem | azure_blob_storage | s3_storage |
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
| settings.environment | string | `""` |  |
| settings.flower.basicAuth | string | `""` |  |
| settings.flower.urlPrefix | string | `""` |  |
| settings.isHttps | bool | `true` |  |
| settings.jwtExpiry | int | `3600` |  |
| settings.logLevel | string | `"INFO"` |  |
| settings.logOutgoingRequestsDBSave | bool | `false` | Whether or not outgoing request logs should always be saved to the database. Defaults to: False. |
| settings.logOutgoingRequestsDBSaveBody | bool | `false` | Whether or not outgoing request bodies should be saved to the database. Defaults to: False. |
| settings.logOutgoingRequestsMaxAge | int | `7` | The number of days after which request logs should be deleted from the database. Defaults to: 7. |
| settings.logOutgoingRequestsResetDBSaveAfter | int | `60` | After the config has been changed via the admin, reset back to the default LOG_OUTGOING_REQUESTS_DB_SAVE after x minutes. Defaults to: 60. |
| settings.logRequests | bool | `true` | Enable structured logging of requests. Defaults to: True. |
| settings.notificationsDisabled | bool | `false` |  |
| settings.notificationsSource | string | `"openzaak"` |  |
| settings.numProxies | int | `1` | use 2 if enabling ingress |
| settings.otel.disabled | bool | `true` | If the OpenTelemetrySDK should be disabled. Opentelemtry is enabled by default, Set this values to 'true' to disable openTelemetry.  |
| settings.otel.exporterOtlpEndpoint | string | `""` | Network address where to send the metrics to. Examples are: https://otel.example.com:4318 or http://otel-collector.namespace.cluster.svc:4317. |
| settings.otel.exporterOtlpHeaders | list | `[]` | Specify any additional HTTP headers required (e.g., Basic Auth). This configuration is stored in secret.yaml because it may include sensitive credentials.  |
| settings.otel.exporterOtlpMetricsInsecure | bool | `false` | If the Opentelemetry Exporter endpoint is Insecure. Default is secured with TLS.    |
| settings.otel.exporterOtlpProtocol | string | `"grpc"` | What protocol Opentelemtry should use. options: grpc and http/protobuf. |
| settings.otel.metricExportInterval | int | `60000` | How often (in milliseconds) the metrics are exported. Exports run in a background thread.  |
| settings.otel.metricExportTimeout | int | `10000` | Timeout of the requests to the collector (in milliseconds) |
| settings.otel.resourceAttributes | list | `[]` | Resource attributes can be used to specify additional information about the instance. These are collected by the Kubernetes attributes processor. |
| settings.s3storage.accessKeyId | string | `""` |  |
| settings.s3storage.customDomain | string | `""` |  |
| settings.s3storage.endpointUrl | string | `""` |  |
| settings.s3storage.fileOverwrite | bool | `false` |  |
| settings.s3storage.location | string | `"documenten/"` |  |
| settings.s3storage.maxMemorySize | int | `0` |  |
| settings.s3storage.querystringExpire | int | `60` |  |
| settings.s3storage.regionName | string | `""` |  |
| settings.s3storage.secretAccessKey | string | `""` |  |
| settings.s3storage.storageBucketName | string | `"openzaak"` |  |
| settings.secretKey | string | `""` | Generate secret key at https://djecrety.ir/ |
| settings.sentry.dsn | string | `""` |  |
| settings.siteDomain | string | `""` | Defines the primary domain where the application is hosted. Defaults to "" |
| settings.timeLeeway | string | `"nil"` | Time leeway in seconds for JWT validation timestamps Accounts for clock drift between server and client Default: nil (uses Django default, typically 0 seconds) Recommended: not to increase above 300 seconds |
| settings.useXForwardedHost | bool | `true` |  |
| settings.uwsgi.harakiri | string | `""` |  |
| settings.uwsgi.master | string | `""` |  |
| settings.uwsgi.maxRequests | string | `""` |  |
| settings.uwsgi.processes | string | `""` |  |
| settings.uwsgi.threads | string | `""` |  |
| settings.zaakIdentificatieGenerator | string | `""` | Sets the method of Zaak.identificatie generation. Possible values are: use-creation-year, use-start-datum-year ; default=use-start-datum-year |
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
| worker.livenessProbe.enabled | bool | `true` |  |
| worker.livenessProbe.failureThreshold | int | `6` |  |
| worker.livenessProbe.initialDelaySeconds | int | `60` |  |
| worker.livenessProbe.periodSeconds | int | `60` |  |
| worker.livenessProbe.successThreshold | int | `1` |  |
| worker.livenessProbe.timeoutSeconds | int | `15` |  |
| worker.podLabels | object | `{}` |  |
| worker.replicaCount | int | `2` |  |
| worker.resources | object | `{}` |  |
| worker.startupProbe.enabled | bool | `true` |  |
| worker.startupProbe.failureThreshold | int | `3` |  |
| worker.startupProbe.initialDelaySeconds | int | `60` |  |
| worker.startupProbe.periodSeconds | int | `50` |  |
| worker.startupProbe.successThreshold | int | `1` |  |
| worker.startupProbe.timeoutSeconds | int | `10` |  |
