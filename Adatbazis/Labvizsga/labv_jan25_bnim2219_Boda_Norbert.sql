USE HR
GO

--1.
SELECT A.Nev, COUNT(DISTINCT R.ReszlegID) AS ReszlegekSzama
FROM Alkalmazottak AS A
	LEFT JOIN AlkalmazottMunkakorok AS AM ON A.AlkalmazottID = AM.AlkalmazottID
	LEFT JOIN Reszlegek AS R ON AM.ReszlegID = R.ReszlegID
GROUP BY A.AlkalmazottID, A.Nev
HAVING COUNT(DISTINCT R.ReszlegID) < 2
ORDER BY ReszlegekSzama DESC

--2.
SELECT M.Nev
FROM Munkakorok AS M
	JOIN AlkalmazottMunkakorok AS AM ON M.MunkakorID = AM.MunkakorID
	JOIN Alkalmazottak AS A ON AM.AlkalmazottID = A.AlkalmazottID
	JOIN Vegzettsegek AS V ON V.VegzettsegID = A.VegzettsegID
	JOIN Irodak AS I ON I.IrodaID = AM.IrodaID
WHERE V.VegzettsegiSzint = 'Masters of Business Administration'
	AND I.Nev = 'HQ'
INTERSECT
SELECT M.Nev
FROM Munkakorok AS M
	JOIN AlkalmazottMunkakorok AS AM ON M.MunkakorID = AM.MunkakorID
	JOIN Alkalmazottak AS A ON AM.AlkalmazottID = A.AlkalmazottID
	JOIN Irodak AS I ON I.IrodaID = AM.IrodaID
WHERE I.Nev <> 'South'
	AND I.Nev <> 'West'

--3.
SELECT A.Nev, I.Nev
FROM Alkalmazottak AS A
	JOIN AlkalmazottMunkakorok AS AM ON A.AlkalmazottID = AM.AlkalmazottID
	JOIN Irodak AS I ON I.IrodaID = AM.IrodaID
WHERE A.AlkalmazottID IN (SELECT MenedzserID FROM AlkalmazottMunkakorok)
	AND AM.MenedzserID IS NULL

--4.
SELECT V.VarosNev, COUNT(DISTINCT R.ReszlegID) AS ReszlegekSzama
FROM Varosok AS V
	JOIN Alkalmazottak AS A ON V.VarosID = A.VarosID
	JOIN AlkalmazottMunkakorok AS AM ON A.AlkalmazottID = AM.AlkalmazottID
	JOIN Reszlegek AS R ON R.ReszlegID = AM.ReszlegID
GROUP BY V.VarosID, V.VarosNev
HAVING COUNT(DISTINCT A.AlkalmazottID) = (SELECT TOP 1 COUNT(DISTINCT AlkalmazottID) AS ASzam
								FROM Alkalmazottak AS A
									JOIN Varosok AS V ON A.VarosID = V.VarosID
								GROUP BY V.VarosID
								ORDER BY ASzam DESC)

--5.
DROP TABLE IF EXISTS #Kulonbseg
SELECT AVG(AM.Fizetes) - MIN(AM.Fizetes) AS Kulonbseg INTO #Kulonbseg
FROM Munkakorok AS M
	JOIN AlkalmazottMunkakorok AS AM ON M.MunkakorID = AM.MunkakorID

SELECT M.Nev
FROM Munkakorok AS M
	JOIN AlkalmazottMunkakorok AS AM ON M.MunkakorID = AM.MunkakorID
