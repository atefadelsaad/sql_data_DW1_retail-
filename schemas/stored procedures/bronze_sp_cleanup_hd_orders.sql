CREATE OR ALTER PROCEDURE silver.cleanup_hd_orders
AS
BEGIN
TRUNCATE TABLE bronze.erp_hd_orders;
TRUNCATE TABLE silver.dim_hd_orders;
END
