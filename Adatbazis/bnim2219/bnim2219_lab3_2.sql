USE AdventureWorks2022

/*Kérdezzük le a Production.ProductCategory tábla tartalmát, rendezzük a név (Name oszlop) szerint ABC sorrendbe! 
Kiírandó attribútumok: Name, ModifiedDate*/
SELECT Name, ModifiedDate
FROM Production.ProductCategory
ORDER BY Name

/*Jelenítsük meg a Production.ProductDescription táblából azokat a leírásokat, 
melyekben a leírás (Description attribútum) legalább 10 karaktert tartalmaz és nincsen benne ‘-’ karakter!
Kiírandó attribútumok: Description, ModifiedDate*/
SELECT Description, ModifiedDate
FROM Production.ProductDescription
WHERE LEN(Description) >= 10
	AND Description NOT LIKE '%-%'

/*Jelenítsük meg azon különleges ajánlatok termékeit (Production.Product táblából), melyek 2012 és 2014 között szerepeltek különleges 
ajánlatokban (Sales.SpecialOffer tábla StartDate és EndDate oszlopai alapján ellenőrizzük a dátum; 
szükségünk lesz a Sales.SpecialOfferProduct táblára is ezek kikereséséhez)!
Kiírandó attribútumok: Production.Product.Name, Sales.SpecialOffer.StartDate, Sales.SpecialOffer.EndDate, Sales.SpecialOffer.Description*/
SELECT P.Name, SO.StartDate, SO.EndDate, SO.Description
FROM Production.Product AS P
	JOIN Sales.SpecialOfferProduct AS SOP ON P.ProductID = SOP.ProductID
	JOIN Sales.SpecialOffer AS SO ON SOP.SpecialOfferID = SO.SpecialOfferID
WHERE SO.StartDate >= '2012' AND SO.EndDate < '2014'

/*Adjuk meg összesen hány termék van raktáron (a Production.ProductInventory tábla Quantity mezője alapján)!
Kiírandó attribútumok: TotalProductQuantity*/
SELECT SUM(Quantity) AS TotalProductQuantity
FROM Production.ProductInventory

/*Adjuk meg a ‘212’ körzetszámú (Person.PersonPhone tábla PhoneNumber oszlopa) és mobil 
(a Person.PhoneNumberType Name attribútuma ‘Cell’ értéket vegyen fel) telefonszámmal  rendelkező személyeket (Person.Person tábla) 
a kereszt- és vezetéknevük (FirstName és LastName attribútumok) alapján csökkenő sorrendbe rendezve! 
Megj.  A személyek ID-ját a BusinessEntityID mezőben tárolja az adatbázis.
Kiírandó attribútumok: Person.Person.Title, Person.Person.FirstName, Person.Person.LastName, Person.PersonPhone.PhoneNumber*/
SELECT P.Title, P.FirstName, P.LastName, PP.PhoneNumber
FROM Person.PersonPhone AS PP
	JOIN Person.PhoneNumberType AS PNT ON PP.PhoneNumberTypeID = PNT.PhoneNumberTypeID
	JOIN Person.Person AS P ON P.BusinessEntityID = PP.BusinessEntityID
WHERE PNT.Name = 'Cell'
	AND PP.PhoneNumber LIKE '212%'
ORDER BY P.FirstName DESC, P.LastName DESC

/*Adjuk meg azon termékeket, melyeket az alábbi beszállítók egyike legalább beszállít: (‘International Trek Center’, ‘Trikes, Inc.’, ‘Compete Enterprises, Inc’)
Kiírandó attribútumok: Production.Product.Name, Production.Product.ProductNumber, Purchasing.Vendor.Name, Purchasing.Vendor.AccountNumber*/
SELECT P.Name, P.ProductNumber, V.Name, V.AccountNumber
FROM Production.Product AS P
	JOIN Purchasing.ProductVendor AS PV ON P.ProductID = PV.ProductID
	JOIN Purchasing.Vendor AS V ON V.BusinessEntityID = PV.BusinessEntityID
WHERE V.Name = 'International Trek Center'
	OR V.Name = 'Trikes, Inc.'
	OR V.Name = 'Compete Enterprises, Inc'

