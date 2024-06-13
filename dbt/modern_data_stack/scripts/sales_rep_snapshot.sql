{% snapshot sales_rep_dim %}

{{
    config(
        target_schema='dbt_prod',
        unique_key='sales_rep_employee_number',
        strategy='check',
        check_cols='all'
    )
}}

select {{ dbt_utils.generate_surrogate_key(['sales_rep_employee_number']) }} as sales_rep_employee_key, * from {{ ref('sales_rep_stg') }}

{% endsnapshot %}