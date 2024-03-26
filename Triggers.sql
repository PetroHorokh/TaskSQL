CREATE OR ALTER TRIGGER [dbo].[tr_Address_Insert]
ON [dbo].[Address]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			INSERT INTO [dbo].[Address]([AddressId],[City],[Street],[Building],[CreatedBy],[CreatedDateTime])
			SELECT i.[AddressId], i.[City], i.[Street], i.[Building], i.[CreatedBy], GETDATE()  AS [CreatedDateTime]
			FROM inserted i;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_Asset_Insert]
ON [dbo].[Asset]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			INSERT INTO [dbo].[Asset]([AssetId],[OwnerId],[RoomId],[CreatedBy],[CreatedDateTime])
			SELECT [AssetId], [OwnerId], [RoomId], i.[CreatedBy], GETDATE()  AS [CreatedDateTime]
			FROM inserted i;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_Bill_Insert]
ON [dbo].[Bill]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			INSERT INTO [dbo].[Bill]([BillId],[TenantId],[AssetId],[BillAmount],[IssueDate],[EndDate],[CreatedBy],[CreatedDateTime])
			SELECT [BillId],[TenantId],[AssetId],[BillAmount],[IssueDate],[EndDate], i.[CreatedBy], GETDATE()  AS [CreatedDateTime]
			FROM inserted i;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_Owner_Insert]
ON [dbo].[Owner]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			INSERT INTO [dbo].[Owner]([OwnerId],[Name],[AddressId],[CreatedBy],[CreatedDateTime])
			SELECT [OwnerId],[Name],[AddressId], i.[CreatedBy], GETDATE()  AS [CreatedDateTime]
			FROM inserted i;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_Payment_Insert]
ON [dbo].[Payment]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			INSERT INTO [dbo].[Payment]([PaymentId],[TenantId],[BillId],[PaymentDay],[Amount],[CreatedBy],[CreatedDateTime])
			SELECT [PaymentId],[TenantId],[BillId],[PaymentDay],[Amount], i.[CreatedBy], GETDATE()  AS [CreatedDateTime]
			FROM inserted i;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_Rent_Insert]
ON [dbo].[Rent]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			INSERT INTO [dbo].[Rent]([RentId],[AssetId],[TenantId],[StartDate],[EndDate],[CreatedBy],[CreatedDateTime])
			SELECT [RentId],[AssetId],[TenantId],[StartDate],[EndDate], i.[CreatedBy], GETDATE()  AS [CreatedDateTime]
			FROM inserted i;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_Room_Insert]
ON [dbo].[Room]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			INSERT INTO [dbo].[Room]([RoomId],[Number],[Area],[RoomTypeId],[CreatedBy],[CreatedDateTime])
			SELECT [RoomId],[Number],[Area],[RoomTypeId], i.[CreatedBy], GETDATE()  AS [CreatedDateTime]
			FROM inserted i;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_RoomType_Insert]
ON [dbo].[RoomType]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			INSERT INTO [dbo].[RoomType]([RoomTypeId],[Name],[CreatedBy],[CreatedDateTime])
			SELECT [RoomTypeId],[Name], i.[CreatedBy], GETDATE()  AS [CreatedDateTime]
			FROM inserted i;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_Tenant_Insert]
ON [dbo].[Tenant]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			INSERT INTO [dbo].[Tenant]([TenantId],[Name],[BankName],[AddressId],[Director],[Description],[CreatedBy],[CreatedDateTime])
			SELECT [TenantId],[Name],[BankName],[AddressId],[Director],[Description], i.[CreatedBy], GETDATE()  AS [CreatedDateTime]
			FROM inserted i;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_Accommodation_Insert]
ON [dbo].[Accommodation]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			INSERT INTO [dbo].[Accommodation]([AccommodationId],[Name],[CreatedBy],[CreatedDateTime])
			SELECT [AccommodationId], [Name], i.[CreatedBy], GETDATE() AS [CreatedDateTime]
			FROM inserted i;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_AccommodationRoom_Insert]
ON [dbo].[AccommodationRoom]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			INSERT INTO [dbo].[AccommodationRoom]([AccommodationRoomId],[AccommodationId],[RoomId],[CreatedBy],[CreatedDateTime])
			SELECT [AccommodationRoomId], [AccommodationId], [RoomId], i.[CreatedBy], GETDATE() AS [CreatedDateTime]
			FROM inserted i;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_Address_Update]
