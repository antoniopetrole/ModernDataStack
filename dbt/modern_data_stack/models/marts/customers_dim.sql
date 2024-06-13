

select {{ dbt_utils.generate_surrogate_key(['customer_number']) }} as customer_key, * from {{ ref('customers_stg') }}
