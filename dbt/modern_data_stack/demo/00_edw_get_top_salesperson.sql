SELECT srd.sales_rep_employee_number, srd.first_name, srd.last_name, srd.territory, SUM(product_price_total) FROM edw_orders_fact of
INNER JOIN edw_products_dim pd ON (of.product_key = pd.product_key)
INNER JOIN edw_sales_rep_dim srd ON (srd.sales_rep_employee_key = of.sales_rep_employee_key)
GROUP BY srd.sales_rep_employee_number, srd.first_name, srd.last_name, srd.territory
ORDER BY 5 DESC
