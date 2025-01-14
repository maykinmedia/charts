# Changelog

## 1.1.1-beta.0 (2025-10-01)

- [#148] Add worker liveness probe command `celery inspect active`. This should detect when a worker is down and should not interrupt long running tasks.
- Fix missing init container to run Django setup configuration.