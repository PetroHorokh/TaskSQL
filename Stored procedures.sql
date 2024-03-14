CREATE OR ALTER PROCEDURE [dbo].[sp_Address_Insert]
@City [nvarchar](255),
@Street [nvarchar](255),
@Building [nvarchar](255)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
		IF EXISTS (SELECT 1
		    FROM [dbo].[Address] [Address]
		    WHERE [Address].[City] = @City
                AND [Address].[Street] = @Street
                AND [Address].[Building] = @Building)
		BEGIN
		    SELECT [Address].[AddressId]
		    FROM [dbo].[Address] [Address]
		    WHERE [Address].[City] = @City
                AND [Address].[Street] = @Street
                AND [Address].[Building] = @Building
            RAISERROR( 'There is aleady such address' , 1, 0) WITH NOWAIT;
	    END
		ELSE
        BEGIN
		    DECLARE @AddressId [uniqueidentifier] = NEWID();
			BEGIN TRANSACTION;
			    INSERT INTO [dbo].[Address] ([AddressId], [City], [Street], [Building], [CreatedBy], [CreatedDateTime])
                SELECT NEWID(), @City, @Street, @Building, '00000000-0000-0000-0000-000000000000', GETDATE();
            COMMIT TRANSACTION; 
			SELECT @AddressId AS [AddressId]
	    END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 0);
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Owner_Insert]
@AddressId [uniqueidentifier],
@Name [nvarchar](50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
	    DECLARE @OwnerId [uniqueidentifier] = NEWID();
        BEGIN TRANSACTION;
            INSERT INTO [dbo].[Owner] ([OwnerId], [Name], [AddressId], [CreatedBy], [CreatedDateTime])
            SELECT @OwnerId, @Name, @AddressId, '00000000-0000-0000-0000-000000000000', GETDATE();
        COMMIT TRANSACTION;
		SELECT @OwnerId AS [OwnerId]
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 4);
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Tenant_Insert]
@AddressId [uniqueidentifier],
@Name [nvarchar](50),
@BankName [nvarchar](50),
@Director [nvarchar](50),
@Description [nvarchar](255)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
		DECLARE @TenantId [uniqueidentifier] = NEWID();
        BEGIN TRANSACTION;
            INSERT INTO [dbo].[Tenant] ([TenantId], [Name], [BankName], [AddressId], [Director], [Description], [CreatedBy], [CreatedDateTime])
            SELECT @TenantId, @Name, @BankName, @AddressId, @Director, @Description, '00000000-0000-0000-0000-000000000000', GETDATE();
        COMMIT TRANSACTION;
		SELECT @TenantId AS [TenantId]
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 10);
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_RoomType_Insert]
@Name [nvarchar](20)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
	    DECLARE @RoomTypeId [int]; 

	    IF EXISTS (SELECT 1 
		    FROM [dbo].[RoomType] [RoomType]
			WHERE [RoomType].[Name] = @Name)
        BEGIN
		    SELECT @RoomTypeId = [RoomType].[RoomTypeId]
		    FROM [dbo].[RoomType] [RoomType]
			WHERE [RoomType].[Name] = @Name;
            RAISERROR( 'There already is such room type' , 1, 9) WITH NOWAIT;
			SELECT @RoomTypeId AS [RoomTypeId];
        END
		ELSE
		BEGIN
			SELECT @RoomTypeId = COUNT(*) + 1
			FROM [dbo].[RoomType] [RoomType];
		    BEGIN TRANSACTION;
                INSERT INTO [dbo].[RoomType] ([RoomTypeId], [Name], [CreatedBy], [CreatedDateTime])
                SELECT @RoomTypeId, @Name, '00000000-0000-0000-0000-000000000000', GETDATE();
            COMMIT TRANSACTION; 
			SELECT @RoomTypeId AS [RoomTypeId];
		END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE();
            RAISERROR( @Message , 11, 9);
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Price_Insert]
@Value [numeric](18,2),
@EndDate [datetime2],
@RoomTypeId [int]
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY

		IF NOT EXISTS(SELECT 1
		    FROM [dbo].[RoomType] [RoomType]
			WHERE [RoomType].[RoomTypeId] = @RoomTypeId
		)
		BEGIN
		    RAISERROR( 'There is no room type with such name' , 1, 6) WITH NOWAIT;
		END
		ELSE
		BEGIN
		    BEGIN TRANSACTION;
                INSERT INTO [dbo].[Price] ([PriceId], [StartDate], [Value], [EndDate], [RoomTypeId], [CreatedBy], [CreatedDateTime])
                SELECT NEWID(), GETDATE(), @Value, @EndDate, @RoomTypeId, '00000000-0000-0000-0000-000000000000', GETDATE();
            COMMIT TRANSACTION;
		END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE();
            RAISERROR( @Message , 11, 6);
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Room_Insert]
@Number [int],
@Area [numeric](18,2),
@RoomTypeId [nvarchar](20)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
	    DECLARE @RoomId [uniqueidentifier];

		IF EXISTS(
			SELECT 1
			FROM [dbo].[Room] [Room]
			WHERE [Room].[Number] = @Number
		)
		BEGIN
		    SELECT @RoomId = [Room].[RoomId] 
			FROM [dbo].[Room] [Room] 
			WHERE [Room].[Number] = @Number 
		    RAISERROR( 'There already is a room with such number' , 1, 8) WITH NOWAIT;
			SELECT @RoomId AS [RoomId]
		END
		ELSE
		BEGIN 
		    IF NOT EXISTS(SELECT 1
			    FROM [dbo].[RoomType] [RoomType]
				WHERE [RoomType].[RoomTypeId] = @RoomTypeId
			)
			BEGIN
			    RAISERROR( 'There is no such room type' , 1, 8) WITH NOWAIT;
			END
			ELSE
			BEGIN
			    SELECT @RoomId = NEWID();
                BEGIN TRANSACTION;
                    INSERT INTO [dbo].[Room] ([RoomId], [Number], [Area], [RoomTypeId], [CreatedBy], [CreatedDateTime])
                    SELECT @RoomId, @Number, @Area, @RoomTypeId, '00000000-0000-0000-0000-000000000000', GETDATE();
                COMMIT TRANSACTION; 
                SELECT @RoomId AS [RoomId];
			END
		END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE();
            RAISERROR( @Message , 11, 8);
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Asset_Insert]
@OwnerId [uniqueidentifier],
@RoomId [uniqueidentifier]
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
		IF NOT EXISTS(SELECT 1
		    FROM [dbo].[Room] [Room]
			WHERE [Room].[RoomId] = @RoomId
		)
		BEGIN
		    RAISERROR( 'There is no room with such number' , 1, 1) WITH NOWAIT;
		END
		ELSE
		BEGIN
		    IF NOT EXISTS(SELECT 1
		        FROM [dbo].[Owner] [Owner]
			    WHERE [Owner].[OwnerId] = @OwnerId
		    )
			BEGIN
			    RAISERROR( 'There is no such owner' , 1, 1) WITH NOWAIT;
			END
			ELSE
			BEGIN
			    DECLARE @AssetId [uniqueidentifier] = NEWID();
			    BEGIN TRANSACTION;
                    INSERT INTO [dbo].[Asset] ([AssetId], [OwnerId], [RoomId], [CreatedBy], [CreatedDateTime])
                    SELECT @AssetId, @OwnerId, @RoomId, '00000000-0000-0000-0000-000000000000', GETDATE();
                COMMIT TRANSACTION;    
                SELECT @AssetId AS [AssetId]
			END

            
		END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE();
            RAISERROR( @Message , 11, 1);
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Bill_Insert]
@TenantId [uniqueidentifier],
@AssetId [uniqueidentifier],
@Amount [numeric](18,2),
@EndDate [date],
@IssueDate [date]
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
	    IF NOT EXISTS(SELECT 1
		    FROM [dbo].[Tenant] [Tenant]
			WHERE [Tenant].[TenantId] = @TenantId
		)
		BEGIN
		    RAISERROR( 'There is no such tenant', 1, 2) WITH NOWAIT;
		END
		ELSE
		BEGIN
		    IF NOT EXISTS(SELECT 1
			    FROM [dbo].[Asset] [Asset]
				WHERE [Asset].[AssetId] = @AssetId
			)
			BEGIN
                RAISERROR( 'There is no room with such number', 1, 2) WITH NOWAIT;
			END
			ELSE
			BEGIN
			    DECLARE @BillId [uniqueidentifier] = NEWID();
                BEGIN TRANSACTION;
                    INSERT INTO [dbo].[Bill] ([BillId], [TenantId], [AssetId], [BillAmount], [IssueDate], [EndDate], [CreatedBy], [CreatedDateTime])
                    SELECT @BillId, @TenantId, @AssetId, @Amount, @IssueDate, @EndDate, '00000000-0000-0000-0000-000000000000', GETDATE();
                COMMIT TRANSACTION;
				SELECT @BillId AS [BillId];
			END
		END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE();
            RAISERROR( @Message , 11, 2);
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Impost_Insert]
@Tax [decimal](4,2),
@Fine [decimal](3,2),
@PaymentDay [int],
@StartDay [datetime2],
@EndDay [datetime2]
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
	    
		IF EXISTS(
            SELECT 1
            FROM [dbo].[Impost] [Impost]
            WHERE (@StartDay BETWEEN [Impost].[StartDate] AND [Impost].[EndDate])
			    OR @EndDay BETWEEN [Impost].[StartDate] AND [Impost].[EndDate]
		)
		BEGIN
		    RAISERROR( 'There already is imposts at this time', 1, 3) WITH NOWAIT;
		END
		ELSE
		BEGIN
		    BEGIN TRANSACTION;
                INSERT INTO [dbo].[Impost] ([ImpostId], [Tax], [Fine], [PaymentDay], [StartDate], [EndDate], [CreatedBy], [CreatedDateTime])
                SELECT NEWID(), @Tax, @Fine, @PaymentDay, @StartDay, @EndDay, '00000000-0000-0000-0000-000000000000', GETDATE()
            COMMIT TRANSACTION;
		END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE()
            RAISERROR( @Message , 11, 3);
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Payment_Insert]
@TenantId [uniqueidentifier],
@BillId [uniqueidentifier],
@PaymentDay [datetime2],
@Amount [numeric](18,2)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF NOT EXISTS(SELECT 1
		    FROM [dbo].[Tenant] [Tenant]
			WHERE [Tenant].[TenantId] = @TenantId
		)
		BEGIN
		    RAISERROR( 'There is no such tenant', 1, 7) WITH NOWAIT;
	    END
		ELSE
		BEGIN
		    IF NOT EXISTS(SELECT 1
			    FROM [dbo].[Bill] [Bill]
				WHERE [Bill].[BillId] = @BillId
				    AND [Bill].[TenantId] = @TenantId
			)
			BEGIN
			    RAISERROR( 'There is no such bill for this tenant', 1, 7) WITH NOWAIT;
			END
			ELSE
			BEGIN
			    BEGIN TRANSACTION;
                    INSERT INTO [dbo].[Payment] ([PaymentId], [TenantId], [BillId], [PaymentDay], [Amount], [CreatedBy], [CreatedDateTime])
                    SELECT NEWID(), @TenantId, @BillId, @PaymentDay, @Amount, '00000000-0000-0000-0000-000000000000', GETDATE();
                COMMIT TRANSACTION;
			END
		END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE();
            RAISERROR( @Message , 11, 9);
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Rent_Insert]
@AssetId [uniqueidentifier],
@TenantId [uniqueidentifier],
@EndDate [date]
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
		IF NOT EXISTS(SELECT 1
		    FROM [dbo].[Asset] [Asset]
			WHERE [Asset].[AssetId] = @AssetId
		)
		BEGIN
		   RAISERROR( 'There is no such asset to rent', 1, 7) WITH NOWAIT;
		END
		ELSE
		BEGIN
		    IF NOT EXISTS(SELECT 1
			    FROM [dbo].[Tenant] [Tenant]
				WHERE [Tenant].[TenantId] = @TenantId
			)
			BEGIN
			    RAISERROR( 'There is no such tenant', 1, 7) WITH NOWAIT;
			END
			ELSE
			BEGIN
				BEGIN TRANSACTION;
                    INSERT INTO [dbo].[Rent] ([RentId], [AssetId], [TenantId], [StartDate], [EndDate], [CreatedBy], [CreatedDateTime])
                    SELECT NEWID(), @AssetId, @TenantId, GETDATE(), @EndDate, '00000000-0000-0000-0000-000000000000', GETDATE();
                COMMIT TRANSACTION;
			END
		END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
			DECLARE @Message [nvarchar](100) = 'An error occurred: ' + ERROR_MESSAGE();
            RAISERROR( @Message , 11, 7);
        END CATCH;
    END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Test_Input]
