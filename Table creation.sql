CREATE TABLE [dbo].[Address](
    [AddressId] [uniqueidentifier] NOT NULL,
    [City] [nvarchar](255) NOT NULL,
	[Street] [nvarchar](255) NOT NULL,
	[Building] [nvarchar](255) NOT NULL,
    PRIMARY KEY ([AddressId])
)
GO

CREATE TABLE [dbo].[RoomType](
    [RoomTypeId] [int] NOT NULL,
    [Type] [nvarchar](20)  NOT NULL,
    PRIMARY KEY ([RoomTypeId])
)
GO

CREATE TABLE [dbo].[Price](
    [PriceId] [uniqueidentifier] NOT NULL,
    [StartDate] [date] NOT NULL,
    [EndDate] [date] NULL,
    [RoomTypeId] [int] NOT NULL,
    PRIMARY KEY ([PriceId])
)
GO
ALTER TABLE [dbo].[Price]  WITH CHECK ADD  CONSTRAINT [FK_Price_RoomTypeId_RoomType_RoomTypeId] FOREIGN KEY([RoomTypeId])
REFERENCES [dbo].[RoomType] ([RoomTypeId])
GO

CREATE TABLE [dbo].[Room](
    [RoomId] [int] NOT NULL,
    [Area] [int]  NOT NULL,
    [RoomTypeId] [int] NOT NULL,
    PRIMARY KEY ([RoomId])
)
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD  CONSTRAINT [FK_Room_RoomTypeId_RoomType_RoomTypeId] FOREIGN KEY([RoomTypeId])
REFERENCES [dbo].[RoomType] ([RoomTypeId])
GO

CREATE TABLE [dbo].[Owner](
    [OwnerId] [uniqueidentifier] NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [AddressId] [int] NOT NULL,
    PRIMARY KEY ([OwnerId])
)
GO
ALTER TABLE [dbo].[Owner]  WITH CHECK ADD  CONSTRAINT [FK_Owner_AddressId_Address_AddressId] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Address] ([AddressId])
GO

CREATE TABLE [dbo].[OwnerShip](
    [OwnerShipId] [uniqueidentifier] NOT NULL,
    [OwnerId] [uniqueidentifier] NOT NULL,
    [RoomId] [uniqueidentifier] NOT NULL,
    [StartDate] [date] NOT NULL,
    [EndDate] [date] NULL,
    PRIMARY KEY([OwnerShipId])
)
GO
ALTER TABLE [dbo].[OwnerShip]  WITH CHECK ADD  CONSTRAINT [FK_OwnerShip_OwnerId_Owner_OwnerId] FOREIGN KEY([OwnerId])
REFERENCES [dbo].[Owner] ([OwnerId])
GO
ALTER TABLE [dbo].[OwnerShip]  WITH CHECK ADD  CONSTRAINT [FK_OwnerShip_RoomId_Room_RoomId] FOREIGN KEY([OwnerId])
REFERENCES [dbo].[Owner] ([OwnerId])
GO

CREATE TABLE [dbo].[Tenant](
    [TenantId] [uniqueidentifier] NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [BankName] [nvarchar](50) NOT NULL,
    [AddressId] [uniqueidentifier] NOT NULL,
    [Director] [nvarchar](50) NOT NULL,
    [Description] [nvarchar](255) NOT NULL,
    PRIMARY KEY ([TenantId])
)
GO
ALTER TABLE [dbo].[Tenant]  WITH CHECK ADD  CONSTRAINT [FK_Tenant_AddressId_Address_AddressId] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Address] ([AddressId])
GO

CREATE TABLE [dbo].[Account](
    [AccountId] [uniqueidentifier] NOT NULL,
    [TenantId] [uniqueidentifier] NOT NULL,
    [ToBePaidAmount] [numeric](18, 2) NOT NULL,
    [StartDate] [date] NOT NULL,
	[EndDate] [date] NULL,
    PRIMARY KEY ([AccountId])
)
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_TenantId_Tenant_TenantId] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([TenantId])
GO

CREATE TABLE [dbo].[Rent](
	[RentId] [uniqueidentifier] NOT NULL,
    [RoomId] [int] NOT NULL,
    [TenantId] [uniqueidentifier] NOT NULL,
    [StartDate] [date] NOT NULL,
    [EndDate] [date] NULL,
    PRIMARY KEY ([RentId])
)
GO
ALTER TABLE [dbo].[Rent]  WITH CHECK ADD  CONSTRAINT [FK_Rent_RoomId_Room_RoomId] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
GO
ALTER TABLE [dbo].[Rent]  WITH CHECK ADD  CONSTRAINT [FK_Rent_TenantId_Tenant_TenantId] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([TenantId])
GO