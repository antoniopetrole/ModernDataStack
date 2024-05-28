{% snapshot employees_dim %}

{{
    config(
        target_schema='prod',
        unique_key='employee_number',
        strategy='check',
        check_cols='all'
    )
}}

select {{ dbt_utils.generate_surrogate_key(['employee_number']) }} as employee_key, * from {{ ref('employees_merge') }}

{% endsnapshot %}