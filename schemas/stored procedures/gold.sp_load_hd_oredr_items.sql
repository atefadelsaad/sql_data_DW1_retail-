	CREATE OR ALTER PROCEDURE gold.load_hd_order_items
	AS
	BEGIN
	    MERGE gold.fact_hd_order_items AS target
		  USING silver.dim_hd_order_items AS source
		  ON target.OrderId = source.OrderId
    WHEN MATCHED AND
	      target.OrderDate <> source.OrderDate
       OR target.DocType <> source.DocType
	   OR target.ItemEan <> source.ItemEan
	   OR target.Barcode <> source.Barcode
	   OR target.ItemName <> source.ItemName
	   OR target.Qty <> source.Qty
	   OR target.ItemCount <> source.ItemCount
	   OR target.RetailPrice <> source.RetailPrice
	   OR target.DiscountValue <> source.DiscountValue
	   OR target.TotalValue <> source.TotalValue
	   OR target.ItemClassName <> source.ItemClassName
	   OR target.Notes <> source.Notes
    THEN UPDATE SET
		  target.OrderDate = source.OrderDate,
		  target.DocType = source.DocType,
		  target.ItemEan = source.ItemEan,
		  target.Barcode = source.Barcode,
		  target.ItemName = source.ItemName,
		  target.Qty = source.Qty,
		  target.ItemCount = source.ItemCount,
		  target.RetailPrice = source.RetailPrice,
		  target.DiscountValue = source.DiscountValue,
		  target.TotalValue = source.TotalValue,
		  target.ItemClassName = source.ItemClassName,
		  target.Notes =source.Notes
    WHEN NOT MATCHED BY target
	THEN    
	     INSERT(OrderId,OrderDate,DocType,ItemEan,Barcode,ItemName,Qty,ItemCount,RetailPrice,DiscountValue,TotalValue,ItemClassName,Notes,last_date)
		 VALUES(source.OrderId,source.OrderDate,source.DocType,source.ItemEan,source.Barcode,source.ItemName,source.Qty,source.ItemCount,source.RetailPrice,source.DiscountValue,source.TotalValue,source.ItemClassName,Notes,GETDATE())
    WHEN NOT MATCHED BY source
	THEN DELETE;
	END
	EXEC gold.load_hd_order_items
