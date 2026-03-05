CREATE OR ALTER PROCEDURE silver.HDCompletedOrders
AS
DECLARE @to DATETIME = (SELECT CAST(GETDATE() AS DATE)) ;
DECLARE @from DATETIME = DATEADD(DAY,-1,@to);
BEGIN
      INSERT INTO silver.dmi_hd_order_bransh(
		 CustomerName ,
		 CustomerPhone ,
		 branch_code ,
		 branch_Name ,
		 Takerno ,
		 TakerName , 
		 StatusName ,
		 OrderDate 
	  
	  )    
	 SELECT
			CASE 
				WHEN h.CustomerName IS  NULL OR h.CustomerName =''
				THEN ' N/A' 
				ELSE TRIM(h.CustomerName)
			END CustomerName,
			CASE 
				WHEN h.CustomerPhone IS  NULL OR h.CustomerPhone =''
				THEN ' N/A' 
				ELSE TRIM(h.CustomerPhone)
			END CustomerPhone,
			h.OrderBranch AS branch_code,
			ISNULL(TRIM(b.a_name),'N/A') AS branch_Name,
				Takerno,
			TRIM(h.TakerName) AS TakerName,
			CASE 
					WHEN h.StatusName IS  NULL OR h.StatusName = ''
					THEN 'تم توصيل الطلب'
					ELSE TRIM(h.StatusName)
			END  orderStatus,
			CAST(h.OrderDate AS DATE) AS OrderDate
	FROM 
		bronze.erp_hd_orders h
		INNER JOIN bronze.erp_sys_branch b 
		ON h.OrderBranch =b.branch
	where StatusName = 'تم توصيل الطلب' AND StatusCode = 6 AND OrderDate BETWEEN @from AND @to
	ORDER BY OrderDate
END
