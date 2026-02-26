CREATE OR ALTER PROCEDURE bronze.cleanup_items
AS
BEGIN
	  TRUNCATE TABLE bronze.erp_sys_item
    TRUNCATE TABLE silver.erp_sys_item
END
