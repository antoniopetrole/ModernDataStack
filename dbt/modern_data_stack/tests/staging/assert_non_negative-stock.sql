with products as (
    SELECT * FROM {{ref('products_merge')}}
)

SELECT productcode FROM products 
WHERE quantityInStock::int < 0