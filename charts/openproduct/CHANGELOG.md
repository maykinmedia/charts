
# Changelog

## 0.2.1 (2025-09-11)
- [#290] Fix mising env variable dbPool.enable (default: false)
- Change db pool variable names to camel case
- **BREAKING CHANGE**: Rename database pool variables from snake_case to camelCase
  - Old: `db_pool.*` → New: `dbPool.*`
  - **Migration required**: Update values.yaml with new variable names

## 0.2.0 (2025-08-24)
##### Upgraded 
- Redis Bitnami Helm subchart to version `22.0.1`
- Common Bitnami Helm subchart to version `2.31.4`
##### Changed
- Redis: Migrated from Bitnami to official Redis container image (`8.0`, pinned)

## 0.1.1 (2025-07-23)

- Added 8 env variables (`db_pool_min_size`, `db_pool_max_size`, `db_pool_timeout`, `db_pool_max_waiting`, `db_pool_max_lifetime`, `db_pool_max_idle`, `db_pool_reconnect_timeout`, `db_pool_num_workers`) for DB POOL related to postgres performance. In addition `db_conn_max_age` variable created.

## 0.1.0 (2025-04-21)

- Initial create Openproduct helm chart
