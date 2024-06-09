SELECT 
"customerNumber"::int AS customer_number,
"customerName"::varchar(50) AS customer_name,
"contactLastName"::varchar(50) AS contact_last_name,
"contactFirstName"::varchar(50) AS contact_first_name,
"phone"::varchar(50) AS phone,
"addressLine1"::varchar(50) AS address_line_1,
"addressLine2"::varchar(50) AS address_line_2,
"city"::varchar(50) AS city,
"state"::varchar(50) AS state,
"postalCode"::varchar(15) AS postal_code,
"country"::varchar(50) AS country,
"salesRepEmployeeNumber"::int AS sales_rep_employee_number,
"creditLimit"::decimal(10,2) AS credit_limit
FROM {{source('classic_models','customers')}} c