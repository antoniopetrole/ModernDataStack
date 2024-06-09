{{
    config(
        unique_key='order_key',
        materialized='incremental'
    )
}}
SELECT
{{ dbt_utils.generate_surrogate_key(["order_number"])}} as order_key,
{{ dbt_utils.generate_surrogate_key(["order_date"]) }} as order_date_key,
{{ dbt_utils.generate_surrogate_key(["product_code"]) }} as product_key,
{{ dbt_utils.generate_surrogate_key(["sales_rep_employee_number"]) }} as sales_rep_employee_key,
price_each,
quantity_ordered,
order_date,
shipped_date,
order_line_number
FROM {{ref("orders_stg")}} 