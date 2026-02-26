CREATE OR ALTER PROCEDURE silver.load_hd_orders
AS
BEGIN
     INSERT INTO silver.dim_hd_orders(
		OrderId ,
		OrderDate,
		CustomerNo,
		CustomerName,
		StatusName,
		TakerName,
		Notes,
		CancelReasonName,
		CustomerNotes,
		OrderBranch,
		TotalValue
	 )
	SELECT
		OrderId ,
		OrderDate,
		CustomerNo,
	    CASE 
		     WHEN CustomerName IS NULL OR CustomerName = ''
			 THEN 'N/A'
		ELSE TRIM(CustomerName)
		END CustomerName,
		StatusName,
		TakerName,
		CASE 
		     WHEN Notes IS NULL OR Notes = ''
			 THEN 'N/A'
		ELSE TRIM(Notes)
		END Notes,
	    CASE 
		     WHEN CancelReasonName IS NULL OR CancelReasonName = ''
			 THEN 'N/A'
		ELSE TRIM(CancelReasonName)
		END CancelReasonName,
	    CASE 
		     WHEN CustomerNotes IS NULL OR CustomerNotes = ''
			 THEN 'N/A'
		ELSE TRIM(CustomerNotes)
		END CustomerNotes,
		OrderBranch,
		TotalValue
	FROM bronze.erp_hd_orders
END

