
# Changelog

## 0.2.0 (2026-08-20)

- Bumped the application version to 0.7.4
- Exposed `enableServiceLinks` for the deployment of the pod that runs the uWSGI server. Default value is `false`.
  This fixes the automatic override of `REFERENTIELIJSTEN_PORT`, which overrides `uwsgi_port`, which caused the problem with the health checks.

## 0.1.1 (2026-02-09)

- Update the Readme.

## 0.1.0 (2025-10-21)

- Initial release of Referentielijsten Helm chart
