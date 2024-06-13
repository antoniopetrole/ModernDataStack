
select {{ dbt_utils.generate_surrogate_key(['sales_rep_employee_number']) }} as sales_rep_employee_key, * from {{ ref('sales_rep_stg') }}