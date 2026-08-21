
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

- Add application settings for Otel configuration, check Referentielijsten documentation for more info.

  - `OTEL_SDK_DISABLED`
  - `OTEL_RESOURCE_ATTRIBUTES`
  - `OTEL_EXPORTER_OTLP_ENDPOINT`
  - `OTEL_EXPORTER_OTLP_METRICS_INSECURE`
  - `OTEL_EXPORTER_OTLP_PROTOCOL`
  - `OTEL_METRIC_EXPORT_INTERVAL`
  - `OTEL_METRIC_EXPORT_TIMEOUT`

- Updated `mozilla-django-oidc-db` to 1.1.0

  - The configuration format has changed, the previous single-model configuration is now split into separate `OIDCProvider` and `OIDCClient` configurations, making it easier to reuse identity provider settings across multiple client IDs.

- Updated `django-setup-configuration` to 0.9.0

  - Secrets can now be read directly from environment variables, removing the need to use `envsubst` when injecting secrets into the application configuration YAML.

  **Upgrade procedure**

  In the `configuration.data` value, replace values using the `envsubst` syntax `${...}`:

  ```yaml
  oidc_rp_client_secret: ${keycloak_client_secret}
  ```

  with:

  ```yaml
  oidc_rp_client_secret:
    value_from:
      env: KEYCLOAK_CLIENT_SECRET
  ```

## 0.1.1 (2026-02-09)

- Update the Readme.

## 0.1.0 (2025-10-21)

- Initial release of Referentielijsten Helm chart
