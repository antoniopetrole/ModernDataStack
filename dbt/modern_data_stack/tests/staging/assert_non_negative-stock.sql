with products as (
    SELECT * FROM {{ref('products_merge')}}
)

SELECT product_code FROM products 
WHERE quantity_in_stock < 0