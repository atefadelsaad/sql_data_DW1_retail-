CREATE OR ALTER PROCEDURE gold.load_hd_orders
AS
BEGIN
       INSERT INTO gold.fact_hd_orders
	     SELECT * FROM silver.dim_hd_orders
END
