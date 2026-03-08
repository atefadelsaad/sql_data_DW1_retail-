CREATE OR ALTER PROCEDURE gold.load_fact_dh_orders_sales_Year
AS
BEGIN
      MERGE gold.fact_dh_orders_sales_Year AS target
	  USING silver.fact_dh_orders_sales_Year AS source
	        ON target.Years = source.Years

	  WHEN MATCHED AND
	           target.branchname <> source.branchname
		    OR target.total_orders <> source.total_orders
			OR target.total_sales <> source.total_sales
			OR target.Avg_Total <> source.Avg_Total
			OR target.sales_status <> source.sales_status
			OR target.Years_sales <> source.Years_sales
	 THEN UPDATE SET  
	           target.branchname = source.branchname,
		       target.total_orders = source.total_orders,
			   target.total_sales  = source.total_sales,
			   target.Avg_Total = source.Avg_Total,
			   target.sales_status = source.sales_status,
			   target.Years_sales = source.Years_sales
     WHEN NOT MATCHED BY target
	      THEN
		      INSERT(Years,branchname,total_orders,total_sales,Avg_Total,sales_status,Years_sales,last_update)
			  VALUES(source.Years,source.branchname,source.total_orders,source.total_sales,source.Avg_Total,source.sales_status,source.Years_sales,GETDATE())
	WHEN NOT MATCHED BY source
	      THEN DELETE
		  OUTPUT $aCTION,
		  inserted.branchname AS BRANCH;

END

EXEC gold.load_fact_dh_orders_sales_Year
