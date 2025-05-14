# Changelog

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
