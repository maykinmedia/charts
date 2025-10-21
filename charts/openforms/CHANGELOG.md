# Changelog

## 1.11.0 (2025-10-21)
- [#267] Add nginx static file serving support
  - Added `nginx.staticFileServing.enabled` (default: true) to enable/disable static file serving directly from nginx 
  - Hard coded mount path /srv/static/ as a place for the static files
  - Added `nginx.staticFileServing.minVersion` to specify minimum OpenForms version requirement (default: 3.3.0)
  - Includes automatic version checking to ensure static file serving only works with compatible OpenForms versions (>= 3.3.0)

## 1.10.2 (2025-09-14)
- Fixed Flower deployment to use the `flower.extraVolumes` instead of `extraVolumes` and `flower.extraVolumeMounts` instead of `extraVolumeMounts`.

## 1.10.1 (2025-09-13)
- [#300] Add startup probe to improve deployment reliability
  - Add startup probe with 5+ minute timeout for application initialization
  - Configuration: 15s initial delay + 30 failures × 10s period = 5 minutes 15 seconds total
  - Prevents premature pod restarts during complex startup scenarios (database migrations, static file collection)

## 1.10.0 (2025-10-03)

- Added environment variables to manage Open Telemetry configuration.
- Updated the example yaml for automatic configuration.

**Upgrade notes**

⚠️ When upgrading to Open Forms 3.3, a number of manual actions are required. See the [changelog](https://open-forms.readthedocs.io/en/3.3.0/changelog.html) for more details.

In addition, the data in the `configuration.data` value regarding the OIDC configuration (`oidc_db_config_admin_auth`) should be updated to the new format.
Look at the example in the `values.yaml` file to see the new format.

## 1.9.0 (2025-08-20)
##### Upgraded 
- Redis Bitnami Helm subchart to version `22.0.1`
- Common Bitnami Helm subchart to version `2.31.4`
##### Changed
- Redis: Migrated from Bitnami to official Redis container image (`8.0`, pinned) 

## 1.8.10 (2025-08-06)

- Enhanced `extraVolumes` and `extraVolumeMounts` for Flower container configuration. Previously applied to all containers, now supports targeting Flower container. Allows more granular control over volume mounting.
- Warning: This change affects deployments that previously relied on extraVolumes and extraVolumeMounts being applied globally across all containers. extraVolumes and extraVolumeMounts now exclusively target the Flower container. Action: Move configurations to the appropriate container-specific sections.

## 1.8.9 (2025-07-29)

- Adding extra env variable `crossOriginOpenerPolicy` to control browser cross-origin window handling; recommended: "unsafe-none" for development, "same-origin" for production; includes validation to ensure only valid values are used

## 1.8.8 (2025-07-24)

- Fixed worker deployment which was using the wrong value to determine if autoscaling is enabled (autoscaling.enabled instead of worker.autoscaling.enabled).

## 1.8.7 (2025-07-18)

- Removing initContainer used in the past for the serup configuration. [ It is no longer supported, and unnecessary ]

## 1.8.6 (2025-07-03)

- Adding extra env variable `EMAIL_TIMEOUT` defined with `settings.email.timeout:`

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
