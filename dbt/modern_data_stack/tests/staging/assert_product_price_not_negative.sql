with products as (
    SELECT * FROM {{ref('products_merge')}}
)

SELECT buyprice FROM products 
WHERE buyprice::float < 0