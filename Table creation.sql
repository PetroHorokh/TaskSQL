IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Address' and xtype='U')
CREATE TABLE [dbo].[Address](
    [AddressId] [uniqueidentifier] NOT NULL,
    [City] [nvarchar](255) NOT NULL,
    [Street] [nvarchar](255) NOT NULL,
    [Building] [nvarchar](255) NOT NULL,
	CONSTRAINT PK_Address PRIMARY KEY ([AddressId])
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='RoomType' and xtype='U')
CREATE TABLE [dbo].[RoomType](
    [RoomTypeId] [int] NOT NULL,
    [Type] [nvarchar](20)  NOT NULL,
    CONSTRAINT PK_RoomType PRIMARY KEY ([RoomTypeId])
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Price' and xtype='U')
CREATE TABLE [dbo].[Price](
    [PriceId] [uniqueidentifier] NOT NULL,
    [StartDate] [date] NOT NULL,
    [EndDate] [date] NULL,
    [RoomTypeId] [int] NOT NULL,
    CONSTRAINT PK_Price PRIMARY KEY ([PriceId])
)
GO
IF NOT EXISTS(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_Price_RoomTypeId_RoomType_RoomTypeId'
)
ALTER TABLE [dbo].[Price]  WITH CHECK ADD  CONSTRAINT [FK_Price_RoomTypeId_RoomType_RoomTypeId] FOREIGN KEY([RoomTypeId])
REFERENCES [dbo].[RoomType] ([RoomTypeId])
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Room' and xtype='U')
CREATE TABLE [dbo].[Room](
    [RoomId] [uniqueidentifier] NOT NULL,
    [Area] [int]  NOT NULL,
    [RoomTypeId] [int] NOT NULL,
    CONSTRAINT PK_Price PRIMARY KEY ([RoomId])
)
GO
IF NOT EXISTS(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_Room_RoomTypeId_RoomType_RoomTypeId'
)
ALTER TABLE [dbo].[Room]  WITH CHECK ADD  CONSTRAINT [FK_Room_RoomTypeId_RoomType_RoomTypeId] FOREIGN KEY([RoomTypeId])
REFERENCES [dbo].[RoomType] ([RoomTypeId])
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Owner' and xtype='U')
CREATE TABLE [dbo].[Owner](
    [OwnerId] [uniqueidentifier] NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [AddressId] [uniqueidentifier] NOT NULL,
    CONSTRAINT [PK_Owner] PRIMARY KEY ([OwnerId])
)
GO
IF NOT EXISTS(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_Owner_AddressId_Address_AddressId'
)
ALTER TABLE [dbo].[Owner]  WITH CHECK ADD  CONSTRAINT [FK_Owner_AddressId_Address_AddressId] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Address] ([AddressId])
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='OwnerShip' and xtype='U')
CREATE TABLE [dbo].[OwnerShip](
    [OwnerShipId] [uniqueidentifier] NOT NULL,
    [OwnerId] [uniqueidentifier] NOT NULL,
    [RoomId] [uniqueidentifier] NOT NULL,
    [StartDate] [date] NOT NULL,
    [EndDate] [date] NULL,
    CONSTRAINT [PK_OwnerShip] PRIMARY KEY([OwnerShipId])
)
GO
IF NOT EXISTS(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_OwnerShip_OwnerId_Owner_OwnerId'
)
ALTER TABLE [dbo].[OwnerShip]  WITH CHECK ADD  CONSTRAINT [FK_OwnerShip_OwnerId_Owner_OwnerId] FOREIGN KEY([OwnerId])
REFERENCES [dbo].[Owner] ([OwnerId])
GO
IF NOT EXISTS(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_OwnerShip_RoomId_Room_RoomId'
)
ALTER TABLE [dbo].[OwnerShip]  WITH CHECK ADD  CONSTRAINT [FK_OwnerShip_RoomId_Room_RoomId] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Tenant' and xtype='U')
CREATE TABLE [dbo].[Tenant](
    [TenantId] [uniqueidentifier] NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [BankName] [nvarchar](50) NOT NULL,
    [AddressId] [uniqueidentifier] NOT NULL,
    [Director] [nvarchar](50) NOT NULL,
    [Description] [nvarchar](255) NOT NULL,
    CONSTRAINT [PK_Tenant] PRIMARY KEY([TenantId])
)
GO
IF NOT EXISTS(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_Tenant_AddressId_Address_AddressId'
)
ALTER TABLE [dbo].[Tenant]  WITH CHECK ADD  CONSTRAINT [FK_Tenant_AddressId_Address_AddressId] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Address] ([AddressId])
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Account' and xtype='U')
CREATE TABLE [dbo].[Account](
    [AccountId] [uniqueidentifier] NOT NULL,
    [TenantId] [uniqueidentifier] NOT NULL,
    [ToBePaidAmount] [numeric](18, 2) NOT NULL,
    [StartDate] [date] NOT NULL,
	[EndDate] [date] NULL,
    CONSTRAINT [PK_Account] PRIMARY KEY ([AccountId])
)
GO
IF NOT EXISTS(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_Account_TenantId_Tenant_TenantId'
)
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_TenantId_Tenant_TenantId] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([TenantId])
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Rent' and xtype='U')
CREATE TABLE [dbo].[Rent](
	[RentId] [uniqueidentifier] NOT NULL,
    [RoomId] [uniqueidentifier] NOT NULL,
    [TenantId] [uniqueidentifier] NOT NULL,
    [StartDate] [date] NOT NULL,
    [EndDate] [date] NULL,
    CONSTRAINT [PK_Rent] PRIMARY KEY ([RentId])
)
GO
IF NOT EXISTS(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_Rent_RoomId_Room_RoomId'
)
ALTER TABLE [dbo].[Rent]  WITH CHECK ADD  CONSTRAINT [FK_Rent_RoomId_Room_RoomId] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
GO
IF NOT EXISTS(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_Rent_TenantId_Tenant_TenantId'
)
ALTER TABLE [dbo].[Rent]  WITH CHECK ADD  CONSTRAINT [FK_Rent_TenantId_Tenant_TenantId] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([TenantId])
GO