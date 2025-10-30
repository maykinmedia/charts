# Changelog

## 1.12.0 (2025-10-28)

**Warning**

⚠️ This release contains breaking changes.

The application version was updated to `1.25.0`. This version of the application uses version `0.9.0` of the `django-setup-configuration` library.

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
- Updated application to version 1.25.0.
- Updated job-config to no longer perform the `envsubst` command.
- Updated the yaml configuration example to reflect the use of environment variables.

## 1.11.2 (2025-10-28)
- Removed initContainer as an option for running the setup configuration

## 1.11.1 (2025-10-28)
- Add startup probe to improve deployment reliability
  - Add startup probe with 5+ minute timeout for application initialization
  - Configuration: 15s initial delay + 30 failures × 10s period = 5 minutes 15 seconds total
  - Prevents premature pod restarts during complex startup scenarios (database migrations, static file collection)
- Updated health check probes to use `/admin/` endpoint instead of `/` for better application readiness detection  

## 1.11.0 (2025-08-08)

- [open-zaak/open-zaak#2132] Expose `result_expires` Celery setting via environment variable `CELERY_RESULT_EXPIRES`.
- Add TIME_LEEWAY environment variable for JWT validation time tolerance (replaces deprecated JWT_LEEWAY) (default: nil)
- Add DB_DISABLE_SERVER_SIDE_CURSORS environment variable to prevent cursor-related errors (default: false)
- Add 8 environment variables (`DB_POOL_MIN_SIZE`, `DB_POOL_MAX_SIZE`, `DB_POOL_TIMEOUT`, `DB_POOL_MAX_WAITING`, `DB_POOL_MAX_LIFETIME`, `DB_POOL_MAX_IDLE`, `DB_POOL_RECONNECT_TIMEOUT`, `DB_POOL_NUM_WORKERS`) for database connection pooling settings. 
- Added `DB_CONN_MAX_AGE` environment variable.

## 1.10.1 (2025-08-28)
- **Nginx** configmap extra variables added. A general configuration `config.clientMaxBodySize` (defaults to 4G)
- Hard coded nginx config values were made to be variables: `proxyConnectTimeoutSeconds` and `proxyReadTimeoutSeconds` (both default to 300 sec).
- Removing individual endpoints for nginx config locations, namely `/documenten/api/v1/enkelvoudiginformatieobjecten` and `/documenten/api/v1/bestandsdelen`.

## 1.10.0 (2025-08-23)
##### Upgraded 
- Redis Bitnami Helm subchart to version `22.0.1`
- Common Bitnami Helm subchart to version `2.31.4`
##### Changed
- Redis: Migrated from Bitnami to official Redis container image (`8.0`) [pinned] 

## 1.9.0 (2025-07-09)

- Upgrade the chart version with respect to Openzaak version 1.21.2 

## 1.8.4 (2025-07-09)

- Adding extra env variable `zaakIdentificatieGenerator` with 2 possible values: *use-start-datum-year*, *use-creation-year* 
- Adding env variable `siteDomain` defines primary domain of Openzaak

## 1.8.3 (2025-06-11)

- Add extra volumes and volumemounts for nginx so it can be deployed with readOnlyRootFilesystem: true

## 1.8.2 (2025-04-25)
- [#193] Fix missing dependency on bitnami common

## 1.8.1 (2025-03-12)

- [#197] Increase default `replicaCount` for the worker and the web app. Increase the (commented out) resources requests values for the web app, the worker, nginx and celery beat. Increase the default the resources requests values for redis.

## 1.8.0 (2025-02-17)

Stable release with support of [django-setup-configuration](https://github.com/maykinmedia/django-setup-configuration). 

- Fixed the configuration-secrets.yaml template to render only if no existing secret is present in the cluster (needed for example if using sealed secrets).
- Removed support for the following environment variables: `SITES_CONFIG_ENABLE`, `OPENZAAK_DOMAIN`, `OPENZAAK_ORGANIZATION`, `NOTIF_OPENZAAK_CONFIG_ENABLE`, `NOTIF_OPENZAAK_CLIENT_ID`, `OPENZAAK_NOTIF_CONFIG_ENABLE`, `NOTIF_API_ROOT`, `OPENZAAK_NOTIF_CLIENT_ID`, `OPENZAAK_SELECTIELIJST_CONFIG_ENAB`, `SELECTIELIJST_API_ROOT`, `SELECTIELIJST_API_OAS`, `SELECTIELIJST_ALLOWED_YEARS`, `SELECTIELIJST_DEFAULT_YEAR`. The settings that used to be configured with these variables can now be configured via django setup configuration.
- Removed variable `DEMO_CONFIG_ENABLE` because it is not supported by the application.

## 1.8.0-beta.0 (2025-01-28)

- [#172] Add Horizontal Pod Autoscaler for nginx. Fix the deployment to look for the `.Values.worker.autoscaling.enabled` value instead of the `.Values.autoscaling.enabled` when setting the replicas of the worker.


## 1.7.0-beta.0 (2025-01-10)

- [#148] Replace the worker liveness probe with the `celery inspect active` command. This should detect when a worker is down and should not interrupt long running tasks.
- [#119] Update the syntax of the worker liveness probe. The worker probes now can be enabled/disabled with:

```yaml
worker:
  livenessProbe:
    enabled: true # true | false
```
