IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Address_City_Street_Building' AND object_id = OBJECT_ID('[dbo].[Address]'))
BEGIN
	CREATE UNIQUE INDEX IX_Address_City_Street_Building ON [dbo].[Address] ([City], [Street], [Building]);
END;
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Owner_Name' AND object_id = OBJECT_ID('[dbo].[[Owner]]'))
BEGIN
	CREATE UNIQUE INDEX IX_Owner_Name ON [dbo].[Owner] ([Name]);
END;
GO