CREATE TABLE [dbo].[room](
    [id] uniqueidentifier NOT NULL,
    [area] int  NOT NULL,
    PRIMARY KEY ([id])
);

CREATE TABLE [dbo].[room_type](
	[id] uniqueidentifier NOT NULL,
    [type] char(255)  NOT NULL,
	[price] float NOT NULL,
    PRIMARY KEY ([id])
);

CREATE TABLE [dbo].[room_room_type](
	[room_id] uniqueidentifier NOT NULL,
	[room_type_id] uniqueidentifier NOT NULL,
    PRIMARY KEY ([room_id], [room_type_id])
)

CREATE TABLE [dbo].[tenant](
	[name] char(50) NOT NULL,
	[bank_id] uniqueidentifier NOT NULL,
	[address] char(50) NOT NULL,
	[director] char(50) NOT NULL,
	[description] char(255) NOT NULL,
	PRIMARY KEY ([name])
)

CREATE TABLE [dbo].[bank](
	[id] uniqueidentifier NOT NULL,
	[name] char(50) NOT NULL,
	PRIMARY KEY ([id])
) 

CREATE TABLE [dbo].[account](
	[id] uniqueidentifier NOT NULL,
	[tenant_id] uniqueidentifier NOT NULL,
	PRIMARY KEY ([id])
)

CREATE TABLE [dbo].[room_rent](
	[room_id] uniqueidentifier NOT NULL,
	[tenant_id] uniqueidentifier NOT NULL,
	[start_date] date NOT NULL,
	[end_date] date NOT NULL,
	PRIMARY KEY ([room_id])
)

