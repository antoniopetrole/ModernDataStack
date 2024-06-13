{{
    config(
        unique_key='order_key',
        materialized='incremental'
    )
}}
SELECT
{{ dbt_utils.generate_surrogate_key(["order_number"])}} as order_key,
{{ dbt_utils.generate_surrogate_key(["product_code"]) }} as product_key,
{{ dbt_utils.generate_surrogate_key(["sales_rep_employee_number"]) }} as sales_rep_employee_key,
{{ dbt_utils.generate_surrogate_key(["customer_number"]) }} as customer_key,
order_number,
order_date,
price_each,
quantity_ordered,
price_each * quantity_ordered AS product_price_total,
order_line_number
FROM {{ref("orders_stg")}} 