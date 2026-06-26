# Changelog

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
