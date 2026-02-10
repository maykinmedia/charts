# Changelog

## 2.0.0 (2026-02-09)

**Warning**

⚠️ This release contains breaking changes.

The application version was updated to `2.0.0`. This involves:

- An upgrade of the `django-setup-configuration` library to version `0.11.0`. This version of `django-setup-configuration` removes the need to use `envsubst` to inject secrets into the yaml file used to configure the application. It supports extracting secrets directly from environment variables.
- An upgrade of the `mozilla-django-oidc-db` library to version `1.1.1`. This version of `mozilla-django-oidc-db` changed the database schema, so the format of the yaml used to configure it has changed.

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
For the upgrade of the yaml used to configure the OIDC login, look at the `values.yaml` file for the updated structure.

**Complete list of changes**

- Added environment variables `POST_DESTRUCTION_VISIBILITY_PERIOD` and `FEATURE_RELATED_COUNT_DISABLED`.
- [#188] Removed the unused init containers for  `django-setup-configuration`.
- Upgraded libraries in the application:

   - Upgrade of `django-setup-configuration` to version `0.11.0`. 
   - Upgrade of `mozilla-django-oidc-db` to version `1.1.1`.

- Added a README template.
- Removed chart dependency on `maykin-utils-lib`
- Fixed bug preventing us from setting `WAITING_PERIOD` to `0`. Now the chart sets it to `7` by default in the same way as the app.
- Updated the nginx configuration to avoid overriding the CSP headers set by the backend.
- Added environment variables to configure OTEL capabilities. See the [Open Archiefbeheer docs](https://open-archiefbeheer.readthedocs.io/en/latest/devops/otel.html) for more details.


## 1.5.3 (2025-12-08)

- Fixed missing `X-Frame-Options` and `Content-Security-Policy` headers in response for static files.

## 1.5.1 (2025-10-29)

- Add `existingConfigurationSecrets` setting to reference an existing secret with the values needed for `django-setup-configuration`.

## 1.5.0 (2025-10-03)

- [maykinmedia/open-archiefbeheer#857] Added the possibility to configure the environment variables `LOG_STDOUT` and `LOG_LEVEL`. These variables are available from Open Archiefbeheer version `1.1.1`.

## 1.4.1 (2025-10-01)

- Add OIDC token renewal and session cookie age configuration options:
  - `settings.oidcRenewIdTokenExpirySeconds`: Configure OIDC ID token renewal expiry time in seconds (defaults to 15 minutes = 900 seconds)
  - `settings.sessionCookieAge`: Configure session cookie age in seconds (defaults to 15 minutes = 900 seconds)

## 1.4.0 (2025-08-24)

- Upgraded Redis Bitnami Helm subchart to version `22.0.1`.
- Upgraded common Bitnami Helm subchart to version `2.31.4`.
- Migrated Redis image from Bitnami to official Redis container image (pinned to version `8.0`).

## 1.3.11 (2025-06-11)

- Add extra volumes and volumemounts for nginx so it can be deployed with readOnlyRootFilesystem: true

## 1.3.10 (2025-05-22)

- Change the default nginx port number to 80 in values.yaml. (To be in line with the rest of Maykin apps)

## 1.3.9 (2025-05-14)

- [#222] Remove unused environment variables `TWO_FACTOR_FORCE_OTP_ADMIN` and `TWO_FACTOR_PATCH_ADMIN` since these are not used by the application. The values `settings.twoFactorAuthentication.forceOtpAdmin` and `settings.twoFactorAuthentication.patchAdmin` have also been removed.

## 1.3.8 (2025-04-23)

- [#210] Fix app version to 1.0.0

## 1.3.7 (2025-04-14)

- Align volumeMount name for initContainer with the configured Volumes
- Add oidc path to nginx proxy configuration

## 1.3.6 (2025-04-01)

- Make it possible to configure the separate cache for the internal endpoints that return all the possible type objects (resultaattypen, informatieobjecttypen, selectielijstklasse, behandelend afdeling).

## 1.3.5 (2025-03-28)

- [#193] Fix missing dependency on bitnami common

## 1.3.4 (2025-03-28)

- Fixed a typo related to configuration-data.yaml file. The double entry for `metadata:` is now removed.

## 1.3.3 (2025-03-14)

- [maykinmedia/open-archiefbeheer#738] Replaced environment variables:

   - `REACT_APP_API_URL`  => `OAB_API_URL`
   - `REACT_APP_API_PATH` => `OAB_API_PATH`
   - `REACT_APP_ZAAK_URL_TEMPLATE` => `OAB_ZAAK_URL_TEMPLATE`

   The values are also renamed from `settings.react.*` to `settings.frontend.*`.

## 1.3.2 (2025-02-21)

- [#191] Fix missing support for environment variable `WAITING_PERIOD`.

## 1.3.1 (2025-02-19)

- [#189] Fix duplicate environment variables in config map.

## 1.3.0 (2025-01-27)

- Add settings for request retry. This should help reduce the failures when resyncing zaken with openzaak.

## 1.2.0 (2025-01-22)

- [#165] Add possibility to use custom celery queue and worker names when using the worker liveness probe.
- Add the maykin-util-lib dependency.


## 1.1.1-beta.0 (2025-10-01)

- [#148] Add worker liveness probe command `celery inspect active`. This should detect when a worker is down and should not interrupt long running tasks.
- Fix missing init container to run Django setup configuration.
