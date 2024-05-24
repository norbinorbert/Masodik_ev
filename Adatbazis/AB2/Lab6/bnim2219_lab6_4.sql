USE DeliveryCompanies
GO

/*
Írjunk lekérdezést, mely visszaadja egy mező értékének maximumát vagy minimumát. 
Oldjuk meg összesítő függvény (MIN, MAX) használatával, illetve a TOP kulcsszó segítségével is 
(pl. SELECT MAX(A) … , illetve SELECT TOP 1 A … ORDER BY A DESC).

SET SHOWPLAN_TEXT ON
SET SHOWPLAN_TEXT OFF

SET STATISTICS TIME ON
SET STATISTICS TIME OFF
*/

SELECT MAX(FoodPrice)
FROM Foods

SELECT TOP 1 FoodPrice
FROM Foods
ORDER BY FoodPrice DESC

/* elso
|--Hash Match(Aggregate, HASH:() DEFINE:([Expr1002]=MAX([DeliveryCompanies].[dbo].[Foods].[FoodPrice])))
    |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[PK_Foods_FoodID]))
	
   CPU time = 32 ms,  elapsed time = 32 ms.
*/

/* masodik
|--Top(TOP EXPRESSION:((1)))
    |--Parallelism(Gather Streams, ORDER BY:([DeliveryCompanies].[dbo].[Foods].[FoodPrice] DESC))
        |--Sort(TOP 1, ORDER BY:([DeliveryCompanies].[dbo].[Foods].[FoodPrice] DESC))
                |--Clustered Index Scan(OBJECT:([DeliveryCompanies].[dbo].[Foods].[PK_Foods_FoodID]))
				
   CPU time = 125 ms,  elapsed time = 10 ms.
*/