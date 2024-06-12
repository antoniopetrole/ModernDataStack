SELECT 
e."employeeNumber"::int AS sales_rep_employee_number,
e."lastName"::varchar(50) AS last_name,
e."firstName"::varchar(50) AS first_name,
e."extension"::varchar(10) AS extension,
e."email"::varchar(100) AS email,
e."officeCode"::varchar(10) AS office_code,
e."reportsTo"::int AS reports_to,
e."jobTitle"::varchar(50) AS job_title,
o."city"::varchar(50),
o."phone"::varchar(50),
o."addressLine1"::varchar(50) AS address_line_1,
o."addressLine2"::varchar(50) AS address_line_2,
o."state"::varchar(50),
o."country"::varchar(50),
o."postalCode"::varchar(15) AS postal_code,
o."territory"::varchar(10)
FROM {{source('classic_models','employees')}} e
LEFT JOIN {{source('classic_models','offices')}} o ON (e."officeCode" = o."officeCode")

