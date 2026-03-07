CREATE OR ALTER PROCEDURE silver.load_fact_dh_orders_sales_month
AS
BEGIN

WITH new_date AS (
	SELECT 
		YEAR(o.OrderDate) AS Years,
		MONTH(o.OrderDate) AS months,
		b.a_name AS branchname,
		COUNT(o.orderid) AS total_orders,
		SUM(oi.totalValue) AS total_sales
	FROM bronze.erp_hd_orders o
	INNER JOIN bronze.erp_hd_order_items oi
		ON o.orderid = oi.orderid
	INNER JOIN bronze.erp_sys_branch b
		ON b.branch = o.orderBranch
	WHERE o.statusCode = 6
	GROUP BY 
		YEAR(o.OrderDate),
		MONTH(o.OrderDate),
		b.a_name
)

INSERT INTO silver.fact_dh_orders_sales_month
(
	Years,
	months,
	branchname,
	total_orders,
	total_sales,
	Avg_Total,
	sales_status,
	months_sales
)

SELECT 
	Years,
	months,
	branchname,
	total_orders,
	total_sales,

	AVG(total_sales) 
	OVER (PARTITION BY branchname) AS Avg_Total,

	CASE
	WHEN total_sales > AVG(total_sales) OVER (PARTITION BY branchname) 
		 THEN 'Above_AVG'
	WHEN total_sales < AVG(total_sales) OVER (PARTITION BY branchname) 
		 THEN 'Below_AVG'
	ELSE 'NO_AVG'
	END,

	LAG(total_sales) 
	OVER (PARTITION BY branchname ORDER BY Years,months)

FROM new_date

END
