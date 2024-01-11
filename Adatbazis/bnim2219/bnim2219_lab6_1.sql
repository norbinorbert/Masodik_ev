USE L6_Egyetem
GO

/*1.  Írjunk tárolt eljárást, melynek bemeneti paramétere: @pSzakNev-string típusú! Az eljárás adja meg (egy táblában) azon tanár-párokat, 
amelyek a megnevezett szakon tanítanak. A párok csak egyszer jelenjenek meg a felsorolásban. Amennyiben a megnevezett szaknév nem létezik, 
írjunk ki hibaüzenetet.*/
GO
CREATE OR ALTER PROCEDURE sp_tanarParok(@pSzakNev VARCHAR(25))
AS
BEGIN
	SET NOCOUNT ON
	IF @pSzakNev NOT IN (SELECT SzakNev FROM Szakok)
	BEGIN
		RAISERROR('Nem letezik ilyen szak', 11, 1)
		RETURN 1
	END
	SELECT DISTINCT Ta.Nev, Ta2.Nev
	FROM Szakok AS Sz
		JOIN Csoportok AS Cs ON Sz.SzakID = Cs.SzakID
		JOIN Tanit AS T ON Cs.CsoportID = T.CsoportID
		JOIN Tanarok AS Ta ON T.TanarID = Ta.TanarID, 
		(SELECT DISTINCT Ta.Nev
		FROM Szakok AS Sz
			JOIN Csoportok AS Cs ON Sz.SzakID = Cs.SzakID
			JOIN Tanit AS T ON Cs.CsoportID = T.CsoportID
			JOIN Tanarok AS Ta ON T.TanarID = Ta.TanarID
		WHERE Sz.SzakNev = @pSzakNev) as Ta2
	WHERE Sz.SzakNev = @pSzakNev
		AND Ta.Nev < Ta2.Nev
	ORDER BY Ta.Nev
END
GO

/*Teszteles
EXEC sp_tanarParok 'Informatika'
*/

/*2.  Írjunk DELETE triggert, mely akkor aktiválódik, ha törlünk egy vagy több sort a Tantargyak táblából. 
(Figyelem! A hivatkozási épség megszorítások fenntartása miatt probléma lehet, ha egy olyan tantárgyat szeretnék törölni, 
melyeket aktívan tanítanak. Ez esetben a problémát orvosoljuk a trigger segítségével! Amennyiben egy tanárnak minden órája törlődik, 
akkor az adott tanárt küldjük nyugdíba (töröljük a Tanarok táblából)).*/
GO
CREATE OR ALTER TRIGGER trTantargyTorles
ON Tantargyak
INSTEAD OF DELETE
AS BEGIN
	SET NOCOUNT ON
	DECLARE @tmp TABLE(
		TantargyID INT, 
		TantargyNev VARCHAR(50),
		KreditSzam INT,
		Leiras VARCHAR(50)
	);
	INSERT INTO @tmp (TantargyID, TantargyNev, KreditSzam, Leiras) 
		(SELECT * FROM deleted)
	
	DELETE FROM Tanit 
	WHERE TantargyID IN (SELECT TantargyID FROM @tmp)

	DELETE FROM Tantargyak
	WHERE TantargyID IN (SELECT TantargyID FROM @tmp)

	DELETE T
	FROM Tanarok AS T
		LEFT JOIN Tanit ON T.TanarID = Tanit.TanarID
	WHERE Tanit.TantargyID IS NULL
END
GO

/*Teszteles
DELETE FROM Tantargyak
WHERE TantargyID IN (2,3)
*/

/*3. a) Hozzunk létre egy új táblát: TanarFizetesEmelesek(EmelesID:int, TanarID:int, TanarNev: string, TanarTel: string, 
RegiFizetes:int, UjFizetes:int, ModositasDatuma:dátum+idő), ahol EmelesID a tábla elsődleges kulcsa (legyen automatikusan sorszámozható), 
míg a TanarID mező egy tanárra hivatkozik. A TanarID attribútum értéke a Tanarok táblából való törlés esetén NULL-ra módosuljon 
(a TanarNev, TanarTel attribútumokban tároljuk az adott tanár adatait - ha az adott tanár törlődik is, 
ezen mezőkben log-olva maradnak a tanár információi).*/
DROP TABLE IF EXISTS TanarFizetesEmelesek
CREATE TABLE TanarFizetesEmelesek(
	EmelesID INT IDENTITY,
	TanarID INT,
	TanarNev VARCHAR(50),
	TanarTel VARCHAR(15),
	RegiFizetes INT,
	UjFizetes INT,
	ModositasDatuma DATETIME,
	CONSTRAINT pk_TanarFizetesEmelesek_EmelesID PRIMARY KEY (EmelesID),
	CONSTRAINT fk_TanarFizetesEmelesek_TanarID FOREIGN KEY (TanarID) REFERENCES Tanarok(TanarID)
);
GO
CREATE OR ALTER TRIGGER trTanarTorles
ON Tanarok
INSTEAD OF DELETE
AS BEGIN
	SET NOCOUNT ON
	DECLARE @TanarIDk TABLE(ID INT);
	INSERT INTO @TanarIDk (ID) (SELECT TanarID FROM deleted)

	UPDATE TanarFizetesEmelesek
	SET TanarID = NULL
	WHERE TanarID IN (SELECT * FROM @TanarIDk)

	DELETE FROM Tanarok
	WHERE TanarID IN (SELECT * FROM @TanarIDk)
