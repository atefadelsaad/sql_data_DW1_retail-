CREATE OR ALTER PROCEDURE silver.load_fact_dh_orders_sales_year
AS
BEGIN

WITH new_date2 AS (
    SELECT 
        YEAR(o.OrderDate) AS Years,
        b.a_name AS branchname,
        COUNT(o.orderid) AS total_orders,
        SUM(oi.totalValue) AS total_sales
    FROM bronze.erp_hd_orders o
    INNER JOIN bronze.erp_hd_order_items oi
        ON o.orderid = oi.orderid
    INNER JOIN bronze.erp_sys_branch b
        ON b.branch = o.orderBranch
    WHERE o.statusCode = 6
    GROUP BY YEAR(o.OrderDate), b.a_name
)

INSERT INTO silver.fact_dh_orders_sales_Year
(
    Years,
    branchname,
    total_orders,
    total_sales,
    Avg_Total,
    sales_status,
    Years_sales
)
SELECT 
    Years,
    branchname,
    total_orders,
    total_sales,
    AVG(total_sales) OVER(PARTITION BY branchname) AS Avg_Total,
    CASE
        WHEN total_sales > AVG(total_sales) OVER(PARTITION BY branchname) THEN 'Above_AVG'
        WHEN total_sales < AVG(total_sales) OVER(PARTITION BY branchname) THEN 'Below_AVG'
        ELSE 'NO_AVG'
    END AS sales_status,
    LAG(total_sales) OVER(PARTITION BY branchname ORDER BY Years) AS Years_sales
FROM new_date2;

END

