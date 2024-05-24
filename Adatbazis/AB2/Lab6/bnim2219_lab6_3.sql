USE DeliveryCompanies
GO

/*
Írjunk lekérdezést, mely egy tábla szám típusú mezője alapján rákeres két szám közötti értékre. 
Próbáljuk az intervallum-keresést végrehajtani a BETWEEN kulcsszó segítségével is, 
vagy kisebb és nagyobb jelek segítségével AND-el összekötve! 
Van-e különbség az AND és a BETWEEN használata között? A lekérdezésben kössünk össze legalább 2 táblát! 

SET SHOWPLAN_TEXT ON
SET SHOWPLAN_TEXT OFF

SET STATISTICS TIME ON
SET STATISTICS TIME OFF
*/

SELECT F.FoodPrice
FROM Foods F JOIN Restaurants R ON F.RestaurantID = R.RestaurantID
WHERE F.FoodPrice BETWEEN 5 AND 10
	AND F.RestaurantID < 10000

SELECT F.FoodPrice
FROM Foods F JOIN Restaurants R ON F.RestaurantID = R.RestaurantID
WHERE F.FoodPrice > 5 AND F.FoodPrice < 10
	AND F.RestaurantID < 10000

/* elso
|--Parallelism(Gather Streams)
    |--Hash Match(Inner Join, HASH:([F].[RestaurantID])=([R].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
        |--Bitmap(HASH:([F].[RestaurantID]), DEFINE:([Bitmap1002]))
        |    |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([F].[RestaurantID]))
        |         |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[PK_Foods_FoodID] AS [F]), WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodPrice] as [F].[FoodPrice]>=(5.0000000000000000e+000) AND [DeliveryCompanies].[dbo].[Foods].[FoodPrice] as [F].[FoodPrice]<=(1.0000000000000000e+001)))
        |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([R].[RestaurantID]))
                |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), WHERE:(PROBE([Bitmap1002],[DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID],N'[IN ROW]')))

   CPU time = 125 ms,  elapsed time = 102 ms.
*/

/* masodik
|--Parallelism(Gather Streams)
    |--Hash Match(Inner Join, HASH:([F].[RestaurantID])=([R].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
        |--Bitmap(HASH:([F].[RestaurantID]), DEFINE:([Bitmap1002]))
        |    |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([F].[RestaurantID]))
        |         |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[PK_Foods_FoodID] AS [F]), WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodPrice] as [F].[FoodPrice]>(5.0000000000000000e+000) AND [DeliveryCompanies].[dbo].[Foods].[FoodPrice] as [F].[FoodPrice]<(1.0000000000000000e+001)))
        |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([R].[RestaurantID]))
                |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), WHERE:(PROBE([Bitmap1002],[DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID],N'[IN ROW]')))

   CPU time = 125 ms,  elapsed time = 105 ms.
*/

--make unclustered index for FK
CREATE INDEX uncl_foods_FK ON Foods (RestaurantID)
GO

/* elso
|--Parallelism(Gather Streams)
    |--Hash Match(Inner Join, HASH:([F].[RestaurantID])=([R].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
        |--Bitmap(HASH:([F].[RestaurantID]), DEFINE:([Bitmap1002]))
        |    |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([F].[RestaurantID]))
        |         |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[PK_Foods_FoodID] AS [F]), WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodPrice] as [F].[FoodPrice]>=(5.0000000000000000e+000) AND [DeliveryCompanies].[dbo].[Foods].[FoodPrice] as [F].[FoodPrice]<=(1.0000000000000000e+001)))
        |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([R].[RestaurantID]))
                |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), WHERE:(PROBE([Bitmap1002],[DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID],N'[IN ROW]')))
				
   CPU time = 125 ms,  elapsed time = 125 ms.
*/

