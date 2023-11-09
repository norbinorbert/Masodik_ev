USE master
GO
DROP DATABASE IF EXISTS Vendeglo
GO
CREATE DATABASE Vendeglo
GO

USE Vendeglo

--Pincerek (PincerID:int, Nev:string)
CREATE TABLE Pincerek(
	PincerID INT IDENTITY,
	Nev VARCHAR(50),
	CONSTRAINT PK_Pincerek_PincerID PRIMARY KEY (PincerID)
);

--Vendegek (VendegID:int, Nev:string, Helyseg:string, UtcaNev:string, HazSzam:int, TelefonSzam:string)
CREATE TABLE Vendegek(
	VendegID INT IDENTITY,
	Nev VARCHAR(50),
	Helyseg VARCHAR(50),
	UtcaNev VARCHAR(50),
	HazSzam INT,
	Telefonszam VARCHAR(20),
	CONSTRAINT PK_Vendegek_VendegID PRIMARY KEY (VendegID)
);

--FizetesiModok (FizetesiModID:int, FizetesiMod:string);
CREATE TABLE FizetesiModok(
	FizetesiModID INT IDENTITY,
	FizetesiMod VARCHAR(15),
	CONSTRAINT PK_FizetesiModok_FizetesiModID PRIMARY KEY (FizetesiModID)
);

--AsztalTipusok (AsztalTipusID:int, Nev:string, DohanyzoE:"logikai")
CREATE TABLE AsztalTipusok(
	AsztalTipusID INT IDENTITY,
	Nev VARCHAR(50),
	DohanyzoE BIT,
	CONSTRAINT PK_AsztalTipusok_AsztalTipusID PRIMARY KEY (AsztalTipusID)
);

--Asztalok (Sorszam:int, Ferohely:tinyint, AsztalTipusID:int, DohanyzoE:"logikai")
CREATE TABLE Asztalok(
	Sorszam INT IDENTITY,
	Ferohely TINYINT,
	AsztalTipusID INT,
	DohanyzoE BIT,
	CONSTRAINT PK_Asztalok_Sorszam PRIMARY KEY (Sorszam),
	CONSTRAINT FK_Asztalok_AsztalTipusID FOREIGN KEY (AsztalTipusID) REFERENCES AsztalTipusok(AsztalTipusID)
);

--Foglalasok (FoglalasID:int, VendegID:int, AsztalSorszam:int, PincerID:int, Datum:dátum, Ora:idő, FizetesiModID:int)
CREATE TABLE Foglalasok(
	FoglalasID INT IDENTITY,
	VendegID INT,
	AsztalSorszam INT,
	PincerID INT,
	Datum DATE,
	Ora TIME,
	FizetesiModID INT,
	CONSTRAINT PK_Foglalasok_FoglalasID PRIMARY KEY (FoglalasID),
	CONSTRAINT FK_Foglalasok_VendegID FOREIGN KEY (VendegID) REFERENCES Vendegek(VendegID),
	CONSTRAINT FK_Foglalasok_AsztalSorszam FOREIGN KEY (AsztalSorszam) REFERENCES Asztalok(Sorszam),
	CONSTRAINT FK_Foglalasok_PincerID FOREIGN KEY (PincerID) REFERENCES Pincerek(PincerID),
	CONSTRAINT FK_Foglalasok_FizetesiModID FOREIGN KEY (FizetesiModID) REFERENCES FizetesiModok(FizetesiModID)
);

--Menuk (MenuID:int, Nev:string, Ar:float, Koltseg:float)
CREATE TABLE Menuk(
	MenuID INT IDENTITY,
	Nev VARCHAR(50),
	Ar FLOAT,
	Koltseg FLOAT,
	CONSTRAINT PK_Menuk_MenuID PRIMARY KEY (MenuID)
);

--Fogyasztas (FoglalasID:int, MenuID:int, DbSzam:int)
CREATE TABLE Fogyasztas(
	FoglalasID INT,
	MenuID INT,
	DbSzam INT,
	CONSTRAINT PK_Fogyasztas_FoglalasID_MenuID PRIMARY KEY (FoglalasID, MenuID),
	CONSTRAINT FK_Fogyasztas_FoglalasID FOREIGN KEY (FoglalasID) REFERENCES Foglalasok(FoglalasID),
	CONSTRAINT FK_Fogyasztas_MenuID FOREIGN KEY (MenuID) REFERENCES Menuk(MenuID)
);

/*A Foglalasok tábla AsztalSorszam és PincerID mezőit oly módon, hogy NE lehessenek NULL értékeik!*/
ALTER TABLE Foglalasok ALTER COLUMN AsztalSorszam INT NOT NULL

ALTER TABLE Foglalasok ALTER COLUMN PincerID INT NOT NULL

/*Szúrjuk be a Keresztnev mezőt a Vendegek táblába, és a Nev mezőt cseréljük át Vezeteknev-re!*/
ALTER TABLE Vendegek ADD Keresztnev VARCHAR(50)

ALTER TABLE Vendegek DROP COLUMN Nev

ALTER TABLE Vendegek ADD Vezeteknev VARCHAR(50)

/*Töröljük a Hazszam mezőt a Vendegek táblából!*/
ALTER TABLE Vendegek DROP COLUMN HazSzam

/*Az AsztalTipusok tábla AsztalTipusID mezőjét módosítsuk oly módon, hogy automatikus sorszámozható legyen! 
 A sorszámozás 5-től kezdődjön és az értékek tízesével növekedjenek (5, 15, 25 stb.).*/
 ALTER TABLE Asztalok DROP FK_Asztalok_AsztalTipusID
 ALTER TABLE AsztalTipusok DROP PK_AsztalTipusok_AsztalTipusID
 ALTER TABLE AsztalTipusok DROP COLUMN AsztalTipusID

 ALTER TABLE AsztalTipusok ADD AsztalTipusID INT IDENTITY(5,10)
 ALTER TABLE AsztalTipusok ADD CONSTRAINT PK_AsztalTipusok_AtszalTipusID PRIMARY KEY (AsztalTipusID)
 ALTER TABLE Asztalok ADD CONSTRAINT FK_Asztalok_AsztalTipusID FOREIGN KEY (AsztalTipusID) REFERENCES AsztalTipusok(AsztalTipusID)

/*Módosítsuk az Asztalok tábla Ferohely mezőjét oly módon, hogy INT típusú értékeket tároljon és 
 NE ülhessenek 6-nál többen egy asztalnál (ugyanakkor min 2 férőhelyes legyen)!*/
ALTER TABLE Asztalok ALTER COLUMN Ferohely INT 
ALTER TABLE Asztalok ADD CONSTRAINT Asztalok_Ferohely_Also_Hatar CHECK (Ferohely >= 2)
ALTER TABLE Asztalok ADD CONSTRAINT Asztalok_Ferohely_Felso_Hatar CHECK (Ferohely <= 6)

/*Módosítsuk a Menuk tábla Nev mezőjét oly módon, hogy értékei egyediek legyenek!*/
ALTER TABLE Menuk ADD CONSTRAINT Menuk_Nev_Unique UNIQUE (Nev)