GROUP BY M.MunkakorID, M.Nev
HAVING MAX(AM.Fizetes) - MIN(AM.Fizetes) > (SELECT * FROM #Kulonbseg)

--6.a
ALTER TABLE AlkalmazottMunkakorok
ADD CONSTRAINT Minimum_Fizetes CHECK (Fizetes >= 0)

--6.b
ALTER TABLE Munkakorok
DROP CONSTRAINT DF__Munkakoro__Munka__3E52440B
ALTER TABLE Munkakorok
DROP COLUMN MunkakorLeiras

--7.
GO
CREATE OR ALTER PROCEDURE sp_nagyFizetes (@pKezdoIdopont DATE, @pVegsoIdopont DATE, @pFizetes INT)
AS
BEGIN
	IF @pFizetes <= 0
		RETURN -1
	
	IF DATEDIFF(D,@pKezdoIdopont, @pVegsoIdopont) < 0
	BEGIN
		RAISERROR('A datumok "novekvo" sorrendben legyenek', 11, 1)
		RETURN -1
	END

	--a fuggveny azokat az embereket szamolja, akik az intervallumban legalabb 1 napot dolgoztak
	SELECT AM.AlkalmazottID INTO #Alkalmazottak
	FROM AlkalmazottMunkakorok AS AM
	WHERE DATEDIFF(D, @pKezdoIdopont, AM.VegsoDatum) > 0 --@pKezdoIdopont <= AM.VegsoDatum 
		AND DATEDIFF(D, @pVegsoIdopont, AM.KezdetiDatum) < 0 --@pVegsoIdopont > AM.KezdetiDatum
		AND AM.Fizetes > @pFizetes

	RETURN (SELECT COUNT(DISTINCT AlkalmazottID) FROM #Alkalmazottak)
END
GO

DECLARE @ASD INT
EXEC @ASD = sp_nagyFizetes '2016-03-06', '2016-09-09', 1
SELECT @ASD

--8.
--csak azokat a sorokat szurja be, amelyek kezdeti datuma multbeli datum
GO
CREATE OR ALTER TRIGGER tr_beszuras
ON AlkalmazottMunkakorok
INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO AlkalmazottMunkakorok
	([AMID], [AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
		SELECT *
		FROM inserted
		WHERE DATEDIFF(D, KezdetiDatum, GETDATE()) < 0
END
GO

INSERT INTO AlkalmazottMunkakorok
    ([AlkalmazottID], [MunkakorID], [KezdetiDatum], [VegsoDatum], [Fizetes], [MenedzserID], [IrodaID], [ReszlegID])
VALUES
    (N'E10033', 10, CAST(N'2026-03-07' AS Date), CAST(N'2100-07-08' AS Date), 111681, N'E77884', 2, 4)
	SELECT * FROM AlkalmazottMunkakorok WHERE AlkalmazottID = 'E10033'
--9.
GO
CREATE OR ALTER PROCEDURE sp_alkalmazottInfok(@pEmail VARCHAR(50), @pOUT INT OUT)
AS
BEGIN
	IF @pEmail NOT IN (SELECT Email FROM Alkalmazottak)
	BEGIN
		SET @pOUT = -1
		RAISERROR('Nincs ilyen alkalmazott', 11, 1)
		RETURN -1
	END

	IF EXISTS(SELECT 1
			FROM AlkalmazottMunkakorok AS AM
				JOIN Alkalmazottak AS A ON AM.AlkalmazottID = A.AlkalmazottID
				JOIN Munkakorok AS M ON M.MunkakorID = AM.MunkakorID
			WHERE A.Email = @pEmail
				AND DATEDIFF(Y, AM.KezdetiDatum, GETDATE()) < 20
				AND AM.Fizetes < (SELECT Fizetes FROM AlkalmazottMunkakorok
									WHERE AlkalmazottID = AM.MenedzserID))
	BEGIN
		RAISERROR('Menedzser fizetese kisebb', 11, 2)
		RETURN -1
	END

	SELECT M.Nev, AM.Fizetes, AM.MenedzserID
	FROM AlkalmazottMunkakorok AS AM
		JOIN Alkalmazottak AS A ON AM.AlkalmazottID = A.AlkalmazottID
		JOIN Munkakorok AS M ON M.MunkakorID = AM.MunkakorID
	WHERE A.Email = @pEmail
		AND DATEDIFF(YEAR, AM.KezdetiDatum, GETDATE()) < 20
END
GO

DECLARE @pOUT INT
EXEC sp_alkalmazottInfok 'Jermaine.Massey@TechCorp.com', @pOUT
GO

DECLARE @pOUT INT
EXEC sp_alkalmazottInfok 'teszt', @pOUT OUTPUT
SELECT @pOUT
