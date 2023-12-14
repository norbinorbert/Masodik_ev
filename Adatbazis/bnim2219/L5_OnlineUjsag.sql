USE master;
GO

IF EXISTS(select * from sys.databases where name='Lab5_OnlineUjsag')
	DROP DATABASE Lab5_OnlineUjsag

SET DATEFORMAT YMD

CREATE DATABASE Lab5_OnlineUjsag;
GO

USE Lab5_OnlineUjsag;
GO

CREATE TABLE Orszagok(
	OrszagID INT IDENTITY
		CONSTRAINT OrszagID_PK PRIMARY KEY(OrszagID),
	OrszagNev VARCHAR(30)
		CONSTRAINT OrszagNev UNIQUE(OrszagNev)
);

CREATE TABLE Felhasznalok(
	FelhasznaloID INT IDENTITY
		CONSTRAINT FelhasznaloID_PK PRIMARY KEY(FelhasznaloID),
	FelhasznaloNev VARCHAR(20)
		CONSTRAINT FelhasznaloNev_U UNIQUE(FelhasznaloNev),
	TeljesNev VARCHAR(30),  
	EmailCim VARCHAR(20) DEFAULT 'anonymus@email.com',
	RegisztracioDatuma DATE DEFAULT '1990-01-01',
	OrszagID INT	
		CONSTRAINT OrszagID_FK FOREIGN KEY(OrszagID) REFERENCES Orszagok(OrszagID),
	NEME CHAR(1)
		CONSTRAINT Neme_CK CHECK (Neme='f' OR Neme='n'),
	FelhErtekeles INT 
		CONSTRAINT FelhErtekeles_CK CHECK (FelhErtekeles BETWEEN 1 AND 5),
	Fizetes INT
		CONSTRAINT Fizetes_CK CHECK (Fizetes>0)
);

CREATE TABLE Kategoriak(
	KategoriaID INT IDENTITY
		CONSTRAINT KategoriaID_PK PRIMARY KEY(KategoriaID),
	KategoriaNev VARCHAR(30),
		CONSTRAINT KategoriaNev UNIQUE(KategoriaNev)
);

CREATE TABLE Cikkek(
	CikkID INT IDENTITY
		CONSTRAINT CikkID_PK PRIMARY KEY(CikkID),
	CikkCim VARCHAR(50) NOT NULL,
	Datum DATE DEFAULT '1990-01-01',
	Szoveg VARCHAR(max),
	SzerzoID INT
		CONSTRAINT SzerzoID_FK FOREIGN KEY(SzerzoID) REFERENCES Felhasznalok(FelhasznaloID),
	KategoriaID INT
		CONSTRAINT KategoriaID_FK FOREIGN KEY(KategoriaID) REFERENCES Kategoriak(KategoriaID),
	Ertekeles INT
		CONSTRAINT Ertekeles_CK CHECK (Ertekeles BETWEEN 1 AND 10)
);

CREATE TABLE Kulcsszavak(
	KulcsszoID INT IDENTITY
		CONSTRAINT KulcsszoID_PK PRIMARY KEY(KulcsszoID),
	KulcsszoNev VARCHAR(30) 
		CONSTRAINT KulcsszoNev_U UNIQUE(KulcsszoNev)
);

CREATE TABLE Kulcsszavai(
	CikkID INT
		CONSTRAINT KuCikkID_FK FOREIGN KEY(CikkID) REFERENCES Cikkek(CikkID),
	KulcsszoID INT
		CONSTRAINT KuKulcsszoID_FK FOREIGN KEY(KulcsszoID) REFERENCES Kulcsszavak(KulcsszoID),
	CONSTRAINT Kulcsszavai_PK PRIMARY KEY (CikkID, KulcsszoID)
);

CREATE TABLE Hozzaszolasok (
	HozzaszolasID INT IDENTITY(1,1)		
		CONSTRAINT HozzaszolasID_PK PRIMARY KEY(HozzaszolasID),
	FelhasznaloID INT
		CONSTRAINT HFelhasznaloID_FK FOREIGN KEY(FelhasznaloID) REFERENCES Felhasznalok (FelhasznaloID),
	CikkID INT
		CONSTRAINT HCikkID_FK FOREIGN KEY(CikkID) REFERENCES Cikkek(CikkID),
	HozzaszolasDatuma DATE DEFAULT '1990-01-01',
	HozzaszolasSzovege VARCHAR(255)	
);

CREATE TABLE Kedvencek (
	FelhasznaloID INT
		CONSTRAINT KFelhasznaloID_FK FOREIGN KEY(FelhasznaloID) REFERENCES Felhasznalok(FelhasznaloID),
	CikkID INT
		CONSTRAINT KCikkID_FK FOREIGN KEY(CikkID) REFERENCES Cikkek (CikkID), 
	CONSTRAINT Kedvencek_PK PRIMARY KEY(FelhasznaloID, CikkID)
);

INSERT INTO Orszagok VALUES ('Romania'),	  --1
							('Magyarorszag'), --2							
							('Nemetorszag') --3

