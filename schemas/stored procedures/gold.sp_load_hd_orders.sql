CREATE OR ALTER PROCEDURE gold.load_hd_orders
AS
BEGIN
      merge [gold].[fact_hd_orders] AS target
      using [silver].[dim_hd_orders] AS source
            ON target.OrderId = source.OrderId
      WHEN MATCHED AND
           target.OrderDate <> source.OrderDate
        OR target.CustomerNo <> source.CustomerNo
        OR target.CustomerName <> source.CustomerName       
        OR target.StatusName <> source.StatusName
        OR target.TakerName <> source.TakerName
        OR target.Notes <> source.Notes
        OR target.CancelReasonName <> source.CancelReasonName
        OR target.CustomerNotes <> source.CustomerNotes
        OR target.OrderBranch <> source.OrderBranch
        OR target.TotalValue <> source.TotalValue
      THEN UPDATE SET
           target.OrderDate = source.OrderDate,
           target.CustomerNo = source.CustomerNo,
           target.CustomerName = source.CustomerName,       
           target.StatusName = source.StatusName,
           target.TakerName = source.TakerName,
           target.Notes = source.Notes,
           target.CancelReasonName = source.CancelReasonName,
           target.CustomerNotes = source.CustomerNotes,
           target.OrderBranch = source.OrderBranch,
           target.TotalValue = source.TotalValue
      WHEN NOT MATCHED BY target
      THEN
           INSERT(OrderId,OrderDate,CustomerNo,CustomerName,StatusName,TakerName,Notes,CancelReasonName,CustomerNotes,OrderBranch,TotalValue,last_date)
           VALUES(source.OrderId,source.OrderDate,source.CustomerNo,source.CustomerName,source.StatusName,source.TakerName,source.Notes,source.CancelReasonName,source.CustomerNotes,source.OrderBranch,source.TotalValue,getdate())
      WHEN NOT MATCHED BY source
      THEN DELETE
      OUTPUT $ACTION AS merge_action,
      inserted.OrderId as OrderId,
      inserted.OrderDate as OrderDate,
      inserted.CustomerNo as CustomerNo,
      inserted.CustomerName as CustomerName,
      deleted.OrderId as OrderId,
      deleted.OrderDate as OrderDate,
      deleted.CustomerNo as CustomerNo,
      deleted.CustomerName as CustomerName;

END