ON [dbo].[Address]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			UPDATE [dbo].[Address]
			SET [ModifiedBy] = i.ModifiedBy, [ModifiedDateTime] = GETDATE()
			FROM [dbo].[Address] [Address]
			RIGHT JOIN inserted AS i ON i.[AddressId] = [Address].[AddressId]
			WHERE [Address].[AddressId] = i.[AddressId]
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_Asset_Update]
ON [dbo].[Asset]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			UPDATE [dbo].[Asset]
			SET [ModifiedBy] = i.ModifiedBy, [ModifiedDateTime] = GETDATE()
			FROM [dbo].[Asset] [Asset]
			RIGHT JOIN inserted AS i ON i.[AssetId] = [Asset].[AssetId]
			WHERE [Asset].[AssetId] = i.[AssetId]
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_Bill_Update]
ON [dbo].[Bill]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			UPDATE [dbo].[Bill]
			SET [ModifiedBy] = i.ModifiedBy, [ModifiedDateTime] = GETDATE()
			FROM [dbo].[Bill] [Bill]
			RIGHT JOIN inserted AS i ON i.[BillId] = [Bill].[BillId]
			WHERE [Bill].[BillId] = i.[BillId]
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_Owner_Update]
ON [dbo].[Owner]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			UPDATE [dbo].[Owner]
			SET [ModifiedBy] = i.ModifiedBy, [ModifiedDateTime] = GETDATE()
			FROM [dbo].[Owner] [Owner]
			RIGHT JOIN inserted AS i ON i.[OwnerId] = [Owner].[OwnerId]
			WHERE [Owner].[OwnerId] = i.[OwnerId]
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_Payment_Update]
ON [dbo].[Payment]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			UPDATE [dbo].[Payment]
			SET [ModifiedBy] = i.ModifiedBy, [ModifiedDateTime] = GETDATE()
			FROM [dbo].[Payment] [Payment]
			RIGHT JOIN inserted AS i ON i.[PaymentId] = [Payment].[PaymentId]
			WHERE [Payment].[PaymentId] = i.[PaymentId]
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_Rent_Update]
ON [dbo].[Rent]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			UPDATE [dbo].[Rent]
			SET [ModifiedBy] = i.ModifiedBy, [ModifiedDateTime] = GETDATE()
			FROM [dbo].[Rent] [Rent]
			RIGHT JOIN inserted AS i ON i.[RentId] = [Rent].[RentId]
			WHERE [Rent].[RentId] = i.[RentId]
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_Room_Update]
ON [dbo].[Room]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			UPDATE [dbo].[Room]
			SET [ModifiedBy] = i.ModifiedBy, [ModifiedDateTime] = GETDATE()
			FROM [dbo].[Room] [Room]
			RIGHT JOIN inserted AS i ON i.[RoomId] = [Room].[RoomId]
			WHERE [Room].[RoomId] = i.[RoomId]
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_RoomType_Update]
ON [dbo].[RoomType]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			UPDATE [dbo].[RoomType]
			SET [ModifiedBy] = i.ModifiedBy, [ModifiedDateTime] = GETDATE()
			FROM [dbo].[RoomType] [RoomType]
			RIGHT JOIN inserted AS i ON i.[RoomTypeId] = [RoomType].[RoomTypeId]
			WHERE [RoomType].[RoomTypeId] = i.[RoomTypeId]
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_Tenant_Update]
ON [dbo].[Tenant]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			UPDATE [dbo].[Tenant]
			SET [ModifiedBy] = i.ModifiedBy, [ModifiedDateTime] = GETDATE()
			FROM [dbo].[Tenant] [Tenant]
			RIGHT JOIN inserted AS i ON i.[TenantId] = [Tenant].[TenantId]
			WHERE [Tenant].[TenantId] = i.[TenantId]
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_Accommodation_Update]
ON [dbo].[Accommodation]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			UPDATE [dbo].[Accommodation]
			SET [ModifiedBy] = i.ModifiedBy, [ModifiedDateTime] = GETDATE()
			FROM [dbo].[Accommodation] [Accommodation]
			RIGHT JOIN inserted AS i ON i.[AccommodationId] = [Accommodation].[AccommodationId]
			WHERE [Accommodation].[AccommodationId] = i.[AccommodationId]
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[tr_AccommodationRoom_Update]
ON [dbo].[AccommodationRoom]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY;
	    BEGIN TRANSACTION;
			UPDATE [dbo].[AccommodationRoom]
			SET [ModifiedBy] = i.ModifiedBy, [ModifiedDateTime] = GETDATE()
			FROM [dbo].[AccommodationRoom] [AccommodationRoom]
			RIGHT JOIN inserted AS i ON i.[AccommodationRoomId] = [AccommodationRoom].[AccommodationRoomId]
			WHERE [AccommodationRoom].[AccommodationRoomId] = i.[AccommodationRoomId]
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO