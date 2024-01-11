USE master;
GO
IF EXISTS(select * from sys.databases where name='L6_Egyetem')
	DROP DATABASE L6_Egyetem

CREATE DATABASE L6_Egyetem;
GO
USE L6_Egyetem;
GO

CREATE TABLE Termek(
	TeremID INT
		CONSTRAINT TeremID_PK PRIMARY KEY(TeremID),
	TeremNev VARCHAR(30)
		CONSTRAINT TeremNev_U UNIQUE(TeremNev),
	Ferohely INT
);


CREATE TABLE Tantargyak(
	TantargyID INT
		CONSTRAINT TantargyID_PK PRIMARY KEY(TantargyID),
	TantargyNev VARCHAR(30) 
		CONSTRAINT TantargyNev_U UNIQUE(TantargyNev),
	KreditSzam INT,
	Leiras VARCHAR(30) DEFAULT 'NOTHING'
);


CREATE TABLE Szakok(
	SzakID INT 
		CONSTRAINT SzakID_PK PRIMARY KEY(SzakID),
	SzakNev VARCHAR(30) 
		CONSTRAINT SzakNev_U UNIQUE(SzakNev)
);


CREATE TABLE Csoportok(
	CsoportID INT 
		CONSTRAINT CsoportID_PK PRIMARY KEY(CsoportID),
	CsoportNev VARCHAR(30) 
		CONSTRAINT CsoportNev_U UNIQUE(CsoportNev),
	SzakID INT 
		CONSTRAINT SzakID_FK FOREIGN KEY(SzakID) REFERENCES Szakok(SzakID), 
	Letszam INT
);

CREATE TABLE Tanarok(
	TanarID INT 
		CONSTRAINT TanarID_PK PRIMARY KEY(TanarID),
	Nev VARCHAR(30),
	Cim VARCHAR(30),
	Tel VARCHAR(12),
	Fizetes REAL
);


CREATE TABLE Tanit(
    TanitID INT IDENTITY 
			CONSTRAINT TanitID_PK PRIMARY KEY(TanitID),
	TanarID INT 
			CONSTRAINT TanarID_FK FOREIGN KEY(TanarID) REFERENCES Tanarok(TanarID), 
	TantargyID INT 
			CONSTRAINT TantargyID_FK FOREIGN KEY(TantargyID) REFERENCES Tantargyak(TantargyID), 
	CsoportID INT 
			CONSTRAINT CsoportID_FK FOREIGN KEY(CsoportID) REFERENCES Csoportok(CsoportID), 
	TeremID INT
			CONSTRAINT TeremID_FK FOREIGN KEY(TeremID) REFERENCES Termek(TeremID), 
	Nap INT, --A het valamelyik napja. PL. 1-hetfo, 2-kedd, ..., 7-vasarnap
	Ora TIME --pl. 13:23
) 

insert into Termek (TeremID, TeremNev, Ferohely) values (1, 'Oyondu', '2019');
insert into Termek (TeremID, TeremNev, Ferohely) values (2, 'Voonix', '87302');
insert into Termek (TeremID, TeremNev, Ferohely) values (3, 'Babbleset', '18');
insert into Termek (TeremID, TeremNev, Ferohely) values (4, 'Oyoba', '59');
insert into Termek (TeremID, TeremNev, Ferohely) values (5, 'Topiclounge', '69282');
insert into Termek (TeremID, TeremNev, Ferohely) values (6, 'Divavu', '440');
insert into Termek (TeremID, TeremNev, Ferohely) values (7, 'Devshare', '770');
insert into Termek (TeremID, TeremNev, Ferohely) values (8, 'Digitube', '757');
insert into Termek (TeremID, TeremNev, Ferohely) values (9, 'Flashspan', '52');
insert into Termek (TeremID, TeremNev, Ferohely) values (10, 'Blogspan', '6912');
insert into Termek (TeremID, TeremNev, Ferohely) values (11, 'Central', '212');


--Informatika
insert into Tantargyak (TantargyID, TantargyNev, KreditSzam) values (1, 'Informatika alapjai', 7);
insert into Tantargyak (TantargyID, TantargyNev, KreditSzam) values (2, 'Szoftver fejelsztes', 7);
insert into Tantargyak (TantargyID, TantargyNev, KreditSzam) values (3, 'C++', 10);
insert into Tantargyak (TantargyID, TantargyNev, KreditSzam) values (4, 'Java', 6);
--Matematika
insert into Tantargyak (TantargyID, TantargyNev, KreditSzam) values (5, 'Geometria 1', 6);
insert into Tantargyak (TantargyID, TantargyNev, KreditSzam) values (6, 'Algebra', 10);
insert into Tantargyak (TantargyID, TantargyNev, KreditSzam) values (7, 'Analizis', 7);
--Teologia
insert into Tantargyak (TantargyID, TantargyNev, KreditSzam) values (8, 'Teologiai alapok 1', 2);
insert into Tantargyak (TantargyID, TantargyNev, KreditSzam) values (9, 'Teologiai alapok 2', 8);
--Fizika
insert into Tantargyak (TantargyID, TantargyNev, KreditSzam) values (10, 'Hotan', 2);
insert into Tantargyak (TantargyID, TantargyNev, KreditSzam) values (11, 'Mechanika', 8);


