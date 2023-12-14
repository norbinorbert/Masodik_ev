Use Lab5_OnlineUjsag
GO

/*A. Az alábbi feladatot oldjátok meg többféleképpen:
SELECT utasítások segítségével adjuk meg azon kategóriá(ka)t (Kategoriak.KategoriaNev), mely(ek)hez a legkésőbb regisztrált 
felhasználók a legkevesebb cikket írták! Ügyeljünk arra, hogy lehet olyan felhasználó, aki egyetlen cikket sem írt eddig!*/

--1. egyetlen select-tel történő megoldás (természetesen lehet benne alkérdés), 
SELECT LK.KategoriaNev 
FROM(SELECT K.KategoriaNev, ISNULL(SUM(IC.CikkekSzama),0) AS CikkekSzama
	 FROM Kategoriak AS K
		LEFT JOIN (SELECT C.KategoriaID, COUNT(C.CikkID) AS CikkekSzama
					FROM Felhasznalok AS F
						JOIN Cikkek AS C ON F.FelhasznaloID = C.SzerzoID
					WHERE F.RegisztracioDatuma = (SELECT MAX(F.RegisztracioDatuma)
													FROM Felhasznalok AS F)
					GROUP BY C.KategoriaID) AS IC ON K.KategoriaID = IC.KategoriaID
	 GROUP BY K.KategoriaNev) AS LK
WHERE LK.CikkekSzama = (SELECT MIN(CikkekSzama) FROM (SELECT K.KategoriaNev, ISNULL(SUM(IC.CikkekSzama),0) AS CikkekSzama
														FROM Kategoriak AS K
															LEFT JOIN (SELECT C.KategoriaID, COUNT(C.CikkID) AS CikkekSzama
																		FROM Felhasznalok AS F
																			JOIN Cikkek AS C ON F.FelhasznaloID = C.SzerzoID
																		WHERE F.RegisztracioDatuma = (SELECT MAX(F.RegisztracioDatuma)
																										FROM Felhasznalok AS F)
																		GROUP BY C.KategoriaID) AS IC ON K.KategoriaID = IC.KategoriaID
														GROUP BY K.KategoriaNev) AS LK)

--2. Változók és/vagy nézetek használatával történő megoldás! 
GO
CREATE OR ALTER VIEW IrtCikkek
AS
	SELECT C.KategoriaID, COUNT(C.CikkID) AS CikkekSzama
	FROM Felhasznalok AS F
		JOIN Cikkek AS C ON F.FelhasznaloID = C.SzerzoID
	WHERE F.RegisztracioDatuma = (SELECT MAX(F.RegisztracioDatuma)
									FROM Felhasznalok AS F)
	GROUP BY C.KategoriaID
GO
CREATE OR ALTER VIEW LegkevesebbKategoriak
AS
	SELECT K.KategoriaNev, ISNULL(SUM(IC.CikkekSzama),0) AS CikkekSzama
	FROM Kategoriak AS K
		LEFT JOIN IrtCikkek AS IC ON K.KategoriaID = IC.KategoriaID
	GROUP BY K.KategoriaNev
GO

SELECT LK.KategoriaNev 
FROM LegkevesebbKategoriak AS LK
WHERE LK.CikkekSzama = (SELECT MIN(CikkekSzama) FROM LegkevesebbKategoriak)

/*B. Az alábbi feladatokban használjunk min 1 feladatnál temporális táblát és min 1 feladatnál tábla típusú változót. 
Tárolt eljárások és függvények segítségével oldjuk meg:
1. Írjunk tárolt eljárást, melynek bemenő paramétere egy természetes szám (@pSzam)! 
Ha @pSzam<0, írjunk ki megfelelő hibaüzenetet! Ellenkező esetben, írassuk ki azon felhasználó(ka)t, 
aki(k) által írt cikkek hozzászólásainak száma kisebb, mint a paraméterként megadott szám!
Ügyeljünk arra, hogy lehet olyan felhasználó, aki egyetlen cikket sem írt eddig/egyetlen hozzászólás sem érkezett a cikkeihez!*/
GO
CREATE OR ALTER PROCEDURE sp_HozzaszolasokSzama (@pSzam INT)
AS
	SET NOCOUNT ON
	IF (@pSzam < 0)
	BEGIN
		RAISERROR('Hiba: parameter kisebb, mint 0', 11, 1)	
		RETURN 1
	END

	SELECT F.TeljesNev
	FROM Felhasznalok AS F
		LEFT JOIN Cikkek AS C ON F.FelhasznaloID = C.SzerzoID
		LEFT JOIN Hozzaszolasok AS H ON C.CikkID = H.CikkID
	GROUP BY F.TeljesNev
	HAVING COUNT(H.HozzaszolasID) < @pSzam
