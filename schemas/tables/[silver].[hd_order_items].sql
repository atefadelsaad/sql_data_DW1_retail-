	DROP TABLE IF EXISTS silver.dim_hd_order_items
	CREATE TABLE silver.dim_hd_order_items(
		OrderId BIGINT NOT NULL,
		OrderDate DATE NOT NULL,
		DocType INT NOT NULL,
		ItemEan NVARCHAR(20) NOT NULL,
		Barcode NVARCHAR(20) NOT NULL,
		ItemName NVARCHAR(150) NOT NULL,
		Qty DECIMAL(12,3) NOT NULL,
		ItemCount INT NOT NULL,
		RetailPrice DECIMAL(20,3) NOT NULL,
		DiscountValue DECIMAL(20,3) NOT NULL,
		TotalValue DECIMAL(20,3) NOT NULL,
		ItemClassName NVARCHAR(100) NOT NULL,
		Notes NVARCHAR(1000) NOT NULL
	)
