USE Lab1_Mozik
GO

/*Írjunk tárolt eljárást, mely segítségével megvásárolhatunk egy mozijegyet. 
Az eljárás paraméterei legyenek: @pMoziID-int, @pFilmCim-string, @pMegjEv-int, @pDatum-dátum, @pOra-int, @pNezoNev-string, 
@pNezoCim-string, @pNezoTelefon-string, @pSor-int, @pNezoUlohely-int, @ típusú attribútumok. 
A tárolt eljárás segítségével valósítsuk meg a következőket:
	Ellenőrizzük a bemeneti adatok helyességét: 
	-létezik-e az adott mozi, film, vetítés, néző; dátum, óra megfelelő-e 
	 (megfelelő-e a formátumuk, aktuális dátumnál nem-e régebbi stb.):
		-Ha a dátum, óra vagy az ülőhely értéke nem megfelelő: hibaüzenet kiíratása mellett térítsünk vissza -1-et.
		-Ha a mozi VAGY a film nem létezik: hibaüzenet kiíratása mellett térítsünk vissza -2-t.
		-Ha a vetítés nem létezik: figyelmeztető üzenet mellett szúrjuk be a Vetitesek táblába a megfelelő adatokat 
		 (EladottHelyekSzama legyen egy általatok választott érték), majd térítsünk vissza -3-at. 
		-Ha a személy nem létezik, szúrjuk be az adatait a Nezok táblába, majd folytassuk a következő alpontokkal.
	-Ellenőrizzük, hogy a megadott időpontban van-e szabad hely az adott vetítésre. 
		-Ha van szabad hely, akkor ellenőrizzük le, hogy szabad-e a kívánt ülőhely a megadott sorban. 
		 Ha nem, akkor egy @pOutEredmeny kimeneti paraméterben adjuk meg egy szabad ülőhely sorszámát  
		 az adott sorban és térítsünk vissza -5-t. Megj. Feltételezhetjük, hogy egy sorban max 10 ülőhely lehet. 
		 Ha az adott sorban nincs üres hely, megfelelő üzenet mellett térítsünk vissza -4-t. 
		 Ha a logika jó, elfogadunk más megoldást is.
		-Ha szabad a megadott ülőhely, akkor a visszatérítési érték 0 legyen. 
		 Emellett ekkor szúrjunk be egy sort a Jegyek táblába, majd adjunk hozzá egyet az 
		 EladottHelyekSzama attribútumhoz a megfelelő vetítésnél. 
	-Ha nincs szabad hely a megadott időpontban a megadott vetítésre, akkor nézzük meg, 
	 hogy van-e más időpont az adott napon, amikor van szabad hely az adott vetítésre. 
		-Ha igen, akkor írassuk ki ezek közül az adott napon a következő legkorábban kezdődő 
		 vetítések közül az elsőnek a kezdési időpontját, a visszatérítési érték pedig 1 legyen.
		-Ha aznap már nincs több vetítés, akkor a visszatérítési érték 2 legyen, 
		 valamint ekkor keressük meg a legkorábbi dátumot és időpontot, amikor az adott filmet vetítik az adott moziban, 
		 és írassuk ki: a dátumot, napot és időpontot (pl. ha a dátum 2021-03-10 volt és a legközelebbi vetítési időpont 
		 2021-03-15, 17, akkor a következőket írassuk ki a képernyőre: 
				2021-03-15, kedd [VAGY Tuesday VAGY 2 VAGY 3], 17.
		-Ha nincs több vetítés (tehát nem találtunk egyetlen időpontot sem, amikor vetítenék a filmet vagy lenne rá 
		szabad hely, akkor megfelelő üzenet kiíratása mellett térítsünk vissza -3-t.
	-Ügyeljünk a Vetitesek tábla Óra attribútumának megszorításaira.*/
