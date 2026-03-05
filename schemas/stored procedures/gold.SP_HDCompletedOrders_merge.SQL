CREATE OR ALTER PROCEDURE gold.HDCompletedOrders_merge
AS
BEGIN
     MERGE gold.dmi_hd_order_bransh AS target
	 USING silver.dmi_hd_order_bransh AS source
	       ON target.branch_code = source.branch_code
	 WHEN MATCHED AND
	       target.CustomerName <> source.CustomerName
        OR target.CustomerPhone <> source.CustomerPhone
		OR target.branch_Name <> source.branch_Name
		OR target.Takerno <> source.Takerno
		OR target.TakerName <> source.TakerName
		OR target.StatusName <> source.StatusName
		OR target.OrderDate <> source.OrderDate
	 THEN UPDATE SET
	       target.CustomerName = source.CustomerName,
           target.CustomerPhone = source.CustomerPhone,
		   target.branch_Name = source.branch_Name,
		   target.Takerno = source.Takerno,
		   target.TakerName = source.TakerName,
		   target.StatusName = source.StatusName,
		   target.OrderDate = source.OrderDate	 
	 WHEN NOT MATCHED BY target
	 THEN
	       INSERT (CustomerName,CustomerPhone,branch_code,Takerno,TakerName,StatusName,OrderDate,last_update)
		   VALUES (source.CustomerName,source.CustomerPhone,source.branch_code,source.Takerno,
		          source.TakerName,source.StatusName,source.OrderDate,GETDATE())
      WHEN NOT MATCHED BY source
	  THEN DELETE;
END
EXEC gold.HDCompletedOrders_merge

