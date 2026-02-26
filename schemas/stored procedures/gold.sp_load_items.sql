CREATE OR ALTER PROCEDURE gold.load_items
AS
BEGIN

    MERGE gold.dim_item AS target
    USING silver.erp_sys_item   AS source
        ON target.itemean = source.itemean

    WHEN MATCHED
                AND 
                   target.arabic_name<> source.arabic_name
                OR target.latin_name <> source.latin_name
                OR target.sub_group <> source.sub_group
                OR target.supplier <> source.supplier
    THEN
        UPDATE SET
            target.arabic_name = source.arabic_name,
            target.latin_name = source.latin_name,
            target.sub_group = source.sub_group,
            target.supplier = source.supplier

    WHEN NOT MATCHED BY TARGET
    THEN
        INSERT (itemean,arabic_name, latin_name,sub_group,supplier,last_update)
        VALUES (source.itemean,source.arabic_name,source.latin_name,source.sub_group,source.supplier,getdate())

    WHEN NOT MATCHED BY SOURCE
    THEN
        DELETE
		OUTPUT
              $ACTION AS merge_action,
              inserted.arabic_name AS inserted ,
			  inserted.latin_name AS inserted ,
              deleted.arabic_name AS deleted,
              deleted.latin_name AS deleted;  


END;
