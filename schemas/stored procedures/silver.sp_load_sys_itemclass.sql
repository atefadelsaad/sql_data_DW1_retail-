CREATE OR ALTER PROCEDURE silver.load_sys_itemclass
AS
BEGIN
INSERT INTO silver.dim_sys_itemclass(class,arabic_name,latin_name)
SELECT 
itemclass AS class,
a_name AS arabic_name,
ISNULL(l_name,'N/A') AS latin_name
FROM bronze.erp_sys_itemclass
END
