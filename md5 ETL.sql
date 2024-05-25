-- SELECT * FROM products p
-- INNER JOIN orderdetails od ON (p."productCode" = od."productCode")
-- INNER JOIN orders o ON (o."orderNumber" = od."orderNumber")
-- INNER JOIN customers c ON (c."customerNumber" = o."customerNumber")
-- INNER JOIN employees e ON (e."employeeNumber" = c."salesRepEmployeeNumber")
--
--
--
-- EXPLAIN ANALYZE WITH orderDetailsAgg AS (SELECT "orderNumber", SUM("quantityOrdered" * CAST("priceEach" AS money)) AS orderTotal FROM orderdetails GROUP BY "orderNumber")
-- SELECT orderDetailsAgg.orderTotal, CONCAT_WS(' ', e."firstName", e."lastName") FROM orders o
-- INNER JOIN orderDetailsAgg ON (orderDetailsAgg."orderNumber" = o."orderNumber")
-- INNER JOIN customers c ON (c."customerNumber" = o."customerNumber")
-- INNER JOIN employees e ON (e."employeeNumber" = c."salesRepEmployeeNumber")
-- ORDER BY orderTotal DESC

INSERT INTO public.products_merge
SELECT
pr."productCode",
pr."productName",
pr."productLine",
pr."productScale",
pr."productVendor",
pr."productDescription",
pr."quantityInStock",
pr."buyPrice",
pr."MSRP",
pl."textDescription",
pl."htmlDescription",
pl."image"
FROM public.products pr
INNER JOIN public.productlines pl ON (pr."productLine" = pl."productLine");




SELECT * from products_merge;

SELECT * FROM prod.products;

SELECT md5(products_merge::TEXT)
FROM products_merge

TRUNCATE prod.products;

INSERT INTO prod.products (
checksum,
productCode,
productName,
productLine,
productScale,
productVendor,
productDescription,
quantityInStock,
buyPrice,
MSRP,
textDescription,
htmlDescription,
image,
start_ts,
end_ts,
is_active
)

    SELECT
    md5(pm::TEXT),
    pm.productCode,
    pm.productName,
    pm.productLine,
    pm.productScale,
    pm.productVendor,
    pm.productDescription,
    pm.quantityInStock::int,
    pm.buyPrice::numeric,
    pm.MSRP::numeric,
    pm.textDescription,
    pm.htmlDescription,
    pm.image,
    CASE WHEN p.productCode = pm.productCode
        THEN p.end_ts
        ELSE '1900-01-01 00:00:00'
    END AS start_ts,
    '9999-12-31 23:59:59' AS end_ts,
    true AS is_active
    FROM public.products_merge pm

    LEFT OUTER JOIN prod.products p ON (p.productCode = pm.productCode)
    WHERE md5(pm::TEXT) IS DISTINCT FROM p.checksum;

SELECT COUNT(*) FROM prod.products;

SELECT * FROM products_merge