/* masodik
|--Parallelism(Gather Streams)
    |--Hash Match(Inner Join, HASH:([F].[RestaurantID])=([R].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
        |--Bitmap(HASH:([F].[RestaurantID]), DEFINE:([Bitmap1002]))
        |    |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([F].[RestaurantID]))
        |         |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[PK_Foods_FoodID] AS [F]), WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodPrice] as [F].[FoodPrice]>(5.0000000000000000e+000) AND [DeliveryCompanies].[dbo].[Foods].[FoodPrice] as [F].[FoodPrice]<(1.0000000000000000e+001)))
        |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([R].[RestaurantID]))
                |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), WHERE:(PROBE([Bitmap1002],[DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID],N'[IN ROW]')))
				
   CPU time = 141 ms,  elapsed time = 123 ms.
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
|--Parallelism(Gather Streams)
    |--Hash Match(Inner Join, HASH:([F].[RestaurantID])=([R].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
        |--Bitmap(HASH:([F].[RestaurantID]), DEFINE:([Bitmap1003]))
        |    |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([F].[RestaurantID]))
        |         |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[cli_foods_restaurantID] AS [F]), WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodPrice] as [F].[FoodPrice]>=(5.0000000000000000e+000) AND [DeliveryCompanies].[dbo].[Foods].[FoodPrice] as [F].[FoodPrice]<=(1.0000000000000000e+001)))
        |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([R].[RestaurantID]))
                |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), WHERE:(PROBE([Bitmap1003],[DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID],N'[IN ROW]')))
				
   CPU time = 31 ms,  elapsed time = 179 ms.
*/

/* masodik
|--Parallelism(Gather Streams)
    |--Hash Match(Inner Join, HASH:([F].[RestaurantID])=([R].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
        |--Bitmap(HASH:([F].[RestaurantID]), DEFINE:([Bitmap1003]))
        |    |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([F].[RestaurantID]))
        |         |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[cli_foods_restaurantID] AS [F]), WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodPrice] as [F].[FoodPrice]>(5.0000000000000000e+000) AND [DeliveryCompanies].[dbo].[Foods].[FoodPrice] as [F].[FoodPrice]<(1.0000000000000000e+001)))
        |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([R].[RestaurantID]))
                |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), WHERE:(PROBE([Bitmap1003],[DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID],N'[IN ROW]')))
				
   CPU time = 62 ms,  elapsed time = 125 ms.
*/

CREATE INDEX uncli_foods_foodPrice ON Foods (FoodPrice)
GO

/* elso
|--Hash Match(Inner Join, HASH:([F].[RestaurantID])=([R].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
    |--Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncli_foods_foodPrice] AS [F]), SEEK:([F].[FoodPrice] >= (5.0000000000000000e+000) AND [F].[FoodPrice] <= (1.0000000000000000e+001)) ORDERED FORWARD)
    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]))
	
   CPU time = 32 ms,  elapsed time = 119 ms.
*/

/* masodik
|--Hash Match(Inner Join, HASH:([F].[RestaurantID])=([R].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
    |--Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncli_foods_foodPrice] AS [F]), SEEK:([F].[FoodPrice] > (5.0000000000000000e+000) AND [F].[FoodPrice] < (1.0000000000000000e+001)) ORDERED FORWARD)
    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]))
	
   CPU time = 63 ms,  elapsed time = 114 ms.
*/

CREATE INDEX uncli_foods_composite_price_restID ON Foods (FoodPrice, RestaurantID)
GO

/* elso
|--Hash Match(Inner Join, HASH:([F].[RestaurantID])=([R].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
    |--Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncli_foods_composite_price_restID] AS [F]), SEEK:([F].[FoodPrice] >= (5.0000000000000000e+000) AND ([F].[FoodPrice], [F].[RestaurantID]) < ((1.0000000000000000e+001), (10000))),  WHERE:([DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]<(10000)) ORDERED FORWARD)
    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), SEEK:([R].[RestaurantID] < (10000)) ORDERED FORWARD)
	
   CPU time = 0 ms,  elapsed time = 32 ms.
*/


/* masodik
|--Hash Match(Inner Join, HASH:([F].[RestaurantID])=([R].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
    |--Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncli_foods_composite_price_restID] AS [F]), SEEK:([F].[FoodPrice] > (5.0000000000000000e+000) AND [F].[FoodPrice] < (1.0000000000000000e+001)),  WHERE:([DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]<(10000)) ORDERED FORWARD)
    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), SEEK:([R].[RestaurantID] < (10000)) ORDERED FORWARD)
	
   CPU time = 0 ms,  elapsed time = 33 ms.
*/