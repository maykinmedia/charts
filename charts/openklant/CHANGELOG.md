# Changelog

## 1.7.0 (2025-05-16)
- Upgrade to Openklant version 2.7.0
- Adding env variable siteDomain defines primary domain of Openklant
- Adding 8 env variables for DB POOL related to postgres performance. In addition db_conn_max_age variable created. ( To be used from openklant version 2.10.0 )

## 1.6.6 (2025-05-16)
- Fix missing env variable USE_X_FORWARDED_HOST from web container

## 1.6.5 (2025-04-25)
- [#193] Fix missing dependency on bitnami common

## 1.6.4 (2025-04-24)

- Allow image tag override
- Changed default pullPolicy to `IfNotPresent`

## 1.6.3 (2025-03-31)

- [#201] Adding "extra deploy" possibility to deploy additional resources like config maps, deployments, etc. The variable `extraDeploy` is added to take the configuration.

## 1.6.2 (2025-03-28)

- Fixed a typo related to configuration-data.yaml file. The double entry for `metadata:` is now removed.

## 1.6.1 (2025-03-12)

- [#197] Increase default `replicaCount` for the worker and the web app. Increase the (commented out) resources requests values for the web app and the worker. Increase the default the resources requests values for redis.

## 1.6.0 (2025-02-12)

- [maykinmedia/open-klant#299] Added nginx to OpenKlant helm chart

## 1.5.0 (2025-02-05)

Stable release with support of [django-setup-configuration](https://github.com/maykinmedia/django-setup-configuration). 

- Fixed the configuration-secrets.yaml template to render only if no existing secret is present in the cluster (needed for example if using sealed secrets).
- Added the possibility to add/use a secret with a custom name for the django-setup-configuration job.

## 1.5.0-beta.0 (2025-01-10)

- [#148] Replace the worker liveness probe with the `celery inspect active` command. This should detect when a worker is down and should not interrupt long running tasks.
- [#119] Update the syntax of the worker liveness probe. The worker probes now can be enabled/disabled with:

```yaml
worker:
  livenessProbe:
    enabled: true # true | false
```
