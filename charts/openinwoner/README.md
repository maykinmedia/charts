# Open Inwoner Chart

Platform voor gemeenten en overheden om producten inzichtelijker en toegankelijker te maken voor inwoners.

![Version: 2.1.2](https://img.shields.io/badge/Version-2.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.0.3](https://img.shields.io/badge/AppVersion-2.0.3-informational?style=flat-square)

## Introduction

This chart can be used to deploy Open Inwoner on a Kubernetes cluster using the Helm package manager.

* [Source code](https://github.com/maykinmedia/open-inwoner)
* [Changelog](https://github.com/maykinmedia/open-inwoner/blob/develop/CHANGELOG.rst)

## Quickstart

```bash
helm repo add maykinmedia https://maykinmedia.github.io/charts/
helm install openinwoner maykinmedia/openinwoner
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 2.31.4 |
| https://charts.bitnami.com/bitnami | redis | 22.0.1 |
| https://helm.elastic.co | eck-elasticsearch | 0.17.0 |
| https://helm.elastic.co | eck-operator | 3.2.0 |

## Configuration and installation details

### Elasticsearch

Open Inwoner requires Elastic Search to be deployed to function
properly. We recommend installing Elastic Search in your cluster using their
[operator](https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-install-helm.html).

To deploy Elasticsearch with Elastic Cloud on Kubernetes (ECK), the cluster wide Custom Resource Definitions (CRDs) need to be present.
They can be installed by a cluster administrator with (see [the docs](https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-installing-eck.html) for more details):

```bash
helm install elastic-operator-crds elastic/eck-operator-crds
```

For Open Inwoner it is enough to deploy the following nodes:

- 1 `master` node
- 1 node with both `data` and `ingest` role.

Currently Open Inwoner does not support sending user authentication details for the requests to Elastic Search.
The authentication on the nodes can be turned off as follows:

```yaml
- name: master
  count: 1
  config:
    node.store.allow_mmap: false
    node.roles: ["master"]
    xpack.security.authc:
      anonymous:
        username: anonymous
        roles: viewer
        authz_exception: false
```

Since Elasticsearch is not exposed through an ingress, Open Inwoner connects to its internal http endpoint.
Open Inwoner does not yet support using the self-signed certificates and the custom CA of Elastic Search, so for
now TLS is to be turned off. The expectation is that this is used in a cluster and that Elastic Search is not exposed
via the ingress to the outside world. The TLS can be turned off as follows:

```yaml
eck-elasticsearch:
  http:
    tls:
      selfSignedCertificate:
        disabled: true
```

After deploying Elastic Search, the indices need to be built. If the value `settings.searchIndexInitContainer`
is set to `true` this will be done automatically with an init container.

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
how to configure, see the Open Inwoner [documentation](https://open-forms.readthedocs.io/en/stable/installation/setup_configuration.html#installation-configuration-cli).

### Sentry

Open Inwoner makes use of [Sentry](https://sentry.io/welcome/) for automatic reporting of errors.
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
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| azureVaultSecret.contentType | string | `""` |  |
| azureVaultSecret.objectName | string | `""` |  |
| azureVaultSecret.secretName | string | `"{{ .Values.existingSecret }}"` |  |
| azureVaultSecret.vaultName | string | `nil` |  |
| beat.podLabels | object | `{}` |  |
| beat.replicaCount | int | `1` |  |
| beat.resources | object | `{}` |  |
| celeryMonitor.podLabels | object | `{}` |  |
| celeryMonitor.replicaCount | int | `1` |  |
| celeryMonitor.resources | object | `{}` |  |
| configuration.data | string | `""` |  |
| configuration.enabled | bool | `false` |  |
| configuration.initContainer.enabled | bool | `false` | Run the setup configuration command in a init container |
| configuration.job.backoffLimit | int | `6` |  |
| configuration.job.enabled | bool | `true` | Run the setup configuration command as a job |
| configuration.job.resources | object | `{}` |  |
| configuration.job.restartPolicy | string | `"OnFailure"` |  |
| configuration.job.ttlSecondsAfterFinished | int | `0` | 0 Will clean the job after it is finished |
| configuration.secrets | object | `{}` |  |
| eck-elasticsearch.annotations | object | `{}` |  |
| eck-elasticsearch.auth | object | `{}` |  |
| eck-elasticsearch.enabled | bool | `true` |  |
| eck-elasticsearch.fullnameOverride | string | `"openinwoner-elasticsearch"` |  |
| eck-elasticsearch.http | object | `{}` |  |
| eck-elasticsearch.ingress.annotations | object | `{}` |  |
| eck-elasticsearch.ingress.enabled | bool | `false` |  |
| eck-elasticsearch.ingress.hosts[0].host | string | `"chart-example.local"` |  |
| eck-elasticsearch.ingress.hosts[0].path | string | `"/"` |  |
| eck-elasticsearch.ingress.labels | object | `{}` |  |
| eck-elasticsearch.ingress.pathType | string | `"Prefix"` |  |
| eck-elasticsearch.ingress.tls.enabled | bool | `false` |  |
| eck-elasticsearch.labels | object | `{}` |  |
| eck-elasticsearch.monitoring | object | `{}` |  |
| eck-elasticsearch.nameOverride | string | `"openinwoner-elasticsearch"` |  |
| eck-elasticsearch.nodeSets[0].config."node.store.allow_mmap" | bool | `false` |  |
| eck-elasticsearch.nodeSets[0].count | int | `1` |  |
| eck-elasticsearch.nodeSets[0].name | string | `"default"` |  |
| eck-elasticsearch.nodeSets[0].podTemplate.spec.containers[0].name | string | `"elasticsearch"` |  |
| eck-elasticsearch.nodeSets[0].podTemplate.spec.containers[0].resources.limits.memory | string | `"2Gi"` |  |
| eck-elasticsearch.nodeSets[0].podTemplate.spec.containers[0].resources.requests.memory | string | `"2Gi"` |  |
| eck-elasticsearch.remoteClusterServer | object | `{}` |  |
| eck-elasticsearch.remoteClusters | object | `{}` |  |
| eck-elasticsearch.secureSettings | list | `[]` |  |
| eck-elasticsearch.transport | object | `{}` |  |
| eck-elasticsearch.updateStrategy | object | `{}` |  |
| eck-elasticsearch.version | string | `"9.2.0"` |  |
| eck-elasticsearch.volumeClaimDeletePolicy | string | `""` |  |
| eck-operator.affinity | object | `{}` |  |
| eck-operator.automountServiceAccountToken | bool | `true` |  |
| eck-operator.config.caDir | string | `""` |  |
| eck-operator.config.caRotateBefore | string | `"24h"` |  |
| eck-operator.config.caValidity | string | `"8760h"` |  |
| eck-operator.config.certificatesRotateBefore | string | `"24h"` |  |
| eck-operator.config.certificatesValidity | string | `"8760h"` |  |
| eck-operator.config.containerRegistry | string | `"docker.elastic.co"` |  |
| eck-operator.config.disableConfigWatch | bool | `false` |  |
| eck-operator.config.elasticsearchClientTimeout | string | `"180s"` |  |
| eck-operator.config.elasticsearchObservationInterval | string | `"10s"` |  |
| eck-operator.config.enableLeaderElection | bool | `true` |  |
| eck-operator.config.exposedNodeLabels[0] | string | `"topology.kubernetes.io/.*"` |  |
| eck-operator.config.exposedNodeLabels[1] | string | `"failure-domain.beta.kubernetes.io/.*"` |  |
| eck-operator.config.ipFamily | string | `""` |  |
| eck-operator.config.kubeClientTimeout | string | `"60s"` |  |
| eck-operator.config.logVerbosity | string | `"0"` |  |
| eck-operator.config.maxConcurrentReconciles | string | `"3"` |  |
| eck-operator.config.metrics.port | string | `"0"` |  |
| eck-operator.config.metrics.secureMode.enabled | bool | `false` |  |
| eck-operator.config.metrics.secureMode.tls.certificateSecret | string | `""` |  |
| eck-operator.config.metricsPort | int | `0` |  |
| eck-operator.config.policies | object | `{}` |  |
| eck-operator.config.setDefaultSecurityContext | string | `"auto-detect"` |  |
| eck-operator.config.ubiOnly | bool | `false` |  |
| eck-operator.config.validateStorageClass | bool | `true` |  |
| eck-operator.createClusterScopedResources | bool | `true` |  |
| eck-operator.dnsConfig | object | `{}` |  |
| eck-operator.dnsPolicy | string | `""` |  |
| eck-operator.enabled | bool | `true` |  |
| eck-operator.env | list | `[]` |  |
| eck-operator.fullnameOverride | string | `"openinwoner-elastic-operator"` |  |
| eck-operator.hostNetwork | bool | `false` |  |
| eck-operator.image.fips | bool | `false` |  |
| eck-operator.image.pullPolicy | string | `"IfNotPresent"` |  |
| eck-operator.image.repository | string | `"docker.elastic.co/eck/eck-operator"` |  |
| eck-operator.image.tag | string | `nil` |  |
| eck-operator.imagePullSecrets | list | `[]` |  |
| eck-operator.installCRDs | bool | `false` |  |
| eck-operator.kubeAPIServerIP | string | `nil` |  |
| eck-operator.managedNamespaces | list | `[]` |  |
| eck-operator.nameOverride | string | `"openinwoner-elastic-operator"` |  |
| eck-operator.nodeSelector | object | `{}` |  |
| eck-operator.podAnnotations | object | `{}` |  |
| eck-operator.podDisruptionBudget.enabled | bool | `false` |  |
| eck-operator.podDisruptionBudget.minAvailable | int | `1` |  |
| eck-operator.podLabels | object | `{}` |  |
| eck-operator.podMonitor.annotations | object | `{}` |  |
| eck-operator.podMonitor.enabled | bool | `false` |  |
| eck-operator.podMonitor.interval | string | `"5m"` |  |
| eck-operator.podMonitor.labels | object | `{}` |  |
| eck-operator.podMonitor.podMetricsEndpointConfig | object | `{}` |  |
| eck-operator.podMonitor.podTargetLabels | list | `[]` |  |
| eck-operator.podMonitor.scrapeTimeout | string | `"30s"` |  |
| eck-operator.podSecurityContext.runAsNonRoot | bool | `true` |  |
| eck-operator.priorityClassName | string | `""` |  |
| eck-operator.refs.enforceRBAC | bool | `false` |  |
| eck-operator.replicaCount | int | `1` |  |
| eck-operator.resources.limits.cpu | int | `1` |  |
| eck-operator.resources.limits.memory | string | `"1Gi"` |  |
| eck-operator.resources.requests.cpu | string | `"100m"` |  |
| eck-operator.resources.requests.memory | string | `"150Mi"` |  |
| eck-operator.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| eck-operator.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| eck-operator.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| eck-operator.securityContext.runAsNonRoot | bool | `true` |  |
| eck-operator.serviceAccount.annotations | object | `{}` |  |
| eck-operator.serviceAccount.automountServiceAccountToken | bool | `true` |  |
| eck-operator.serviceAccount.create | bool | `true` |  |
| eck-operator.serviceAccount.name | string | `""` |  |
| eck-operator.serviceMonitor.caMountDirectory | string | `"/etc/prometheus/secrets/"` |  |
| eck-operator.serviceMonitor.caSecret | string | `""` |  |
| eck-operator.serviceMonitor.enabled | bool | `true` |  |
| eck-operator.serviceMonitor.insecureSkipVerify | bool | `true` |  |
| eck-operator.softMultiTenancy.enabled | bool | `false` |  |
| eck-operator.statefulsetAnnotations | object | `{}` |  |
| eck-operator.statefulsetLabels | object | `{}` |  |
| eck-operator.telemetry.disabled | bool | `false` |  |
| eck-operator.telemetry.distributionChannel | string | `"helm"` |  |
| eck-operator.tolerations | list | `[]` |  |
| eck-operator.tracing.config.ELASTIC_APM_SERVER_TIMEOUT | string | `"30s"` |  |
| eck-operator.tracing.config.ELASTIC_APM_SERVER_URL | string | `"http://localhost:8200"` |  |
| eck-operator.tracing.enabled | bool | `false` |  |
| eck-operator.volumeMounts | list | `[]` |  |
| eck-operator.volumes | list | `[]` |  |
| eck-operator.webhook.caBundle | string | `"Cg=="` |  |
| eck-operator.webhook.certManagerCert | string | `nil` |  |
| eck-operator.webhook.certsDir | string | `"/tmp/k8s-webhook-server/serving-certs"` |  |
| eck-operator.webhook.certsSecret | string | `""` |  |
| eck-operator.webhook.enabled | bool | `true` |  |
| eck-operator.webhook.failurePolicy | string | `"Ignore"` |  |
| eck-operator.webhook.manageCerts | bool | `true` |  |
| eck-operator.webhook.namespaceSelector | object | `{}` |  |
| eck-operator.webhook.objectSelector | object | `{}` |  |
| eck-operator.webhook.port | int | `9443` |  |
| existingConfigurationSecrets | string | `nil` |  |
| existingSecret | string | `nil` |  |
| extraDeploy | list | `[]` | Extra objects to deploy (value evaluated as a template) |
| extraEnvVars | list | `[]` | Array with extra environment variables to add |
| extraIngress | list | `[]` |  |
| extraVolumeMounts | list | `[]` | Optionally specify extra list of additional volumeMounts |
| extraVolumes | list | `[]` | Optionally specify extra list of additional volumes |
| fullnameOverride | string | `""` |  |
| global.configuration.enabled | bool | `false` |  |
| global.configuration.secrets | object | `{}` |  |
| global.settings.databaseHost | string | `""` | Global databasehost, overrides setting.database.host |
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
| nginx.config.basicAuth | object | `{"enabled":false,"users":"usernameexample:$apr1$5QwE2Ysc$ycRucgmLt0iQMMxcnu4CA/"}` | Configure nginx basic authentication, only use if you are unable to set it on your ingress controller |
| nginx.config.basicAuth.enabled | bool | `false` | Enables nginx basic password authentication |
| nginx.config.basicAuth.users | string | `"usernameexample:$apr1$5QwE2Ysc$ycRucgmLt0iQMMxcnu4CA/"` | You need to generate the encrypted basic auth password yourself |
| nginx.config.clientMaxBodySize | string | `"10M"` |  |
| nginx.config.proxyConnectTimeoutSeconds | int | `300` |  |
| nginx.config.proxyReadTimeoutSeconds | int | `300` |  |
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
| persistence.mediaMountSubpath | string | `"openinwoner/media"` |  |
| persistence.privateMediaMountSubpath | string | `"openinwoner/private_media"` |  |
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
| redis.image | object | `{"registry":"docker.io","repository":"redis","tag":"8.0"}` | Redis image configuration - Migration from Bitnami to official Redis image           |
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
| settings.allowCustomJs | bool | `false` | Custom JavaScript Configuration Flag to enable the custom JavaScript upload feature in the admin interface. When set to true, this feature allows admins to upload custom JavaScript code that will be loaded on all pages. WARNING: Custom JavaScript can negatively impact security and performance, and should be done with care. NOTE: This variable can only be set to true with openinwoner version 1.35.0 or higher |
| settings.allowedHosts | string | `""` |  |
| settings.brpVersion | string | `""` |  |
| settings.cache.axes | string | `""` | Sets 'CACHE_AXES' var, only required when tags.redis is false |
| settings.cache.default | string | `""` | Sets 'CACHE_DEFAULT' var, only required when tags.redis is false |
| settings.celery.brokerUrl | string | `""` |  |
| settings.celery.logLevel | string | `"debug"` |  |
| settings.celery.resultBackend | string | `""` |  |
| settings.database.host | string | `""` |  |
| settings.database.name | string | `""` |  |
| settings.database.password | string | `""` |  |
| settings.database.port | int | `5432` |  |
| settings.database.sslmode | string | `"prefer"` |  |
| settings.database.username | string | `""` |  |
| settings.debug | bool | `false` |  |
| settings.digidMock | string | `""` |  |
| settings.djangoSettingsModule | string | `"open_inwoner.conf.docker"` |  |
| settings.eherkenningMock | string | `""` |  |
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
| settings.oidcFrontendLogoutWithHints | bool | `true` | Whether to provide a id_token_hint to the IdP broker when initiating a frontchannel logout |
| settings.otel.disabled | bool | `true` |  |
| settings.otel.exporterOtlpEndpoint | string | `""` | Network address where to send the metrics to. Examples are: https://otel.example.com:4318 or http://otel-collector.namespace.cluster.svc:4317. |
| settings.otel.exporterOtlpHeaders | list | `[]` | Any additional HTTP headers, for example if you need Basic auth. This is used in the secret.yaml, as it can contain credentials. |
| settings.otel.exporterOtlpMetricsInsecure | bool | `false` | Is true if the endoint is not protected with TLS. |
| settings.otel.exporterOtlpProtocol | string | `"grpc"` | Controls the wire protocol for the OTLP data. Available options: grpc and http/protobuf. |
| settings.otel.metricExportInterval | int | `60000` | Controls how often (in milliseconds) the metrics are exported. The exports run in a background thread and should not affect the performance of the application. |
| settings.otel.metricExportTimeout | int | `10000` | Controls the timeout of the requests to the collector (in milliseconds) |
| settings.otel.resourceAttributes | list | `[]` | Resources Attributes can be used to specify additional information about the instance. |
| settings.searchIndexInitContainer | bool | `false` |  |
| settings.secretKey | string | `""` | Generate secret key at https://djecrety.ir/ |
| settings.secretKeyFallback | string | `""` | This optional setting can be used to rotate a secret key, by moving a new value into secretKey, and moving the previous secretKey into secretKeyFallback.  |
| settings.sentry.dsn | string | `""` |  |
| settings.smsgateway.apikey | string | `""` |  |
| settings.smsgateway.backend | string | `""` | For example "open_inwoner.accounts.gateways.MessageBird" |
| settings.uwsgi.bufferSize | string | `""` |  |
| settings.uwsgi.harakiri | string | `""` |  |
| settings.uwsgi.httpKeepalive | string | `""` |  |
| settings.uwsgi.httpTimeout | string | `""` |  |
| settings.uwsgi.maxRequests | string | `""` |  |
| settings.uwsgi.port | string | `""` |  |
| settings.uwsgi.postBuffering | string | `""` |  |
| settings.uwsgi.processes | string | `""` |  |
| settings.uwsgi.threads | string | `""` |  |
| settings.zgwMaxRequests | string | `""` | The maximum number of requests allowed for fetching zaken on the Mijn Zaken page. The total number of zaken fetched will be this number multiplied by the page size of the ZGW backend's zaken endpoint. |
| startupProbe.failureThreshold | int | `30` |  |
| startupProbe.initialDelaySeconds | int | `15` | Total time: 15s initial delay + (30 failures × 10s period) = 315s (5 minutes 15 seconds)     |
| startupProbe.periodSeconds | int | `10` |  |
| startupProbe.successThreshold | int | `1` |  |
| startupProbe.timeoutSeconds | int | `5` |  |
| tags.elasticsearch | bool | `true` |  |
| tags.redis | bool | `true` |  |
| tolerations | list | `[]` |  |
| worker.autoscaling.enabled | bool | `false` |  |
| worker.autoscaling.maxReplicas | int | `100` |  |
| worker.autoscaling.minReplicas | int | `1` |  |
| worker.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| worker.autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| worker.concurrency | int | `4` |  |
| worker.livenessProbe.enabled | bool | `false` |  |
| worker.livenessProbe.exec.command[0] | string | `"/bin/sh"` |  |
| worker.livenessProbe.exec.command[1] | string | `"-c"` |  |
| worker.livenessProbe.exec.command[2] | string | `"celery --workdir src --app open_inwoner.celery inspect --destination celery@${HOSTNAME} active"` |  |
| worker.livenessProbe.failureThreshold | int | `3` |  |
| worker.livenessProbe.initialDelaySeconds | int | `60` |  |
| worker.livenessProbe.periodSeconds | int | `50` |  |
| worker.livenessProbe.successThreshold | int | `1` |  |
| worker.livenessProbe.timeoutSeconds | int | `10` |  |
| worker.maxWorkerLivenessDelta | string | `""` |  |
| worker.podLabels | object | `{}` |  |
| worker.replicaCount | int | `2` |  |
| worker.resources | object | `{}` |  |
