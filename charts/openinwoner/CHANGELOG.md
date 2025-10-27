# Changelog

## 1.11.3 (2025-10-27)
- [#287] Add `ALLOW_CUSTOM_JS` environment variable to enable/disable custom JavaScript upload feature (default: "False")
  - **Note**: This variable can only be used with Openinwoner version 1.35.0 or higher

## 1.11.0 (2025-09-10)

**Warning**

⚠️ This release contains breaking changes.

The application version was updated to `1.34`. This version of the application uses version `0.9.0` of the `django-setup-configuration` library.

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

- Updated application to version 1.34.
- Updated job-config to no longer perform the `envsubst` command.
- Updated the yaml configuration example to reflect the use of environment variables.

## 1.10.1 (2025-09-08)
- Fix Elasticsearch host configuration syntax for env variable `ES_HOST` environment variable by using Elasticsearch subchart variables for protocol and port configuration
- Subchart variables (`elasticsearch.service.ports.restAPI` and `elasticsearch.security.tls.restEncryption`) for protocol and port configuration

## 1.10.0 (2025-08-26)
- Pinned Elasticsearch image to 9.0.3-debian-12-r1

## 1.9.0 (2025-08-25)

### Upgraded
- Bitnami Elasticsearch Helm subchart to version `22.1.5`

### Changed
- Elasticsearch: (Temporary) migrated from the `bitnami` to the `bitnamilegacy` container image repository  

## 1.8.0 (2025-08-22)
##### Upgraded 
- Redis Bitnami Helm subchart to version `22.0.1`
- Common Bitnami Helm subchart to version `2.31.4`
##### Changed
- Redis: Migrated from Bitnami to official Redis container image (`8.0`) [pinned] 

## 1.7.6 (2025-07-24)
- Fixed worker deployment which was using the wrong value to determine if autoscaling is enabled (autoscaling.enabled instead of worker.autoscaling.enabled).
- Adding the HPA for worker deployment, (it was missing so far)

## 1.7.5 (2025-07-11)
- Adding/setting extra variables `proxyConnectTimeoutSeconds` and `proxyReadTimeoutSeconds` for nginx in configmap-nginx ; default to 300
- Adding new optional secret `SECRET_KEY_FALLBACK` for rotating a secret key

## 1.7.4 (2025-06-11)
- Add extra volumes and volumemounts for nginx so it can be deployed with readOnlyRootFilesystem: true

## 1.7.3 (2025-04-25)
- [#193] Fix missing dependency on bitnami common

## 1.7.2 (2025-03-28)

- Fixed a typo related to configuration-data.yaml file. The double entry for `metadata:` is now removed.

## 1.7.1 (2025-03-12)

- [#197] Increase default `replicaCount` for the worker. Increase the (commented out) resources requests values for the web app, the worker, celery beat, celery monitor, nginx. Increase the default the resources requests values for redis, elasticsearch master and elasticsearch data.

## 1.7.0 (2025-02-11)

Stable release with support of [django-setup-configuration](https://github.com/maykinmedia/django-setup-configuration). 

- Fixed the configuration-secrets.yaml template to render only if no existing secret is present in the cluster (needed for example if using sealed secrets).

## 1.7.0-beta.1 (2025-02-05)

- Bring uWSGI settings into sync with available options for the upcoming `v1.27` release
  of OIP.

## 1.7.0-beta.0 (2025-01-10)

- [#148] Replace the worker liveness probe with the `celery inspect active` command. This should detect when a worker is down and should not interrupt long running tasks.
- [#119] Update the syntax of the worker liveness probe. The worker probes now can be enabled/disabled with:

```yaml
worker:
  livenessProbe:
    enabled: true # true | false
```
