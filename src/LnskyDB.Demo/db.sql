USE LnskyNS_Test
GO

IF DB_NAME() <> N'LnskyNS_Test' SET NOEXEC ON
GO
/****** Object:  Table [dbo].[Purify_ProductSaleByDayNS]    Script Date: 2019/6/18 17:09:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Purify_ProductSaleByDayNS](
	[SysNo] [uniqueidentifier] NOT NULL,
	[DataSource] [nvarchar](100) NOT NULL,
	[OutProductID] [nvarchar](100) NOT NULL,
	[BrandID] [uniqueidentifier] NOT NULL,
	[CategoryID] [uniqueidentifier] NOT NULL,
	[ProductID] [uniqueidentifier] NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[ShopID] [uniqueidentifier] NOT NULL,
	[ShopName] [nvarchar](100) NULL,
	[StatisticalDate] [date] NOT NULL,
	[Sales] [decimal](18, 2) NOT NULL,
	[NumberOfSales] [int] NOT NULL,
	[AveragePrice] [decimal](18, 2) NOT NULL,
	[OrderQuantity] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateDate] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[ImportGroupId] [uniqueidentifier] NOT NULL,
	[IsExclude] [bit] NOT NULL,
 CONSTRAINT [PK_Purify_ProductSaleByDayNS] PRIMARY KEY CLUSTERED 
(
	[SysNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Purify_ProductSaleByDayNS] ADD  CONSTRAINT [DF_Purify_ProductSaleByDayNS_SysNo]  DEFAULT (newid()) FOR [SysNo]
GO

ALTER TABLE [dbo].[Purify_ProductSaleByDayNS] ADD  CONSTRAINT [DF_Purify_ProductSaleByDayNS_OutProductID]  DEFAULT ('') FOR [OutProductID]
GO

ALTER TABLE [dbo].[Purify_ProductSaleByDayNS] ADD  CONSTRAINT [DF_Purify_ProductSaleByDayNS_BrandID]  DEFAULT (CONVERT([binary],(0))) FOR [BrandID]
GO

ALTER TABLE [dbo].[Purify_ProductSaleByDayNS] ADD  CONSTRAINT [DF_Purify_ProductSaleByDayNS_CategoryID]  DEFAULT (CONVERT([binary],(0))) FOR [CategoryID]
GO

ALTER TABLE [dbo].[Purify_ProductSaleByDayNS] ADD  CONSTRAINT [DF_Purify_ProductSaleByDayNS_ProductID]  DEFAULT (CONVERT([binary],(0))) FOR [ProductID]
GO

ALTER TABLE [dbo].[Purify_ProductSaleByDayNS] ADD  CONSTRAINT [DF_Purify_ProductSaleByDayNS_ShopID]  DEFAULT (CONVERT([binary],(0))) FOR [ShopID]
GO

ALTER TABLE [dbo].[Purify_ProductSaleByDayNS] ADD  CONSTRAINT [DF_Purify_ProductSaleByDayNS_ShopName]  DEFAULT ('') FOR [ShopName]
GO

ALTER TABLE [dbo].[Purify_ProductSaleByDayNS] ADD  CONSTRAINT [DF_Purify_ProductSaleByDayNS_Sales]  DEFAULT ((0)) FOR [Sales]
GO

ALTER TABLE [dbo].[Purify_ProductSaleByDayNS] ADD  CONSTRAINT [DF_Purify_ProductSaleByDayNS_NumberOfSales]  DEFAULT ((0)) FOR [NumberOfSales]
GO

ALTER TABLE [dbo].[Purify_ProductSaleByDayNS] ADD  CONSTRAINT [DF_Purify_ProductSaleByDayNS_AveragePrice]  DEFAULT ((0)) FOR [AveragePrice]
GO

ALTER TABLE [dbo].[Purify_ProductSaleByDayNS] ADD  CONSTRAINT [DF_Purify_ProductSaleByDayNS_OrderQuantity]  DEFAULT ((0)) FOR [OrderQuantity]
GO

ALTER TABLE [dbo].[Purify_ProductSaleByDayNS] ADD  CONSTRAINT [DF_Purify_ProductSaleByDayNS_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[Purify_ProductSaleByDayNS] ADD  CONSTRAINT [DF_Purify_ProductSaleByDayNS_CreateUserID]  DEFAULT (CONVERT([binary],(0))) FOR [CreateUserID]
GO

ALTER TABLE [dbo].[Purify_ProductSaleByDayNS] ADD  CONSTRAINT [DF_Purify_ProductSaleByDayNS_IsExclude]  DEFAULT ((0)) FOR [IsExclude]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据来源' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purify_ProductSaleByDayNS', @level2type=N'COLUMN',@level2name=N'DataSource'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'外部商品ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purify_ProductSaleByDayNS', @level2type=N'COLUMN',@level2name=N'OutProductID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purify_ProductSaleByDayNS', @level2type=N'COLUMN',@level2name=N'CategoryID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purify_ProductSaleByDayNS', @level2type=N'COLUMN',@level2name=N'ProductID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purify_ProductSaleByDayNS', @level2type=N'COLUMN',@level2name=N'ProductName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'店铺ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purify_ProductSaleByDayNS', @level2type=N'COLUMN',@level2name=N'ShopID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'店铺名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purify_ProductSaleByDayNS', @level2type=N'COLUMN',@level2name=N'ShopName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'统计日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purify_ProductSaleByDayNS', @level2type=N'COLUMN',@level2name=N'StatisticalDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'销售额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purify_ProductSaleByDayNS', @level2type=N'COLUMN',@level2name=N'Sales'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'销量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purify_ProductSaleByDayNS', @level2type=N'COLUMN',@level2name=N'NumberOfSales'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品均价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purify_ProductSaleByDayNS', @level2type=N'COLUMN',@level2name=N'AveragePrice'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purify_ProductSaleByDayNS', @level2type=N'COLUMN',@level2name=N'OrderQuantity'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purify_ProductSaleByDayNS', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purify_ProductSaleByDayNS', @level2type=N'COLUMN',@level2name=N'CreateUserID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purify_ProductSaleByDayNS', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purify_ProductSaleByDayNS', @level2type=N'COLUMN',@level2name=N'UpdateUserID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'导入组' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purify_ProductSaleByDayNS', @level2type=N'COLUMN',@level2name=N'ImportGroupId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'黑名单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purify_ProductSaleByDayNS', @level2type=N'COLUMN',@level2name=N'IsExclude'
GO



USE [Lnsky_Test_19]
GO

IF DB_NAME() <> N'Lnsky_Test_19' SET NOEXEC ON
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_12]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_12] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_12] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_12] on table [dbo].[Purify_ProductSaleByDay_12]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_12]
  ON [dbo].[Purify_ProductSaleByDay_12] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_12_DOS] on table [dbo].[Purify_ProductSaleByDay_12]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_12_DOS]
  ON [dbo].[Purify_ProductSaleByDay_12] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_12_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_12]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_12_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_12] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_12_OrderBy] on table [dbo].[Purify_ProductSaleByDay_12]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_12_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_12] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_12_ShopID] on table [dbo].[Purify_ProductSaleByDay_12]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_12_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_12] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_12_SI] on table [dbo].[Purify_ProductSaleByDay_12]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_12_SI]
  ON [dbo].[Purify_ProductSaleByDay_12] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_12_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_12]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_12_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_12] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_11]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_11] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_11] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_11] on table [dbo].[Purify_ProductSaleByDay_11]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_11]
  ON [dbo].[Purify_ProductSaleByDay_11] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_11_DOS] on table [dbo].[Purify_ProductSaleByDay_11]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_11_DOS]
  ON [dbo].[Purify_ProductSaleByDay_11] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_11_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_11]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_11_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_11] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_11_OrderBy] on table [dbo].[Purify_ProductSaleByDay_11]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_11_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_11] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_11_ShopID] on table [dbo].[Purify_ProductSaleByDay_11]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_11_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_11] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_11_SI] on table [dbo].[Purify_ProductSaleByDay_11]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_11_SI]
  ON [dbo].[Purify_ProductSaleByDay_11] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_11_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_11]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_11_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_11] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_10]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_10] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_10] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_10] on table [dbo].[Purify_ProductSaleByDay_10]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_10]
  ON [dbo].[Purify_ProductSaleByDay_10] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_10_DOS] on table [dbo].[Purify_ProductSaleByDay_10]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_10_DOS]
  ON [dbo].[Purify_ProductSaleByDay_10] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_10_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_10]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_10_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_10] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_10_OrderBy] on table [dbo].[Purify_ProductSaleByDay_10]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_10_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_10] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_10_ShopID] on table [dbo].[Purify_ProductSaleByDay_10]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_10_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_10] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_10_SI] on table [dbo].[Purify_ProductSaleByDay_10]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_10_SI]
  ON [dbo].[Purify_ProductSaleByDay_10] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_10_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_10]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_10_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_10] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_09]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_09] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_09] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_09] on table [dbo].[Purify_ProductSaleByDay_09]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_09]
  ON [dbo].[Purify_ProductSaleByDay_09] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_09_DOS] on table [dbo].[Purify_ProductSaleByDay_09]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_09_DOS]
  ON [dbo].[Purify_ProductSaleByDay_09] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_09_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_09]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_09_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_09] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_09_OrderBy] on table [dbo].[Purify_ProductSaleByDay_09]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_09_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_09] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_09_ShopID] on table [dbo].[Purify_ProductSaleByDay_09]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_09_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_09] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_09_SI] on table [dbo].[Purify_ProductSaleByDay_09]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_09_SI]
  ON [dbo].[Purify_ProductSaleByDay_09] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_09_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_09]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_09_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_09] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_08]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_08] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_08] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_08] on table [dbo].[Purify_ProductSaleByDay_08]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_08]
  ON [dbo].[Purify_ProductSaleByDay_08] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_08_DOS] on table [dbo].[Purify_ProductSaleByDay_08]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_08_DOS]
  ON [dbo].[Purify_ProductSaleByDay_08] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_08_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_08]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_08_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_08] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_08_OrderBy] on table [dbo].[Purify_ProductSaleByDay_08]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_08_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_08] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_08_ShopID] on table [dbo].[Purify_ProductSaleByDay_08]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_08_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_08] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_08_SI] on table [dbo].[Purify_ProductSaleByDay_08]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_08_SI]
  ON [dbo].[Purify_ProductSaleByDay_08] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_08_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_08]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_08_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_08] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_07]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_07] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_07] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_07] on table [dbo].[Purify_ProductSaleByDay_07]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_07]
  ON [dbo].[Purify_ProductSaleByDay_07] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_07_DOS] on table [dbo].[Purify_ProductSaleByDay_07]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_07_DOS]
  ON [dbo].[Purify_ProductSaleByDay_07] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_07_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_07]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_07_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_07] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_07_OrderBy] on table [dbo].[Purify_ProductSaleByDay_07]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_07_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_07] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_07_ShopID] on table [dbo].[Purify_ProductSaleByDay_07]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_07_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_07] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_07_SI] on table [dbo].[Purify_ProductSaleByDay_07]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_07_SI]
  ON [dbo].[Purify_ProductSaleByDay_07] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_07_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_07]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_07_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_07] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_06]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_06] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_06] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_06] on table [dbo].[Purify_ProductSaleByDay_06]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_06]
  ON [dbo].[Purify_ProductSaleByDay_06] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_06_DOS] on table [dbo].[Purify_ProductSaleByDay_06]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_06_DOS]
  ON [dbo].[Purify_ProductSaleByDay_06] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_06_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_06]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_06_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_06] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_06_OrderBy] on table [dbo].[Purify_ProductSaleByDay_06]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_06_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_06] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_06_ShopID] on table [dbo].[Purify_ProductSaleByDay_06]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_06_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_06] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_06_SI] on table [dbo].[Purify_ProductSaleByDay_06]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_06_SI]
  ON [dbo].[Purify_ProductSaleByDay_06] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_06_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_06]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_06_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_06] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_05]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_05] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_05] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_05] on table [dbo].[Purify_ProductSaleByDay_05]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_05]
  ON [dbo].[Purify_ProductSaleByDay_05] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_05_BrandID] on table [dbo].[Purify_ProductSaleByDay_05]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_05_BrandID]
  ON [dbo].[Purify_ProductSaleByDay_05] ([StatisticalDate], [IsExclude], [BrandID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_05_DOS] on table [dbo].[Purify_ProductSaleByDay_05]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_05_DOS]
  ON [dbo].[Purify_ProductSaleByDay_05] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_05_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_05]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_05_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_05] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_05_OrderBy] on table [dbo].[Purify_ProductSaleByDay_05]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_05_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_05] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_05_ShopID] on table [dbo].[Purify_ProductSaleByDay_05]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_05_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_05] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_05_SI] on table [dbo].[Purify_ProductSaleByDay_05]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_05_SI]
  ON [dbo].[Purify_ProductSaleByDay_05] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_05_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_05]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_05_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_05] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_04]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_04] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_04] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_04] on table [dbo].[Purify_ProductSaleByDay_04]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_04]
  ON [dbo].[Purify_ProductSaleByDay_04] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_04_DOS] on table [dbo].[Purify_ProductSaleByDay_04]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_04_DOS]
  ON [dbo].[Purify_ProductSaleByDay_04] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_04_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_04]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_04_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_04] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_04_OrderBy] on table [dbo].[Purify_ProductSaleByDay_04]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_04_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_04] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_04_ShopID] on table [dbo].[Purify_ProductSaleByDay_04]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_04_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_04] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_04_SI] on table [dbo].[Purify_ProductSaleByDay_04]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_04_SI]
  ON [dbo].[Purify_ProductSaleByDay_04] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_04_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_04]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_04_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_04] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_03]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_03] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_03] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_03] on table [dbo].[Purify_ProductSaleByDay_03]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_03]
  ON [dbo].[Purify_ProductSaleByDay_03] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_03_DOS] on table [dbo].[Purify_ProductSaleByDay_03]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_03_DOS]
  ON [dbo].[Purify_ProductSaleByDay_03] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_03_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_03]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_03_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_03] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_03_OrderBy] on table [dbo].[Purify_ProductSaleByDay_03]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_03_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_03] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_03_ShopID] on table [dbo].[Purify_ProductSaleByDay_03]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_03_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_03] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_03_SI] on table [dbo].[Purify_ProductSaleByDay_03]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_03_SI]
  ON [dbo].[Purify_ProductSaleByDay_03] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_03_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_03]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_03_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_03] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_02]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_02] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_IsExclude_1] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_02] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_02] on table [dbo].[Purify_ProductSaleByDay_02]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_02]
  ON [dbo].[Purify_ProductSaleByDay_02] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_02_DOS] on table [dbo].[Purify_ProductSaleByDay_02]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_02_DOS]
  ON [dbo].[Purify_ProductSaleByDay_02] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_02_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_02]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_02_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_02] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_02_OrderBy] on table [dbo].[Purify_ProductSaleByDay_02]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_02_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_02] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_02_ShopID] on table [dbo].[Purify_ProductSaleByDay_02]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_02_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_02] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_02_SI] on table [dbo].[Purify_ProductSaleByDay_02]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_02_SI]
  ON [dbo].[Purify_ProductSaleByDay_02] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_02_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_02]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_02_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_02] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_01]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_01] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_01] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_01] on table [dbo].[Purify_ProductSaleByDay_01]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_01]
  ON [dbo].[Purify_ProductSaleByDay_01] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_01_DOS] on table [dbo].[Purify_ProductSaleByDay_01]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_01_DOS]
  ON [dbo].[Purify_ProductSaleByDay_01] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_01_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_01]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_01_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_01] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_01_OrderBy] on table [dbo].[Purify_ProductSaleByDay_01]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_01_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_01] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_01_ShopID] on table [dbo].[Purify_ProductSaleByDay_01]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_01_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_01] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_01_SI] on table [dbo].[Purify_ProductSaleByDay_01]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_01_SI]
  ON [dbo].[Purify_ProductSaleByDay_01] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_01_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_01]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_01_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_01] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'IsExclude'
GO

--
-- Set NOEXEC to off
--
SET NOEXEC OFF
GO

USE [Lnsky_Test_18]
GO

IF DB_NAME() <> N'Lnsky_Test_18' SET NOEXEC ON
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_12]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_12] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_12_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_12] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_12] on table [dbo].[Purify_ProductSaleByDay_12]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_12]
  ON [dbo].[Purify_ProductSaleByDay_12] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_12_DOS] on table [dbo].[Purify_ProductSaleByDay_12]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_12_DOS]
  ON [dbo].[Purify_ProductSaleByDay_12] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_12_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_12]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_12_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_12] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_12_OrderBy] on table [dbo].[Purify_ProductSaleByDay_12]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_12_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_12] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_12_ShopID] on table [dbo].[Purify_ProductSaleByDay_12]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_12_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_12] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_12_SI] on table [dbo].[Purify_ProductSaleByDay_12]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_12_SI]
  ON [dbo].[Purify_ProductSaleByDay_12] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_12_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_12]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_12_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_12] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_12].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_12', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_11]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_11] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_11_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_11] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_11] on table [dbo].[Purify_ProductSaleByDay_11]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_11]
  ON [dbo].[Purify_ProductSaleByDay_11] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_11_DOS] on table [dbo].[Purify_ProductSaleByDay_11]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_11_DOS]
  ON [dbo].[Purify_ProductSaleByDay_11] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_11_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_11]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_11_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_11] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_11_OrderBy] on table [dbo].[Purify_ProductSaleByDay_11]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_11_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_11] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_11_ShopID] on table [dbo].[Purify_ProductSaleByDay_11]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_11_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_11] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_11_SI] on table [dbo].[Purify_ProductSaleByDay_11]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_11_SI]
  ON [dbo].[Purify_ProductSaleByDay_11] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_11_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_11]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_11_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_11] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_11].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_11', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_10]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_10] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_10_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_10] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_10] on table [dbo].[Purify_ProductSaleByDay_10]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_10]
  ON [dbo].[Purify_ProductSaleByDay_10] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_10_DOS] on table [dbo].[Purify_ProductSaleByDay_10]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_10_DOS]
  ON [dbo].[Purify_ProductSaleByDay_10] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_10_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_10]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_10_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_10] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_10_OrderBy] on table [dbo].[Purify_ProductSaleByDay_10]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_10_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_10] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_10_ShopID] on table [dbo].[Purify_ProductSaleByDay_10]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_10_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_10] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_10_SI] on table [dbo].[Purify_ProductSaleByDay_10]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_10_SI]
  ON [dbo].[Purify_ProductSaleByDay_10] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_10_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_10]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_10_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_10] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_10].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_10', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_09]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_09] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_09_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_09] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_09] on table [dbo].[Purify_ProductSaleByDay_09]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_09]
  ON [dbo].[Purify_ProductSaleByDay_09] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_09_DOS] on table [dbo].[Purify_ProductSaleByDay_09]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_09_DOS]
  ON [dbo].[Purify_ProductSaleByDay_09] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_09_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_09]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_09_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_09] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_09_OrderBy] on table [dbo].[Purify_ProductSaleByDay_09]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_09_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_09] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_09_ShopID] on table [dbo].[Purify_ProductSaleByDay_09]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_09_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_09] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_09_SI] on table [dbo].[Purify_ProductSaleByDay_09]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_09_SI]
  ON [dbo].[Purify_ProductSaleByDay_09] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_09_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_09]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_09_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_09] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_09].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_09', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_08]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_08] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_08_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_08] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_08] on table [dbo].[Purify_ProductSaleByDay_08]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_08]
  ON [dbo].[Purify_ProductSaleByDay_08] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_08_DOS] on table [dbo].[Purify_ProductSaleByDay_08]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_08_DOS]
  ON [dbo].[Purify_ProductSaleByDay_08] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_08_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_08]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_08_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_08] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_08_OrderBy] on table [dbo].[Purify_ProductSaleByDay_08]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_08_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_08] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_08_ShopID] on table [dbo].[Purify_ProductSaleByDay_08]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_08_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_08] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_08_SI] on table [dbo].[Purify_ProductSaleByDay_08]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_08_SI]
  ON [dbo].[Purify_ProductSaleByDay_08] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_08_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_08]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_08_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_08] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_08].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_08', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_07]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_07] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_07_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_07] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_07] on table [dbo].[Purify_ProductSaleByDay_07]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_07]
  ON [dbo].[Purify_ProductSaleByDay_07] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_07_DOS] on table [dbo].[Purify_ProductSaleByDay_07]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_07_DOS]
  ON [dbo].[Purify_ProductSaleByDay_07] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_07_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_07]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_07_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_07] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_07_OrderBy] on table [dbo].[Purify_ProductSaleByDay_07]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_07_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_07] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_07_ShopID] on table [dbo].[Purify_ProductSaleByDay_07]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_07_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_07] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_07_SI] on table [dbo].[Purify_ProductSaleByDay_07]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_07_SI]
  ON [dbo].[Purify_ProductSaleByDay_07] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_07_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_07]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_07_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_07] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_07].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_07', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_06]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_06] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_06_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_06] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_06] on table [dbo].[Purify_ProductSaleByDay_06]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_06]
  ON [dbo].[Purify_ProductSaleByDay_06] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_06_DOS] on table [dbo].[Purify_ProductSaleByDay_06]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_06_DOS]
  ON [dbo].[Purify_ProductSaleByDay_06] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_06_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_06]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_06_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_06] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_06_OrderBy] on table [dbo].[Purify_ProductSaleByDay_06]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_06_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_06] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_06_ShopID] on table [dbo].[Purify_ProductSaleByDay_06]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_06_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_06] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_06_SI] on table [dbo].[Purify_ProductSaleByDay_06]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_06_SI]
  ON [dbo].[Purify_ProductSaleByDay_06] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_06_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_06]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_06_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_06] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_06].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_06', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_05]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_05] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_05_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_05] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_05] on table [dbo].[Purify_ProductSaleByDay_05]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_05]
  ON [dbo].[Purify_ProductSaleByDay_05] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_05_DOS] on table [dbo].[Purify_ProductSaleByDay_05]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_05_DOS]
  ON [dbo].[Purify_ProductSaleByDay_05] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_05_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_05]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_05_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_05] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_05_OrderBy] on table [dbo].[Purify_ProductSaleByDay_05]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_05_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_05] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_05_ShopID] on table [dbo].[Purify_ProductSaleByDay_05]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_05_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_05] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_05_SI] on table [dbo].[Purify_ProductSaleByDay_05]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_05_SI]
  ON [dbo].[Purify_ProductSaleByDay_05] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_05_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_05]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_05_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_05] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_05].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_05', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_04]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_04] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_04_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_04] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_04] on table [dbo].[Purify_ProductSaleByDay_04]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_04]
  ON [dbo].[Purify_ProductSaleByDay_04] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_04_DOS] on table [dbo].[Purify_ProductSaleByDay_04]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_04_DOS]
  ON [dbo].[Purify_ProductSaleByDay_04] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_04_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_04]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_04_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_04] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_04_OrderBy] on table [dbo].[Purify_ProductSaleByDay_04]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_04_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_04] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_04_ShopID] on table [dbo].[Purify_ProductSaleByDay_04]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_04_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_04] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_04_SI] on table [dbo].[Purify_ProductSaleByDay_04]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_04_SI]
  ON [dbo].[Purify_ProductSaleByDay_04] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_04_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_04]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_04_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_04] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_04].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_04', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_03]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_03] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_03_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_03] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_03] on table [dbo].[Purify_ProductSaleByDay_03]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_03]
  ON [dbo].[Purify_ProductSaleByDay_03] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_03_DOS] on table [dbo].[Purify_ProductSaleByDay_03]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_03_DOS]
  ON [dbo].[Purify_ProductSaleByDay_03] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_03_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_03]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_03_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_03] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_03_OrderBy] on table [dbo].[Purify_ProductSaleByDay_03]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_03_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_03] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_03_ShopID] on table [dbo].[Purify_ProductSaleByDay_03]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_03_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_03] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_03_SI] on table [dbo].[Purify_ProductSaleByDay_03]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_03_SI]
  ON [dbo].[Purify_ProductSaleByDay_03] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_03_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_03]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_03_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_03] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_03].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_03', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_02]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_02] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_02_IsExclude_1] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_02] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_02] on table [dbo].[Purify_ProductSaleByDay_02]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_02]
  ON [dbo].[Purify_ProductSaleByDay_02] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_02_DOS] on table [dbo].[Purify_ProductSaleByDay_02]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_02_DOS]
  ON [dbo].[Purify_ProductSaleByDay_02] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_02_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_02]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_02_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_02] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_02_OrderBy] on table [dbo].[Purify_ProductSaleByDay_02]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_02_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_02] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_02_ShopID] on table [dbo].[Purify_ProductSaleByDay_02]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_02_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_02] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_02_SI] on table [dbo].[Purify_ProductSaleByDay_02]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_02_SI]
  ON [dbo].[Purify_ProductSaleByDay_02] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_02_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_02]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_02_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_02] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_02].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_02', 'COLUMN', N'IsExclude'
GO

--
-- Create table [dbo].[Purify_ProductSaleByDay_01]
--
CREATE TABLE [dbo].[Purify_ProductSaleByDay_01] (
  [SysNo] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_SysNo] DEFAULT (newid()),
  [DataSource] [nvarchar](100) NOT NULL,
  [OutProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_OutProductID] DEFAULT (''),
  [BrandID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_BrandID] DEFAULT (CONVERT([binary],(0))),
  [CategoryID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_CategoryID] DEFAULT (CONVERT([binary],(0))),
  [ProductID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_ProductID] DEFAULT (CONVERT([binary],(0))),
  [ProductName] [nvarchar](100) NOT NULL,
  [ShopID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_ShopID] DEFAULT (CONVERT([binary],(0))),
  [ShopName] [nvarchar](100) NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_ShopName] DEFAULT (''),
  [StatisticalDate] [date] NOT NULL,
  [Sales] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_Sales] DEFAULT (0),
  [NumberOfSales] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_NumberOfSales] DEFAULT (0),
  [AveragePrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_AveragePrice] DEFAULT (0),
  [OrderQuantity] [int] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_OrderQuantity] DEFAULT (0),
  [CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_CreateDate] DEFAULT (getdate()),
  [CreateUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_CreateUserID] DEFAULT (CONVERT([binary],(0))),
  [UpdateDate] [datetime] NULL,
  [UpdateUserID] [uniqueidentifier] NULL,
  [ImportGroupId] [uniqueidentifier] NOT NULL,
  [IsExclude] [bit] NOT NULL CONSTRAINT [DF_Purify_ProductSaleByDay_01_IsExclude] DEFAULT (0),
  CONSTRAINT [PK_Purify_ProductSaleByDay_01] PRIMARY KEY CLUSTERED ([SysNo])
)
ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_01] on table [dbo].[Purify_ProductSaleByDay_01]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_01]
  ON [dbo].[Purify_ProductSaleByDay_01] ([UpdateDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_01_DOS] on table [dbo].[Purify_ProductSaleByDay_01]
--
CREATE UNIQUE INDEX [IX_Purify_ProductSaleByDay_01_DOS]
  ON [dbo].[Purify_ProductSaleByDay_01] ([DataSource], [OutProductID], [StatisticalDate])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_01_GenerateShopSaleByDay] on table [dbo].[Purify_ProductSaleByDay_01]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_01_GenerateShopSaleByDay]
  ON [dbo].[Purify_ProductSaleByDay_01] ([StatisticalDate], [IsExclude], [BrandID], [CategoryID])
  INCLUDE ([DataSource], [ShopID], [Sales], [NumberOfSales], [OrderQuantity])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_01_OrderBy] on table [dbo].[Purify_ProductSaleByDay_01]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_01_OrderBy]
  ON [dbo].[Purify_ProductSaleByDay_01] ([StatisticalDate] DESC, [UpdateDate] DESC, [CreateDate] DESC, [SysNo])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_01_ShopID] on table [dbo].[Purify_ProductSaleByDay_01]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_01_ShopID]
  ON [dbo].[Purify_ProductSaleByDay_01] ([ShopID])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_01_SI] on table [dbo].[Purify_ProductSaleByDay_01]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_01_SI]
  ON [dbo].[Purify_ProductSaleByDay_01] ([StatisticalDate] DESC, [IsExclude])
  ON [PRIMARY]
GO

--
-- Create index [IX_Purify_ProductSaleByDay_01_StatisticalDate] on table [dbo].[Purify_ProductSaleByDay_01]
--
CREATE INDEX [IX_Purify_ProductSaleByDay_01_StatisticalDate]
  ON [dbo].[Purify_ProductSaleByDay_01] ([StatisticalDate] DESC)
  ON [PRIMARY]
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[DataSource]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'数据来源', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'DataSource'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[OutProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'外部商品ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'OutProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[CategoryID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'分类id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'CategoryID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[ProductID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品id', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'ProductID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[ProductName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'ProductName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[ShopID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺ID', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'ShopID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[ShopName]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'店铺名称', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'ShopName'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[StatisticalDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'统计日期', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'StatisticalDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[Sales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销售额', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'Sales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[NumberOfSales]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'销量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'NumberOfSales'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[AveragePrice]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'商品均价', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'AveragePrice'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[OrderQuantity]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'订单量', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'OrderQuantity'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[CreateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'CreateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[CreateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'创建人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'CreateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[UpdateDate]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新时间', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'UpdateDate'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[UpdateUserID]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'更新人', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'UpdateUserID'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[ImportGroupId]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'导入组', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'ImportGroupId'
GO

--
-- Add extended property [MS_Description] on column [dbo].[Purify_ProductSaleByDay_01].[IsExclude]
--
EXEC sys.sp_addextendedproperty N'MS_Description', N'黑名单', 'SCHEMA', N'dbo', 'TABLE', N'Purify_ProductSaleByDay_01', 'COLUMN', N'IsExclude'
GO

--
-- Set NOEXEC to off
--
SET NOEXEC OFF
GO

