CREATE TABLE [dbo].[Room](
    [RoomId] [int] NOT NULL,
    [Area] [int]  NOT NULL,
	PRIMARY KEY ([RoomId])
)
GO

CREATE TABLE [dbo].[RoomType](
    [RoomTypeId] [uniqueidentifier] NOT NULL,
    [Type] [nvarchar](255)  NOT NULL,
    [Price] [float] NOT NULL,
    PRIMARY KEY ([RoomTypeId])
)
GO

CREATE TABLE [dbo].[RoomRoomType](
    [RoomId] [int] NOT NULL,
    [RoomTypeId] [uniqueidentifier] NOT NULL,
    PRIMARY KEY ([RoomId], [RoomTypeId])
)
GO
ALTER TABLE [dbo].[RoomRoomType]  WITH CHECK ADD  CONSTRAINT [FK_RoomRoomType_RoomId_Room_RoomId] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
GO
ALTER TABLE [dbo].[RoomRoomType]  WITH CHECK ADD  CONSTRAINT [FK_RoomRoomType_RoomTypeId_RoomType_RoomTypeId] FOREIGN KEY([RoomTypeId])
REFERENCES [dbo].[RoomType] ([RoomTypeId])
GO

CREATE TABLE [dbo].[Bank](
    [BankId] [int] NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    PRIMARY KEY ([BankId])
) 
GO

CREATE TABLE [dbo].[Tenant](
	[TenantId] [uniqueidentifier] NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [BankId] [int] NOT NULL,
    [Address] [nvarchar](50) NOT NULL,
    [Director] [nvarchar](50) NOT NULL,
    [Description] [nvarchar](255) NOT NULL,
    PRIMARY KEY ([TenantId])
)
GO
ALTER TABLE [dbo].[Tenant]  WITH CHECK ADD  CONSTRAINT [FK_Tenant_BankId_Bank_BankId] FOREIGN KEY([BankId])
REFERENCES [dbo].[Bank] ([BankId])
GO

CREATE TABLE [dbo].[Account](
    [AccountId] [int] NOT NULL,
    [TenantId] [uniqueidentifier] NOT NULL,
    PRIMARY KEY ([AccountId])
)
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_TenantId_Tenant_TenantId] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([TenantId])
GO

CREATE TABLE [dbo].[RoomRent](
    [RoomId] [int] NOT NULL,
    [TenantId] [uniqueidentifier] NOT NULL,
    [StartDate] [date] NOT NULL,
    [EndDate] [date] NOT NULL,
    PRIMARY KEY ([RoomId])
)
GO
ALTER TABLE [dbo].[RoomRent]  WITH CHECK ADD  CONSTRAINT [FK_RoomRent_RoomId_Room_RoomId] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
GO
ALTER TABLE [dbo].[RoomRent]  WITH CHECK ADD  CONSTRAINT [FK_RoomRent_TenantId_Tenant_TenantId] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([TenantId])
GO