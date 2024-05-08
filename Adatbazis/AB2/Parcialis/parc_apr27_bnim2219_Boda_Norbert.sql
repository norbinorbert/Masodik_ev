USE AB2Parc_apr27
GO

CREATE OR ALTER PROCEDURE sp_parcialis (@pKINev VARCHAR(50), @pBNev VARCHAR(50), @pBTelefon VARCHAR(50), @pBEmail VARCHAR(50),
									@pDatum DATE, @pKezdIdo TIME, @pOrakSzama INT, @pEredmeny TIME OUTPUT)
AS
BEGIN
SET NOCOUNT ON
	--letezik-e az iroda
	IF NOT EXISTS(SELECT 1 FROM KozossegiIrodak WHERE KINev = @pKINev)
	BEGIN
		RAISERROR('Nincs ilyen iroda', 11, 1)
		RETURN -1
	END

	DECLARE @IrodaID INT
	SELECT @IrodaID = KIrodaID FROM KozossegiIrodak WHERE KINev = @pKINev


	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	BEGIN TRANSACTION

	--letezik-e a berlo
	IF NOT EXISTS (SELECT 1 FROM Berlok WHERE BNev = @pBNev AND BTelefon = @pBTelefon AND BEmail = @pBEmail)
	BEGIN
		INSERT INTO Berlok VALUES (@pBNev, @pBTelefon, @pBEmail)
		IF @@ERROR != 0
		BEGIN
			RAISERROR('Nem sikerult beszurni a berlot', 11, 10)
			ROLLBACK
			RETURN -10
		END
	END
	
	DECLARE @berloID INT
	SELECT @berloID = BerloID FROM Berlok WHERE BNev = @pBNev AND BTelefon = @pBTelefon AND BEmail = @pBEmail

	--mivel az ora csak fix lehet, ezert minden oran vegig iteralok a kezdeti oratol kezdve
	DECLARE @ido TIME
	SET @ido = @pKezdIdo
	DECLARE @bezaras TIME
	--bezarasig lehet csak lefoglalni, utana nem
	SELECT @bezaras = DATEADD(HOUR, NyitvatartasOrakSzama, NyitasIdopontja) FROM KozossegiIrodak WHERE KIrodaID = @IrodaID

	WHILE DATEDIFF(HOUR, DATEADD(HOUR, @pOrakSzama, @ido), @bezaras) >= 0
	BEGIN
		DECLARE asztalCursor CURSOR FOR (SELECT MAID FROM Munkaasztalok WHERE KIrodaID = @IrodaID)
		OPEN asztalCursor
		DECLARE @asztalID INT
		FETCH NEXT FROM asztalCursor INTO @asztalID

		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF NOT EXISTS(SELECT 1 FROM Foglalasok WHERE MAID = @asztalID AND Datum = @pDatum 
							AND DATEADD(HOUR, @pOrakSzama, @ido) > KezdIdo AND DATEADD(HOUR, OrakSzama, KezdIdo) > @ido)
			BEGIN
				DECLARE @ar INT
				SELECT @ar = (ArPerOra * @pOrakSzama) FROM KozossegiIrodak WHERE KIrodaID = @IrodaID

				--ugyanabban a honap es evben a foglalasok szama; ha 9 ilyen van, akkor 50% discount
				IF (SELECT COUNT(*) FROM Foglalasok WHERE BerloID = @berloID AND DATEPART(MONTH, Datum) = DATEPART(MONTH, @pDatum)
					AND DATEPART(YEAR, Datum) = DATEPART(YEAR, @pDatum)) = 9
				BEGIN
					SET @ar = @ar / 2
				END
				INSERT INTO Foglalasok VALUES (@berloID, @asztalID, @pDatum, @ido, @pOrakSzama, @ar)
				IF @@ERROR != 0
				BEGIN
					RAISERROR('Nem sikerult lefoglalni', 11, 10)
					ROLLBACK
					RETURN -10
				END
				SET @pEredmeny = @ido
			
				CLOSE asztalCursor
				DEALLOCATE asztalCursor
				COMMIT
				RETURN 0
			END
			FETCH NEXT FROM asztalCursor INTO @asztalID
		END
		CLOSE asztalCursor
		DEALLOCATE asztalCursor
		SET @ido = DATEADD(HOUR, 1, @ido)
	END

	ROLLBACK
	RAISERROR('Nincs az adott napon szabad hely', 11, 2)
	RETURN -2
END
GO

--nem letezik az iroda
GO
DECLARE @retval INT, @output TIME
EXEC @retval = sp_parcialis 'Közösségi Iroda 111', 'nev', 'telefon', 'email', '2024-05-15', '9:00', 2, @output OUT
SELECT @retval, @output
GO

--minden jol megy, 10. futtatasra dicountot is kap
DECLARE @retval INT, @output TIME
EXEC @retval = sp_parcialis 'Közösségi Iroda 1', 'nev', 'telefon', 'email', '2024-05-15', '8:00', 2, @output OUT
SELECT @retval, @output
GO

--nem lehet foglalni
DECLARE @retval INT, @output TIME
EXEC @retval = sp_parcialis 'Közösségi Iroda 1', 'nev', 'telefon', 'email', '2024-05-15', '13:00', 4, @output OUT
SELECT @retval, @output
GO
/*
SELECT * FROM Berlok
SELECT * FROM Foglalasok WHERE BerloID = 13
SELECT * FROM Foglalasok WHERE Datum = '2024-05-15' AND MAID = 5
SELECT * FROM KozossegiIrodak
SELECT * FROM Munkaasztalok
*/