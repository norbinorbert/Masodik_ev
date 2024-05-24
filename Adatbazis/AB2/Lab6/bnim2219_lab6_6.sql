USE DeliveryCompanies
GO

/*
Az 1-5. feladatok közül válasszunk ki egyet, mely esetében vizsgáljuk meg, 
hogy változik-e a végrehajtási terv és a futási idő, ha csak azokat az attribútumokat íratjuk ki, 
amelyekre van valamilyen index létrehozva, vagy épp ha több attribútumot is kiíratunk. 
Lesz-e változás, ha covering indexe(ke)t hozunk létre? 

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

CREATE INDEX uncli_foods_foodName ON Foods (FoodName)
GO

/* elso, csak FoodName
|--Nested Loops(Inner Join, OUTER REFERENCES:([F].[RestaurantID]))
    |--Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncli_foods_foodName] AS [F]), SEEK:([F].[FoodName]='Cheeseburger') ORDERED FORWARD)
    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), SEEK:([R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]) ORDERED FORWARD)
	
   CPU time = 0 ms,  elapsed time = 0 ms.
*/

/* elso, minden
|--Nested Loops(Inner Join, OUTER REFERENCES:([F].[RestaurantID]))
    |--Nested Loops(Inner Join, OUTER REFERENCES:([Uniq1001], [F].[RestaurantID]))
    |    |--Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncli_foods_foodName] AS [F]), SEEK:([F].[FoodName]='Cheeseburger') ORDERED FORWARD)
    |    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[cli_foods_restaurantID] AS [F]), SEEK:([F].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID] AND [Uniq1001]=[Uniq1001]) LOOKUP ORDERED FORWARD)
    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), SEEK:([R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]) ORDERED FORWARD)
	
   CPU time = 0 ms,  elapsed time = 0 ms.
*/

/* masodik, csak FoodName
|--Nested Loops(Inner Join, OUTER REFERENCES:([F].[RestaurantID]))
    |--Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncli_foods_foodName] AS [F]), SEEK:([F].[FoodName] >= 'Cheeseburg' AND [F].[FoodName] <= 'Cheeseburg'),  WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodName] as [F].[FoodName] like 'Cheeseburg') ORDERED FORWARD)
    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), SEEK:([R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]) ORDERED FORWARD)
	
   CPU time = 0 ms,  elapsed time = 0 ms.
*/

/* masodik, minden
|--Nested Loops(Inner Join, OUTER REFERENCES:([F].[RestaurantID]))
    |--Nested Loops(Inner Join, OUTER REFERENCES:([Uniq1001], [F].[RestaurantID]))
    |    |--Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncli_foods_foodName] AS [F]), SEEK:([F].[FoodName] >= 'Cheeseburg' AND [F].[FoodName] <= 'Cheeseburg'),  WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodName] as [F].[FoodName] like 'Cheeseburg') ORDERED FORWARD)
    |    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[cli_foods_restaurantID] AS [F]), SEEK:([F].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID] AND [Uniq1001]=[Uniq1001]) LOOKUP ORDERED FORWARD)
    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), SEEK:([R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]) ORDERED FORWARD)
	
   CPU time = 0 ms,  elapsed time = 0 ms.
*/

CREATE INDEX uncl_foods_everything ON Foods (FoodName) INCLUDE (FoodID, FoodDescription, FoodPrice, RestaurantID, VerRow)
GO

/* elso, csak FoodName
|--Nested Loops(Inner Join, OUTER REFERENCES:([F].[RestaurantID]))
    |--Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncl_foods_everything] AS [F]), SEEK:([F].[FoodName]='Cheeseburger') ORDERED FORWARD)
    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), SEEK:([R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]) ORDERED FORWARD)
	
   CPU time = 0 ms,  elapsed time = 1 ms.
*/

/* elso, minden
|--Nested Loops(Inner Join, OUTER REFERENCES:([F].[RestaurantID]))
    |--Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncl_foods_everything] AS [F]), SEEK:([F].[FoodName]='Cheeseburger') ORDERED FORWARD)
    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), SEEK:([R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]) ORDERED FORWARD)
	
   CPU time = 0 ms,  elapsed time = 0 ms.
*/

/* masodik, csak FoodName
|--Nested Loops(Inner Join, OUTER REFERENCES:([F].[RestaurantID]))
    |--Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncl_foods_everything] AS [F]), SEEK:([F].[FoodName] >= 'Cheeseburg' AND [F].[FoodName] <= 'Cheeseburg'),  WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodName] as [F].[FoodName] like 'Cheeseburg') ORDERED FORWARD)
    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), SEEK:([R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]) ORDERED FORWARD)
	
   CPU time = 0 ms,  elapsed time = 0 ms.
*/

/* masodik, minden
|--Nested Loops(Inner Join, OUTER REFERENCES:([F].[RestaurantID]))
    |--Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncl_foods_everything] AS [F]), SEEK:([F].[FoodName] >= 'Cheeseburg' AND [F].[FoodName] <= 'Cheeseburg'),  WHERE:([DeliveryCompanies].[dbo].[Foods].[FoodName] as [F].[FoodName] like 'Cheeseburg') ORDERED FORWARD)
    |--Clustered Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), SEEK:([R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]) ORDERED FORWARD)
	
   CPU time = 0 ms,  elapsed time = 0 ms.
*/

