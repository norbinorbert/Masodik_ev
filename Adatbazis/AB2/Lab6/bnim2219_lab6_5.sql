USE DeliveryCompanies
GO

/*
Írjunk egy olyan lekérdezést, mely tartalmaz alkérdést, és van benne egy legalább egy feltétel 
(pl x nagyobb mint y)! Oldjuk meg sima join-ok segítségével, valamint alkérdés segítségével is. 
Nézzük meg, hogy megjelenik-e az Anti-Join vagy Semi-Join a végrehajtási tervben!

SET SHOWPLAN_TEXT ON
SET SHOWPLAN_TEXT OFF

SET STATISTICS TIME ON
SET STATISTICS TIME OFF
*/

SELECT F.FoodID
FROM Foods F
WHERE F.FoodID IN (SELECT FoodID FROM OrderContains WHERE Amount > 5)
	AND F.FoodPrice > 10

SELECT F.FoodID
FROM Foods F JOIN OrderContains OC ON OC.FoodID = F.FoodID
WHERE OC.Amount > 5
	AND F.FoodPrice > 10

/* elso
|--Parallelism(Gather Streams)
    |--Hash Match(Right Semi Join, HASH:([DeliveryCompanies].[dbo].[OrderContains].[FoodID])=([F].[FoodID]))
        |--Bitmap(HASH:([DeliveryCompanies].[dbo].[OrderContains].[FoodID]), DEFINE:([Bitmap1003]))
        |    |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([DeliveryCompanies].[dbo].[OrderContains].[FoodID]))
        |         |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[OrderContains].[PK_OrderContains_OrderID_FoodID]), WHERE:([DeliveryCompanies].[dbo].[OrderContains].[Amount]>(5)))
        |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([F].[FoodID]))
                |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[PK_Foods_FoodID] AS [F]), WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodPrice] as [F].[FoodPrice]>(1.0000000000000000e+001) AND PROBE([Bitmap1003],[DeliveryCompanies].[dbo].[Foods].[FoodID] as [F].[FoodID],N'[IN ROW]')))
				
   CPU time = 46 ms,  elapsed time = 217 ms.
*/

/* masodik
|--Parallelism(Gather Streams)
    |--Hash Match(Inner Join, HASH:([OC].[FoodID])=([F].[FoodID]))
        |--Bitmap(HASH:([OC].[FoodID]), DEFINE:([Bitmap1002]))
        |    |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([OC].[FoodID]))
        |         |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[OrderContains].[PK_OrderContains_OrderID_FoodID] AS [OC]), WHERE:([DeliveryCompanies].[dbo].[OrderContains].[Amount] as [OC].[Amount]>(5)))
        |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([F].[FoodID]))
                |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[PK_Foods_FoodID] AS [F]), WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodPrice] as [F].[FoodPrice]>(1.0000000000000000e+001) AND PROBE([Bitmap1002],[DeliveryCompanies].[dbo].[Foods].[FoodID] as [F].[FoodID],N'[IN ROW]')))
				
   CPU time = 171 ms,  elapsed time = 228 ms.
*/

--make clustered index for FK
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
    |--Hash Match(Right Semi Join, HASH:([DeliveryCompanies].[dbo].[OrderContains].[FoodID])=([F].[FoodID]))
        |--Bitmap(HASH:([DeliveryCompanies].[dbo].[OrderContains].[FoodID]), DEFINE:([Bitmap1004]))
        |    |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([DeliveryCompanies].[dbo].[OrderContains].[FoodID]))
        |         |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[OrderContains].[PK_OrderContains_OrderID_FoodID]), WHERE:([DeliveryCompanies].[dbo].[OrderContains].[Amount]>(5)))
        |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([F].[FoodID]))
                |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[cli_foods_restaurantID] AS [F]), WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodPrice] as [F].[FoodPrice]>(1.0000000000000000e+001) AND PROBE([Bitmap1004],[DeliveryCompanies].[dbo].[Foods].[FoodID] as [F].[FoodID],N'[IN ROW]')))
				
   CPU time = 329 ms,  elapsed time = 229 ms.
*/

/* masodik
|--Parallelism(Gather Streams)
    |--Hash Match(Inner Join, HASH:([OC].[FoodID])=([F].[FoodID]))
        |--Bitmap(HASH:([OC].[FoodID]), DEFINE:([Bitmap1003]))
        |    |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([OC].[FoodID]))
        |         |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[OrderContains].[PK_OrderContains_OrderID_FoodID] AS [OC]), WHERE:([DeliveryCompanies].[dbo].[OrderContains].[Amount] as [OC].[Amount]>(5)))
        |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([F].[FoodID]))
                |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[cli_foods_restaurantID] AS [F]), WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodPrice] as [F].[FoodPrice]>(1.0000000000000000e+001) AND PROBE([Bitmap1003],[DeliveryCompanies].[dbo].[Foods].[FoodID] as [F].[FoodID],N'[IN ROW]')))
				
   CPU time = 187 ms,  elapsed time = 214 ms.
*/

CREATE INDEX uncli_foods_foodPrice_incl_foodID ON Foods (FoodPrice) INCLUDE (FoodID)
GO

/* elso
|--Hash Match(Right Semi Join, HASH:([DeliveryCompanies].[dbo].[OrderContains].[FoodID])=([F].[FoodID]))
    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[OrderContains].[PK_OrderContains_OrderID_FoodID]), WHERE:([DeliveryCompanies].[dbo].[OrderContains].[Amount]>(5)))
    |--Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncli_foods_foodPrice_incl_foodID] AS [F]), SEEK:([F].[FoodPrice] > (1.0000000000000000e+001)) ORDERED FORWARD)

   CPU time = 109 ms,  elapsed time = 246 ms.
*/

/* masodik
|--Hash Match(Inner Join, HASH:([OC].[FoodID])=([F].[FoodID]))
    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[OrderContains].[PK_OrderContains_OrderID_FoodID] AS [OC]), WHERE:([DeliveryCompanies].[dbo].[OrderContains].[Amount] as [OC].[Amount]>(5)))
    |--Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncli_foods_foodPrice_incl_foodID] AS [F]), SEEK:([F].[FoodPrice] > (1.0000000000000000e+001)) ORDERED FORWARD)

   CPU time = 109 ms,  elapsed time = 244 ms.
*/