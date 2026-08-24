# Open Forms Chart

Snel en eenvoudig slimme formulieren bouwen en publiceren

![Version: 1.12.0](https://img.shields.io/badge/Version-1.12.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 3.3.9](https://img.shields.io/badge/AppVersion-3.3.9-informational?style=flat-square)

## Introduction

This chart can be used to deploy Open Forms on a Kubernetes cluster using the Helm package manager.

* [Source code](https://github.com/open-formulieren/open-forms/)
* [Documentation](https://open-forms.readthedocs.io/)
* [Docker image](https://hub.docker.com/r/openformulieren/open-forms)
* [Changelog](https://open-forms.readthedocs.io/en/stable/changelog.html)

## Quickstart

```bash
helm repo add maykinmedia https://maykinmedia.github.io/charts/
helm install openforms maykinmedia/openforms
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
how to configure, see the Open Forms [documetation](https://open-forms.readthedocs.io/en/stable/installation/setup_configuration.html#installation-configuration-cli).

### Sentry

Open Forms makes use of [Sentry](https://sentry.io/welcome/) for automatic reporting of errors.
In order to configure it, the value `settings.sentry.dsn` needs to be set. To see where to find the `DSN`, see
the [Sentry documentation](https://docs.sentry.io/concepts/key-terms/dsn-explainer/#where-to-find-your-data-source-name-dsn). 

```yaml
settings:
  sentry:
    dsn: "https://public@sentry.example.com/1"
```

The value of the `DSN` is considered sensitive, so it should be handled as a secret.

### Cleaning up logs

It is possible to schedule a `CronJob` resource to clean up Timeline log entries. In order to enable it, set the value `settings.cleanLogs.enabled: true`.
You can configure the number of days for which the logs should be kept by specifying  `settings.cleanLogs.daysRetained`. A value of `90` will keep all the logs newer than `90` days.

Note that if you have accumulated a large number of logs, it is possible that the job might be OOM killed. Keep an eye on it to make sure that logs are properly deleted.

### Open Telemetry

Open Forms supports the Open Telemetry Protocol.

We recommend deploying one or more Open Telemetry Collector instances in your cluster to receive
telemetry. Alternatively, you can use any vendor that speaks the OTLP protocol.

The environment variables that the Open Telemetry SDK supports can be found [here](https://opentelemetry.io/docs/specs/otel/configuration/sdk-environment-variables/#general-sdk-configuration).

### Static File Serving

The OpenForms Helm chart supports nginx-based static file serving for improved performance and reduced load on the application server. This feature allows nginx to serve static files (CSS, JavaScript, images) directly without proxying requests to the uWSGI application.

#### Requirements

- **OpenForms Version**: 3.3.0 or higher
- **Chart Configuration**: `nginx.staticFileServing.enabled: true`

> **Important**: Static file serving is **enabled by default** (`enabled: true`). You can disable it by setting `nginx.staticFileServing.enabled: false` in your values.

#### How It Works

When static file serving is enabled:

1. **File Collection**: The web container collects static files during startup and copies them to a shared volume
2. **Shared Storage**: Both the web and nginx containers mount the same PVC subPath (`openforms/static`)
3. **Direct Serving**: Nginx serves static files directly from `/srv/static/` instead of proxying to uWSGI
4. **Performance**: Reduces application server load and improves response times for static assets

#### Configuration

```yaml
nginx:
  staticFileServing:
    enabled: true
```

#### Architecture

The static file serving feature uses the existing media PVC with subPaths to organize storage:

- **PVC**: `openforms` (shared between media and static files)
- **Media subPath**: `openforms/media` → `/app/media` (web container)
- **Static subPath**: `openforms/static` → `/srv/static` (both containers)

### Probes

Open Forms 3.5.0 added new functionality to improve the container health checks for the web application, the Celery worker, the Celery beat and the Flower container. Below you can find additional information about the various checks.

**Web application**

There are now the endpoints `/_healthz/`, `/_healthz/livez/` and `/_healthz/readyz/` which are used for the startup, liveness and readiness probe respectively. You can find more information about what these endpoints check [here](https://github.com/open-formulieren/open-forms/blob/b7da980cc7053c10ae6d920ca0479db4ceb193df/docs/installation/health_checks.rst#http-service).

Important to note: these endpoints are not reacheable from outside the cluster, Nginx is configured to return 404 for these endpoints.

**Celery worker**

You can read more about the worker health checks in the `maykin-common` documentation [here](https://maykin-django-common.readthedocs.io/en/latest/health_checks.html#celery-worker-health-checks). Things to note here are:

* For the startup probe, we only check the presence of the readiness file. This is created when the worker is ready to accept work. Then it is no longer updated and it is cleaned up when the worker shuts down.
* For the liveness probe, we check the presence of the liveness file, which is touched by the internal event loop of the worker every `60 s` (not a configurable value). We check that the file is not older than `70 s`. We also perform a ping to check the connection with the broker.

Also note that for the liveness probe we use a script to be able to determine the Celery queue name, which is needed to build the name of the worker to check. Open Forms uses by default "default queues", but since the queue name can be changed with the `extraEnvVar` value, we support custom queue names.

**Celery Beat**

You can read more about the Beat health checks in the `maykin-common` documentation [here](https://maykin-django-common.readthedocs.io/en/latest/health_checks.html#celery-beat-health-checks).

* For the startup, we check the presence of a liveness file. This is created when a new beat task is published. In Open Forms, there are the activate-form/deactivate-form tasks which should be published every minute. With the startup probe we aim to check that Beat has started and can schedule tasks, so the age of the file is not particularly important.
* For the liveness probe we also check the liveness file. However, here we check that it is not older than 2 min, to be sure that Beat can still publish new tasks.

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
| configuration.job.backoffLimit | int | `6` |  |
| configuration.job.enabled | bool | `true` | Run the setup configuration command as a job |
| configuration.job.resources | object | `{}` |  |
| configuration.job.restartPolicy | string | `"OnFailure"` |  |
| configuration.job.ttlSecondsAfterFinished | int | `0` | 0 Will clean the job after it is finished |
| configuration.secrets | object | `{}` |  |
| configurationSecretsName | string | `""` |  |
| existingConfigurationSecrets | string | `nil` |  |
| existingSecret | string | `nil` |  |
| existingTlsSecret | string | `nil` |  |
| extraDeploy | list | `[]` |  |
| extraEnvVars | list | `[]` |  |
| extraIngress | list | `[]` | Specify extra ingresses, for example if you have multiple ingress classes |
| extraVerifyCerts | string | `""` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
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
| image.repository | string | `"openformulieren/open-forms"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts | list | `[]` | ingress hosts |
| ingress.tls | list | `[]` |  |
| ingress.tlsSecret.cert | string | `""` |  |
| ingress.tlsSecret.enabled | bool | `false` |  |
| ingress.tlsSecret.key | string | `""` |  |
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
| nginx.staticFileServing.enabled | bool | `true` | Enable static file serving directly from Nginx (requires OpenForms >= 3.3.0) |
| nodeSelector | object | `{}` |  |
| pdb.create | bool | `false` |  |
| pdb.maxUnavailable | string | `""` |  |
| pdb.minAvailable | int | `1` |  |
| persistence.enabled | bool | `true` |  |
| persistence.existingClaim | string | `nil` |  |
| persistence.mediaMountSubpath | string | `"openforms/media"` |  |
| persistence.privateMediaMountSubpath | string | `"openforms/private_media"` |  |
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
| settings.baseUrl | string | `""` |  |
| settings.cache.axes | string | `""` |  |
| settings.cache.default | string | `""` |  |
| settings.cache.portalLocker | string | `""` |  |
| settings.celery.brokerUrl | string | `""` |  |
| settings.celery.logLevel | string | `"debug"` |  |
| settings.celery.resultBackend | string | `""` |  |
| settings.cleanLogs.cronjob.historyLimit | int | `1` |  |
| settings.cleanLogs.cronjob.resources | object | `{}` |  |
| settings.cleanLogs.cronjob.schedule | string | `"0 0 * * *"` | Schedule to run the clean logs cronjob. The default will run the job every day at 00:00 |
| settings.cleanLogs.daysRetained | int | `90` | Number of days to retain logs |
| settings.cleanLogs.enabled | bool | `false` | Clean Timeline Log entries |
| settings.cookieSamesite | string | `""` | Choises Strict or Lax |
| settings.cors.allowAllOrigins | bool | `false` |  |
| settings.cors.allowedOrigins | list | `[]` |  |
| settings.cors.allowedOriginsNginx | bool | `false` |  |
| settings.crossOriginOpenerPolicy | string | `""` | Recommended: "same-origin" for production security, "unsafe-none" for development/testing |
| settings.csp.extraDefaultSrc | list | `[]` |  |
| settings.csp.extraImgSrc | list | `[]` |  |
| settings.csp.log | bool | `true` | Whether to save violation reports to the database. Defaults to true |
| settings.csp.reportOnly | bool | `false` | If True, CSP only reports violations but does not block them. Defaults to False |
| settings.csp.reportPercentage | float | `1` | Float between 0 and 1.0 expressing the percentage of violations that will be reported. Defaults to 1.0 (100%) |
| settings.csp.reportSave | bool | `false` |  |
| settings.csrf.trustedOrigins | list | `[]` |  |
| settings.database.host | string | `""` |  |
| settings.database.name | string | `""` |  |
| settings.database.password | string | `""` |  |
| settings.database.port | int | `5432` |  |
| settings.database.sslmode | string | `"prefer"` |  |
| settings.database.username | string | `""` |  |
| settings.debug | bool | `false` |  |
| settings.djangoSettingsModule | string | `"openforms.conf.docker"` |  |
| settings.elasticapm.token | string | `""` |  |
| settings.elasticapm.url | string | `""` |  |
| settings.email.defaultFrom | string | `""` |  |
| settings.email.host | string | `"localhost"` |  |
| settings.email.password | string | `""` |  |
| settings.email.port | int | `25` |  |
| settings.email.timeout | string | `""` | default value email_timeout in openforms app = 10       |
| settings.email.useTLS | bool | `false` |  |
| settings.email.username | string | `""` |  |
| settings.environment | string | `nil` |  |
| settings.environmentLabelBackgroundColor | string | `""` | CSS color value for the environment information background color. Defaults to orange, example values can be specified in HEX format too, e.g.: #FF0000 for red. |
| settings.environmentLabelForegroundColor | string | `""` | CSS color value for the environment information text color. Defaults to black. Follows the same rules as ENVIRONMENT_BACKGROUND_COLOR. |
| settings.environmentLabelName | string | `""` | Environment information to display, defaults to the value of ENVIRONMENT. Only displayed when SHOW_ENVIRONMENT is set to True. You can set this to strings like OpenGem PROD or simply PROD, depending on your needs. |
| settings.escapeRegistrationOutput | bool | `false` |  |
| settings.flower.basicAuth | string | `""` |  |
| settings.flower.urlPrefix | string | `""` |  |
| settings.isHttps | bool | `true` |  |
| settings.maxFileUpload | string | `"50M"` | Configure the maximum allowed file upload size |
| settings.maxImportSize | string | `"20M"` | Configure the maximum allowed size for importing forms in the admin |
| settings.numProxies | int | `1` | use 2 if enabling ingress |
| settings.oidc | object | `{"useLegacyDigidEndpoint":false,"useLegacyEndpont":false,"useLegacyOrgEndpoint":false}` | https://open-forms.readthedocs.io/en/latest/changelog.html#upgrade-notes |
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
| settings.sessionCookieDomain | string | `""` | Domain for session cookies (e.g. "example.com" for cross-domain or ".example.com" for all subdomains). Leave empty for standard domain cookies. |
| settings.showLabelEnvironment | bool | `false` | Display environment information in the header in the admin. Defaults to True. Environment information is only displayed to logged in users. |
| settings.throttling.enable | bool | `true` |  |
| settings.throttling.rateAnonymous | string | `""` |  |
| settings.throttling.ratePolling | string | `""` |  |
| settings.throttling.rateUser | string | `""` |  |
| settings.useXForwardedHost | bool | `false` |  |
| settings.uwsgi.harakiri | string | `""` |  |
| settings.uwsgi.master | bool | `false` |  |
| settings.uwsgi.maxRequests | string | `""` |  |
| settings.uwsgi.processes | string | `""` |  |
| settings.uwsgi.threads | string | `""` |  |
| startupProbe.failureThreshold | int | `30` |  |
| startupProbe.initialDelaySeconds | int | `15` | Total time: 15s initial delay + (30 failures × 10s period) = 315s (5 minutes 15 seconds)     |
| startupProbe.periodSeconds | int | `10` |  |
| startupProbe.successThreshold | int | `1` |  |
| startupProbe.timeoutSeconds | int | `5` |  |
| tags.redis | bool | `true` |  |
| tlsSecretName | string | `""` |  |
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
