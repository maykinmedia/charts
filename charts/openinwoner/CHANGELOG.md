# Changelog

## 2.7.0 (2026-11-03)

**Warning**

⚠️ This release contains breaking changes.

The application version was updated to `2.5.0`. This version of the application
removes the setup configuration through environment variables: `setup_configuration`
only accepts the YAML format, and environment variables such as those starting with
`KIC_`, `ADMIN_OIDC_`, `DIGID_OIDC_`, `DIGID_SAML_`, `EHERKENNING_OIDC_`,
`EHERKENNING_SAML_`, `CMS_`, `SITE_` (except `SITE_ID`) and most `ZGW_` variables
are ignored. See the
[Open Inwoner changelog](https://github.com/maykinmedia/open-inwoner/blob/v2.5.0/CHANGELOG.rst)
for the full list.

---

**Upgrade procedure**

If any of the removed environment variables are set, for example through
`extraEnvVars` or `existingSecret`, move that configuration to the `configuration.data`
value in the YAML format. See the
[setup configuration documentation](https://docs.openinwoner.nl/en/v2.5.0/configuration/01_setup_config.html)
for the available steps and fields.

The application has a new, unauthenticated endpoint `/api/reporting-api/` that
receives reports sent by browsers. The bundled nginx exposes it with a rate limit
(see `nginx.config.reportingApiRateLimit`). If requests reach the application through
another reverse proxy or ingress, we recommend rate limiting the endpoint there as
well. Behind an ingress controller, the default key `$binary_remote_addr` of the
bundled nginx is the address of the controller, so the limit applies to all clients
together.

The primary key of the `NotificationRecord` table is converted to a UUID, which
updates every row individually. This only affects installations that use ZGW
notifications. Migrations run when the web container starts (or in the
`search-index` init container, if `settings.searchIndexInitContainer` is enabled),
so on a large table the default `livenessProbe` may restart the pod before the
migration has finished. Before upgrading, check the number of rows:

```sql
SELECT COUNT(*) FROM notifications_notificationrecord;
```

If it is large, prune the table first with
`python src/manage.py prune_notification_records`, or temporarily increase
`livenessProbe.initialDelaySeconds` and the timeout of `helm upgrade --wait`.

During the upgrade, data migrations remove links and images with an unsupported URL
scheme from rich text entered by administrators, and log a warning for every removal.
Keep the logs of the first startup of the web container (or the `search-index` init
container), so the administrators can check and restore the affected content.

We recommend enabling the celery beat liveness probe (`beat.livenessProbe.enabled`).
Open Inwoner 2.5 schedules a task every minute, so the probe reliably reflects
whether beat is still scheduling tasks.

**Changes**

- Bumped the app version to `2.5.0`.
- Added `settings.enableInteractiveChecks` (default: `false`), which sets
  `ENABLE_INTERACTIVE_CHECKS`. Required to use the interactive configuration
  checks in the admin.
- Added `settings.showLabelEnvironment` (default: `false`),
  `settings.environmentLabelName`, `settings.environmentLabelBackgroundColor` and
  `settings.environmentLabelForegroundColor` for the environment label in the
  admin, which set `SHOW_ENVIRONMENT`, `ENVIRONMENT_LABEL`,
  `ENVIRONMENT_BACKGROUND_COLOR` and `ENVIRONMENT_FOREGROUND_COLOR`.
- Added `settings.customProduct` (`name`, `url`, `logoPath`, `logoUrl`) for custom
  product branding in the admin, which set `CUSTOM_PRODUCT_NAME`,
  `CUSTOM_PRODUCT_URL`, `CUSTOM_PRODUCT_LOGO_PATH` and `CUSTOM_PRODUCT_LOGO_URL`.
- Added `settings.cspReportOnly` and `settings.permissionsPolicyReportOnly`
  (default: `false`), which set `CSP_REPORT_ONLY` and
  `PERMISSIONS_POLICY_REPORT_ONLY`.
- Added `settings.reportingApi` (`enabled`, `maxReportsPerRequest`,
  `loggingEnabled`, `maxLoggedViolationsPerRequest`, `metricsEnabled`) for the
  endpoint that receives reports from browsers, which set
  `REPORTING_API_ENABLED`, `REPORTING_API_MAX_REPORTS_PER_REQUEST`,
  `REPORTING_API_LOGGING_ENABLED`,
  `REPORTING_API_MAX_LOGGED_VIOLATIONS_PER_REQUEST` and
  `REPORTING_API_METRICS_ENABLED`.
- The bundled nginx exposes the `/api/reporting-api/` endpoint with a rate limit,
  configurable through `nginx.config.reportingApiRateLimit` (default: enabled,
  10 requests per minute with a burst of 10, 64k maximum body size).
- Added `settings.cache.notificationThrottle` (`backend`, `location`,
  `clientClass`, `ignoreExceptions`) for an optional separate cache to rate
  limit notifications sent on behalf of users, which set
  `CACHE_NOTIFICATION_THROTTLE_BACKEND`, `CACHE_NOTIFICATION_THROTTLE_LOCATION`,
  `CACHE_NOTIFICATION_THROTTLE_CLIENT_CLASS` and
  `CACHE_NOTIFICATION_THROTTLE_IGNORE_EXCEPTIONS`. By default the default cache
  is used, so no action is required.
- Added an optional liveness probe for celery beat (`beat.livenessProbe`, default:
  disabled) using `maykin-common beat-health-check`.
- Updated the example setup configuration in `values.yaml` to the
  `klantensysteem_config` step and to file extensions without a leading dot.
  Open Inwoner 2.5 only supports setup configuration through YAML.

## 2.6.0 (2026-08-24)

- Add Helm hooks to ensure the `job-config` runs at the correct stage of the release lifecycle.

## 2.5.0 (2026-08-11)

- Bumped the app version to `2.4.3`.

## 2.4.0 (2026-08-10)

- Bumped the app version to `2.4.2`.

## 2.3.0 (2026-07-21)

- Bumped the app version to `2.4.0`.
- Added `OIDC_USE_LEGACY_ENDPOINTS` setting for DigiD/eHerkenning/eIDAS
- Removed `CACHE_ZGW_ZAKEN_TIMEOUT` environment variable.
- Updated celery liveness probes to use maykin-common health checks

## 2.2.1 (2026-06-10)

- Bumped the app version to `2.3.1`.

## 2.2.0 (2026-05-29)

- Bumped the app version to `2.3.0`.
- Added `settings.cms4MigrationInitContainer` (default: `true`) - an init container that runs
  `python /app/src/manage.py cms4_migration`. Enabled by default to ensure the migration runs
  on the initial rollout to 2.3.0. Once it has completed successfully it can be set to `false`
  to prevent it from re-running on every pod restart.
- Added `lowLatencyWorker` - a dedicated Celery worker for the `low-latency` queue
  (concurrency 8), keeping the default worker unchanged.
- Exposed `settings.zgwApisCacheDuration` to configure the ZGW cache timeout.
- Configured the `low-latency` queue for cache seeding tasks via `settings.cacheSeederQueue`.

## 2.1.1 (2026-02-06)

- Fixed typo in the readme.

## 2.1.0 (2026-01-06)

- Bumped the app version to `2.0.0`.

## 2.0.0 (2025-12-10)

**Warning**

⚠️ This chart release contains breaking changes.

- [#328] Replaced Bitnami Elastic chart with [ECK](https://www.elastic.co/docs/deploy-manage/deploy/cloud-on-k8s). See the Readme for instructions on how to install ECK in the cluster.
- Fixed typo in value `settings.searchInexInitContainer` which is now `settings.searchIndexInitContainer`.


## 1.12.0 (2025-11-25)
- [#329] Add `OIDC_FRONTEND_LOGOUT_WITH_HINTS` environment variable to enable/disable
  passing of hints to the OIDC frontchannel logout (default: "True")
- Bumped minimal `appVersion` to `1.35.3`

## 1.11.3 (2025-10-27)
- [#287] Add `ALLOW_CUSTOM_JS` environment variable to enable/disable custom JavaScript upload feature (default: "False")
  - **Note**: This variable can only be used with Openinwoner version 1.35.0 or higher
  
## 1.11.2 (2025-09-13)
- [#300] Add startup probe to improve deployment reliability
  - Add startup probe with 5+ minute timeout for application initialization
  - Configuration: 15s initial delay + 30 failures × 10s period = 5 minutes 15 seconds total
  - Prevents premature pod restarts during complex startup scenarios (database migrations, static file collection)

## 1.11.1 (2025-10-13)
- [#302] Fix health check probes to use non-redirecting endpoints
  - Update liveness and readiness probe paths from `/admin/` to `/admin/login/`

## 1.11.0 (2025-09-10)

**Warning**

⚠️ This release contains breaking changes.

The application version was updated to `1.34`. This version of the application uses version `0.9.0` of the `django-setup-configuration` library.

This version of `django-setup-configuration` removes the need to use `envsubst` to inject secrets into the yaml file used to 
configure the application. It supports extracting secrets directly from environment variables.

---

**Upgrade procedure**

In the `configuration.data` value, any value using the `envsubst` syntax `${...}`, for example:

```yaml
oidc_rp_client_secret: ${keycloak_client_secret}
```

should be changed to:

```yaml
oidc_rp_client_secret:
  value_from:
    env: KEYCLOAK_CLIENT_SECRET
```

Note: It is still possible to specify values directly. 

**Changes**

- Updated application to version 1.34.
- Updated job-config to no longer perform the `envsubst` command.
- Updated the yaml configuration example to reflect the use of environment variables.

## 1.10.1 (2025-09-08)
- Fix Elasticsearch host configuration syntax for env variable `ES_HOST` environment variable by using Elasticsearch subchart variables for protocol and port configuration
- Subchart variables (`elasticsearch.service.ports.restAPI` and `elasticsearch.security.tls.restEncryption`) for protocol and port configuration

## 1.10.0 (2025-08-26)
- Pinned Elasticsearch image to 9.0.3-debian-12-r1

## 1.9.0 (2025-08-25)

### Upgraded
- Bitnami Elasticsearch Helm subchart to version `22.1.5`

### Changed
- Elasticsearch: (Temporary) migrated from the `bitnami` to the `bitnamilegacy` container image repository  

## 1.8.0 (2025-08-22)
##### Upgraded 
- Redis Bitnami Helm subchart to version `22.0.1`
- Common Bitnami Helm subchart to version `2.31.4`
##### Changed
- Redis: Migrated from Bitnami to official Redis container image (`8.0`) [pinned] 

## 1.7.6 (2025-07-24)
- Fixed worker deployment which was using the wrong value to determine if autoscaling is enabled (autoscaling.enabled instead of worker.autoscaling.enabled).
- Adding the HPA for worker deployment, (it was missing so far)

## 1.7.5 (2025-07-11)
- Adding/setting extra variables `proxyConnectTimeoutSeconds` and `proxyReadTimeoutSeconds` for nginx in configmap-nginx ; default to 300
- Adding new optional secret `SECRET_KEY_FALLBACK` for rotating a secret key

## 1.7.4 (2025-06-11)
- Add extra volumes and volumemounts for nginx so it can be deployed with readOnlyRootFilesystem: true

## 1.7.3 (2025-04-25)
- [#193] Fix missing dependency on bitnami common

## 1.7.2 (2025-03-28)

- Fixed a typo related to configuration-data.yaml file. The double entry for `metadata:` is now removed.

## 1.7.1 (2025-03-12)

- [#197] Increase default `replicaCount` for the worker. Increase the (commented out) resources requests values for the web app, the worker, celery beat, celery monitor, nginx. Increase the default the resources requests values for redis, elasticsearch master and elasticsearch data.

## 1.7.0 (2025-02-11)

Stable release with support of [django-setup-configuration](https://github.com/maykinmedia/django-setup-configuration). 

- Fixed the configuration-secrets.yaml template to render only if no existing secret is present in the cluster (needed for example if using sealed secrets).

## 1.7.0-beta.1 (2025-02-05)

- Bring uWSGI settings into sync with available options for the upcoming `v1.27` release
  of OIP.

## 1.7.0-beta.0 (2025-01-10)

- [#148] Replace the worker liveness probe with the `celery inspect active` command. This should detect when a worker is down and should not interrupt long running tasks.
- [#119] Update the syntax of the worker liveness probe. The worker probes now can be enabled/disabled with:

```yaml
worker:
  livenessProbe:
    enabled: true # true | false
```
