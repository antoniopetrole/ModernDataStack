{% snapshot edw_sales_rep_dim %}

{{
    config(
        target_schema='dbt_prod',
        unique_key='sales_rep_employee_number',
        strategy='check',
        check_cols=['last_name','first_name','extension','email','office_code','reports_to','job_title','city','phone','address_line_1','address_line_2','state','country','postal_code','territory']
    )
}}

select {{ dbt_utils.generate_surrogate_key(['sales_rep_employee_number',dbt_date.now()]) }} as sales_rep_employee_key, * from {{ ref('sales_rep_stg') }}

{% endsnapshot %}