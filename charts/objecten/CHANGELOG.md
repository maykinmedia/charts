# Changelog

## 2.11.1 (2026-02-09)

- Update the Readme.

## 2.11.0 (2025-12-24)

**Warning**

⚠️ This release contains breaking changes.

The library `mozilla-django-oidc-db` has been bumped to 1.1.0, which introduces a new data format. 

The new configuration must be used, as it splits the previous solo model configuration into OIDCProvider and OIDCClient configurations, making it easier to re-use identity provider settings across multiple client IDs.

Refer to the example in the values file or consult the openzaak configuration documentation. 

**Changes**

- Added support for the enivornment variables needed to configure Open Telemetry.
- Updated examples in values.yaml to reflect the expected new OIDC config


## 2.10.0 (2025-10-29)

**Warning**

⚠️ This release contains breaking changes.

The application version was updated to `1.3.1`. This version of the application uses version `0.9.0` of the `django-setup-configuration` library.

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
- Updated application to version 1.3.1.
- Updated job-config to no longer perform the `envsubst` command.
- Updated the yaml configuration example to reflect the use of environment variables.
- Add `OBJECTS_ADMIN_SEARCH_DISABLED` environment variable to disable the search bar in the Objects admin list view (default: false)

## 2.9.0 (2025-08-21)
##### Upgraded 
- Redis Bitnami Helm subchart to version `22.0.1`
- Common Bitnami Helm subchart to version `2.31.4`
##### Changed
- Redis: Migrated from Bitnami to official Redis container image (`8.0`, pinned)

## 2.8.3 (2025-08-05)
- [maykinmedia/objects-api#643] Expose `result_expires` Celery setting via envvar
- Add configurable log level via LOG_LEVEL environment variable (default: INFO)

## 2.8.2 (2025-07-18)
- Adding default values to the 8 env variables for DB POOL 

## 2.8.1 (2025-07-12)
- Added the env variable `SITE_DOMAIN`, which should contain the primary domain where the application is hosted.

## 2.8.0 (2025-05-20)
- Adding 8 env variables for DB POOL related to postgres performance. In addition `db_conn_max_age` and `objecttype_version_cache_timeout` were created as well. Increasing the appVersion to 3.0.4 which is introducing the extra variables.

## 2.7.5 (2025-04-25)
- [#193] Fix missing dependency on bitnami common

## 2.7.4 (2025-03-28)
- Fixed a typo related to configuration-data.yaml file. The double entry of `metadata:` is now removed.

## 2.7.3 (2025-03-12)

- [#197] Increase default `replicaCount` for the worker and the web app. Increase the (commented out) resources requests values for the web app and the worker. Increase the default the resources requests values for redis.

## 2.7.2 (2025-03-12)

- [#195] `DISABLE_2FA` setting was defined twice by mistake in the config map. Now it is present only once.

## 2.7.1 (2025-02-11)

- [#172] Add Horizontal Pod Autoscaler for the worker. Fix the deployment to look for the `.Values.worker.autoscaling.enabled` value instead of the `.Values.autoscaling.enabled` when setting the replicas of the worker.

## 2.7.0 (2025-01-31)


Stable release with support of [django-setup-configuration](https://github.com/maykinmedia/django-setup-configuration). 

- Fixed the configuration-secrets.yaml template to render only if no existing secret is present in the cluster (needed for example if using sealed secrets).
- Removed the env vars `SITES_CONFIG_ENABLE`, `OBJECTS_OBJECTTYPES_TOKEN` and `OBJECTS_DOMAIN` as these settings are now managed with django-setup-configuration.
- Removed the env vars `OBJECTS_ORGANIZATION`, `DEMO_CONFIG_ENABLE`, `DEMO_PERSON`, `DEMO_EMAIL` because they are not used in the application.

## 2.7.0-beta.0 (2025-01-10)

- [#148] Replace the worker liveness probe with the `celery inspect active` command. This should detect when a worker is down and should not interrupt long running tasks.
- [#119] Update the syntax of the worker liveness probe. The worker probes now can be enabled/disabled with:

```yaml
worker:
  livenessProbe:
    enabled: true # true | false
```
