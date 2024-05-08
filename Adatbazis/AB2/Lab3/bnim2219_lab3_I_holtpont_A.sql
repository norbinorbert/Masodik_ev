USE DeliveryCompanies
GO

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION
UPDATE Foods SET FoodPrice = 1000 WHERE FoodID = 1
--B tranzakcio indul
UPDATE Restaurants SET ClosingHour = 10 WHERE RestaurantID = 1
--deadlock

ROLLBACK