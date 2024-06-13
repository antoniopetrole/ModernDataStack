{% snapshot edw_customers_dim %}

{{
    config(
        target_schema='dbt_prod',
        unique_key='customer_number',
        strategy='check',
        check_cols=['customer_name','contact_last_name','contact_first_name','phone','address_line_1','address_line_2','city','state','postal_code','country','sales_rep_employee_number','credit_limit']
    )
}}

select {{ dbt_utils.generate_surrogate_key(['customer_number',dbt_date.now()]) }} as customer_key, * from {{ ref('customers_stg') }}

{% endsnapshot %}