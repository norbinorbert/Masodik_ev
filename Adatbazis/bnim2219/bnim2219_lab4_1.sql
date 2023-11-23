USE AdventureWorks2022
GO

/*1. Adjuk meg azon termékeket, melyeknél nem adtuk meg, kiknek való (Production.Product tábla Style mezője “üres”), 
és amelyekből a legtöbb van raktáron (Production.ProductInventory tábla Quantity mezője alapján)! 
Kiírandó attribútumok: Production.Product.Name, Production.Product.ProductNumber, 
  Production.Product.Class, Production.Product.Weight, Production.ProductInventory.Quantity*/
SELECT P.Name, P.ProductNumber, P.Class, P.Weight, PIV.Quantity
FROM Production.Product AS P
	JOIN Production.ProductInventory AS PIV ON P.ProductID = PIV.ProductID
WHERE P.Style IS NULL 
	AND PIV.Quantity = (SELECT MAX(PIV.Quantity) 
							FROM Production.Product AS P 
								JOIN Production.ProductInventory AS PIV ON P.ProductID = PIV.ProductID)

/*2. Adjuk meg, hogy az egyes alkategóriákba tartozó termékeket hány különböző helyen gyártják/raktározzák 
(Production.ProductInventory táblával dolgozzunk-LocationID alapján kapjuk meg a helyeket)! 
Csak azokat a termékeket vegyük figyelembe, melyek biztonsági készletszintje (lsd. Production.Product.SafetyStockLevel mező) kisebb, 
mint az átlagos készletszint (az összes terméket figyelembe véve) és csak azokat az alkategóriákat jelenítsük meg, 
melyek adatait 2008-ban módosították (Production.ProductSubcategory.ModifiedDate mező alapján) és 
amelyek termékei megtalálhatóak készleten (gyártanak/raktároznak) min 3 különböző helyen, helyek száma szerint csökkenő sorrendben!
Kiírandó attribútumok: Production.ProductSubcategory.ProductSubcategoryID, Production.ProductSubcategory.Name, HelyekSzama*/
SELECT PS.ProductSubcategoryID, PS.Name, COUNT(PIV.LocationID) AS HelyekSzama
FROM Production.ProductSubcategory AS PS
	JOIN Production.Product AS P ON P.ProductSubcategoryID = PS.ProductSubcategoryID
	JOIN Production.ProductInventory AS PIV ON P.ProductID = PIV.ProductID
WHERE P.SafetyStockLevel < (SELECT AVG(P.SafetyStockLevel) FROM Production.Product AS P)
	AND YEAR(PS.ModifiedDate) = 2008
GROUP BY PS.ProductSubcategoryID, PS.Name
HAVING COUNT(PIV.LocationID) >= 3
ORDER BY HelyekSzama DESC

/*3. Minden vásárló esetén adjuk meg a rendeléseinek számát és a legutolsó rendelésének dátumát, 
rendelések száma szerint csökkenő sorrendben! 
A lekérdezéshez szükség van a Person.Person, Sales.Customer és a Sales.SalesOrderHeader táblákra is!
Megj. (A feladatot enélkül is elfogadjuk, csak kevesebb pontra.) Oldjuk meg azt is, hogy azokat a személyeket is írassuk ki, 
akik nem vásároltak egyszer sem (lehet, hogy nem is vásárlók-csak a Person táblában találhatóak meg az adataik).
Kiírandó attribútumok: Person.Person.FirstName, Person.Person.LastName, UtolsoRendelesDatuma, RendelesekSzama*/
SELECT P.FirstName, P.LastName, MAX(SOH.OrderDate) AS UtolsoRendelesDatuma, COUNT(C.CustomerID) AS RendelesekSzama
FROM Person.Person AS P
	LEFT JOIN Sales.Customer AS C ON P.BusinessEntityID = C.PersonID
	LEFT JOIN Sales.SalesOrderHeader AS SOH ON C.CustomerID = SOH.CustomerID
GROUP BY P.BusinessEntityID, P.FirstName, P.LastName
ORDER BY RendelesekSzama DESC

/*4. Adjuk meg azon bankkártyákat (lsd. Sales.CreditCard tábla), amelyek típusa ’SuperiorCard’ (Sales.CreditCard.CardType mező alapján) 
és amelyeket nem használtak egyetlen rendelésnél sem (lsd. Sales.SalesOrderHeader tábla)! 
A lekérdezést adjuk meg kétféleképpen: i) halmazművelettel, majd ii) anélkül!
Kiírandó attribútumok: Sales.CreditCard.CreditCardID, Sales.CreditCard.CardNumber*/
SELECT CC.CreditCardID, CC.CardNumber
FROM Sales.CreditCard AS CC
WHERE CC.CardType = 'SuperiorCard'
INTERSECT
SELECT CC.CreditCardID, CC.CardNumber
FROM Sales.CreditCard AS CC
	LEFT JOIN Sales.SalesOrderHeader AS SOH ON SOH.CreditCardID = CC.CreditCardID
