CREATE OR ALTER PROCEDURE gold.load_branch
AS
BEGIN

    MERGE gold.dim_branch AS target
    USING silver.erp_sys_branch AS source
        ON target.branch = source.branch

    WHEN MATCHED
               AND 
		          target.arabic_name <> source.arabic_name
                  OR target.latin_name  <> source.latin_name
                  OR target.branch_type <> source.branch_type
                   
    THEN
        UPDATE SET
            target.arabic_name = source.arabic_name,
            target.latin_name = source.latin_name,
            target.branch_type = source.branch_type,
            target.lest_update = getdate()
    WHEN NOT MATCHED BY TARGET
    THEN
        INSERT (branch,arabic_name,latin_name,branch_type,lest_update)
        VALUES (source.branch, source.arabic_name, source.latin_name, source.branch_type, GETDATE())
    WHEN NOT MATCHED BY SOURCE
    THEN
        DELETE
		 
        OUTPUT
               $ACTION AS merge_action,
               inserted.branch AS inserted ,
               deleted.branch AS deleted;

END;
