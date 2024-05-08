USE DeliveryCompanies
GO

-- modositunk egy sort, majd ezt olvassuk a B-nel
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION
UPDATE Foods SET FoodPrice = 1000 WHERE FoodID = 1


-- "abortoljuk"
ROLLBACK