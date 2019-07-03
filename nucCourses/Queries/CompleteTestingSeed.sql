--INSERT INTO Items (ItemTypeId, ItemRaritiesId, [Name], [Description], [Value], StatOne, StatTwo, [Image], UserId, [Weight], Legal) VALUES ( 1,3,'Sword +1','Very Sharp!',100,'+1 DMG','+5 Attack','None',1,10,'true' );
--INSERT INTO Items (ItemTypeId, ItemRaritiesId, [Name], [Description], [Value], StatOne, StatTwo, [Image], UserId, [Weight], Legal) VALUES ( 1,5,'Flame Sword','Fire...',1580,'+3 DMG','+6 Attack','Cool.jpg',1,5,'true' );
--INSERT INTO Items (ItemTypeId, ItemRaritiesId, [Name], [Description], [Value], StatOne, StatTwo, [Image], UserId, [Weight], Legal) VALUES ( 2,2,'Shield','Adds AC',15,'+2 AC','Normal','Shield.png',2,5,'true' );
--INSERT INTO Items (ItemTypeId, ItemRaritiesId, [Name], [Description], [Value], StatOne, StatTwo, [Image], UserId, [Weight], Legal) VALUES ( 4,1,'Dog','Woof',12,'Protective','+5 Attack','Doggo.png',3,120,'true' );

--INSERT INTO ItemTypes ( Categories ) VALUES ( 'Weapon' );
--INSERT INTO ItemTypes ( Categories ) VALUES ( 'Armor' );
--INSERT INTO ItemTypes ( Categories ) VALUES ( 'Clothing' );
--INSERT INTO ItemTypes ( Categories ) VALUES ( 'Animals' );

--INSERT INTO ItemRarities( [Availability] ) VALUES ( 'Common' );
--INSERT INTO ItemRarities( [Availability] ) VALUES ( 'Uncommon' );
--INSERT INTO ItemRarities( [Availability] ) VALUES ( 'Rare' );
--INSERT INTO ItemRarities( [Availability] ) VALUES ( 'Very Rare' );
--INSERT INTO ItemRarities( [Availability] ) VALUES ( 'Legendary' );

--INSERT INTO Users ( [Name], Dm, [Password], Funds, GroupId, MaxCarry, CurrentWeight) VALUES ('Apollyon', 'true', 'nick', 12000, 2, 200, 100);
--INSERT INTO Users ( [Name], Dm, [Password], Funds, GroupId, MaxCarry, CurrentWeight) VALUES ('Cythera', 'false', 'megan', 737, 2, 150, 25);
--INSERT INTO Users ( [Name], Dm, [Password], Funds, GroupId, MaxCarry, CurrentWeight) VALUES ('Mittens', 'false', 'nick', 1002, 1, 120, 105);

--INSERT INTO Groups ( [Name], Funds ) VALUES ( 'Tombstone', 1242352);
--INSERT INTO Groups ( [Name], Funds ) VALUES ( 'Red Scare', 647387);
--INSERT INTO Groups ( [Name], Funds ) VALUES ( 'Paperless', 7382);

--SELECT Id, ItemTypeId, ItemRaritiesId, [Name], [Description], [Value], StatOne, StatTwo, [Image], UserId, [Weight], Legal FROM Items;

--SELECT * FROM Users
--SELECT * FROM Items


IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='Goups' and xtype='U')
CREATE TABLE Groups (
    Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
    [Name] VARCHAR(64) NOT NULL,
	Funds INTEGER NOT NULL
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='Users' and xtype='U')
CREATE TABLE Users (
    Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
    [Name] VARCHAR(64) NOT NULL,
    Dm BIT NOT NULL,
	[Password] VARCHAR(64) NOT NULL,
	Funds INTEGER NOT NULL,
	GroupId INTEGER NOT NULL,
	CONSTRAINT FK_Users_Groups FOREIGN KEY(GroupId) REFERENCES Groups(Id),
	MaxCarry INTEGER NOT NULL,
	CurrentWeight INTEGER NOT NULL
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='ItemTypes' and xtype='U')
CREATE TABLE ItemTypes (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	Categories VARCHAR(64) NOT NULL
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='ItemRarities' and xtype='U')
CREATE TABLE ItemRarities (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	[Availability] VARCHAR(64) NOT NULL
);
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='Items' and xtype='U')
CREATE TABLE Items (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	ItemTypeId INTEGER NOT NULL,
	ItemRaritiesId INTEGER NOT NULL,
	CONSTRAINT FK_Item_ItemType FOREIGN KEY(ItemTypeId) REFERENCES ItemTypes(Id), 
	CONSTRAINT FK_Item_ItemsRarity FOREIGN KEY(ItemRaritiesId) REFERENCES ItemRarities(Id), 
	[Name] VARCHAR(64) NOT NULL,
	[Description] VARCHAR(64) NOT NULL,
	[Value] INTEGER NOT NULL,
	StatOne VARCHAR(64) NOT NULL,
	StatTwo VARCHAR(64) NOT NULL,
	[Image] VARCHAR(64) NOT NULL,
	UserId INTEGER NOT NULL,
	CONSTRAINT FK_Item_User FOREIGN KEY(UserId) REFERENCES Users(Id),
	[Weight] INTEGER NOT NULL,
	Legal BIT NOT NULL,
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='UserItems' and xtype='U')
CREATE TABLE UserItems (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	UserId INTEGER NOT NULL,
	ItemId INTEGER NOT NULL,
	CONSTRAINT FK_UserItems_User FOREIGN KEY(UserId) REFERENCES Users(Id),
	CONSTRAINT FK_UserItems_Item FOREIGN KEY(ItemId) REFERENCES Items(Id),
	BoughtTime VARCHAR(64) NOT NULL,
	Bought VARCHAR(64) NOT NULL,
	SoldTime VARCHAR(64) NOT NULL,
	Sold VARCHAR(64) NOT NULL
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='CitySizes' and xtype='U')
CREATE TABLE CitySizes (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	Size VARCHAR(64) NOT NULL
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='Countries' and xtype='U')
CREATE TABLE Countries (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	[Name] VARCHAR(64) NOT NULL
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='Weather' and xtype='U')
CREATE TABLE Weather (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	Weather VARCHAR(64) NOT NULL,
	WeatherIcon VARCHAR(64) NOT NULL
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='Locations' and xtype='U')
CREATE TABLE Locations (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	CountryId INTEGER NOT NULL,
	CONSTRAINT FK_Locations_Country FOREIGN KEY(CountryId) REFERENCES Countries(Id),
	CitySizeId INTEGER NOT NULL,
	CONSTRAINT FK_Locations_CitySize FOREIGN KEY(CitySizeId) REFERENCES CitySizes(Id), 
	WeatherId INTEGER NOT NULL,
	CONSTRAINT FK_Locations_Weather FOREIGN KEY(WeatherId) REFERENCES Weather(Id), 
	CityName VARCHAR(64) NOT NULL,
	OwnedBy VARCHAR(64) NOT NULL,
	Ruler VARCHAR(64) NOT NULL,
	Biome VARCHAR(64) NOT NULL,
	LocationCode VARCHAR(64) NOT NULL,
	[Image] VARCHAR(64) NOT NULL,
	UserId INTEGER NOT NULL,
	CONSTRAINT FK_Locations_User FOREIGN KEY(UserId) REFERENCES Users(Id)
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='PlayerLocations' and xtype='U')
CREATE TABLE PlayerLocations (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	UserId INTEGER NOT NULL,
	CONSTRAINT FK_PlayerLocations_User FOREIGN KEY(UserId) REFERENCES Users(Id), 
	LocationId INTEGER NOT NULL,
	CONSTRAINT FK_PlayerLocations_Location FOREIGN KEY(LocationId) REFERENCES Locations(Id), 
	ArrivalTime VARCHAR(64) NOT NULL
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='Races' and xtype='U')
CREATE TABLE Races (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	[Name] VARCHAR(64) NOT NULL,
	[Languages] VARCHAR(64) NOT NULL,
	MaxAge VARCHAR(64) NOT NULL,
	MaxHeight VARCHAR(64) NOT NULL,
	Speed VARCHAR(64) NOT NULL,
	[Weight] VARCHAR(64) NOT NULL,
	Alignment VARCHAR(64) NOT NULL,
	Images VARCHAR(64) NOT NULL,
	[Description] VARCHAR(64) NOT NULL,
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='Classes' and xtype='U')
CREATE TABLE Classes (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	[Name] VARCHAR(64) NOT NULL,
	HitDie VARCHAR(64) NOT NULL,
	Ability VARCHAR(64) NOT NULL,
	Saves VARCHAR(64) NOT NULL,
	[Image] VARCHAR(64) NOT NULL,
	[Description] VARCHAR(64) NOT NULL,
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='Monsters' and xtype='U')
CREATE TABLE Monsters (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	[name] VARCHAR(64) NOT NULL,
	AC VARCHAR(64) NOT NULL,
	HP VARCHAR(64) NOT NULL,
	[Languages] VARCHAR(64) NOT NULL,
	CR VARCHAR(64) NOT NULL,
	Speed VARCHAR(64) NOT NULL,
	Alignment VARCHAR(64) NOT NULL,
	[Image] VARCHAR(64) NOT NULL,
	[Description] VARCHAR(64) NOT NULL,
)
GO
