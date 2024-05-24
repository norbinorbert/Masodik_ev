USE DeliveryCompanies
GO

/*
Írjunk lekérdezést, mely string mező szerint ABC sorrendbe rendez! Először írassuk ki csak azt a mezőt, ami szerint rendeztünk, 
majd a tábla összes attribútumát! A lekérdezésben kössünk össze legalább 2 táblát! 

SET SHOWPLAN_TEXT ON
SET SHOWPLAN_TEXT OFF

SET STATISTICS TIME ON
SET STATISTICS TIME OFF
*/
SELECT F.FoodName
FROM Foods F JOIN Restaurants R ON F.RestaurantID = R.RestaurantID
ORDER BY F.FoodName

SELECT *
FROM Foods F JOIN Restaurants R ON F.RestaurantID = R.RestaurantID
ORDER BY F.FoodName

/* elso
|--Parallelism(Gather Streams, ORDER BY:([F].[FoodName] ASC))
    |--Sort(ORDER BY:([F].[FoodName] ASC))
        |--Hash Match(Inner Join, HASH:([R].[RestaurantID])=([F].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
                |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]))
                |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[PK_Foods_FoodID] AS [F]))

   CPU time = 626 ms,  elapsed time = 1734 ms.
*/

/* masodik
|--Parallelism(Gather Streams, ORDER BY:([F].[FoodName] ASC))
    |--Sort(ORDER BY:([F].[FoodName] ASC))
        |--Hash Match(Inner Join, HASH:([R].[RestaurantID])=([F].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
                |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]))
                |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[PK_Foods_FoodID] AS [F]))

   CPU time = 1296 ms,  elapsed time = 3268 ms.
*/

--make unclustered index for FK
CREATE INDEX uncl_foods_FK ON Foods (RestaurantID)
GO

/* elso
|--Parallelism(Gather Streams, ORDER BY:([F].[FoodName] ASC))
    |--Sort(ORDER BY:([F].[FoodName] ASC))
        |--Hash Match(Inner Join, HASH:([R].[RestaurantID])=([F].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
                |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([R].[RestaurantID]))
                |    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]))
                |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([F].[RestaurantID]))
                    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[PK_Foods_FoodID] AS [F]))
					
   CPU time = 857 ms,  elapsed time = 1770 ms.
*/

/* masodik
|--Parallelism(Gather Streams, ORDER BY:([F].[FoodName] ASC))
    |--Sort(ORDER BY:([F].[FoodName] ASC))
        |--Hash Match(Inner Join, HASH:([R].[RestaurantID])=([F].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
                |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([R].[RestaurantID]))
                |    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]))
                |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([F].[RestaurantID]))
                    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[PK_Foods_FoodID] AS [F]))
					
   CPU time = 1549 ms,  elapsed time = 3147 ms.
*/

--make clustered index for FK
DROP INDEX uncl_foods_FK ON Foods
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
|--Parallelism(Gather Streams, ORDER BY:([F].[FoodName] ASC))
    |--Sort(ORDER BY:([F].[FoodName] ASC))
        |--Hash Match(Inner Join, HASH:([R].[RestaurantID])=([F].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
                |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([R].[RestaurantID]))
                |    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]))
                |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([F].[RestaurantID]))
                    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[cli_foods_restaurantID] AS [F]))
					
   CPU time = 1236 ms,  elapsed time = 1712 ms.
*/

/* masodik
|--Parallelism(Gather Streams, ORDER BY:([F].[FoodName] ASC))
    |--Sort(ORDER BY:([F].[FoodName] ASC))
        |--Hash Match(Inner Join, HASH:([R].[RestaurantID])=([F].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
                |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([R].[RestaurantID]))
                |    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]))
                |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([F].[RestaurantID]))
                    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[cli_foods_restaurantID] AS [F]))
					
   CPU time = 2203 ms,  elapsed time = 3247 ms.
*/