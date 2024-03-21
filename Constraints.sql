ALTER TABLE [dbo].[Address]
ADD CONSTRAINT [DF_Address_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
GO

ALTER TABLE [dbo].[Address]
ADD CONSTRAINT [DF_Address_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
GO

ALTER TABLE [dbo].[Asset]
ADD CONSTRAINT [DF_Asset_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
GO

ALTER TABLE [dbo].[Asset]
ADD CONSTRAINT [DF_Asset_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
GO

ALTER TABLE [dbo].[Bill]
ADD CONSTRAINT [DF_Bill_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
GO

ALTER TABLE [dbo].[Bill]
ADD CONSTRAINT [DF_Bill_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
GO

ALTER TABLE [dbo].[Impost]
ADD CONSTRAINT [DF_Impost_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
GO

ALTER TABLE [dbo].[Impost]
ADD CONSTRAINT [DF_Impost_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
GO

ALTER TABLE [dbo].[Owner]
ADD CONSTRAINT [DF_Owner_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
GO

ALTER TABLE [dbo].[Owner]
ADD CONSTRAINT [DF_Owner_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
GO

ALTER TABLE [dbo].[Payment]
ADD CONSTRAINT [DF_Payment_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
GO

ALTER TABLE [dbo].[Payment]
ADD CONSTRAINT [DF_Payment_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
GO

ALTER TABLE [dbo].[Price]
ADD CONSTRAINT [DF_Price_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
GO

ALTER TABLE [dbo].[Price]
ADD CONSTRAINT [DF_Price_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
GO

ALTER TABLE [dbo].[Rent]
ADD CONSTRAINT [DF_Rent_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
GO

ALTER TABLE [dbo].[Rent]
ADD CONSTRAINT [DF_Rent_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
GO

ALTER TABLE [dbo].[Room]
ADD CONSTRAINT [DF_Room_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
GO

ALTER TABLE [dbo].[Room]
ADD CONSTRAINT [DF_Room_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
GO

ALTER TABLE [dbo].[RoomType]
ADD CONSTRAINT [DF_RoomType_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
GO

ALTER TABLE [dbo].[RoomType]
ADD CONSTRAINT [DF_RoomType_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
GO

ALTER TABLE [dbo].[Tenant]
ADD CONSTRAINT [DF_Tenant_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
GO

ALTER TABLE [dbo].[Tenant]
ADD CONSTRAINT [DF_Tenant_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
GO