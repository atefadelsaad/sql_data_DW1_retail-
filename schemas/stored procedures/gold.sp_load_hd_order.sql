
CREATE OR ALTER PROCEDURE gold.load_hd_orders
AS
BEGIN
       MERGE [gold].[fact_hd_orders] AS target
	     using [silver].[dim_hd_orders] AS source
	           ON target.orderid = source.orderid
      WHEN MATCHED AND
	           target.orderdate <> source.orderdate
          OR target.CustomerNo <> source.CustomerNo
		      OR target.CustomerName <> source.CustomerName
			    OR target.StatusName <> source.StatusName
		    	OR target.StatusCode <> source.StatusCode
		    	OR target.TakerName <> source.TakerName
			    OR target.Notes <> source.Notes
			    OR target.CancelReasonName <> source.CancelReasonName
		    	OR target.CustomerNotes <> source.CustomerNotes
		    	OR target.OrderBranch <> source.OrderBranch
		    	OR target.TotalValue <> source.TotalValue
       THEN UPDATE SET
             target.orderdate = source.orderdate,
             target.CustomerNo = source.CustomerNo,
			       target.CustomerName = source.CustomerName,
			       target.StatusName = source.StatusName,
			       target.StatusCode = source.StatusCode,
			       target.TakerName = source.TakerName,
			       target.Notes = source.Notes,
		    	   target.CancelReasonName = source.CancelReasonName,
			       target.CustomerNotes = source.CustomerNotes,
			       target.OrderBranch = source.OrderBranch,
			       target.TotalValue = source.TotalValue	            
        WHEN NOT MATCHED BY target
		THEN
		    INSERT(orderid,orderdate,CustomerNo,CustomerName,StatusName,StatusCode,TakerName,Notes,CancelReasonName,CustomerNotes,OrderBranch,TotalValue,last_date)
			  VALUES(source.orderid,source.orderdate,source.CustomerNo,source.CustomerName,source.StatusName,source.StatusCode,source.TakerName,source.Notes,source.CancelReasonName,source.CustomerNotes,source.OrderBranch,source.TotalValue,GETDATE())
        WHEN NOT MATCHED BY source
		THEN DELETE;
 
END
exec gold.load_hd_orders
