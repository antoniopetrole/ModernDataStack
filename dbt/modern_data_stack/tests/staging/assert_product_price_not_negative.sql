with products as (
    SELECT * FROM {{ref('products_merge')}}
)

SELECT buy_price FROM products 
WHERE buy_price < 0