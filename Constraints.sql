IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Address_CreatedBy'
)
BEGIN
    ALTER TABLE [dbo].[Address]
	ADD CONSTRAINT [DF_Address_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Address_CreatedDateTime'
)
BEGIN
    ALTER TABLE [dbo].[Address]
	ADD CONSTRAINT [DF_Address_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Asset_CreatedBy'
)
BEGIN
    ALTER TABLE [dbo].[Asset]
	ADD CONSTRAINT [DF_Asset_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Asset_CreatedDateTime'
)
BEGIN
    ALTER TABLE [dbo].[Asset]
	ADD CONSTRAINT [DF_Asset_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Bill_CreatedBy'
)
BEGIN
    ALTER TABLE [dbo].[Bill]
	ADD CONSTRAINT [DF_Bill_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Bill_CreatedDateTime'
)
BEGIN
	ALTER TABLE [dbo].[Bill]
	ADD CONSTRAINT [DF_Bill_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Impost_CreatedBy'
)
BEGIN
	ALTER TABLE [dbo].[Impost]
	ADD CONSTRAINT [DF_Impost_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Impost_CreatedDateTime'
)
BEGIN
	ALTER TABLE [dbo].[Impost]
	ADD CONSTRAINT [DF_Impost_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Owner_CreatedBy'
)
BEGIN
	ALTER TABLE [dbo].[Owner]
	ADD CONSTRAINT [DF_Owner_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Owner_CreatedDateTime'
)
BEGIN
	ALTER TABLE [dbo].[Owner]
	ADD CONSTRAINT [DF_Owner_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Payment_CreatedBy'
)
BEGIN
	ALTER TABLE [dbo].[Payment]
	ADD CONSTRAINT [DF_Payment_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Payment_CreatedDateTime'
)
BEGIN
	ALTER TABLE [dbo].[Payment]
	ADD CONSTRAINT [DF_Payment_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Price_CreatedBy'
)
BEGIN
	ALTER TABLE [dbo].[Price]
	ADD CONSTRAINT [DF_Price_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Price_CreatedDateTime'
)
BEGIN
	ALTER TABLE [dbo].[Price]
	ADD CONSTRAINT [DF_Price_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Rent_CreatedBy'
)
BEGIN
	ALTER TABLE [dbo].[Rent]
	ADD CONSTRAINT [DF_Rent_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Rent_CreatedDateTime'
)
BEGIN
	ALTER TABLE [dbo].[Rent]
	ADD CONSTRAINT [DF_Rent_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Room_CreatedBy'
)
BEGIN
	ALTER TABLE [dbo].[Room]
	ADD CONSTRAINT [DF_Room_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Room_CreatedDateTime'
)
BEGIN
	ALTER TABLE [dbo].[Room]
	ADD CONSTRAINT [DF_Room_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_RoomType_CreatedBy'
)
BEGIN
	ALTER TABLE [dbo].[RoomType]
	ADD CONSTRAINT [DF_RoomType_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_RoomType_CreatedDateTime'
)
BEGIN
	ALTER TABLE [dbo].[RoomType]
	ADD CONSTRAINT [DF_RoomType_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Tenant_CreatedBy'
)
BEGIN
	ALTER TABLE [dbo].[Tenant]
	ADD CONSTRAINT [DF_Tenant_CreatedBy] DEFAULT SUSER_SID() FOR [CreatedBy];
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM [sys].[default_constraints]
    WHERE [name]  = 'DF_Tenant_CreatedDateTime'
)
BEGIN
	ALTER TABLE [dbo].[Tenant]
	ADD CONSTRAINT [DF_Tenant_CreatedDateTime] DEFAULT GETDATE() FOR [CreatedDateTime];
END;
GO