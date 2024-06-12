{{
    config(
        unique_key='order_key',
        materialized='incremental'
    )
}}
SELECT
{{ dbt_utils.generate_surrogate_key(["order_number"])}} as order_key,
CASE
    WHEN ucd.customer_key IS NULL THEN '-1' 
    ELSE ucd.customer_key
END,
CASE
    WHEN upd.product_key IS NULL THEN '-1' 
    ELSE upd.product_key
END,
CASE
    WHEN usrd.sales_rep_employee_key IS NULL THEN '-1' 
    ELSE usrd.sales_rep_employee_key
END,
os.order_date,
price_each,
price_each * quantity_ordered AS product_total,
quantity_ordered,
order_line_number
FROM {{ref("unique_orders_stg")}} os
LEFT JOIN {{ref("unique_customers_dim")}} ucd ON (os.customer_number = ucd.customer_number)
LEFT JOIN {{ref("unique_products_dim")}} upd ON (os.product_code = upd.product_code)
LEFT JOIN {{ref("unique_sales_rep_dim")}} usrd ON (usrd.sales_rep_employee_number = os.sales_rep_employee_number)
WHERE ucd.dbt_valid_to IS NULL 
AND upd.dbt_valid_to IS NULL
AND usrd.dbt_valid_to IS NULL