insert into Szakok (SzakID, SzakNev) values (1, 'Informatika')
insert into Szakok (SzakID, SzakNev) values (2, 'Matematika')
insert into Szakok (SzakID, SzakNev) values (3, 'Teologia')
insert into Szakok (SzakID, SzakNev) values (4, 'Fizika informatika')

insert into Csoportok (CsoportID, CsoportNev, SzakID, Letszam) values (1, 'Teo1', 3, 93);
insert into Csoportok (CsoportID, CsoportNev, SzakID, Letszam) values (2, 'Mat1', 2, 48);
insert into Csoportok (CsoportID, CsoportNev, SzakID, Letszam) values (3, 'Info1', 1, 85);
insert into Csoportok (CsoportID, CsoportNev, SzakID, Letszam) values (4, 'Info2', 1, 99);
insert into Csoportok (CsoportID, CsoportNev, SzakID, Letszam) values (5, 'Info3', 1, 99);
insert into Csoportok (CsoportID, CsoportNev, SzakID, Letszam) values (6, 'Fizinfo', 1, 15);

insert into Tanarok (TanarID, Nev, Cim, Tel, Fizetes) values (1, 'Lazarus Clendinning', '0 Arrowood Plaza', '1739686202', 500.5);
insert into Tanarok (TanarID, Nev, Cim, Tel, Fizetes) values (2, 'Emelina Littlechild', '10581 3rd Park', '1654211387',1000.21);
insert into Tanarok (TanarID, Nev, Cim, Tel, Fizetes) values (3, 'Rozamond Jowle', '75272 Bay Street', '7099120366',400);
insert into Tanarok (TanarID, Nev, Cim, Tel, Fizetes) values (4, 'Evita Mitcheson', '7455 Schlimgen Circle', '6336939128',350);
insert into Tanarok (TanarID, Nev, Cim, Tel, Fizetes) values (5, 'Jannelle McArd', '07 Boyd Street', '2554230517',650);
insert into Tanarok (TanarID, Nev, Cim, Tel, Fizetes) values (6, 'Bruce Gennerich', '09 Portage Terrace', '8222631307',725);
insert into Tanarok (TanarID, Nev, Cim, Tel, Fizetes) values (7, 'Belva Chardin', '011 Doe Crossing Road', '4209681426',250);
insert into Tanarok (TanarID, Nev, Cim, Tel, Fizetes) values (8, 'Richart Park', '9 Scofield Street', '6733493403',1200);
insert into Tanarok (TanarID, Nev, Cim, Tel, Fizetes) values (9, 'Mac Cosgrove', '2 Huxley Point', '9419078633',650);
insert into Tanarok (TanarID, Nev, Cim, Tel, Fizetes) values (10, 'Isacco Mollitt', '24 Esch Circle', '6004062431',475);
insert into Tanarok (TanarID, Nev, Cim, Tel, Fizetes) values (11, 'Jennifer Smith', '34 Central Perk', '3333332431',850);
insert into Tanarok (TanarID, Nev, Cim, Tel, Fizetes) values (12, 'Richart Park', '14 Central Perk', '8888332431',725);


insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (8, 5, 1, 7, 1, '11:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (3, 2, 1, 8, 5, '6:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (5, 1, 2, 8, 2, '10:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (2, 2, 4, 4, 4, '10:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (1, 8, 1, 1, 2, '6:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (1, 2, 3, 9, 2, '2:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (7, 3, 3, 7, 5, '12:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (5, 7, 2, 10, 2, '3:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (9, 5, 2, 6, 3, '8:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (9, 4, 1, 7, 6, '3:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (3, 2, 4, 6, 6, '3:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (4, 1, 4, 9, 4, '8:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (4, 9, 2, 7, 5, '1:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (5, 6, 2, 8, 2, '10:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (8, 9, 3, 10, 6, '7:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (6, 1, 2, 5, 6, '11:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (7, 3, 3, 4, 6, '2:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (5, 2, 2, 3, 1, '9:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (8, 3, 2, 10, 2, '2:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (9, 6, 2, 6, 3, '5:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (6, 9, 4, 8, 6, '9:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (2, 1, 4, 2, 4, '1:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (7, 2, 3, 9, 3, '11:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (2, 8, 2, 8, 5, '11:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (1, 1, 2, 2, 4, '9:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (1, 10, 6, 2, 4, '18:00');
insert into Tanit (TanarID, TantargyID, CsoportID, TeremID, Nap, Ora) values (1, 10, 5, 11, 4, '18:00');