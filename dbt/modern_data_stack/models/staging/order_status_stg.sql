SELECT 
status::varchar AS status,
"comments"::text AS comments,
"orderDate"::date AS order_date,
"orderNumber"::int AS order_number,
"shippedDate"::date AS shipped_date,
"requiredDate"::date AS required_date,
"customerNumber"::int AS customer_number
FROM {{source('classic_models','orders')}} od