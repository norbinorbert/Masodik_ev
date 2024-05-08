USE DeliveryCompanies
GO

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION
UPDATE Restaurants SET ClosingHour = 12 WHERE RestaurantID = 1
UPDATE Foods SET FoodPrice = 1001 WHERE FoodID = 1
--deadlock

ROLLBACK

-- megoldas: rendszer rollbackeli az egyik tranzakciot