GO

--Teszteles
EXEC sp_HozzaszolasokSzama 5

/*2. Írjunk függvényt, melynek bemenő paramétere: @pFelhasznaloNev-string típusú. A függvény segítségével számoljuk ki, 
hogy az adott felhasználó hány nappal ezelőtt kezdett hozzá az íráshoz (az első cikkének publikálásától számítjuk)! 
Visszatérítési érték: eltelt napok száma-int típusú.
Megj. Ellenőrizzük a bemeneti adatok helyességét: a felhasználónak léteznie kell az adatbázisban, 
nem lehet üres string megadva. Hibás bemenet esetén térítsünk vissza -1-et.*/
GO
CREATE OR ALTER FUNCTION fn_MiotaIr (@pFelhasznalonev VARCHAR(50))
RETURNS INT
AS
BEGIN
	DECLARE @a TABLE (FelhasznaloNev VARCHAR(50));
	INSERT INTO @a (FelhasznaloNev) (SELECT FelhasznaloNev FROM Felhasznalok)
	IF @pFelhasznalonev NOT IN (SELECT * FROM @a)
		RETURN -1

	DECLARE @datum DATE
	SET @datum = (SELECT MIN(C.Datum)
				FROM Felhasznalok AS F
					JOIN Cikkek AS C ON F.FelhasznaloID = C.SzerzoID
				WHERE F.FelhasznaloNev = @pFelhasznalonev)
	
	IF @datum IS NULL
		RETURN 0

	RETURN DATEDIFF(DAY, @datum, GETDATE())
END
GO

--Teszteles
DECLARE @ElteltNapokSzama INT 
EXEC @ElteltNapokSzama = fn_MiotaIr Attila
print(@ElteltNapokSzama)

SELECT dbo.fn_MiotaIr('Anna') AS ElteltNapokSzama

