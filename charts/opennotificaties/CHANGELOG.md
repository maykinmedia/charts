# Changelog


## 1.11.0 (2025-08-26)
##### Upgraded
- RabbitMQ Bitnami Helm subchart: Upgraded from version `11.7.1` to `16.0.12`
  * RabbitMQ Application: Upgraded from version `3.11.8` to `4.1.3`
- Added "dummy" value for rabbitmq.auth.password: To prevent upgrade errors. ( NOTE: If you remove existingPasswordSecret configuration and want to use direct passwords change the password from "dummy" to your actual RabbitMQ password. )
##### Changed
- RabbitMQ Container Image: Pinned to `4.1.3-debian-12-r0` (previously default image `3.11.8-debian-11-r0`)
- RabbitMQ: (Temporary) migrated from the bitnami to the bitnamilegacy container image repository

## 1.10.0 (2025-08-24)
##### Upgraded
- Redis Bitnami Helm subchart to version `22.0.1`
- Common Bitnami Helm subchart to version `2.31.4`
##### Changed
- Redis: Migrated from Bitnami to official Redis container image (`8.0`, pinned)

## 1.9.5 (2025-08-14)

- Add configurable log level via LOG_LEVEL environment variable (default: INFO)

## 1.9.4 (2025-07-24)

- Fixed worker deployment which was using the wrong value to determine if autoscaling is enabled (autoscaling.enabled instead of worker.autoscaling.enabled).

## 1.9.3 (2025-07-18)

- Added default values for the 8 `DB_POOL` env variables

## 1.9.2 (2025-07-10)

- Added the env variable `SITE_DOMAIN`, which should contain the primary domain where the application is hosted.
- Added 8 env variables (`db_pool_min_size`, `db_pool_max_size`, `db_pool_timeout`, `db_pool_max_waiting`, `db_pool_max_lifetime`, `db_pool_max_idle`, `db_pool_reconnect_timeout`, `db_pool_num_workers`) for DB POOL related to postgres performance. In addition `db_conn_max_age` variable created. ( To be used from version 2.11.0 )

## 1.9.1 (2025-07-02)

- Fixed env variable name `PUBLISH_BROKER_URL` in secrets.yaml

## 1.9.0 (2025-05-08)

- [open-zaak/open-notificaties#240] Expose `result_expires` Celery setting via envvar

## 1.8.4 (2025-05-14)

- Fixed missing environment variable `NOTIFICATION_REQUESTS_TIMEOUT`.

## 1.8.3 (2025-04-25)
- [#193] Fix missing dependency on bitnami common

## 1.8.2 (2025-03-28)

- Fixed a typo related to configuration-data.yaml file. The double entry for `metadata:` is now removed.

## 1.8.1 (2025-03-12)

- [#197] Increase default `replicaCount` for the web app. Increase the (commented out) resources requests values for the web app, the worker and celery beat. Increase the default the resources requests values for redis and rabbitmq.

## 1.8.0 (2025-02-05)

Stable release with support of [django-setup-configuration](https://github.com/maykinmedia/django-setup-configuration). 

- Fixed the configuration-secrets.yaml template to render only if no existing secret is present in the cluster (needed for example if using sealed secrets).
- Added the possibility to add/use a secret with a custom name for the django-setup-configuration job.
- Removed these env vars from the secret, as they are no longer used: `NOTIF_OPENZAAK_SECRET`, `OPENZAAK_NOTIF_SECRET` as these settings are now managed with django-setup-configuration.
- Removed these env vars from the config map, as they are no longer used: `DEMO_CONFIG_ENABLE`, `SITES_CONFIG_ENABLE`, `OPENNOTIFICATIES_DOMAIN`, `OPENNOTIFICATIES_ORGANIZATION`, `AUTHORIZATION_CONFIG_ENABLE`, `AUTORISATIES_API_ROOT`, `NOTIF_OPENZAAK_CLIENT_ID`, `OPENZAAK_NOTIF_CONFIG_ENABLE`, `OPENZAAK_NOTIF_CLIENT_ID` as these settings are now managed with django-setup-configuration.

## 1.8.0-beta.1 (2025-01-23)

- [#170] Add autoscaling behavior for ON

## 1.8.0-beta.0 (2025-01-22)

- [#169] Add pdb for worker

## 1.7.0-beta.0 (2025-01-10)

- [#148] Replace the worker liveness probe with the `celery inspect active` command. This should detect when a worker is down and should not interrupt long running tasks.
- [#119] Update the syntax of the worker liveness probe. The worker probes now can be enabled/disabled with:

```yaml
worker:
  livenessProbe:
    enabled: true # true | false
```
