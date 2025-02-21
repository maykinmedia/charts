# Changelog

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