END
GO

/*b)  Írjunk UPDATE triggert, mely akkor aktiválódik, ha módosítunk egy vagy több sort a Tanarok táblában. 
Amennyiben a módosítás az adott tanár(ok) fizetésére (is) vonatkozott, akkor a trigger vezessen fel egy 
(vagy több) új sort a TanarFizetesEmelesek táblába, eltárolva az eddigi fizetést, az új fizetést és a módosítás dátumát.*/
GO
CREATE OR ALTER TRIGGER trFizetesValtoztatas
ON Tanarok
AFTER UPDATE
AS BEGIN
	SET NOCOUNT ON
	DECLARE @Regi TABLE(
		TanarID INT,
		Nev VARCHAR(30),
		Cim VARCHAR(30),
		Tel VARCHAR(12),
		Fizetes REAL); 
	DECLARE @Uj TABLE(
		TanarID INT,
		Nev VARCHAR(30),
		Cim VARCHAR(30),
		Tel VARCHAR(12),
		Fizetes REAL);

	INSERT INTO @Regi (TanarID, Nev, Cim, Tel, Fizetes) (SELECT * FROM deleted)
	INSERT INTO @Uj (TanarID, Nev, Cim, Tel, Fizetes) (SELECT * FROM inserted)

	INSERT INTO TanarFizetesEmelesek 
		SELECT DISTINCT R.TanarID, R.Nev, R.Tel, R.Fizetes, U.Fizetes, GETDATE()
		FROM @Regi AS R 
			JOIN @Uj AS U ON R.TanarID = U.TanarID
		WHERE R.Fizetes != U.Fizetes
END
GO

/*4. Írjunk INSERT triggert, mely akkor engedélyezi a Termek táblába való beszúrást, 
ha a terem neve NEM tartalmaz szám karaktereket és a férőhely értéke nagyobb, mint 20, de kisebb, mint 150.*/
GO
CREATE OR ALTER TRIGGER trUjTerem
ON Termek
INSTEAD OF INSERT
AS BEGIN
	SET NOCOUNT ON
	DECLARE @engedelyezett TABLE(
		TeremID INT,
		TeremNev VARCHAR(50),
		Ferohely INT
	);
	INSERT INTO @engedelyezett (TeremID, TeremNev, Ferohely)
		(SELECT * FROM inserted
		WHERE Ferohely > 20
			AND Ferohely < 150
			AND TeremNev NOT LIKE ('%[0-9]%'))

	INSERT INTO Termek (TeremID, TeremNev, Ferohely)
		(SELECT * FROM @engedelyezett)
END
GO

/*Teszteles
SELECT * FROM Termek
INSERT INTO Termek VALUES (12, 'b', 50), (13, '0asd', 120), (14, 'a', 10)
SELECT * FROM Termek
*/

/*5. Írjunk tárolt eljárást, melynek bemeneti paramétere: @pOraberLimit - egy valós szám. A tárolt eljárás segítségével ellenőrizzük, 
hogy @pOraberLimit > 0. Ha nem, írassunk ki megfelelő hibaüzenetet. Ellenkező esetben, írassuk ki azon tanárok nevét, 
akik az adott paraméternél kisebb órabérrel dolgoznak. (Feltételezve, hogy a Tanit tábla egy heti leosztását mutatja az óráknak, 
egy tanítási alkalom 2 fizikai órából áll, míg a tanárok fizetését havi szintre adjuk meg, számítsuk ki az adott tanár egy fizikai órára 
eső fizetését. Egy hónapban vehetjük úgy, hogy 4.5 hét van). Amennyiben vannak ilyen tanárok, emeljük fel a fizetésüket (UPDATE művelet) úgy, 
hogy az elérje a kapott limitet.*/
GO
CREATE OR ALTER PROCEDURE sp_szegenyek (@pOraberLimit REAL)
AS BEGIN
	SET NOCOUNT ON
	IF @pOraberLimit <= 0
	BEGIN
		RAISERROR('A megadot parameter nem nagyobb 0-nal', 11, 1)
		RETURN 1
	END

	SELECT T.TanarID, 4.5*2*COUNT(Ta.Ora) AS OrakSzamaEgyHonapban INTO #HaviOrakSzama
	FROM Tanarok AS T
		JOIN Tanit AS Ta ON T.TanarID = Ta.TanarID
	GROUP BY T.TanarID

	SELECT T.TanarID INTO #Szegenyek
	FROM Tanarok AS T
		JOIN #HaviOrakSzama AS H ON T.TanarID = H.TanarID
	WHERE (T.Fizetes / H.OrakSzamaEgyHonapban) < @pOraberLimit
	
	SELECT Nev FROM #Szegenyek JOIN Tanarok ON #Szegenyek.TanarID = Tanarok.TanarID

	DECLARE @Fizetesek TABLE(
		TanarID INT,
		Fizetes REAL);

	INSERT INTO @Fizetesek (TanarID, Fizetes)(SELECT DISTINCT T.TanarID, @pOraberLimit * H.OrakSzamaEgyHonapban
												FROM #Szegenyek AS T
													JOIN #HaviOrakSzama AS H ON T.TanarID = H.TanarID)

	UPDATE T
	SET T.Fizetes = F.Fizetes
	FROM Tanarok AS T
		JOIN @Fizetesek AS F ON T.TanarID = F.TanarID
END
GO

/*Teszteles
EXEC sp_szegenyek 20
SELECT * FROM TanarFizetesEmelesek
*/