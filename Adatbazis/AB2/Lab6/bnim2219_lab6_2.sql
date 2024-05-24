USE DeliveryCompanies
GO

/*
Írjunk lekérdezést, mely “=” jellel (exact match) keres rá egy stringre! Majd próbáljuk ki, 
hogy összehasonlításnál egyenlőségjel helyett LIKE-ot  használunk és csak a string egy részére keressünk rá 
(pl. ha az egyenlőségnél azt írtuk, hogy Nev = ‘xyz’, akkor próbáljuk úgy, hogy Nev LIKE ‘xy’). 
Nézzük meg van-e különbség? A lekérdezésben kössünk össze legalább 2 táblát! 

SET SHOWPLAN_TEXT ON
SET SHOWPLAN_TEXT OFF

SET STATISTICS TIME ON
SET STATISTICS TIME OFF
*/

SELECT *
FROM Foods F JOIN Restaurants R ON F.RestaurantID = R.RestaurantID
WHERE F.FoodName = 'Cheeseburger'

SELECT *
FROM Foods F JOIN Restaurants R ON F.RestaurantID = R.RestaurantID
WHERE F.FoodName LIKE 'Cheeseburg'

/* elso
|--Nested Loops(Inner Join, OUTER REFERENCES:([F].[RestaurantID]))
    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[PK_Foods_FoodID] AS [F]), WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodName] as [F].[FoodName]='Cheeseburger'))
    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), SEEK:([R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]) ORDERED FORWARD)
	
   CPU time = 31 ms,  elapsed time = 31 ms.
*/

/* masodik
|--Nested Loops(Inner Join, OUTER REFERENCES:([F].[RestaurantID]))
    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[PK_Foods_FoodID] AS [F]), WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodName] as [F].[FoodName] like 'Cheeseburg'))
    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), SEEK:([R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]) ORDERED FORWARD)

   CPU time = 47 ms,  elapsed time = 44 ms.
*/

--make unclustered index for FK
CREATE INDEX uncl_foods_FK ON Foods (RestaurantID)
GO

/* elso
|--Nested Loops(Inner Join, OUTER REFERENCES:([F].[RestaurantID]))
    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[PK_Foods_FoodID] AS [F]), WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodName] as [F].[FoodName]='Cheeseburger'))
    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), SEEK:([R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]) ORDERED FORWARD)
	
   CPU time = 31 ms,  elapsed time = 31 ms.
*/

/* masodik
|--Nested Loops(Inner Join, OUTER REFERENCES:([F].[RestaurantID]))
    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[PK_Foods_FoodID] AS [F]), WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodName] as [F].[FoodName] like 'Cheeseburg'))
    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), SEEK:([R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]) ORDERED FORWARD)
	
   CPU time = 47 ms,  elapsed time = 42 ms.
*/

--make clustered index for FK
DROP INDEX uncl_foods_FK ON Foods
GO

GO
ALTER TABLE OrderContains
DROP CONSTRAINT FK_OrderContains_FoodID, FK_OrderContains_OrderID
GO

ALTER TABLE Foods
DROP CONSTRAINT PK_Foods_FoodID
GO

CREATE CLUSTERED INDEX cli_foods_restaurantID ON Foods (RestaurantID)
GO

ALTER TABLE Foods
ADD CONSTRAINT PK_Foods_FoodID PRIMARY KEY (FoodID)
GO

ALTER TABLE OrderContains
ADD CONSTRAINT FK_OrderContains_FoodID FOREIGN KEY (FoodID) REFERENCES Foods(FoodID)
GO

ALTER TABLE OrderContains
ADD CONSTRAINT FK_OrderContains_OrderID FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
GO

/* elso
|--Nested Loops(Inner Join, OUTER REFERENCES:([F].[RestaurantID]))
    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[cli_foods_restaurantID] AS [F]), WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodName] as [F].[FoodName]='Cheeseburger'))
    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), SEEK:([R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]) ORDERED FORWARD)
	
   CPU time = 31 ms,  elapsed time = 32 ms.
*/

/* masodik
|--Nested Loops(Inner Join, OUTER REFERENCES:([F].[RestaurantID]))
    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[cli_foods_restaurantID] AS [F]), WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodName] as [F].[FoodName] like 'Cheeseburg'))
    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), SEEK:([R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]) ORDERED FORWARD)
	
   CPU time = 47 ms,  elapsed time = 45 ms.
*/

CREATE INDEX uncli_foods_foodName ON Foods (FoodName)
GO

/* elso
|--Nested Loops(Inner Join, OUTER REFERENCES:([F].[RestaurantID]))
    |--Nested Loops(Inner Join, OUTER REFERENCES:([Uniq1001], [F].[RestaurantID]))
    |    |--Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncli_foods_foodName] AS [F]), SEEK:([F].[FoodName]='Cheeseburger') ORDERED FORWARD)
    |    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[cli_foods_restaurantID] AS [F]), SEEK:([F].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID] AND [Uniq1001]=[Uniq1001]) LOOKUP ORDERED FORWARD)
    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), SEEK:([R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]) ORDERED FORWARD)
	
   CPU time = 16 ms,  elapsed time = 34 ms.
*/

/* masodik
|--Nested Loops(Inner Join, OUTER REFERENCES:([F].[RestaurantID]))
    |--Nested Loops(Inner Join, OUTER REFERENCES:([Uniq1001], [F].[RestaurantID]))
    |    |--Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncli_foods_foodName] AS [F]), SEEK:([F].[FoodName] >= 'Cheeseburg' AND [F].[FoodName] <= 'Cheeseburg'),  WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodName] as [F].[FoodName] like 'Cheeseburg') ORDERED FORWARD)
    |    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[cli_foods_restaurantID] AS [F]), SEEK:([F].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID] AND [Uniq1001]=[Uniq1001]) LOOKUP ORDERED FORWARD)
    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), SEEK:([R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]) ORDERED FORWARD)
	
   CPU time = 15 ms,  elapsed time = 18 ms.
*/