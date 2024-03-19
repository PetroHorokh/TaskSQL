CREATE OR ALTER VIEW [dbo].[vw_Rooms_With_Tenants]
AS
SELECT [Room].[Number], [Tenant].[Name], [Rent].[StartDate], [Rent].[EndDate]
FROM [dbo].[Room] [Room]
LEFT JOIN [dbo].[Asset] AS [Asset] ON [Asset].[RoomId] = [Room].[RoomId]
LEFT JOIN [dbo].[Rent] AS [Rent] ON [Rent].[AssetId] = [Asset].[AssetId]
LEFT JOIN [dbo].[Tenant] AS [Tenant] ON [Tenant].[TenantId] = [Rent].[TenantId];
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Tenants_In_Rooms_In_Specific_day]
@Day [date]
AS
BEGIN
    SELECT [RWT].[Number] AS [Room Number], [RWT].[Name] AS [Tenant Name]
	FROM [dbo].[vw_Rooms_With_Tenants] [RWT]
	WHERE @Day BETWEEN [RWT].[StartDate] AND [RWT].[EndDate];
END;
GO

EXEC [dbo].[sp_Tenants_In_Rooms_In_Specific_day] @Day = '2022-01-02';
GO

CREATE OR ALTER VIEW [dbo].[vw_Certificate_For_Tenant]
AS
SELECT [Tenant].[TenantId], [Rent].[RentId], [Rent].[StartDate] AS [Rent Start Date], [Rent].[EndDate] AS [Rent End Date], [Bill].[BillId], [Payment].[PaymentId]
FROM [dbo].[Tenant] [Tenant]
LEFT JOIN [dbo].[Rent] AS [Rent] ON [Rent].[TenantId] = [Tenant].[TenantId]
LEFT JOIN [dbo].[Bill] AS [Bill] ON [Bill].[AssetId] = [Rent].[AssetId]
LEFT JOIN [dbo].[Payment] AS [Payment] ON [Payment].[BillId] = [Bill].[BillId];
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Get_Certificate_For_Tenant]
@TenantId [uniqueidentifier]
AS
BEGIN
    SELECT *
	FROM [dbo].[vw_Certificate_For_Tenant] [CFT]
	WHERE [CFT].[TenantId] = @TenantId;
END;
GO

DECLARE @TenantId [uniqueidentifier];

SELECT @TenantId = [Tenant].[TenantId]
FROM [dbo].[Tenant] [Tenant]
WHERE [Tenant].[Name] = 'Widget Industries';

EXEC [dbo].[sp_Get_Certificate_For_Tenant] @TenantId = @TenantId;
GO

CREATE OR ALTER VIEW [dbo].[vw_Tenant_Asset_Payment]
AS
SELECT [Tenant].[TenantId], [Tenant].[Name], [Rent].[RentId], [Room].[Number], [Room].[Area] * [Price].[Value] * (1 + [Impost].[Tax]) AS [Price]
FROM [dbo].[Tenant] [Tenant]
RIGHT JOIN [dbo].[Rent] AS [Rent] ON [Rent].[TenantId] = [Tenant].[TenantId]
LEFT JOIN [dbo].[Asset] AS [Asset] ON [Asset].[AssetId] = [Rent].[AssetId]
LEFT JOIN [dbo].[Room] AS [Room] ON [Room].[RoomId] = [Asset].[RoomId]
LEFT JOIN [dbo].[Price] AS [Price] ON [Price].[RoomTypeId] = [Room].[RoomTypeId]
CROSS JOIN [dbo].[Impost] AS [Impost]
WHERE [Rent].[StartDate] BETWEEN [Impost].[StartDate] AND [Impost].[EndDate];
GO

SELECT *
FROM [vw_Tenant_Asset_Payment];
GO