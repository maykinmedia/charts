# Changelog

## 1.5.0 (2025-10-29)

**Warning**

⚠️ This release contains breaking changes.

The application version was updated to `3.3.0`. This version of the application uses version `0.9.0` of the `django-setup-configuration` library.

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
- Updated application to version 3.3.0.
- Updated job-config to no longer perform the `envsubst` command.
- Updated the yaml configuration example to reflect the use of environment variables.
- Add 8 environment variables (`DB_POOL_MIN_SIZE`, `DB_POOL_MAX_SIZE`, `DB_POOL_TIMEOUT`, `DB_POOL_MAX_WAITING`, `DB_POOL_MAX_LIFETIME`, `DB_POOL_MAX_IDLE`, `DB_POOL_RECONNECT_TIMEOUT`, `DB_POOL_NUM_WORKERS`) for database connection pooling settings. 
- Added `DB_CONN_MAX_AGE` environment variable.


## 1.4.0 (2025-08-24)
##### Upgraded 
- Redis Bitnami Helm subchart to version `22.0.1`
- Common Bitnami Helm subchart to version `2.31.4`
##### Changed
- Redis: Migrated from Bitnami to official Redis container image (`8.0`, pinned)

## 1.3.3 (2025-04-25)
- [#193] Fix missing dependency on bitnami common

## 1.3.2 (2025-03-28)

- Fixed a typo related to configuration-data.yaml file. The double entry for `metadata:` is now removed.

## 1.3.1 (2025-03-12)

- [#197] Increase default `replicaCount` for the web app. Increase the (commented out) resources requests values for the web app. Increase the default the resources requests values for redis.

## 1.3.0 (2025-01-31)

Stable release with support of [django-setup-configuration](https://github.com/maykinmedia/django-setup-configuration). 

- Fixed the configuration-secrets.yaml template to render only if no existing secret is present in the cluster (needed for example if using sealed secrets).
- Added the possibility to add/use a secret with a custom name for the django-setup-configuration job.
- Removed these environment variables: `SITES_CONFIG_ENABLE`, `OBJECTTYPES_DOMAIN`, `OBJECTTYPES_ORGANIZATION`, `DEMO_CONFIG_ENABLE`, `DEMO_PERSON`, `DEMO_EMAIL`. These are no longer used in the application.
