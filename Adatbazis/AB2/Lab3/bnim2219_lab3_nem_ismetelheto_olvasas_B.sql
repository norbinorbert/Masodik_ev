USE DeliveryCompanies
GO

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION
-- modositunk egy sort, majd ezt olvassuk az A-nal
UPDATE Foods SET FoodPrice = 1000 WHERE FoodID = 1

ROLLBACK