AS
BEGIN
	--Address
	CREATE TABLE #TempAddressData
    ([City] [nvarchar](255),
	[Street] [nvarchar](255),
	[Building] [nvarchar](255))

	CREATE TABLE #TempAddressId
    ([AddressId] [uniqueidentifier])

	INSERT INTO #TempAddressData
	VALUES ('New York', 'Broadway', '123'),
    ('Los Angeles', 'Hollywood Blvd', '456'),
    ('London', 'Oxford Street', '789'),
    ('Paris', 'Champs-Élysées', '1011'),
    ('Tokyo', 'Shibuya Crossing', '1213')

	DECLARE Address_cursor CURSOR
    FOR SELECT [City], [Street], [Building]
    FROM #TempAddressData

	DECLARE @City [nvarchar](255), @Street [nvarchar](255), @Building [nvarchar](255)
	OPEN Address_cursor;

	FETCH NEXT FROM Address_cursor INTO 
    @City, @Street, @Building

	WHILE @@FETCH_STATUS = 0
	BEGIN
	   
	    INSERT INTO #TempAddressId EXEC [dbo].[sp_Address_Insert] @City = @City, @Street = @Street, @Building = @Building

	    FETCH NEXT FROM Address_cursor INTO 
        @City, @Street, @Building
	END

	CLOSE Address_cursor;

    --Owner
	CREATE TABLE #TempOwnerId
	([OwnerId] [uniqueidentifier])

	CREATE TABLE #TempOwnerData
    ([Name] [nvarchar](50))

	CREATE TABLE #TempOwner
	([Name] [nvarchar](50),
	[AddressId] [uniqueidentifier])

	INSERT INTO #TempOwnerData
	VALUES ('Emily Martinez'),
	('Benjamin Kim'),
	('Sophia Nguyen'),
	('Alexander Patel'),
	('Olivia Brown');

	DECLARE Owner_cursor CURSOR
    FOR SELECT [Name], [AddressId]
    FROM #TempOwner

    INSERT INTO #TempOwner
	SELECT DISTINCT [combine].[Name], [combine].[AddressId]
	FROM(SELECT [t1].[Name], [t2].[AddressId], ROW_NUMBER() OVER (ORDER BY NEWID()) AS [rownum]
        FROM #TempOwnerData AS [t1]
        CROSS JOIN #TempAddressId AS [t2]) AS [combine]
	WHERE [combine].[rownum] % 5 = 0
   
	DECLARE @Name [nvarchar](50), @AddressId [uniqueidentifier];
	OPEN Owner_cursor;

	FETCH NEXT FROM Owner_cursor INTO 
    @Name, @AddressId

	WHILE @@FETCH_STATUS = 0
	BEGIN
	    INSERT INTO #TempOwnerId EXEC [dbo].[sp_Owner_Insert] @Name = @Name, @AddressId = @AddressId

	    FETCH NEXT FROM Owner_cursor INTO 
        @Name, @AddressId
	END

	CLOSE Owner_cursor;

	--Tenant
	CREATE TABLE #TempTenantId
	([TenantId] [uniqueidentifier])

	CREATE TABLE #TempTenantData
	([Name] [nvarchar](50),
	[BankName] [nvarchar](50),
	[Director] [nvarchar](50),
	[Description] [nvarchar](255))

	CREATE TABLE #TempTenant
    ([Name] [nvarchar](50),
	[BankName] [nvarchar](50),
	[AddressId] [uniqueidentifier],
	[Director] [nvarchar](50),
	[Description] [nvarchar](255))

	INSERT INTO #TempTenantData
    VALUES
    ('Emily Martinez', 'Bank A', 'John Doe', 'Tenant description 1'),
    ('Benjamin Kim', 'Bank B', 'Jane Smith', 'Tenant description 2'),
    ('Sophia Nguyen', 'Bank C', 'Michael Johnson', 'Tenant description 3'),
    ('Alexander Patel', 'Bank D', 'Emma Brown', 'Tenant description 4'),
    ('Olivia Brown', 'Bank E', 'David Lee', 'Tenant description 5')

	DECLARE Tenant_cursor CURSOR
    FOR SELECT [Name], [BankName], [AddressId], [Director], [Description]
    FROM #TempTenant;

    INSERT INTO #TempTenant
	SELECT DISTINCT [combine].[Name], [combine].[BankName], [combine].[AddressId], [combine].[Director], [combine].[Description]
	FROM(SELECT [t1].[Name], [t1].[BankName], [t1].[Director], [t1].[Description], [t2].[AddressId], ROW_NUMBER() OVER (ORDER BY NEWID()) AS [rownum]
        FROM #TempTenantData AS [t1]
        CROSS JOIN #TempAddressId AS [t2]) AS [combine]
	WHERE [combine].[rownum] % 5 = 0;
   
	DECLARE @BankName [nvarchar](50), @Director [nvarchar](50), @Description [nvarchar](255);
	OPEN Tenant_cursor;

	FETCH NEXT FROM Tenant_cursor INTO 
    @Name, @BankName, @AddressId, @Director, @Description;

	WHILE @@FETCH_STATUS = 0
	BEGIN
	    INSERT INTO #TempTenantId EXEC [dbo].[sp_Tenant_Insert] @AddressId = @AddressId, @Name = @Name, @BankName = @BankName, @Director = @Director, @Description = @Description;

	    FETCH NEXT FROM Tenant_cursor INTO 
    @Name, @BankName, @AddressId, @Director, @Description;
	END

	CLOSE Tenant_cursor;

	--RoomType
	CREATE TABLE #TempRoomTypeId
	([RoomTypeId] [int])

	CREATE TABLE #TempRoomTypeData
	([Name] [nvarchar](50))

	INSERT INTO #TempRoomTypeData
    VALUES ('Room Type A'),
    ('Room Type B'),
    ('Room Type C'),
    ('Room Type D'),
    ('Room Type E');

	DECLARE RoomType_cursor CURSOR
    FOR SELECT [Name]
    FROM #TempRoomTypeData;

	OPEN RoomType_cursor;

	FETCH NEXT FROM RoomType_cursor INTO 
    @Name;

	WHILE @@FETCH_STATUS = 0
	BEGIN
	    INSERT INTO #TempRoomTypeId EXEC [dbo].[sp_RoomType_Insert] @Name = @Name;
	    FETCH NEXT FROM RoomType_cursor INTO 
        @Name;
	END
	CLOSE RoomType_cursor;

	--Price
	CREATE TABLE #TempPriceData
	([Value] [numeric](18,2),
	[EndDate] [datetime2])

	CREATE TABLE #TempPrice
    ([Value] [numeric](18,2),
	[EndDate] [datetime2],
	[RoomTypeId] [int])

	INSERT INTO #TempPriceData
    VALUES
    (100.50, '2024-03-15 18:30:00'),
    (75.20, '2024-03-16 17:45:00'),
    (120.75, '2024-03-17 19:00:00'),
    (90.80, '2024-03-18 16:20:00'),
    (105.00, '2024-03-19 20:15:00');

    INSERT INTO #TempPrice
	SELECT [combine].[Value], [combine].[EndDate], [combine].[RoomTypeId]
	FROM(SELECT [t1].[Value], [t1].[EndDate], [t2].[RoomTypeId], ROW_NUMBER() OVER (ORDER BY NEWID()) AS [rownum]
        FROM #TempPriceData AS [t1]
        CROSS JOIN #TempRoomTypeId AS [t2]) AS [combine]
	WHERE [combine].[rownum] % 5 = 0;
   
    DECLARE Price_cursor CURSOR
    FOR SELECT [Value], [EndDate], [RoomTypeId]
    FROM #TempPrice;

	OPEN Price_cursor;

	DECLARE @Value [numeric](18,2), @EndDate [datetime2], @RoomTypeId [int];

	FETCH NEXT FROM Price_cursor INTO 
    @Value, @EndDate, @RoomTypeId;

	WHILE @@FETCH_STATUS = 0
	BEGIN
	    EXEC [dbo].[sp_Price_Insert] @Value = @Value, @EndDate = @EndDate, @RoomTypeId = @RoomTypeId

	    FETCH NEXT FROM Price_cursor INTO 
        @Value, @EndDate, @RoomTypeId;
	END

	CLOSE Price_cursor;

	--Room
    CREATE TABLE #TempRoomId
	([RoomId] [uniqueidentifier])

	CREATE TABLE #TempRoomData
	([Number] [int],
	[Area] [numeric](18,2))

	CREATE TABLE #TempRoom
    ([Number] [int],
	[Area] [numeric](18,2),
	[RoomTypeId] [int])

	INSERT INTO #TempRoomData
    VALUES
    (1, 100.50),
    (2, 75.25),
    (3, 120.75),
    (4, 90.00),
    (5, 60.80);

	DECLARE Room_cursor CURSOR
    FOR SELECT [Number], [Area], [RoomTypeId]
    FROM #TempRoom;

    INSERT INTO #TempRoom
	SELECT DISTINCT [combine].[Number], [combine].[Area], [combine].[RoomTypeId]
	FROM(SELECT [t1].[Number], [t1].[Area], [t2].[RoomTypeId], ROW_NUMBER() OVER (ORDER BY NEWID()) AS [rownum]
        FROM #TempRoomData AS [t1]
        CROSS JOIN #TempRoomTypeId AS [t2]) AS [combine]
	WHERE [combine].[rownum] % 5 = 0;
   
	OPEN Room_cursor;

	DECLARE @Number [int], @Area [numeric](18,2)

	FETCH NEXT FROM Room_cursor INTO 
    @Number, @Area, @RoomTypeId

	WHILE @@FETCH_STATUS = 0
	BEGIN
	    INSERT INTO #TempRoomId EXEC [dbo].[sp_Room_Insert] @Number = @Number, @Area = @Area, @RoomTypeId = @RoomTypeId;

	    FETCH NEXT FROM Room_cursor INTO 
        @Number, @Area, @RoomTypeId
	END

	CLOSE Room_cursor;

	--Asset
	CREATE TABLE #TempAssetId
	([AssetId] [uniqueidentifier])

	CREATE TABLE #TempAsset
    ([OwnerId] [uniqueidentifier],
	[RoomId] [uniqueidentifier])

	DECLARE Asset_cursor CURSOR
    FOR SELECT [OwnerId], [RoomId]
    FROM #TempAsset;

    INSERT INTO #TempAsset
	SELECT DISTINCT [combine].[OwnerId], [combine].[RoomId]
	FROM(SELECT [t1].[OwnerId], [t2].[RoomId], ROW_NUMBER() OVER (ORDER BY NEWID()) AS [rownum]
        FROM #TempOwnerId AS [t1]
        CROSS JOIN #TempRoomId AS [t2]) AS [combine]
	WHERE [combine].[rownum] % 5 = 0;
   
    DECLARE @OwnerId [uniqueidentifier], @RoomId[uniqueidentifier];

	OPEN Asset_cursor;

	FETCH NEXT FROM Asset_cursor INTO 
    @OwnerId, @RoomId

	WHILE @@FETCH_STATUS = 0
	BEGIN
	    INSERT INTO #TempAssetId EXEC [dbo].[sp_Asset_Insert] @OwnerId = @OwnerId, @RoomId = @RoomId;

	    FETCH NEXT FROM Asset_cursor INTO 
        @OwnerId, @RoomId
	END

	CLOSE Asset_cursor;

	--Rent
	CREATE TABLE #TempRentId
	([RentId] [uniqueidentifier]);

	CREATE TABLE #TempRent
    ([AssetId] [uniqueidentifier],
	[TenantId] [uniqueidentifier],
	[EndDate] [date]);

	DECLARE Rent_cursor CURSOR
    FOR SELECT [AssetId], [TenantId], [EndDate]
    FROM #TempRent;

    INSERT INTO #TempRent
	SELECT DISTINCT [combine].[AssetId], [combine].[TenantId], DATEADD(MONTH, [combine].[rownum], GETDATE()) AS [EndDate]
	FROM(SELECT [t1].[AssetId], [t2].[TenantId], ROW_NUMBER() OVER (ORDER BY NEWID()) AS [rownum]
        FROM #TempAssetId AS [t1]
        CROSS JOIN #TempTenantId AS [t2]) AS [combine]
	WHERE [combine].[rownum] % 5 = 0;

	DECLARE @AssetId [uniqueidentifier], @TenantId [uniqueidentifier];

	OPEN Rent_cursor;

	FETCH NEXT FROM Rent_cursor INTO 
    @AssetId, @TenantId, @EndDate

	WHILE @@FETCH_STATUS = 0
	BEGIN
	    INSERT INTO #TempRentId EXEC [dbo].[sp_Rent_Insert] @AssetId = @AssetId, @TenantId = @TenantId, @EndDate = @EndDate;

	    FETCH NEXT FROM Rent_cursor INTO 
        @AssetId, @TenantId, @EndDate
	END

	CLOSE Rent_cursor;

	--Bill
	CREATE TABLE #TempBillId
	([BillId] [uniqueidentifier])

	CREATE TABLE #TempBillData
	([BillAmount] [numeric](18,2),
	[IssueDate] [date],
	[EndDate] [date])

	CREATE TABLE #TempBill
    ([BillAmount] [numeric](18,2),
	[AssetId] [uniqueidentifier],
	[TenantId] [uniqueidentifier],
	[IssueDate] [date],
	[EndDate] [date]);

	INSERT INTO #TempBillData
    VALUES
    (100.50, '2024-02-14', NULL),
    (75.25, '2023-02-15', '2023-08-15'),
    (120.75, '2024-02-16', NULL),
    (90.00, '2020-02-17', NULL),
    (60.80, '2023-02-18', NULL);

	DECLARE Bill_cursor CURSOR
    FOR SELECT [BillAmount], [AssetId], [TenantId], [IssueDate], [EndDate]
    FROM #TempBill;

    INSERT INTO #TempBill
	SELECT DISTINCT [combine].[BillAmount], [combine].[AssetId], [combine].[TenantId], [combine].[IssueDate], [combine].[EndDate]
	FROM(SELECT [t1].[BillAmount], [t1].[IssueDate], [t1].[EndDate], [t2].[AssetId], [t3].[TenantId], ROW_NUMBER() OVER (ORDER BY NEWID()) AS [rownum]
        FROM #TempBillData AS [t1]
        CROSS JOIN #TempAssetId AS [t2]
		CROSS JOIN #TempTenantId AS [t3]) AS [combine]
	WHERE [combine].[rownum] % 5 = 0;
   
	OPEN Bill_cursor;

	DECLARE @BillAmount [numeric](18,2), @IssueDate [date];

	FETCH NEXT FROM Bill_cursor INTO 
    @BillAmount, @AssetId, @TenantId, @IssueDate, @EndDate;

	WHILE @@FETCH_STATUS = 0
	BEGIN
	    INSERT INTO #TempBillId EXEC [dbo].[sp_Bill_Insert] @Amount = @BillAmount, @IssueDate = @IssueDate, @EndDate = @EndDate, @AssetId = @AssetId, @TenantId = @TenantId;

	   FETCH NEXT FROM Bill_cursor INTO 
       @BillAmount, @AssetId, @TenantId, @IssueDate, @EndDate;
	END

	CLOSE Bill_cursor;

	--Payment
	CREATE TABLE #TempPaymentData
	([PaymentDay] [datetime2],
	[Amount] [numeric](18,2));

	CREATE TABLE #TempPayment
    ([TenantId] [uniqueidentifier],
	[BillId] [uniqueidentifier],
	[PaymentDay] [datetime2],
	[Amount] [numeric](18,2));

	INSERT INTO #TempPaymentData ([PaymentDay], [Amount])
    VALUES
    ('2023-02-14 10:00:00', 100.50),
    ('2023-04-15 11:30:00', 75.25),
    ('2023-05-16 12:45:00', 120.75),
    ('2023-06-17 09:15:00', 90.00),
    ('2023-07-18 14:20:00', 60.80);

	DECLARE Payment_cursor CURSOR
    FOR SELECT [TenantId], [BillId], [PaymentDay], [Amount]
    FROM #TempPayment;

    INSERT INTO #TempPayment
	SELECT DISTINCT [combine].[TenantId], [combine].[BillId], [combine].[PaymentDay], [combine].[Amount]
	FROM(SELECT [t1].[PaymentDay], [t1].Amount, [t2].[TenantId], [t3].[BillId], ROW_NUMBER() OVER (ORDER BY NEWID()) AS [rownum]
        FROM #TempPaymentData AS [t1]
        CROSS JOIN #TempTenantId AS [t2]
		CROSS JOIN #TempBillId AS [t3]) AS [combine]
	WHERE [combine].[rownum] % 5 = 0;
   
    DECLARE @BillId [uniqueidentifier], @PaymentDay [datetime2], @Amount [numeric](18,2)

	OPEN Payment_cursor;

	FETCH NEXT FROM Payment_cursor INTO 
    @TenantId, @BillId, @PaymentDay, @Amount;

	WHILE @@FETCH_STATUS = 0
	BEGIN
	    EXEC [dbo].[sp_Payment_Insert] @TenantId = @TenantId, @BillId = @BillId, @PaymentDay = @PaymentDay, @Amount = @Amount;

	    FETCH NEXT FROM Payment_cursor INTO 
        @TenantId, @BillId, @PaymentDay, @Amount;
	END

	CLOSE Payment_cursor;

	--Impost
	CREATE TABLE #TempImpostData
	([Tax] [numeric](18,2),
	[Fine] [numeric](18,2),
	[PaymentDay] [int],
	[StartDay] [datetime2],
	[EndDay] [datetime2]);

	INSERT INTO #TempImpostData
    VALUES
    (00.50, 0.01, 11, '2024-02-14 00:00:00', NULL),
    (00.25, 0.05, 12, '2024-01-15 00:00:00', '2024-02-13 00:00:00'),
    (00.10, 0.02, 13, '2023-03-16 00:00:00', '2024-01-14 00:00:00'),
    (00.30, 0.05, 14, '2022-03-17 00:00:00', '2023-03-15 00:00:00'),
    (00.50, 0.01, 15, '2024-01-18 00:00:00', '2022-03-16 00:00:00');

	DECLARE Impost_cursor CURSOR
    FOR SELECT [Tax], [Fine], [PaymentDay], [StartDay], [EndDay]
    FROM #TempImpostData;
    
	DECLARE @Tax [numeric](4,2), @Fine [numeric](3,2), @PaymentDays[int], @StartDay [datetime2], @EndDay [datetime2];

	OPEN Impost_cursor;

	FETCH NEXT FROM Impost_cursor INTO 
    @Tax, @Fine, @PaymentDays, @StartDay, @EndDay;

	WHILE @@FETCH_STATUS = 0
	BEGIN
	    EXEC [dbo].[sp_Impost_Insert] @Tax = @Tax, @Fine = @Fine, @PaymentDay = @PaymentDays, @StartDay = @StartDay, @EndDay = @EndDay;

	    FETCH NEXT FROM Impost_cursor INTO 
        @Tax, @Fine, @PaymentDays, @StartDay, @EndDay;
	END

	CLOSE Impost_cursor;
END
GO