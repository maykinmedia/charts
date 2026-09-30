# Maykin Component Chart

Generic Helm chart for deploying Maykin applications on Kubernetes

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

## Installing the Chart

### From the Helm repository (deprecated)

```shell

helm repo add maykinmedia https://maykinmedia.github.io/charts/
helm repo update
helm install <application-name> ./maykin-component --namespace test -f values.yaml
```

## Uninstall the Chart

To uninstall the chart:

```shell
helm uninstall <application-name> --namespace test
```

## Testing

This chart ships `helm-unittest` test suites under `tests/`:

```bash
helm plugin install https://github.com/helm-unittest/helm-unittest
helm unittest maykin-component
```

And is linted with:

```bash
helm lint maykin-component
```

## Chart Dependencies

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 2.27.0 |
| https://charts.bitnami.com/bitnami | redis | 17.3.14 |

## Naming convention for ConfigMap, Secret, SealedSecret and ExternalSecret

- TODO

## Consuming environment variable in application chart

- TODO

## Configuring probes

- TODO

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalLabels | object | `{}` | Extra labels applied to all resources created by this chart |
| affinity | object | `{}` | Affinity rules for application pods |
| applicationName | string | `""` | Name of the application, used in resource naming templates |
| autoscaling.additionalLabels | object | `{}` | Extra labels for the HorizontalPodAutoscaler |
| autoscaling.annotations | object | `{}` | Extra annotations for the HorizontalPodAutoscaler |
| autoscaling.behavior | object | `{}` | Optional HPA scale-up/scale-down behavior policy (spec.behavior) |
| autoscaling.enabled | bool | `false` | Enable HorizontalPodAutoscaler for the main application deployment |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.metrics | list | `[]` | Extra custom/external metrics, appended alongside the CPU/memory targets above |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| azureVaultSecret.contentType | string | `""` | Content type of the secret; must match its actual content ('application/x-json' or 'application/x-yaml') |
| azureVaultSecret.objectName | string | `""` | Name of the Multi Key Value Secret in the vault |
| azureVaultSecret.secretName | string | `"{{ .Values.existingSecret }}"` | Target secret name; you must also set .Values.existingSecret |
| azureVaultSecret.vaultName | string | `nil` | Name of the Azure Key Vault; setting this creates the AzureVaultSecret resource |
| beat.enabled | bool | `true` | Enable the Celery beat (scheduler) deployment |
| beat.livenessProbe | object | `{}` |  |
| beat.podLabels | object | `{}` |  |
| beat.readinessProbe | object | `{}` |  |
| beat.replicaCount | int | `1` |  |
| beat.resources | object | `{}` |  |
| chartVersionOverride | string | `""` | Override the chart version label used on resources |
| componentOverride | string | `""` | Override the "app.kubernetes.io/component" label value |
| configMap.additionalLabels | object | `{}` | Extra labels for the generated ConfigMap |
| configMap.annotations | object | `{}` | Extra annotations for the generated ConfigMap |
| configuration.data | string | `""` | YAML content consumed by "manage.py setup_configuration". Rendered into a ConfigMap and mounted into the Job at /app/configuration/configuration.yaml. |
| configuration.enabled | bool | `false` | Enable django-setup-configuration support for this release (must also have global.configuration.enabled: true) |
| configuration.job.additionalLabels | object | `{}` | Extra labels merged onto the Job and its Pod template |
| configuration.job.annotations | object | `{}` | Extra annotations merged onto the Job (helm hook annotations are always set) |
| configuration.job.backoffLimit | int | `0` | Number of retries before the Job is considered failed |
| configuration.job.enabled | bool | `false` | Run "manage.py setup_configuration" as a post-install/post-upgrade Helm hook Job. The Job only renders when this AND configuration.enabled AND configuration.data (non-empty) are all set — see templates/configuration-job.yaml |
| configuration.job.resources | object | `{}` | Resource requests/limits for the setup-configuration container. NOTE: this field is immutable once the Job has been created by Helm |
| configuration.job.restartPolicy | string | `"Never"` | Pod restart policy for the Job. Job pods generally should not restart in place; a failed attempt is retried by creating a new pod, governed by backoffLimit |
| configuration.overwrite | bool | `true` | Whether re-running setup_configuration is allowed to overwrite existing values |
| configuration.secrets | object | `{}` | Extra Kubernetes Secret data referenced by the generated configuration.yaml (e.g. credentials that setup_configuration should read) |
| configuration.superuser.email | string | `""` | Email address for the Django superuser created by setup_configuration |
| configuration.superuser.password | string | `""` | Password for the Django superuser created by setup_configuration |
| configuration.superuser.username | string | `""` | Username for the Django superuser created by setup_configuration |
| configurationSecretsName | string | `""` | If no secret already exists with the values needed for django-setup-configuration, create one with this name (defaults to "<fullname>-config-secret") |
| enableServiceLinks | bool | `false` | Disable auto-injected Kubernetes Service environment variables in pods |
| existingConfigurationSecret | string | `nil` | Reference to an existing secret with the values needed for django-setup-configuration |
| existingSecret | string | `nil` | Use an existing Secret instead of the one generated by the chart. Required if azureVaultSecret is used |
| extraEnvVars | list | `[]` | Array with extra environment variables to add to the main container |
| extraIngress | list | `[]` | Specify extra ingresses, for example if you have multiple ingress classes |
| extraVolumeMounts | list | `[]` | Optionally specify extra list of additional volumeMounts |
| extraVolumes | list | `[]` | Optionally specify extra list of additional volumes |
| flower.additionalLabels | object | `{}` |  |
| flower.annotations | object | `{}` |  |
| flower.autoscaling.enabled | bool | `false` |  |
| flower.autoscaling.maxReplicas | int | `100` |  |
| flower.autoscaling.minReplicas | int | `1` |  |
| flower.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| flower.autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| flower.enabled | bool | `true` | Enable the Flower (Celery monitoring UI) deployment |
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
| fullnameOverride | string | `""` | Override the chart's fullname template |
| global.configuration.enabled | bool | `false` | Master switch: must be true (together with configuration.enabled) for django-setup-configuration resources (ConfigMap/Secret/Job) to be rendered at all |
| global.configuration.overwrite | bool | `true` | Whether the setup-configuration job is allowed to overwrite existing config |
| global.configuration.secrets | object | `{}` |  |
| global.settings.databaseHost | string | `""` | Global database host, overrides settings.database.host when set |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"maykinmedia/application"` | Container image repository (required) |
| image.tag | string | `"0.0.0"` | Image tag; defaults to .Chart.AppVersion when empty |
| imagePullSecrets | list | `[]` | References to secrets for pulling images from private registries |
| ingress.additionalLabels | object | `{}` | Extra labels for the Ingress |
| ingress.annotations | object | `{}` | Extra annotations for the Ingress |
| ingress.className | string | `""` | IngressClass name |
| ingress.enabled | bool | `false` | Enable the primary Ingress resource |
| ingress.hosts | list | `[]` | Ingress hosts and path rules |
| ingress.tls | list | `[]` | TLS configuration for the Ingress |
| livenessProbe.enabled | bool | `false` | Enable the liveness probe |
| livenessProbe.failureThreshold | int | `6` |  |
| livenessProbe.httpGet.path | string | `"/admin/"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| livenessProbe.initialDelaySeconds | int | `60` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `10` |  |
| namespaceOverride | string | `""` | Override the namespace resources are deployed into |
| nodeSelector | object | `{}` | Node selector for application pods |
| partOfOverride | string | `""` | Override the "app.kubernetes.io/part-of" label value |
| pdb.create | bool | `false` | Create a PodDisruptionBudget for the main application deployment |
| pdb.maxUnavailable | string | `""` |  |
| pdb.minAvailable | int | `1` |  |
| persistence.accessMode | string | `"ReadWriteMany"` |  |
| persistence.additionalLabels | object | `{}` |  |
| persistence.annotations | object | `{}` |  |
| persistence.enabled | bool | `true` | Enable persistent storage (PVC) for media files; falls back to emptyDir when false |
| persistence.existingClaim | string | `nil` | Use an existing PVC instead of creating a new one |
| persistence.mediaMountSubpath | string | `""` | If null, use "<application.name>/media" and "<application.name>/private_media" |
| persistence.privateMediaMountSubpath | string | `""` |  |
| persistence.size | string | `"1Gi"` |  |
| persistence.storageClassName | string | `""` |  |
| persistence.volumeMode | string | `""` |  |
| persistence.volumeName | string | `""` |  |
| podAnnotations | object | `{}` | Annotations added to application pods |
| podLabels | object | `{}` | Labels added to application pods |
| podSecurityContext | object | `{"fsGroup":1000}` | Pod-level securityContext |
| readinessProbe.enabled | bool | `false` | Enable the readiness probe |
| readinessProbe.failureThreshold | int | `6` |  |
| readinessProbe.httpGet.path | string | `"/admin/"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.initialDelaySeconds | int | `30` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `10` |  |
| redis.architecture | string | `"standalone"` | Redis deployment topology (standalone or replication) |
| redis.auth.enabled | bool | `false` | Enable Redis authentication |
| redis.image.registry | string | `"docker.io"` |  |
| redis.image.repository | string | `"redis"` |  |
| redis.image.tag | string | `"8.0"` |  |
| redis.master.persistence.enabled | bool | `true` |  |
| redis.master.persistence.size | string | `"8Gi"` |  |
| redis.master.persistence.storageClass | string | `""` |  |
| redis.master.resources.requests.cpu | string | `"250m"` |  |
| redis.master.resources.requests.memory | string | `"256Mi"` |  |
| replicaCount | int | `2` | Number of application pod replicas |
| resources | object | `{}` | Resource requests/limits for the main application container |
| secret.additionalLabels | object | `{}` | Extra labels for the generated Secret |
| secret.annotations | object | `{}` | Extra annotations for the generated Secret |
| securityContext | object | `{"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":false,"runAsNonRoot":true,"runAsUser":1000}` | Container-level securityContext |
| service.additionalLabels | object | `{}` | Extra labels for the Service |
| service.annotations | object | `{}` | Extra annotations for the Service |
| service.clusterIP | string | `""` | Static ClusterIP address to assign (leave empty to let Kubernetes allocate one) |
| service.externalIPs | list | `[]` | Assign additional external IPs to the Service |
| service.loadBalancerClass | string | `""` | loadBalancerClass, only used when service.type is LoadBalancer |
| service.loadBalancerIP | string | `""` | Static loadBalancerIP to request, only used when service.type is LoadBalancer |
| service.loadBalancerSourceRanges | list | `[]` | Restrict access to the LoadBalancer to these CIDRs, only used when service.type is LoadBalancer |
| service.port | int | `80` | Kubernetes Service port (used only when service.ports is not set) |
| service.ports | list | `[]` | Full custom port list; overrides service.port entirely when set |
| service.type | string | `"ClusterIP"` | Kubernetes Service type |
| serviceAccount.additionalLabels | object | `{}` | Extra labels for the ServiceAccount |
| serviceAccount.annotations | object | `{}` | Annotations to add to the ServiceAccount |
| serviceAccount.automountServiceAccountToken | bool | `true` | Whether to auto-mount the ServiceAccount token into pods using it |
| serviceAccount.create | bool | `true` | Whether a ServiceAccount should be created |
| serviceAccount.name | string | `""` | Name of the ServiceAccount to use; generated from the fullname template if not set |
| settings.allowedHosts | string | `""` | Comma-separated (or templated) list of allowed hosts for Django's ALLOWED_HOSTS |
| settings.cache.axes | string | `""` |  |
| settings.cache.default | string | `""` |  |
| settings.cache.oidc | string | `""` |  |
| settings.celery.brokerUrl | string | `""` |  |
| settings.celery.logLevel | string | `"debug"` |  |
| settings.celery.resultBackend | string | `""` |  |
| settings.celery.resultExpires | string | `""` |  |
| settings.database.db_conn_max_age | string | `nil` | Max connection age in seconds (Django CONN_MAX_AGE); null uses Django default |
| settings.database.db_pool.db_pool_max_idle | string | `nil` |  |
| settings.database.db_pool.db_pool_max_lifetime | string | `nil` |  |
| settings.database.db_pool.db_pool_max_size | string | `nil` |  |
| settings.database.db_pool.db_pool_max_waiting | string | `nil` |  |
| settings.database.db_pool.db_pool_min_size | string | `nil` |  |
| settings.database.db_pool.db_pool_num_workers | string | `nil` |  |
| settings.database.db_pool.db_pool_reconnect_timeout | string | `nil` |  |
| settings.database.db_pool.db_pool_timeout | string | `nil` |  |
| settings.database.db_pool.enabled | bool | `false` | Enable database connection pooling |
| settings.database.host | string | `""` | Database host; overridden by global.settings.databaseHost when set |
| settings.database.name | string | `""` |  |
| settings.database.password | string | `""` |  |
| settings.database.port | int | `5432` |  |
| settings.database.sslmode | string | `"prefer"` |  |
| settings.database.username | string | `""` |  |
| settings.debug | bool | `false` | Enable Django DEBUG mode. Never enable in production |
| settings.disable2fa | bool | `false` | Disable two factor authentication |
| settings.djangoSettingsModule | string | `""` | Python path to the Django settings module to use |
| settings.elasticapm.serviceName | string | `""` | Service name reported to Elastic APM |
| settings.elasticapm.token | string | `""` | Elastic APM secret token |
| settings.elasticapm.url | string | `""` | Elastic APM server URL |
| settings.email.defaultFrom | string | `""` | Default "From" address for outgoing email |
| settings.email.host | string | `"localhost"` | SMTP host |
| settings.email.password | string | `""` |  |
| settings.email.port | int | `25` | SMTP port |
| settings.email.useTLS | bool | `false` | Use TLS for SMTP connections |
| settings.email.username | string | `""` |  |
| settings.environment | string | `""` | Sets the 'ENVIRONMENT' variable (e.g. staging, production) |
| settings.extraSettings | object | `{}` | Extra arbitrary key/value environment variables injected as Django settings |
| settings.isHttps | bool | `true` | Whether the app is served over HTTPS (affects secure cookie / redirect settings) |
| settings.logging.level | string | `""` | Root log level (e.g. DEBUG, INFO, WARNING) |
| settings.logging.outgoingRequests | bool | `false` | Log outgoing requests |
| settings.logging.outgoingRequestsDBSave | bool | `false` | Persist outgoing request logs to the database |
| settings.logging.outgoingRequestsDBSaveBody | bool | `false` | Include request/response body when saving outgoing request logs |
| settings.logging.outgoingRequestsMaxAge | string | `nil` | Max age (days) of outgoing request logs kept in the database |
| settings.logging.outgoingRequestsResetDBSaveAfter | string | `nil` | Days after which saved outgoing request logs are purged; null disables purging |
| settings.logging.requests | bool | `false` | Log incoming requests |
| settings.notifications.disabled | bool | `true` | Disable the notifications (NRC) integration |
| settings.notifications.logInDb | bool | `false` | Log notifications to the database |
| settings.notifications.numberOfDaysRetained | string | `nil` | Retention period (days) for logged notifications; null keeps them indefinitely |
| settings.notifications.source | string | `""` | Notification source identifier |
| settings.otel.disabled | bool | `true` | Disable OpenTelemetry instrumentation |
| settings.otel.exporterOtlpEndpoint | string | `""` | OTLP exporter endpoint |
| settings.otel.exporterOtlpHeaders | list | `[]` | Any additional HTTP headers, for example if you need Basic auth. This is used in the secret.yaml, as it can contain credentials.  |
| settings.otel.exporterOtlpMetricsInsecure | bool | `false` | Disable TLS for the OTLP metrics exporter |
| settings.otel.exporterOtlpProtocol | string | `""` | OTLP exporter protocol (e.g. grpc, http/protobuf) |
| settings.otel.metricExportInterval | string | `""` | Metric export interval |
| settings.otel.metricExportTimeout | string | `""` | Metric export timeout |
| settings.otel.resourceAttributes | list | `[]` | Extra OTEL resource attributes (list of "key=value" strings) |
| settings.secretKey | string | `""` | Django SECRET_KEY. Generate one at https://djecrety.ir/ |
| settings.sentry.dsn | string | `""` | Sentry DSN for error tracking; leave empty to disable |
| settings.siteDomain | string | `""` |  |
| settings.useXForwardedHost | bool | `false` | Whether Django should trust the X-Forwarded-Host header (behind a proxy/ingress) |
| settings.uwsgi.harakiri | string | `""` | uWSGI harakiri timeout (seconds) for stuck requests |
| settings.uwsgi.master | string | `""` | uWSGI master process mode |
| settings.uwsgi.maxRequests | string | `""` | Max requests served by a worker before respawn |
| settings.uwsgi.processes | string | `""` | Number of uWSGI worker processes |
| settings.uwsgi.threads | string | `""` | Number of uWSGI threads per worker |
| startupProbe.enabled | bool | `false` | Enable the startup probe (useful for slow-starting apps, e.g. large migrations) |
| startupProbe.failureThreshold | int | `30` |  |
| startupProbe.httpGet.path | string | `"/admin/"` |  |
| startupProbe.httpGet.port | string | `"http"` |  |
| startupProbe.initialDelaySeconds | int | `15` | Total time: 15s initial delay + (30 failures x 10s period) = 315s (5 minutes 15 seconds) |
| startupProbe.periodSeconds | int | `10` |  |
| startupProbe.successThreshold | int | `1` |  |
| startupProbe.timeoutSeconds | int | `10` |  |
| tags.redis | bool | `true` | Whether the bundled Redis subchart is used for cache/celery broker |
| tolerations | list | `[]` | Tolerations for application pods |
| worker.additionalLabels | object | `{}` |  |
| worker.annotations | object | `{}` |  |
| worker.autoscaling.enabled | bool | `false` |  |
| worker.autoscaling.maxReplicas | int | `100` |  |
| worker.autoscaling.minReplicas | int | `1` |  |
| worker.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| worker.autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| worker.command | string | `""` | Override the default worker start command |
| worker.concurrency | int | `4` | Celery worker concurrency (number of child processes/threads) |
| worker.enabled | bool | `true` | Enable the Celery worker deployment |
| worker.label | string | `"celery"` | Label used to identify this worker (e.g. for celery queue routing) |
| worker.livenessProbe.enabled | bool | `false` |  |
| worker.livenessProbe.exec.command[0] | string | `"/app/liveness/liveness-probe.sh"` |  |
| worker.livenessProbe.failureThreshold | int | `3` |  |
| worker.livenessProbe.initialDelaySeconds | int | `60` |  |
| worker.livenessProbe.periodSeconds | int | `50` |  |
| worker.livenessProbe.successThreshold | int | `1` |  |
| worker.livenessProbe.timeoutSeconds | int | `10` |  |
| worker.maxWorkerLivenessDelta | string | `""` | Max allowed delta (seconds) before the worker liveness check considers it stuck. Defaults to 60s |
| worker.name | string | `""` | Override the generated worker resource name |
| worker.podLabels | object | `{}` |  |
| worker.queueName | string | `""` | Name of the Celery queue this worker consumes from |
| worker.replicaCount | int | `2` |  |
| worker.resources | object | `{}` |  |
