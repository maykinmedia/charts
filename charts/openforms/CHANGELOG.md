# Changelog

## 1.8.5 (2025-06-11)

- Add extra volumes and volumemounts for nginx so it can be deployed with readOnlyRootFilesystem: true

## 1.8.4 (2025-04-25)
- [#193] Fix missing dependency on bitnami common

## 1.8.3 (2025-04-08)

- Adding TLS secret to the helm template files. To be used with plain text certificates and when private web certificate is required as opposed to let's encrypt one for example.

## 1.8.2 (2025-03-28)

- Fixed a typo related to configuration-data.yaml file. The double entry for `metadata:` is now removed.

## 1.8.1 (2025-03-12)

- [#197] Increase default `replicaCount` for the web app. Increase the (commented out) resources requests values for the web app, the worker and celery beat. Increase the default the resources requests values for redis.

## 1.8.0 (2025-01-29)

Stable release with support of [django-setup-configuration](https://github.com/maykinmedia/django-setup-configuration). 

- Fixed the configuration-secrets.yaml template to render only if no existing secret is present in the cluster (needed for example if using sealed secrets).

## 1.8.0-beta.0 (2025-01-10)

- [#148] Replace the worker liveness probe with the `celery inspect active` command. This should detect when a worker is down and should not interrupt long running tasks.
- [#119] Update the syntax of the worker liveness probe. The worker probes now can be enabled/disabled with:

```yaml
worker:
  livenessProbe:
    enabled: true # true | false
```
