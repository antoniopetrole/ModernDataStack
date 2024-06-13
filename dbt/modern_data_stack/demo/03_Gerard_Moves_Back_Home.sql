-- UPDATE dbt_prod.sales_rep_dim SET territory = 'EMEA' WHERE sales_rep_employee_number = '1370';

UPDATE raw."employees" SET "officeCode" = '4' WHERE "employeeNumber" = '1370';
