  CREATE OR ALTER PROCEDURE gold.HDorders_HDorderItems_branch_item_merge
AS
	declare @to smalldatetime = (select CAST(GETDATE() AS DATE));
	declare @from smalldatetime = DATEADD(DAY,-1,@to);
BEGIN
WITH data_sources AS(
		SELECT 
				o.OrderId ,
				o.OrderDate,
				o.CustomerNo,
				o.CustomerName,
				o.StatusName as orderStatus,
				o.TakerName,
				o.Notes,
				o.CancelReasonName,
				o.CustomerNotes ,
				o.OrderBranch ,
				b.arabic_name as branch,
				o.TotalValue,
				oi.Barcode,
				i.arabic_name as itemName,
				oi.Qty, 
				oi.RetailPrice as price,
				oi.Notes as ItemNotes
		FROM silver.dim_hd_orders o
		INNER JOIN 
			 silver.erp_sys_branch b
		ON   b.branch	=	o.OrderBranch
		INNER JOIN silver.dim_hd_order_items oi
		ON   oi.orderid	=	o.OrderId
		INNER JOIN silver.erp_sys_item i
		ON   i.itemean	=	oi.ItemEan
		WHERE
			o.orderdate between @from and @to and
			StatusCode = 200
			)

   MERGE gold.fact_HDCancelledOrders AS target
   USING data_sources AS source
         ON target.OrderId = source.OrderId
   WHEN MATCHED AND	(		
			   target.OrderDate <> source.OrderDate
			OR target.CustomerNo <> source.CustomerNo
			OR target.CustomerName <> source.CustomerName
			OR target.orderStatus <> source.orderStatus
			OR target.TakerName <> source.TakerName
			OR target.Notes <> source.Notes
			OR target.CancelReasonName <> source.CancelReasonName
			OR target.CustomerNotes <> source.CustomerNotes
			OR target.OrderBranch <> source.OrderBranch
			OR target.arabic_name  <> source.branch
			OR target.TotalValue <> source.TotalValue
			OR target.Barcode <> source.Barcode
			OR target.itemName  <> source.itemName
			OR target.Qty <> source.Qty
			OR target.price  <> source.price
			OR target.ItemNotes   <> source.ItemNotes    
			)
    THEN UPDATE SET
			 target.OrderDate = source.OrderDate,
			 target.CustomerNo = source.CustomerNo,
			 target.CustomerName = source.CustomerName,
			 target.orderStatus = source.orderStatus,
			 target.TakerName = source.TakerName,
			 target.Notes = source.Notes,
			 target.CancelReasonName = source.CancelReasonName,
			 target.CustomerNotes = source.CustomerNotes,
			 target.OrderBranch = source.OrderBranch,
			 target.arabic_name  = source.branch,
			 target.TotalValue = source.TotalValue,
			 target.Barcode = source.Barcode,
			 target.itemName  = source.itemName,
			 target.Qty = source.Qty,
			 target.price  = source.price,
			 target.ItemNotes   = source.ItemNotes
     WHEN NOT MATCHED BY target
     THEN
	         INSERT (OrderId,OrderDate,CustomerNo,CustomerName,orderStatus,TakerName,Notes,
			         CancelReasonName,CustomerNotes,OrderBranch,arabic_name ,TotalValue,Barcode,itemName ,Qty,price ,ItemNotes  ,last_update )
			 VALUES(source.OrderId,source.OrderDate,source.CustomerNo,source.CustomerName,source.orderStatus,source.TakerName,source.Notes,
			         source.CancelReasonName,source.CustomerNotes,source.OrderBranch,source.branch,source.TotalValue,source.Barcode,source.itemName,source.Qty,source.price,source.ItemNotes,getdate())
     WHEN NOT MATCHED BY source
	 THEN DELETE;

END

