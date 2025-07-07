# Changelog

## 1.8.4 (2025-07-07)

- Adding extra env variable `zaakIdentificatieGenerator` with 2 possible values: *use-start-datum-year*, *use-creation-year* 

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
