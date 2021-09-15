/*1*/
SELECT ProductID, Name, Color, ListPrice 
From Production.Product
/*2*/
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE ListPrice = 0
/*3*/
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color is NULL
/*4*/
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color is not NULL
/*5*/
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color is not NULL AND ListPrice > 0
/*6*/
SELECT Name, Color
FROM Production.Product
WHERE Color is not NULL

/*7*/
SELECT CONCAT('NAME:',Name,'  --  COLOR:',color) AS 'Name And Color'
FROM Production.Product
WHERE Color in ('Black', 'Silver')

/*8*/
SELECT ProductID, Name
FROM Production.Product
WHERE ProductID < 500 and ProductID > 400
/*9*/
SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color IN ('black', 'blue')

/*10*/
SELECT  Name, Color, ListPrice
FROM Production.Product
WHERE Name LIKE 'S%'

/*11*/
SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice = 5399 OR ListPrice = 0 and Name like 'SEAT%' or Name like 'SHORT%[^X][LM]'
ORDER BY name ASC

/*12*/
SELECT Name, ListPrice
FROM Production.Product
ORDER BY Name ASC

/*13*/
SELECT Name
FROM Production.Product
WHERE Name LIKE '[SPO][^K]%'
ORDER BY Name ASC

/*14*/
SELECT DISTINCT Color
FROM Production.Product
WHERE Color is not NULL
ORDER BY Color DESC

/*15*/
SELECT DISTINCT ProductSubcategoryID, Color
FROM Production.Product
WHERE ProductSubcategoryID is not NULL and Color is not NULL

/*16*/
SELECT ProductSubCategoryID
      , LEFT([Name],35) AS [Name]
      , Color, ListPrice 
FROM Production.Product
WHERE (Color NOT IN ('Red','Black') or ProductSubCategoryID = 1)
      OR ListPrice BETWEEN 1000 AND 2000 
ORDER BY ProductID

/*17*/
SELECT ProductSubcategoryID, Name, Color, ListPrice
FROM Production.Product
WHERE ListPrice <= 1431.50 AND ListPrice >= 539.99 
ORDER BY ListPrice DESC