WHERE SOH.CreditCardID IS NULL

SELECT CC.CreditCardID, CC.CardNumber
FROM Sales.CreditCard AS CC
	LEFT JOIN Sales.SalesOrderHeader AS SOH ON SOH.CreditCardID = CC.CreditCardID
WHERE CC.CardType = 'SuperiorCard'
	AND SOH.CreditCardID IS NULL

/*5. Adjuk meg azon termékek számát, melyeket 15%-nál kisebb profittal árusítanak 
((Product.ListPrice-Product.StandardCost)*100/Product.ListPrice < 15%) és amelyeket csak az 
‘International Trek Center’ nevű beszállító szállít be!
Kiírandó attribútumok: TermekekSzama*/
SELECT COUNT(*) AS TermekekSzama
FROM Production.Product AS P
WHERE P.ProductID IN (SELECT DISTINCT P.ProductID
						FROM Production.Product AS P
							JOIN Purchasing.ProductVendor AS PV ON P.ProductID = PV.ProductID
							JOIN Purchasing.Vendor AS V ON PV.BusinessEntityID = V.BusinessEntityID
						WHERE P.ListPrice != 0 
							AND (P.ListPrice-P.StandardCost)*100/P.ListPrice < 15
							AND V.Name = 'International Trek Center'
					EXCEPT
					SELECT DISTINCT P.ProductID
					FROM Production.Product AS P
						JOIN Purchasing.ProductVendor AS PV ON P.ProductID = PV.ProductID
						JOIN Purchasing.Vendor AS V ON PV.BusinessEntityID = V.BusinessEntityID
					WHERE V.Name != 'International Trek Center')

/*6. Adjuk meg azon termékeket, amelyek standard költsége (Production.Product.StandardCost attribútum alapján) nagyobb, mint 40, 
és legalább 2 különleges ajánlatban szerepeltek (Sales.SpecialOfferProduct attribútum alapján)! 
A termékek csak egyszer jelenjenek meg a felsorolásban!
Kiírandó attribútumok: Production.Product.Name, Production.Product.StandardCost*/
SELECT DISTINCT P.Name, P.StandardCost
FROM Production.Product AS P
	JOIN Sales.SpecialOfferProduct AS SOP ON SOP.ProductID = P.ProductID
WHERE P.StandardCost > 40
GROUP BY P.ProductID, P.Name, P.StandardCost
HAVING COUNT(SOP.SpecialOfferID) >= 2

/*7. Módosítsuk a termékek listaárát (Production.Product tábla ListPrice oszlop) 100-ra, és állítsuk be a módosítási dátumot 
(ModifiedDate) a mai dátumra, azon termékek esetén, melyeknek a leírásában (Production.ProductDescription tábla Description oszlop) 
szerepel a ‘custom’ szó!
Megj. A feladatot oldjuk meg kétféleképpen: i) alkérdéssel; ii) join-ok használatával!*/
UPDATE Production.Product 
SET ListPrice = 100, ModifiedDate = GETDATE()
FROM Production.Product AS P
	JOIN Production.ProductModel AS PM ON PM.ProductModelID = P.ProductModelID
	JOIN Production.ProductModelProductDescriptionCulture AS PMPDC ON PMPDC.ProductModelID = PM.ProductModelID
WHERE PMPDC.ProductDescriptionID IN (SELECT ProductDescriptionID
									FROM Production.ProductDescription AS PDesc
									WHERE PDesc.Description LIKE '%custom%')

UPDATE Production.Product 
SET ListPrice = 100, ModifiedDate = GETDATE()
FROM Production.Product AS P
	JOIN Production.ProductModel AS PM ON PM.ProductModelID = P.ProductModelID
	JOIN Production.ProductModelProductDescriptionCulture AS PMPDC ON PMPDC.ProductModelID = PM.ProductModelID
	JOIN Production.ProductDescription AS PD ON PMPDC.ProductDescriptionID = PD.ProductDescriptionID
WHERE PD.Description LIKE '%custom%'

/*8. Töröljük a ‘Production’ részleghez (HumanResources.Department tábla Name oszlop) tartozó alkalmazott “történelmét” 
(HumanResources.EmployeeDepartmentHistory táblából)!
Megj. A feladatot oldjuk meg kétféleképpen: i) alkérdéssel; ii) join-ok használatával!*/
DELETE FROM HumanResources.EmployeeDepartmentHistory
WHERE DepartmentID IN (SELECT D.DepartmentID
						FROM HumanResources.Department AS D
						WHERE D.Name = 'Production')

DELETE EDH
FROM HumanResources.EmployeeDepartmentHistory AS EDH
	JOIN HumanResources.Department AS D ON D.DepartmentID = EDH.DepartmentID
WHERE D.Name = 'Production'

--INSERT INTO HumanResources.EmployeeDepartmentHistory (BusinessEntityID, DepartmentID, ShiftID, StartDate) VALUES (1, 7, 1, GETDATE())