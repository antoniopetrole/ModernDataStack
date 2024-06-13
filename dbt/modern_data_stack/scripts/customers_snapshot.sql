{% snapshot customers_dim %}

{{
    config(
        target_schema='dbt_prod',
        unique_key='customer_number',
        strategy='check',
        check_cols='all'
    )
}}

select {{ dbt_utils.generate_surrogate_key(['customer_number']) }} as customer_key, * from {{ ref('customers_stg') }}

{% endsnapshot %}