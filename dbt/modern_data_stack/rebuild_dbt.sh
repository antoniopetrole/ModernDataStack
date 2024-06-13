psql -h 127.0.0.1 -U admin -p 5432 -d edw -c "DROP SCHEMA IF EXISTS dbt_transform CASCADE;DROP SCHEMA IF EXISTS dbt_prod CASCADE;"
psql -h 127.0.0.1 -U admin -p 5432 -d edw < demo/remove_order.sql
psql -h 127.0.0.1 -U admin -p 5432 -d edw < demo/03_Gerard_Moves_Back_Home.sql
dbt build
