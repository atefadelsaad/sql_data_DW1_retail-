
CREATE TABLE [gold].[HDCancelledOrders](
	[OrderId] [bigint] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[CustomerNo] [int] NOT NULL,
	[CustomerName] [nvarchar](150) NOT NULL,
	[orderStatus] [nvarchar](100) NOT NULL,
	[TakerName] [nvarchar](150) NOT NULL,
	[Notes] [nvarchar](150) NOT NULL,
	[CancelReasonName] [nvarchar](150) NOT NULL,
	[CustomerNotes] [nvarchar](1000) NOT NULL,
	[OrderBranch] [int] NOT NULL,
	[arabic_name] [char](50) NOT NULL,
	[TotalValue] [decimal](16, 3) NOT NULL,
	[Barcode] [nvarchar](20) NOT NULL,
	[itemName] [nvarchar](20) NOT NULL,
	[Qty] [decimal](12, 3) NOT NULL,
	[price] [decimal](20, 3) NOT NULL,
	[ItemNotes] [nvarchar](1000) NOT NULL,
	[last_update] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC)
  )