/*3. Írjunk tárolt eljárást, melynek bemenő paraméterei: @pKedvelesSzam-, @pSzazalek-int típusúak. 
A tárolt eljárás segítségével csökkentsük a legtöbb @pKedvelesSzam számú kedveléssel (cikkeinek összkedvelését tekintve) 
rendelkező felhasználó(k) fizetését @pSzazalek százalékkal!
A képernyőre írassuk ki a módosított felhasználó(k): felhasználónevét, teljes nevét, országát, 
valamint minden felhasználó esetén a kedvelt cikkeit, vesszőkkel elválasztva (FelhasznaloNev, TeljesNev, OrszagNev, KedveltCikkCimek). 
Használjuk a STRING_AGG függvényt! Kimeneti paraméter: @pmfsz (int) - módosított felhasználók száma.*/
GO
CREATE OR ALTER PROCEDURE sp_FizetesCsokkentes (@pKedvelesSzam INT, @pSzazalek INT, @pmfsz INT OUTPUT)
AS
BEGIN
	SET NOCOUNT ON
	IF @pSzazalek < 0 OR @pSzazalek > 100
	BEGIN
		RAISERROR('A szazalek 0 es 100 kozott kell legyen', 11, 1)
		RETURN 1
	END

	SELECT F.FelhasznaloID INTO #Felhasznalok
	FROM Felhasznalok AS F
		JOIN Cikkek AS C ON F.FelhasznaloID = C.SzerzoID
	GROUP BY F.FelhasznaloID
	HAVING SUM(C.Ertekeles) <= @pKedvelesSzam
	
	UPDATE Felhasznalok
	SET Fizetes = Fizetes - Fizetes * @pSzazalek / 100
	WHERE FelhasznaloID IN (SELECT * FROM #Felhasznalok)

	SELECT F.FelhasznaloNev, F.TeljesNev, O.OrszagNev
	FROM Felhasznalok AS F
		JOIN Orszagok AS O ON F.OrszagID = O.OrszagID
	WHERE F.FelhasznaloID IN (SELECT * FROM #Felhasznalok)

	SELECT F.FelhasznaloNev, F.TeljesNev, O.OrszagNev, STRING_AGG(C.CikkCim, ',') AS KedveltCikkCimek
	FROM Felhasznalok AS F
		JOIN Orszagok AS O ON O.OrszagID = F.OrszagID
		JOIN Kedvencek AS K ON F.FelhasznaloID = K.FelhasznaloID
		JOIN Cikkek AS C ON K.CikkID = K.CikkID
	GROUP BY F.FelhasznaloID, F.FelhasznaloNev, F.TeljesNev, O.OrszagNev

	SELECT @pmfsz = (SELECT COUNT(*) FROM #Felhasznalok)
END
GO

--Teszteles
DECLARE @a INT
EXEC sp_FizetesCsokkentes 22, 0, @a OUTPUT
SELECT @a AS ModositottFelhasznalokSzama

/*4. Írjunk függvényt, melynek bemeneti paraméterei: @pKulcsszoNev-, @pKategoriaNev - string.
A függvény egy táblában térítse vissza azon cikke(ke)t, amely(ek) az adott kategóriában íródtak/íródott, 
de NEM rendelkeznek/rendelkezik az adott kulcsszóval!*/
GO
CREATE OR ALTER FUNCTION fn_KulcsszoNelkuli(@pKulcsszoNev VARCHAR(50), @pKategoriaNev VARCHAR(50))
RETURNS TABLE
AS
	RETURN
	(SELECT C.CikkCim
	 FROM Cikkek AS C
		JOIN Kategoriak AS K ON C.KategoriaID = K.KategoriaID
	 WHERE K.KategoriaNev = @pKategoriaNev
	 EXCEPT
	 SELECT C.CikkCim
	 FROM Cikkek AS C
		JOIN Kategoriak AS K ON C.KategoriaID = K.KategoriaID
		JOIN Kulcsszavai AS KSI ON C.CikkID = KSI.CikkID
		JOIN Kulcsszavak AS KS ON KSI.KulcsszoID = KS.KulcsszoID
	 WHERE K.KategoriaNev = @pKategoriaNev
		AND KS.KulcsszoNev = @pKulcsszoNev)
GO

--Teszteles
SELECT * FROM fn_KulcsszoNelkuli('Korcsolya', 'Sport')

/*5. Írjunk tárolt eljárást, melynek bemeneti paraméterei: @pKulcsszoNev-, @pKategoriaNev - string-, @pDatum-dátum típusúak, @pErtekeles-int típusúak.
Ellenőrizzük le, hogy @pDatum értéke megfelelő-e (pl. 1990.jan.1 és az aktuális dátum közötti). Ha igen, 
írjunk ki megfelelő hibaüzenetet és térítsünk vissza 1-et. Ellenkező esetben, ellenőrizzük a többi bemeneti adat helyességét is: 
ne legyenek üres string-ek, illetve létezzen az adott kategória, kulcsszó. Nem megfelelő adatok esetén írjunk ki megfelelő hibaüzenetet 
és térítsünk vissza 2-t! Ellenkező esetben írassuk ki azon felhasználó(ka)t (Felhasznalok.FelhasznaloNev, Felhasznalok.EmailCim), 
aki(k) legalább egy olyan cikkhez hozzászólt(ak), amely értékelése kisebb, mint @pErtekeles, @pKategoriaNev kategóriában íródott, 
de NEM rendelkezik a @pKulcsszoNev kulcsszóval! */
GO
CREATE OR ALTER PROCEDURE sp_Hozzaszoltak (@pKulcsszoNev VARCHAR(50), @pKategoriaNev VARCHAR(50), @pDatum DATE, @pErtekeles INT)
AS
BEGIN
	SET NOCOUNT ON
	IF DATEDIFF(DAY, '1990-01-01', @pDatum) < 0 OR DATEDIFF(DAY, @pDatum, GETDATE()) < 0
	BEGIN
		RAISERROR('Helytelen datum', 11, 1)
		RETURN 1
	END
	IF @pKulcsszoNev NOT IN (SELECT KulcsszoNev FROM Kulcsszavak)
	BEGIN
		RAISERROR('Nincs ilyen kulcsszo', 11, 2)
		RETURN 2
	END
	IF @pKategoriaNev NOT IN (SELECT KategoriaNev FROM Kategoriak)
	BEGIN
		RAISERROR('Nincs ilyen kategoria', 11, 2)
		RETURN 2
	END
		
	SELECT F.FelhasznaloNev, F.EmailCim
	FROM Felhasznalok AS F
		JOIN Hozzaszolasok AS H ON F.FelhasznaloID = H.FelhasznaloID
		JOIN Cikkek AS C ON H.CikkID = C.CikkID
	WHERE C.Ertekeles < @pErtekeles
		AND C.CikkCim IN (SELECT * FROM fn_KulcsszoNelkuli(@pKulcsszoNev, @pKategoriaNev))
END
GO

--Teszteles
EXEC sp_Hozzaszoltak 'korcsolya', 'Sport', '2023-01-01', 100