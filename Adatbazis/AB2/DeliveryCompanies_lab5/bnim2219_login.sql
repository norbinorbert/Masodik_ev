USE DeliveryCompanies
GO

-- make admin login and user with permissions
CREATE LOGIN administrator 
	WITH PASSWORD = 'administrator';
GO

CREATE USER administrator FOR LOGIN administrator;
GO

GRANT DELETE, EXECUTE, INSERT, SELECT, UPDATE ON DATABASE :: DeliveryCompanies TO administrator;
GO

-- make guest login and user with permissions
CREATE LOGIN guest
	WITH PASSWORD = 'guest';
GO

CREATE USER guest FOR LOGIN guest;
GO

GRANT SELECT ON Foods TO guest;
GRANT SELECT ON Restaurants TO guest;
GRANT SELECT ON DeliveryCompanies TO guest;
GO

CREATE OR ALTER PROCEDURE sp_new_user(@pUserName VARCHAR(100), @pPassword VARCHAR(100))
AS BEGIN
SET NOCOUNT ON
--BEGIN TRANSACTION kellene
	IF EXISTS (SELECT name FROM sys.database_principals WHERE name = @pUserName)
	BEGIN
		RAISERROR('User already exists', 11, 1)
		RETURN -1
	END

	DECLARE @return INT
	EXEC @return = sp_addlogin @pUserName, @pPassword, DeliveryCompanies
	IF @return != 0
	BEGIN
		RAISERROR('Could not create login', 11, 2)
		RETURN -2
	END

	EXEC @return = sp_adduser @pUserName, @pUserName
	IF @return != 0
	BEGIN
		RAISERROR('Could not create user', 11, 3)
		EXEC sp_droplogin @pUserName
		RETURN -3
	END
	
	DECLARE @SQL NVARCHAR(MAX);
	SET @SQL = 'GRANT SELECT ON Foods TO ' + @pUserName;
	EXEC sp_executesql @SQL;
	SET @SQL = 'GRANT SELECT ON Restaurants TO ' + @pUserName;
	EXEC sp_executesql @SQL;
	SET @SQL = 'GRANT SELECT ON DeliveryCompanies TO ' + @pUserName;
	EXEC sp_executesql @SQL;
	SET @SQL = 'GRANT SELECT ON Orders TO ' + @pUserName;
	EXEC sp_executesql @SQL;
	SET @SQL = 'GRANT SELECT ON OrderContains TO ' + @pUserName;
	EXEC sp_executesql @SQL;
	SET @SQL = 'GRANT EXECUTE ON sp_rendeles TO ' + @pUserName;
	EXEC sp_executesql @SQL;

	RETURN 0
END
GO