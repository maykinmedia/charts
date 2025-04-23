# Changelog

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
