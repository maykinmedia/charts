# Changelog

## 1.10.0 (2025-12-24)

- Added support for the enivornment variables needed to configure Open Telemetry.

## 1.9.0 (2025-10-29)

**Warning**

⚠️ This release contains breaking changes.

The application version was updated to `2.13.0`. This version of the application uses version `0.9.0` of the `django-setup-configuration` library.

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
- Updated application to version 2.13.0.
- Updated job-config to no longer perform the `envsubst` command.
- Updated the yaml configuration example to reflect the use of environment variables.

## 1.8.2 (2025-09-30)

### Configuration Updates
- **OIDC Configuration**: Updated example setup configuration YAML file to use modern `mozilla-django-oidc-db` v0.25.1 format
  - Migrated deprecated fields to new `options` structure
  - Added proper provider/client separation
  - Improved claim mappings and group settings configuration
- **Compatibility**: Requires OpenKlant version > 2.12.0
### Version Information
- **App Version**: 2.12.0 (upgraded from previous version 2.7.0)


### Breaking Changes
- OIDC configuration format has changed - existing configurations need to be updated to the new structure
- See migration guide for details on updating your OIDC setup

## 1.8.1 (2025-09-11)
- [#284] Fix hardcoded worker `replicas` -> now using `worker.replicaCount` variable
- Fix worker replica autoscaling: now properly respects `worker.autoscaling.enabled` setting
- Add missing HPA (Horizontal Pod Autoscaler) template for worker autoscaling 

## 1.8.0 (2025-08-24)
##### Upgraded 
- Redis Bitnami Helm subchart to version `22.0.1`
- Common Bitnami Helm subchart to version `2.31.4`
##### Changed
- Redis: Migrated from Bitnami to official Redis container image (`8.0`, pinned)

## 1.7.1 (2025-07-23)
- Added default values for the 8 `DB_POOL` env variables

## 1.7.0 (2025-05-16)
- Upgrade to Openklant version 2.7.0
- Adding env variable siteDomain defines primary domain of Openklant
- Adding 8 env variables for DB POOL related to postgres performance. In addition db_conn_max_age variable created. ( To be used from openklant version 2.10.0 )

## 1.6.7 (2025-06-11)
- Add extra volumes and volumemounts for nginx so it can be deployed with readOnlyRootFilesystem: true

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
