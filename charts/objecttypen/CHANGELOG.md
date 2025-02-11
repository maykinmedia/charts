# Changelog

## 1.3.0 (2025-01-31)

Stable release with support of [django-setup-configuration](https://github.com/maykinmedia/django-setup-configuration). 

- Fixed the configuration-secrets.yaml template to render only if no existing secret is present in the cluster (needed for example if using sealed secrets).
- Added the possibility to add/use a secret with a custom name for the django-setup-configuration job.
- Removed these environment variables: `SITES_CONFIG_ENABLE`, `OBJECTTYPES_DOMAIN`, `OBJECTTYPES_ORGANIZATION`, `DEMO_CONFIG_ENABLE`, `DEMO_PERSON`, `DEMO_EMAIL`. These are no longer used in the application.
