{% snapshot products_difff %}

{{
    config(
        target_schema='dbt_prod',
        unique_key='product_code',
        strategy='check',
        check_cols='all'
    )
}}

select {{ dbt_utils.generate_surrogate_key(['product_code']) }} as product_key, * from {{ ref('products_stg') }}

{% endsnapshot %}