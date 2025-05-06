# Changelog

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