INSERT INTO Kategoriak VALUES ('Politika'), --1
							  ('Eletmod'),   --2
							  ('Bulvar'),    --3
							  ('Divat'),  --4
							  ('Sport')  --5

INSERT INTO Felhasznalok VALUES 
			('Anna', 'Kovacs Annamaria', 'anna@email.com', '2019-11-01', 1, 'n',3,500),        --1
			('Levente', 'Magyar Levente', 'levente@email.com','2020-10-01', 2, 'f', 5, 900),   --2
			('Attila', 'Antal Attila', 'attila@email.com','2020-12-01', 2, 'f', 2, 300),        --3
			('Gergo', 'Bereczki Gergely', 'gergo@email.com','2022-05-01', 3, 'f', 4, 600),      --4 
			('Istvan', 'Nagy Istvan', 'isti@email.com','2022-08-01', 2, 'f', 3, 450),			--5
			('Jurgen', 'Jurgen Schwarz', 'jurgen@email.com','2022-12-01',3,'f', 4, 900),		--6
			('Zsuzsi', 'Vajda Zsuzsa', 'zsuzsi@email.com','2023-10-01', 1, 'n', 5, 600),		--7
			('Zoli', 'Nagy Zoltan', 'zoltan@email.com','2023-01-01', 2, 'f', 5, 700),			--8
			('Boti', 'Laszlo Botond', 'boti@email.com','2023-04-01', 2, 'f', 4, 250)			--9

INSERT INTO Cikkek VALUES ('Karacsonyi ajandekotletek', '2022-10-15', null, 1, 2, 3),  --1
						  ('Karacsonyi sutemenyek', '2022-12-02', null, 3, 2, 5),      --2
						  ('B divizioban a Juventus', '2022-11-01', null, 1, 5, 8),    --3
						  ('Elkezdodott a mukorcsolya vilagbajnoksag', '2023-02-15', null, 6, 5, 7),  --4
						  ('Hazai palyan kapott ki a CFR', '2023-05-12', null, 6, 5, 8),	--5
						  ('Teli sportlehetosegek', '2023-08-01', null, 3, 2, 8),			--6
						  ('Madonna a D&G reklamarca', '2023-10-01', null, 1, 4, 8),		--7
						  ('Valik a sztarpar', '2023-08-05', null, 1, 3, 8),				--8
						  ('Obama Koppenhagaba utazott', '2023-09-01', null, 3, 1, 7),		--9
						  ('Megbukott a kormany', '2023-10-15', null, 1, 1, 4)				--10

INSERT INTO Kulcsszavak VALUES  ('karacsony'),  --1
								('ajandek'),	--2		
								('haztartas'),	--3
								('labdarugas'),	--4	
								('korcsolya'),	--5
								('konferencia'),--6
								('belpolitika'),--7
								('hazassag'),	--8
								('tel'),		--9
								('Amerika'),	--10
								('egeszseg')	--11
								
INSERT INTO Kulcsszavai VALUES (1, 1), (1, 2), (1, 9),
							   (2, 1), (2, 3),
							   (3, 4),
							   (4, 5),
							   (5, 4),
							   (6, 9), (6, 11),
							   (7, 10),
							   (8, 8),
							   (9, 6), (9, 10)

INSERT INTO Kedvencek VALUES(3, 9), (3, 8), (3, 5),
							(4, 7),
							(6, 7),
							(5, 5), (5, 9)

INSERT INTO Hozzaszolasok VALUES (1, 4, '2023-02-15', null)
INSERT INTO Hozzaszolasok VALUES (1, 4, '2023-02-16', null)
INSERT INTO Hozzaszolasok VALUES (2, 4, '2023-02-15', null)
INSERT INTO Hozzaszolasok VALUES (3, 4, '2023-02-15', null)
INSERT INTO Hozzaszolasok VALUES (4, 4, '2023-02-20', null)
INSERT INTO Hozzaszolasok VALUES (5, 4, '2023-08-15', null)
INSERT INTO Hozzaszolasok VALUES (6, 4, '2023-10-24', null)
INSERT INTO Hozzaszolasok VALUES (7, 4, '2023-10-24', null)
INSERT INTO Hozzaszolasok VALUES (9, 4, '2023-10-24', null)
INSERT INTO Hozzaszolasok VALUES (9, 4, '2023-10-24', null)
INSERT INTO Hozzaszolasok VALUES (3, 5, '2023-05-12', null)
INSERT INTO Hozzaszolasok VALUES (1, 9, '2023-09-17', null)
INSERT INTO Hozzaszolasok VALUES (1, 10, '2023-10-10', null)
INSERT INTO Hozzaszolasok VALUES (1, 7, '2023-10-25', null)
INSERT INTO Hozzaszolasok VALUES (2, 7, '2023-10-10', null)
INSERT INTO Hozzaszolasok VALUES (6, 7, '2023-10-30', null)
INSERT INTO Hozzaszolasok VALUES (6, 9, '2023-09-20', null)
INSERT INTO Hozzaszolasok VALUES (9, 9, '2023-09-21', null)
INSERT INTO Hozzaszolasok VALUES (9, 10, '2023-10-11', null)