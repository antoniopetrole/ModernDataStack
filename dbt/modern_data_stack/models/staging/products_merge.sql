{{
    config(
        materialized='table'
    )
}}

SELECT
pr.productCode,
pr.productName,
pr.productLine,
pr.productScale,
pr.productVendor,
pr.productDescription,
pr.quantityInStock,
pr.buyPrice,
pr.MSRP,
pl.textDescription,
pl.htmlDescription,
pl.image
FROM {{source('classic_models','products')}} pr
INNER JOIN {{source('classic_models','productlines')}} pl ON (pr.productLine = pl.productLine)