--------------------------------------------------------------------------------------------

/*
Az 1-5. feladatok közül válasszunk ki egyet, mely esetén bővítsük a lekérdezést legalább 1 feltétellel,
mely intervallum-keresés (range selection) legyen vagy konkrét egyezést (exact match) vizsgáljon. 
Hozzunk létre további indexeket (simple, composite, akár covering) és vizsgáljuk, hogyan változik a végrehajtási terv és a futási idő. 

SET SHOWPLAN_TEXT ON
SET SHOWPLAN_TEXT OFF

SET STATISTICS TIME ON
SET STATISTICS TIME OFF
*/
SELECT F.FoodName
FROM Foods F JOIN Restaurants R ON F.RestaurantID = R.RestaurantID
WHERE R.OpeningHour BETWEEN 16 AND 20
ORDER BY F.FoodName

SELECT *
FROM Foods F JOIN Restaurants R ON F.RestaurantID = R.RestaurantID
WHERE R.OpeningHour BETWEEN 16 AND 20
ORDER BY F.FoodName

/* elso
|--Parallelism(Gather Streams, ORDER BY:([F].[FoodName] ASC))
    |--Sort(ORDER BY:([F].[FoodName] ASC))
        |--Hash Match(Inner Join, HASH:([R].[RestaurantID])=([F].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
                |--Bitmap(HASH:([R].[RestaurantID]), DEFINE:([Bitmap1003]))
                |    |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([R].[RestaurantID]))
                |         |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), WHERE:([DeliveryCompanies].[dbo].[Restaurants].[OpeningHour] as [R].[OpeningHour]>=(16) AND [DeliveryCompanies].[dbo].[Restaurants].[OpeningHour] as [R].[OpeningHour]<=(20)))
                |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([F].[RestaurantID]))
                    |--Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncli_foods_foodName] AS [F]),  WHERE:(PROBE([Bitmap1003],[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID],N'[IN ROW]')))
					
   CPU time = 187 ms,  elapsed time = 409 ms.
*/

/* masodik
|--Parallelism(Gather Streams, ORDER BY:([F].[FoodName] ASC))
    |--Sort(ORDER BY:([F].[FoodName] ASC))
        |--Hash Match(Inner Join, HASH:([R].[RestaurantID])=([F].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
                |--Bitmap(HASH:([R].[RestaurantID]), DEFINE:([Bitmap1003]))
                |    |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([R].[RestaurantID]))
                |         |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), WHERE:([DeliveryCompanies].[dbo].[Restaurants].[OpeningHour] as [R].[OpeningHour]>=(16) AND [DeliveryCompanies].[dbo].[Restaurants].[OpeningHour] as [R].[OpeningHour]<=(20)))
                |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([F].[RestaurantID]))
                    |--Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncl_foods_everything] AS [F]),  WHERE:(PROBE([Bitmap1003],[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID],N'[IN ROW]')))
					
   CPU time = 310 ms,  elapsed time = 779 ms.
*/

CREATE INDEX uncl_restaurants_open ON Restaurants (OpeningHour)
GO

/* elso
|--Parallelism(Gather Streams, ORDER BY:([F].[FoodName] ASC))
    |--Sort(ORDER BY:([F].[FoodName] ASC))
        |--Hash Match(Inner Join, HASH:([R].[RestaurantID])=([F].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
                |--Bitmap(HASH:([R].[RestaurantID]), DEFINE:([Bitmap1003]))
                |    |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([R].[RestaurantID]))
                |         |--Index Seek(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[uncl_restaurants_open] AS [R]), SEEK:([R].[OpeningHour] >= (16) AND [R].[OpeningHour] <= (20)) ORDERED FORWARD)
                |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([F].[RestaurantID]))
                    |--Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncli_foods_foodName] AS [F]),  WHERE:(PROBE([Bitmap1003],[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID],N'[IN ROW]')))
					
   CPU time = 202 ms,  elapsed time = 383 ms.
*/

/* masodik
|--Parallelism(Gather Streams, ORDER BY:([F].[FoodName] ASC))
    |--Sort(ORDER BY:([F].[FoodName] ASC))
        |--Hash Match(Inner Join, HASH:([R].[RestaurantID])=([F].[RestaurantID]), RESIDUAL:([DeliveryCompanies].[dbo].[Restaurants].[RestaurantID] as [R].[RestaurantID]=[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID]))
                |--Bitmap(HASH:([R].[RestaurantID]), DEFINE:([Bitmap1003]))
                |    |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([R].[RestaurantID]))
                |         |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Restaurants].[PK_Restaurants_RestaurantID] AS [R]), WHERE:([DeliveryCompanies].[dbo].[Restaurants].[OpeningHour] as [R].[OpeningHour]>=(16) AND [DeliveryCompanies].[dbo].[Restaurants].[OpeningHour] as [R].[OpeningHour]<=(20)))
                |--Parallelism(Repartition Streams, Hash Partitioning, PARTITION COLUMNS:([F].[RestaurantID]))
                    |--Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[uncl_foods_everything] AS [F]),  WHERE:(PROBE([Bitmap1003],[DeliveryCompanies].[dbo].[Foods].[RestaurantID] as [F].[RestaurantID],N'[IN ROW]')))
					
   CPU time = 282 ms,  elapsed time = 766 ms.
*/