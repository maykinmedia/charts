# Changelog

## 1.8.0-beta.1 (2025-23-01)
- [#170] Add autoscaling behavior for ON

## 1.8.0-beta.0 (2025-22-01)
- [#169] Add pdb for worker

## 1.7.0-beta.0 (2025-10-01)

- [#148] Replace the worker liveness probe with the `celery inspect active` command. This should detect when a worker is down and should not interrupt long running tasks.
- [#119] Update the syntax of the worker liveness probe. The worker probes now can be enabled/disabled with:

```yaml
worker:
  livenessProbe:
    enabled: true # true | false
```