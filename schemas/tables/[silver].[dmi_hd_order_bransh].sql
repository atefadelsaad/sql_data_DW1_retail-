DROP TABLE IF EXISTS silver.dmi_hd_order_bransh
CREATE TABLE silver.dmi_hd_order_bransh(
	 CustomerName NVARCHAR(150) NOT NULL,
	 CustomerPhone NVARCHAR(50) NOT NULL,
	 branch_code INT NOT NULL,
	 branch_Name NVARCHAR(50) NOT NULL,
	 Takerno INT NOT NULL,
	 TakerName NVARCHAR(150) NOT NULL, 
	 StatusName NVARCHAR(150) NOT NULL,
	 OrderDate DATE NOT NULL
)
