DROP TABLE IF EXISTS gold.fact_dh_orders_sales_Year
CREATE TABLE gold.fact_dh_orders_sales_Year(
	Years INT NOT NULL,
	branchname NVARCHAR(50) NOT NULL,
	total_orders BIGINT NOT NULL,
	total_sales BIGINT NOT NULL,
	Avg_Total BIGINT NOT NULL,
	sales_status NVARCHAR(20) NOT NULL,
	Years_sales BIGINT  NULL,
	last_update DATETIME NOT NULL
)