CREATE OR ALTER PROCEDURE spLab1 (@pMoziID INT, @pFilmCim VARCHAR(50), @pMegjEv INT, @pDatum DATE, @pOra INT, 
@pNezoNev VARCHAR(50), @pNezoCim VARCHAR(50), @pNezoTelefon VARCHAR(20), @pSor INT, @pNezoUlohely INT, @pOutEredmeny INT OUT)
AS
BEGIN
SET NOCOUNT ON
	--Ha a dátum, óra vagy az ülőhely értéke nem megfelelő: hibaüzenet kiíratása mellett térítsünk vissza -1-et.
	--Ha a mozi VAGY a film nem létezik: hibaüzenet kiíratása mellett térítsünk vissza -2-t.
	IF (DATEDIFF(D, GETDATE(), @pDatum) < 0)
	BEGIN
		RAISERROR('Nem jo datum', 11, 1)
		RETURN -1
	END

	IF ((DATEDIFF(D, GETDATE(), @pDatum) = 0) AND (DATEPART(HOUR, GETDATE()) > @pOra))
		OR (@pOra < 10) OR (@pOra > 23)
	BEGIN
		RAISERROR('Nem jo ora', 11, 2)
		RETURN -1
	END
	
	IF NOT EXISTS (SELECT 1 FROM Mozik WHERE MoziID = @pMoziID)
	BEGIN
		RAISERROR('Nem letezik a mozi', 11, 4)
		RETURN -2
	END

	IF (@pNezoUlohely > 10) OR (@pNezoUlohely <= 0) OR
	NOT EXISTS (SELECT 1 FROM Mozik WHERE ((FerohelyekSzama / 10) >= @pSor) AND MoziID = @pMoziID)
	BEGIN
		RAISERROR('Nincs ilyen ulohely', 11, 3)
		RETURN -1
	END

	IF NOT EXISTS (SELECT 1 FROM Filmek WHERE Cim = @pFilmCim AND MegjEv = @pMegjEv)
	BEGIN
		RAISERROR('Nem letezik a film', 11, 5)
		RETURN -2
	END
	
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	BEGIN TRANSACTION 

	--Ha a vetítés nem létezik: figyelmeztető üzenet mellett szúrjuk be a Vetitesek táblába a megfelelő adatokat 
	--	 (EladottHelyekSzama legyen egy általatok választott érték), majd térítsünk vissza -3-at. 
	DECLARE @FID INT
	SELECT @FID = FilmID FROM Filmek WHERE Cim = @pFilmCim AND MegjEv = @pMegjEv

	IF NOT EXISTS (SELECT 1 FROM Vetitesek WHERE MoziID = @pMoziID AND FilmID = @FID AND Datum = @pDatum AND Ora = @pOra)
	BEGIN
		INSERT INTO Vetitesek VALUES (@pMoziID, @FID, @pDatum, @pOra, 0)
		IF @@ERROR <> 0
		BEGIN
			RAISERROR('Varatlan hiba allt fel', 11, 0)
			ROLLBACK
			RETURN -10
		END
		RAISERROR('Nem volt ilyen vetites, de most lett letrehozva', 6, 6)
		COMMIT 
		RETURN -3
	END

	--Ha a személy nem létezik, szúrjuk be az adatait a Nezok táblába, majd folytassuk a következő alpontokkal.
	IF NOT EXISTS(SELECT 1 FROM Nezok WHERE NNev = @pNezoNev AND NCim = @pNezoCim AND NTelefon = @pNezoTelefon)
	BEGIN
		INSERT INTO Nezok VALUES (@pNezoNev, @pNezoCim, @pNezoTelefon)
		IF @@ERROR <> 0
		BEGIN
			RAISERROR('Varatlan hiba allt fel', 11, 0)
			ROLLBACK
			RETURN -10
		END
	END
	
    --Ellenőrizzük, hogy a megadott időpontban van-e szabad hely az adott vetítésre. 
	DECLARE @ferohely INT, @vetites INT, @NID INT
	SELECT @ferohely = FerohelyekSzama FROM Mozik WHERE MoziID = @pMoziID
	SELECT @NID = NezoID FROM Nezok WHERE NNev = @pNezoNev AND NCim = @pNezoCim AND NTelefon = @pNezoTelefon
	SELECT @vetites = VetID FROM Vetitesek WHERE MoziID = @pMoziID AND FilmID = @FID AND Datum = @pDatum AND Ora = @pOra

	IF (@ferohely > (SELECT EladottHelyekSzama FROM Vetitesek WHERE VetID = @vetites))
	BEGIN
		/*Ha van szabad hely, akkor ellenőrizzük le, hogy szabad-e a kívánt ülőhely a megadott sorban. 
		 Ha szabad a megadott ülőhely, akkor a visszatérítési érték 0 legyen. 
		 Emellett ekkor szúrjunk be egy sort a Jegyek táblába, majd adjunk hozzá egyet az 
		 EladottHelyekSzama attribútumhoz a megfelelő vetítésnél. */
		IF NOT EXISTS (SELECT 1 FROM Jegyek
					WHERE Sor = @pSor AND UlohelySorszam = @pNezoUlohely AND VetID = @vetites)
		BEGIN
			INSERT INTO Jegyek VALUES (@vetites, @NID, @pSor, @pNezoUlohely)
			IF @@ERROR <> 0
			BEGIN
				RAISERROR('Varatlan hiba allt fel', 11, 0)
				ROLLBACK
				RETURN -10
			END
			UPDATE Vetitesek SET EladottHelyekSzama = EladottHelyekSzama + 1 WHERE VetID = @vetites
			IF @@ERROR <> 0
			BEGIN
				RAISERROR('Varatlan hiba allt fel', 11, 0)
				ROLLBACK
				RETURN -10
			END
			COMMIT
			RETURN 0
		END

		/*Ha nem, akkor egy @pOutEredmeny kimeneti paraméterben adjuk meg egy szabad ülőhely sorszámát  
		 az adott sorban és térítsünk vissza -5-t. Megj. Feltételezhetjük, hogy egy sorban max 10 ülőhely lehet. 
		 Ha az adott sorban nincs üres hely, megfelelő üzenet mellett térítsünk vissza -4-t.*/
		DECLARE @i INT
		SET @i = 1
		WHILE(@i < 11)
		BEGIN
			IF NOT EXISTS (SELECT 1 FROM Jegyek WHERE Sor = @pSor AND UlohelySorszam = @i AND VetID = @vetites)
			BEGIN
				SET @pOutEredmeny = @i
				COMMIT
				RETURN -5
			END
			ELSE
			BEGIN
				SET @i = @i + 1
			END
		END

	    --Ha az adott sorban nincs üres hely, megfelelő üzenet mellett térítsünk vissza -4-t.
		RAISERROR('Nincs szabad hely a megadott sorban', 11, 7)
		COMMIT
		RETURN -4
	END
	
	/*Ha nincs szabad hely a megadott időpontban a megadott vetítésre, akkor nézzük meg, 
	 hogy van-e más időpont az adott napon, amikor van szabad hely az adott vetítésre. */
	
	/*Ha igen, akkor írassuk ki ezek közül az adott napon a következő legkorábban kezdődő 
	 vetítések közül az elsőnek a kezdési időpontját, a visszatérítési érték pedig 1 legyen.*/
	IF EXISTS (SELECT 1 FROM Vetitesek
		WHERE MoziID = @pMoziID AND Datum = @pDatum AND FilmID = @FID AND EladottHelyekSzama < @ferohely AND Ora > @pOra)
	BEGIN
		SELECT Ora INTO #tmp
		FROM Vetitesek
		WHERE MoziID = @pMoziID AND Datum = @pDatum AND FilmID = @FID 
			AND EladottHelyekSzama < @ferohely AND Ora > @pOra

		SELECT MIN(Ora)
		FROM #tmp
		COMMIT
		RETURN 1
	END

	/*-Ha aznap már nincs több vetítés, akkor a visszatérítési érték 2 legyen, 
		 valamint ekkor keressük meg a legkorábbi dátumot és időpontot, amikor az adott filmet vetítik az adott moziban, 
		 és írassuk ki: a dátumot, napot és időpontot (pl. ha a dátum 2021-03-10 volt és a legközelebbi vetítési időpont 
		 2021-03-15, 17, akkor a következőket írassuk ki a képernyőre: 
				2021-03-15, kedd [VAGY Tuesday VAGY 2 VAGY 3], 17.*/
	IF EXISTS(SELECT 1 FROM Vetitesek
			WHERE MoziID = @pMoziID AND FilmID = @FID AND EladottHelyekSzama < @ferohely AND DATEDIFF(D, @pDatum, Datum) > 0)
	BEGIN
		SELECT Datum, Ora INTO #tmp2
		FROM Vetitesek
		WHERE MoziID = @pMoziID AND FilmID = @FID AND EladottHelyekSzama < @ferohely 
			AND DATEDIFF(D, @pDatum, Datum) > 0

		DECLARE @datum DATE, @ora INT
		SELECT TOP 1 @datum = Datum, @ora = Ora
		FROM #tmp2
		WHERE Datum = (SELECT MIN(Datum) FROM #tmp2)
			AND Ora = (SELECT MIN(Ora) FROM #tmp2 
						WHERE Datum = (SELECT MIN(Datum) FROM #tmp2))
		PRINT CAST(@datum AS VARCHAR(25)) + ', ' + CAST(DATENAME(dw, @datum) AS VARCHAR(25)) + ', ' + CAST(@ora AS VARCHAR(25))
		COMMIT
		RETURN 2
	END
	
	/*Ha nincs több vetítés (tehát nem találtunk egyetlen időpontot sem, amikor vetítenék a filmet vagy lenne rá 
	  szabad hely, akkor megfelelő üzenet kiíratása mellett térítsünk vissza -3-t.*/

	RAISERROR('Nincs tobb vetites', 11, 8)
	COMMIT
	RETURN -3
END
GO
/*
--nem jo datum
DECLARE @return INT
EXEC @return = spLab1 1, 'Nemo nyomaban', 2003, '2023-03-03', 13, 'Nev', 'Cim', '0756', 1, 1, null
SELECT @return

--uj vetites hozzaadasa
DECLARE @return INT
EXEC @return = spLab1 1, 'Nemo nyomaban', 2003, '2025-03-03', 13, 'Nev', 'Cim', '0756', 1, 1, null
SELECT @return

--minden jol megy(ha az elozo is le volt futtatva)
DECLARE @return INT
EXEC @return = spLab1 1, 'Nemo nyomaban', 2003, '2025-03-03', 13, 'Nev', 'Cim', '0756', 1, 1, null
SELECT @return

--outputban van az uj hely
DECLARE @return INT
DECLARE @out INT
EXEC @return = spLab1 1, 'Nemo nyomaban', 2003, '2025-03-03', 13, 'Nev', 'Cim', '0756', 1, 1, @out OUT
SELECT @out as OUT, @return AS RET

--ora kiirasa a kovetkezo vetitesre (beszur ketto ujat, majd a korabbi lesz kiirva)
DECLARE @return INT
EXEC spLab1 1, 'Nemo nyomaban', 2003, '2025-03-03', 16, 'Nev', 'Cim', '0756', 1, 1, null
EXEC spLab1 1, 'Nemo nyomaban', 2003, '2025-03-03', 14, 'Nev', 'Cim', '0756', 1, 1, null
UPDATE Vetitesek SET EladottHelyekSzama = 10 WHERE VetID = 13
EXEC @return = spLab1 1, 'Nemo nyomaban', 2003, '2025-03-03', 13, 'Nev', 'Cim', '0756', 1, 1, null
SELECT @return

--nincs tobb vetites
DECLARE @return INT
UPDATE Vetitesek SET EladottHelyekSzama = 10 WHERE VetID IN (14, 15)
EXEC @return = spLab1 1, 'Nemo nyomaban', 2003, '2025-03-03', 13, 'Nev', 'Cim', '0756', 1, 1, null
SELECT @return

--datum kiirasa a kovetkezo vetitesre (beszur ketto ujat, majd a korabbi lesz kiirva)
DECLARE @return INT
EXEC spLab1 1, 'Nemo nyomaban', 2003, '2026-04-03', 12, 'Nev', 'Cim', '0756', 1, 1, null
EXEC spLab1 1, 'Nemo nyomaban', 2003, '2026-03-03', 16, 'Nev', 'Cim', '0756', 1, 1, null
EXEC @return = spLab1 1, 'Nemo nyomaban', 2003, '2025-03-03', 13, 'Nev', 'Cim', '0756', 1, 1, null
SELECT @return

SELECT * FROM Vetitesek
SELECT * FROM Filmek
SELECT * FROM Jegyek
SELECT * FROM Mozik
SELECT * FROM Nezok
*/