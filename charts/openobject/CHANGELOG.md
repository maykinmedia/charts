# Changelog

## 1.2.0 (2026-08-21)

- Bumped the application version to 4.2.1
- Exposed `enableServiceLinks` for the deployment of the pod that runs the uWSGI server. Default value is `false`.
  This fixes the automatic override of `OPENOBJECT_PORT`, which overrides `uwsgi_port`, which caused the problem with the health checks.
- Added the `JSONSCHEMA_USE_FORMAT_CHECKER` setting to control JSON Schema format validation. The default value is `true`.
- Added Helm hooks to ensure the `job-config` runs at the correct stage of the release lifecycle.
- Added envvars for failed notification rescheduling

  - `LOG_NOTIFICATIONS_IN_DB` 
  - `NOTIFICATION_NUMBER_OF_DAYS_RETAINED` 

- Fix application settings for outgoing request logging configuration

  - `LOG_OUTGOING_REQUESTS_DB_SAVE`
  - `LOG_OUTGOING_REQUESTS_DB_SAVE_BODY`
  - `LOG_OUTGOING_REQUESTS_RESET_DB_SAVE_AFTER`
  - `LOG_OUTGOING_REQUESTS_MAX_AGE`
  - Set `LOG_OUTGOING_REQUESTS_DB_SAVE` value to `true`

## 1.1.1 (2026-06-26)

**Changes**

- Fixed inconsistent naming of configuration secret

## 1.1.0 (2026-06-24)

**Changes**

- Fixed the ``existingConfigurationSecret`` value name

## 1.0.0 (2026-06-19)

**Changes**

- Bumped the application version to **4.1.0**.
    
    * ``siteDomain`` value is required now

- [#402] Fixed duplicate volumes entries in Open Object Helm chart configuration
- [#404] Added missing ``django_setup_configuration`` values.

    * Removed `sites_config` from `django_setup_configuration`.
    * Removed the `objecttypes-api` service from the `zgw_consumers` `django_setup_configuration`.

**Documentation**

- [#405] Added a deprecation warning to the Objecten Helm chart and improved Open Object documentation

## 0.1.0 (2026-05-28)

- First chart release of Open Object 4.0, which combines Objecttypes API and Objects API into a single application.
