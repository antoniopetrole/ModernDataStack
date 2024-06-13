{{
    config(
        unique_key='order_number',
        materialized='incremental'
    )
}}
SELECT
{{ dbt_utils.generate_surrogate_key(["order_number"])}} as order_key,
order_number,
ucd.customer_key,
upd.product_key,
usrd.sales_rep_employee_key,
os.order_date,
price_each,
price_each * quantity_ordered AS product_price_total,
quantity_ordered,
order_line_number
FROM {{ref("unique_orders_stg")}} os
LEFT JOIN {{ref("edw_customers_dim")}} ucd ON (os.customer_number = ucd.customer_number)
LEFT JOIN {{ref("edw_products_dim")}} upd ON (os.product_code = upd.product_code)
LEFT JOIN {{ref("edw_sales_rep_dim")}} usrd ON (usrd.sales_rep_employee_number = os.sales_rep_employee_number)
WHERE ucd.dbt_valid_to IS NULL 
AND upd.dbt_valid_to IS NULL
AND usrd.dbt_valid_to IS NULL
{% if is_incremental() %}
  -- this filter will only be applied on an incremental run
  AND os.order_date > ucd.dbt_valid_from
  AND os.order_date > upd.dbt_valid_from
  AND os.order_date > usrd.dbt_valid_from
{% endif %}
