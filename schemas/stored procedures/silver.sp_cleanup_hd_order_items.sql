
CREATE OR ALTER PROCEDURE silver.cleanup_hd_order_items
AS
BEGIN
TRUNCATE TABLE silver.dim_hd_order_items;
TRUNCATE TABLE [bronze].[erp_hd_order_items]
END 

