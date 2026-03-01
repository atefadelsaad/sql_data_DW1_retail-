CREATE OR ALTER PROCEDURE silver.load_hd_order_items
 AS
 BEGIN
        INSERT INTO silver.dim_hd_order_items(
		OrderId,
			OrderDate,
			DocType ,
			ItemEan,
			Barcode,
			ItemName,
			Qty,
			ItemCount,
			RetailPrice,
			DiscountValue,
			TotalValue,
			ItemClassName,
			Notes
		)
		SELECT 
			OrderId,
			OrderDate,
			DocType ,
			ItemEan,
			Barcode,
			CASE
				WHEN ItemName IS NULL OR ItemName = ''
					THEN 'N/A'
				ELSE ItemName
			END ItemName,
				CASE
				WHEN Qty IS NULL OR Qty < 0
					THEN 0
				ELSE Qty
			END Qty,
			CASE
				WHEN ItemCount IS NULL OR ItemCount < 0
					THEN 0
				ELSE ItemCount
			END ItemCount,
			CASE
				WHEN RetailPrice IS NULL OR RetailPrice < 0
					THEN 0
				ELSE RetailPrice
			END RetailPrice,
			CASE
				WHEN DiscountValue IS NULL OR DiscountValue < 0
					THEN 0
				ELSE DiscountValue
			END DiscountValue,
			CASE 
				WHEN TotalValue IS NULL OR TotalValue < 0
					THEN 0
				ELSE TotalValue 
			END TotalValue 	,
			TRIM(ItemClassName ) AS ItemClassName, 
			CASE 
				WHEN Notes IS NULL OR Notes = ''
				THEN 'N/A'
				ELSE Notes
			END Notes
		FROM bronze.erp_hd_order_items
END

EXEC silver.load_hd_order_items 

