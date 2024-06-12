psql -h 127.0.0.1 -U admin -p 5432 -d edw -c "DROP SCHEMA IF EXISTS dbt_transform CASCADE;DROP SCHEMA IF EXISTS dbt_prod CASCADE;"
psql -h 127.0.0.1 -U admin -p 5432 -d edw < scripts/remove_order.sql
dbt build
