
CREATE OR ALTER PROCEDURE gold.load_sys_itemclass
AS
BEGIN
	MERGE gold.dim_sys_itemclass AS target
	USING silver.dim_sys_itemclass AS source
	ON target.class = source.class
	WHEN MATCHED AND
	target.arabic_name <> source.arabic_name OR
	target.latin_name <> source.latin_name
	THEN UPDATE SET
    target.arabic_name = source.arabic_name ,
	target.latin_name = source.latin_name
	WHEN NOT MATCHED BY target
	THEN 
	  INSERT(class,arabic_name,latin_name,last_upadet)
	  VALUES(source.class,source.arabic_name,source.latin_name,GETDATE())
	  WHEN NOT MATCHED BY source
	  THEN DELETE;
END
