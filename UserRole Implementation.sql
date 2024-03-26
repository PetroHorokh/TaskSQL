IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='User' and xtype='U')
CREATE TABLE [dbo].[User](
    [UserId] [uniqueidentifier] NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
	[CreatedBy] [uniqueidentifier] DEFAULT CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY(16), SUSER_SID())) NOT NULL,
    [CreatedDateTime] [datetime2] DEFAULT GETDATE() NOT NULL,
    [ModifiedBy] [uniqueidentifier] DEFAULT CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY(16), SUSER_SID())) NOT NULL,
    [ModifiedDateTime] [datetime2] DEFAULT GETDATE() NOT NULL,
    CONSTRAINT [PK_User] PRIMARY KEY ([UserId]),
	ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL,
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL,
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
)
WITH
(
    SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[User_History])
);
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Role' and xtype='U')
CREATE TABLE [dbo].[Role](
    [RoleId] [int] NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
	[CreatedBy] [uniqueidentifier] DEFAULT CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY(16), SUSER_SID())) NOT NULL,
    [CreatedDateTime] [datetime2] DEFAULT GETDATE() NOT NULL,
    [ModifiedBy] [uniqueidentifier] DEFAULT CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY(16), SUSER_SID())) NOT NULL,
    [ModifiedDateTime] [datetime2] DEFAULT GETDATE() NOT NULL,
    CONSTRAINT [PK_Role] PRIMARY KEY ([RoleId]),
	ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL,
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL,
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
)
WITH
(
    SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[Role_History])
);

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='UserRole' and xtype='U')
CREATE TABLE [dbo].UserRole(
    [UserRoleId] [uniqueidentifier] NOT NULL,
    [UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [int] NOT NULL,
	[CreatedBy] [uniqueidentifier] DEFAULT CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY(16), SUSER_SID())) NOT NULL,
    [CreatedDateTime] [datetime2] DEFAULT GETDATE() NOT NULL,
    [ModifiedBy] [uniqueidentifier] DEFAULT CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY(16), SUSER_SID())) NOT NULL,
    [ModifiedDateTime] [datetime2] DEFAULT GETDATE() NOT NULL,
    CONSTRAINT [PK_UserRole] PRIMARY KEY ([UserRoleId]),
	ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL,
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL,
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
)
WITH
(
    SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[UserRole_History])
);
GO
IF NOT EXISTS(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_UserRole_UserId_User_UserId'
)
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_UserId_User_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId]);
GO
IF NOT EXISTS(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_UserRole_RoleId_Role_RoleId'
)
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_RoleId_Role_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleId]);
GO

