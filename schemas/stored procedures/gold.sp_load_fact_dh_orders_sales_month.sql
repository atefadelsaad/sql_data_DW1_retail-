CREATE OR ALTER PROCEDURE gold.load_fact_dh_orders_sales_month
AS
BEGIN
      MERGE gold.fact_dh_orders_sales_month AS target
	  USING silver.fact_dh_orders_sales_month AS source
	        ON target.Years = source.Years

	  WHEN MATCHED AND 
	           target.months <> source.months
	        OR target.branchname <> source.branchname
		    OR target.total_orders <> source.total_orders
			OR target.total_sales <> source.total_sales
			OR target.Avg_Total <> source.Avg_Total
			OR target.sales_status <> source.sales_status
			OR target.months_sales <> source.months_sales
	 THEN UPDATE SET  
	           target.months = source.months,
	           target.branchname = source.branchname,
		       target.total_orders = source.total_orders,
			   target.total_sales  = source.total_sales,
			   target.Avg_Total = source.Avg_Total,
			   target.sales_status = source.sales_status,
			   target.months_sales = source.months_sales
     WHEN NOT MATCHED BY target
	      THEN
		      INSERT(Years,months,branchname,total_orders,total_sales,Avg_Total,sales_status,months_sales,last_update)
			  VALUES(source.Years,source.months,source.branchname,source.total_orders,source.total_sales,source.Avg_Total,source.sales_status,source.months_sales,GETDATE())
	WHEN NOT MATCHED BY source
	      THEN DELETE
		  OUTPUT $aCTION,
		  inserted.branchname AS BRANCH;

END

EXEC gold.load_fact_dh_orders_sales_month
