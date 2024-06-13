SELECT order_date, SUM(product_price_total), territory, first_name, last_name, sales_rep_employee_number 
FROM edw_orders_fact of 
INNER JOIN edw_sales_rep_dim srd ON (of.sales_rep_employee_key = srd.sales_rep_employee_key) 
WHERE sales_rep_employee_number = '1370'
GROUP BY 1,3,4,5,6
ORDER BY order_date
