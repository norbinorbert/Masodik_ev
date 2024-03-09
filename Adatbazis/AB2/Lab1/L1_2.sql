USE master;
GO

IF EXISTS(SELECT * FROM sys.databases WHERE name='Lab1_Mozik')
	DROP DATABASE Lab1_Mozik

SET DATEFORMAT YMD

CREATE DATABASE Lab1_Mozik;
GO

USE Lab1_Mozik;
GO

CREATE TABLE Mozik(
 MoziID INT PRIMARY KEY IDENTITY,
 MNev VARCHAR(20),
 MoziCim VARCHAR(30),
 FerohelyekSzama INT CHECK(FerohelyekSzama>0)
 )

CREATE TABLE Filmek(
 FilmID INT PRIMARY KEY IDENTITY,
 Cim VARCHAR(30),
 Studio VARCHAR(30),
 MegjEv INT,
 Idotartam INT
)

CREATE TABLE Vetitesek(
 VetID INT PRIMARY KEY IDENTITY,
 MoziID INT REFERENCES Mozik(MoziID),
 FilmID INT REFERENCES Filmek(FilmID),
 Datum DATE,
 Ora INT NOT NULL CHECK (Ora BETWEEN 10 and 23), 
 EladottHelyekSzama INT NOT NULL CHECK (EladottHelyekSzama >= 0)
)

CREATE TABLE Nezok(
NezoID INT PRIMARY KEY IDENTITY,
NNev VARCHAR(30),
NCim VARCHAR(30),
NTelefon VARCHAR(10)
)

CREATE TABLE Jegyek(
JegyID INT PRIMARY KEY IDENTITY,
VetID INT REFERENCES Vetitesek(VetID),
NezoID INT REFERENCES Nezok(NezoID),
Sor INT CHECK(Sor>0),
UlohelySorszam INT CHECK(UlohelySorszam>0)
)

INSERT INTO Mozik VALUES ('Mozi1', 'Cim1', 10), 
				         ('Mozi2', 'Cim2', 80),
						 ('Mozi3', 'Cim3', 50);

INSERT INTO Filmek VALUES ('Nemo nyomaban','Walt Disney Pictures',2003,120),
						  ('Transformers','DreamWorks SKG',2007,144),
						  ('White noise','Brightlight Pictures',2005,101),
						  ('Finding Neverland','Miramax Films',2004,106),
						  ('Ket het mulva orokke','Castle Rock Entertainment',2002,101);

INSERT INTO Vetitesek (MoziID, FilmID, Datum, Ora, EladottHelyekSzama) VALUES 
							 (1,1,'2025/02/02',12,8), --1
							 (1,1,'2025/02/02',21,0), --2
							 (2,1,'2025/02/02',11,4), --3
							 (2,1,'2025/02/02',22,5), --4
							 (1,5,'2025/02/03',16,10), --5
							 (2,5,'2025/02/03',18,0), --6
							 (2,4,'2025/02/03',23,0), --7
							 (3,2,'2025/02/03',15,6),  --8
							 (3,3,'2025/02/03',19,0), --9
							 (1,3,'2025/02/10',11,0), --10
							 (2,3,'2025/02/10',20,0), --11
							 (2,4,'2025/02/10',10,0); --12

INSERT INTO Nezok VALUES('Szilagyi Jeno','Kolozsvar, Scortarilor 79','0732067895'), --1
						('Andras Mihaly','Kolozsvar, Gr. Alexandrescu 5','0264435672'), --2
						('Kiraly Lorand','Kolozsvar, Unirii 1','0264789678'), --3
						('Csizmar Karoly','Nagyvarad, Closca 90','0260361739'), --4
						('Balogh Imre','Kolozsvar, Paris 3','0728345678'), --5
						('Andras Hannah','Kolozsvar, Gr. Alexandrescu 5','0264435672'), --6
						('Andor Zoltan','Kolozsvar, Fantanele 34','0780345678'), --7
						('Nagy Ildiko','Kolozsvar, Motilor 2','0751234786'), --8
						('Kollo Ingrid','Szatmarnemeti, Somesul 67','0261868685'), --9
						('Petok Ilona','Nagykaroly, Agoston 52','0728798789') --10

INSERT INTO Jegyek(VetID, NezoID, Sor, UlohelySorszam) VALUES 
						  (1, 1, 1, 1), --1
						  (1, 1, 1, 2),
						  (1, 1, 1, 3),
						  (1, 2, 1, 4),
						  (1, 3, 1, 6), --5
						  (1, 3, 1, 7),
						  (1, 4, 1, 9),
						  (1, 5, 1, 10), --8

						  (3, 3, 1, 5),
						  (3, 3, 1, 6), --10
						  (3, 5, 3, 9),
						  (3, 5, 3, 10),

						  (4, 4, 1, 5),	
						  (4, 4, 1, 6),
						  (4, 5, 2, 2), --15
						  (4, 5, 2, 3), 
						  (4, 5, 2, 4),
						  
						  (5, 7, 1, 1),
						  (5, 7, 1, 2),
						  (5, 7, 1, 3), --20
						  (5, 7, 1, 4), 
						  (5, 8, 1, 5),
						  (5, 3, 1, 6),
						  (5, 3, 1, 7),
						  (5, 6, 1, 8), --25
						  (5, 6, 1, 9), 
						  (5, 6, 1, 10),
						  
						  (8,10, 2, 8),
						  (8,10, 2, 9),
						  (8,10, 2, 10), --30
						  (8, 9, 3, 5), 
						  (8, 9, 3, 6),
						  (8, 6, 5, 2),
						  (8, 6, 5, 3),
						  (8, 4, 5, 7); --35