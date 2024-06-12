SELECT
o."orderDate"::timestamp AS order_date,
o."shippedDate"::timestamp AS shipped_date,
cs.customer_number,
sr.sales_rep_employee_number,
od."orderNumber"::int AS order_number,
od."priceEach"::money AS price_each,
od."productCode"::varchar AS product_code,
od."orderLineNumber"::int AS order_line_number,
od."quantityOrdered"::int AS quantity_ordered
FROM {{source("classic_models","orders")}} o
LEFT OUTER JOIN {{source("classic_models","orderdetails")}} od ON (od."orderNumber" = o."orderNumber")
LEFT JOIN {{ref("customers_stg")}} cs ON (cs.customer_number = o."customerNumber")
LEFT JOIN {{ref("sales_rep_stg")}} sr ON (cs.sales_rep_employee_number = sr.sales_rep_employee_number)