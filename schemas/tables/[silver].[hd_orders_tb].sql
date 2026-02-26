DROP TABLE IF EXISTS silver.dim_hd_orders
CREATE TABLE silver.dim_hd_orders(
 	OrderId bigint NOT NULL,
	OrderDate datetime NOT NULL,
	CustomerNo int NOT NULL,
	CustomerName nvarchar(150) NOT NULL,
	StatusName nvarchar(100) NOT NULL,
	TakerName nvarchar(150) NOT NULL,
	Notes nvarchar(1000) NOT NULL,
	CancelReasonName nvarchar(150) NOT NULL,
	CustomerNotes nvarchar(1000) NOT NULL ,
	OrderBranch INT NOT NULL,
	TotalValue decimal(16, 3) NOT NULL,
)
