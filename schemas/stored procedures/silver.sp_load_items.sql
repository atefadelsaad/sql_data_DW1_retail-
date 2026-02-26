CREATE OR ALTER PROCEDURE silver.load_items AS
BEGIN
	INSERT INTO silver.erp_sys_item 
	   (
		itemean,
		arabic_name,
		latin_name,
		sub_group,
		supplier 
	    )
	SELECT 
	TRIM(itemean) AS itemean,
	TRIM(a_name) AS arabic_name,
	CASE
		WHEN l_name IS NULL OR l_name = ''
		THEN 'N/A'
		ELSE l_name
	END latin_name,
	    department AS sub_group,
	    producerrno AS supplier
	FROM bronze.erp_sys_item ORDER BY itemean
END
EXEC silver.load_items
SELECT * FROM silver.erp_sys_item 
