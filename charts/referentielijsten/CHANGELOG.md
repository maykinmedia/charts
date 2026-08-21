
# Changelog

## 0.2.0 (2026-08-21)

- Bumped the application version to 0.7.4
- Exposed `enableServiceLinks` for the deployment of the pod that runs the uWSGI server. Default value is `false`.
  This fixes the automatic override of `REFERENTIELIJSTEN_PORT`, which overrides `uwsgi_port`, which caused the problem with the health checks.
- Add Helm hooks to ensure the `job-config` runs at the correct stage of the release lifecycle.
- Fix application settings for outgoing request logging configuration

  - Update `LOG_REQUESTS` default value to `True` instead of `False`.
  - Update `LOG_OUTGOING_REQUESTS_DB_SAVE_BODY` default value to `True` instead of `False`.
  - Add `LOG_OUTGOING_REQUESTS_RESET_DB_SAVE_AFTER` 

## 0.1.1 (2026-02-09)

- Update the Readme.

## 0.1.0 (2025-10-21)

- Initial release of Referentielijsten Helm chart
