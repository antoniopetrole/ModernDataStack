{% snapshot unique_products_dim %}

{{
    config(
        target_schema='dbt_prod',
        unique_key='product_code',
        strategy='check',
        check_cols=['product_name','product_line','product_scale','product_vendor','product_description','quantity_in_stock','buy_price','msrp','text_description','html_description','image']
    )
}}

select {{ dbt_utils.generate_surrogate_key(['product_code']) }} as product_key, * from {{ ref('products_stg') }}

{% endsnapshot %}