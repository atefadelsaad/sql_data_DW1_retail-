CREATE OR ALTER PROCEDURE bronze.cleanup_branch
AS
BEGIN
	  TRUNCATE TABLE bronze.erp_sys_branch
	  TRUNCATE TABLE silver.erp_sys_branch
END
