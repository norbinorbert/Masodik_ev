USE DeliveryCompanies
GO


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION
-- a modositott adatot fogjuk olvasni, de ezt kesobb visszaallitjuk, szoval az eredmeny "helytelen"
SELECT * FROM Foods WHERE FoodID = 1

ROLLBACK

-- megoldas: READ COMMITED ISOLATION LEVEL