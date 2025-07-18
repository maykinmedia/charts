# Changelog

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
