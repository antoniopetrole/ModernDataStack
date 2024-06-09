SELECT
pr."productCode"::varchar(8) AS product_code,
pr."productName"::varchar(70) AS product_name,
pr."productLine"::varchar(50) AS product_line,
pr."productScale"::varchar(10) AS product_scale,
pr."productVendor"::varchar(50) AS product_vendor,
pr."productDescription" AS product_description,
pr."quantityInStock"::int AS quantity_in_stock,
pr."buyPrice"::decimal(10,2) AS buy_price,
pr."MSRP"::decimal(10,2) AS msrp,
pl."textDescription" AS text_description,
pl."htmlDescription" AS html_description,
pl."image"
FROM {{source("classic_models","products")}} pr
INNER JOIN {{source("classic_models","productlines")}} pl ON (pr."productLine" = pl."productLine")