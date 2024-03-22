IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Accommodation' and xtype='U')
CREATE TABLE [dbo].[Accommodation](
	[AccommodationId] [int] IDENTITY(0,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
    [CreatedBy] [nvarchar](50) DEFAULT CURRENT_USER NOT NULL,
    [CreatedDateTime] [datetime2] DEFAULT GETDATE() NOT NULL,
    [ModifiedBy] [nvarchar](50) DEFAULT CURRENT_USER NOT NULL,
    [ModifiedDateTime] [datetime2] DEFAULT GETDATE() NOT NULL,
	CONSTRAINT [PK_Accommodation] PRIMARY KEY ([AccommodationId])
);
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AccommodationRoom' and xtype='U')
CREATE TABLE [dbo].[AccommodationRoom](
	[AccommodationRoomId] [uniqueidentifier] NOT NULL,
	[AccommodationId] [int] NOT NULL,
	[RoomId] [uniqueidentifier] NOT NULL,
    [CreatedBy] [nvarchar](50) DEFAULT CURRENT_USER NOT NULL,
    [CreatedDateTime] [datetime2] DEFAULT GETDATE() NOT NULL,
    [ModifiedBy] [nvarchar](50) DEFAULT CURRENT_USER NOT NULL,
    [ModifiedDateTime] [datetime2] DEFAULT GETDATE() NOT NULL,
	CONSTRAINT [PK_AccommodationRoom] PRIMARY KEY ([AccommodationRoomId])
);
GO
IF NOT EXISTS(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_AccommodationRoom_AccommodationId_Accommodation_AccommodationId'
)
ALTER TABLE [dbo].[AccommodationRoom]  WITH CHECK ADD  CONSTRAINT [FK_AccommodationRoom_AccommodationId_Accommodation_AccommodationId] FOREIGN KEY([AccommodationId])
REFERENCES [dbo].[Accommodation] ([AccommodationId]);
GO

IF NOT EXISTS(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_AccommodationRoom_RoomId_Room_RoomId'
)
ALTER TABLE [dbo].[AccommodationRoom]  WITH CHECK ADD  CONSTRAINT [FK_AccommodationRoom_RoomId_Room_RoomId] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId]);
GO