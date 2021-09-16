/*
1.What is a result set?
Result set is a set of data, could be empty or not, returned by a select statement, or a stored procedure, that is saved in RAM or displayed on the screen. And A TSQL script can have 0 to multiple result sets.

2.What is the difference between Union and Union All? 
Union and Union all are used to combine multiple result sets selected by ‘SELECT’ by rows. Union all keeps all of data but union remove duplicated rows.
Union will sort the data based on the first column
3.What are the other Set Operators SQL Server has?
INTERSECT and EXCEPT
4.What is the difference between Union and Join?
Union is used to combine multiple result sets selected by ‘SELECT’ by rows. 
But join is used to combine associated result set on matched condition.

5.What is the difference between INNER JOIN and FULL JOIN?
Inner join only return the rows which match the join condition from two tables.
FULL join keep all rows from two tables that exist in the right table and the left table.


6.What is difference between left join and outer join
Left join will keep all the rows which appear in left tables included the part with right table which match join condition.
But Outer join will remove the intersected part of two tables and keep the rest part of two tables.

7.What is cross join?
The CROSS JOIN is used to generate a paired combination of each row of the first table with each row of the second 	table. 
8.What is the difference between WHERE clause and HAVING clause?
1,We cant use WHERE clause with aggregate functions but we can use HAVING clause with aggregate functions. 
2 they are used in different positions. WHERE is used before GROUP BY but HAVING is used after GROUP BY.
3, HAVING can only be used with SELECT, but WHERE can be used with SELECT, INSERT, UPDATED

9.Can there be multiple group by columns?
Yes, we can put multiple columns before group by 
*/

/*1*/
SELECT count(ProductID)
FROM Production.Product
/*2*/
SELECT count(ProductSubcategoryID)
FROM Production.Product
/*3*/
SELECT ProductSubcategoryID,count(ProductID) CountedProducts
FROM Production.Product
GROUP BY ProductSubcategoryID
HAVING ProductSubcategoryID IS NOT NULL
/*4*/
SELECT ProductSubcategoryID,count(ProductID) CountedProducts
FROM Production.Product
GROUP BY ProductSubcategoryID
HAVING ProductSubcategoryID IS NULL
/*5*/
SELECT ProductID,SUM(Quantity) TheSum
FROM Production.ProductInventory
GROUP BY ProductID
/*6*/
SELECT ProductID,SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID
HAVING SUM(Quantity) < 100
/*7*/
SELECT Shelf,ProductID,SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY Shelf,ProductID
HAVING SUM(Quantity) < 100
/*8*/
SELECT ProductID,AVG(quantity) AS TheAvg
FROM Production.ProductInventory
WHERE LocationID = 10
GROUP BY ProductID
/*9*/
SELECT ProductID,shelf,AVG(quantity) AS TheAvg
FROM Production.ProductInventory
GROUP BY Shelf,ProductID
/*10*/
SELECT ProductID,shelf,AVG(quantity) AS TheAvg
FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP BY Shelf,ProductID
/*11*/
SELECT Color, Class, count(ProductID) as TheCount, AVG(ListPrice) AS AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL AND Class is not null
GROUP BY Color, Class
/*12*/
SELECT c.Name Country, s.Name Province
FROM person.CountryRegion c inner join person.StateProvince s
ON c.CountryRegionCode = s.CountryRegionCode
/*13*/
SELECT c.Name Country, s.Name Province
FROM person.CountryRegion c inner join person.StateProvince s
ON c.CountryRegionCode = s.CountryRegionCode
WHERE c.Name = 'Germany' or c.Name = 'Canada'
/*14*/ 
select d.ProductID
from dbo.Orders o inner join [Northwind].[dbo].[Order Details] d
on o.OrderID = d.OrderID
where o.OrderDate is not null and o.OrderDate > '1996-09-19 00:00:00.000'
/*15*/
select TOP 5 o.ShipPostalCode as postcode, count(o.OrderID) AS countProduct
from [Northwind].[dbo].[Orders] o
where o.ShipPostalCode is not null
group by o.ShipPostalCode
ORDER BY countProduct DESC
/*16*/
select TOP 5 o.ShipPostalCode as postcode, count(o.OrderID) AS countProduct
from [Northwind].[dbo].[Orders] o
where o.OrderDate is not null and o.OrderDate > '2001-09-19 00:00:00.000' and o.ShipPostalCode is not null
group by o.ShipPostalCode
ORDER BY countProduct DESC
/*17*/
select c.City, count(c.CustomerID) AS countCustomer
FROM [Northwind].[dbo].[Customers] c
GROUP BY c.City
/*18*/
select c.City, count(c.CustomerID) AS countCustomer
FROM [Northwind].[dbo].[Customers] c
GROUP BY c.City
HAVING count(c.CustomerID) >= 10
/*19*/
select DISTINCT c.ContactName
from [Northwind].[dbo].[Orders] o inner join [Northwind].[dbo].[Customers] c
on o.CustomerID = c.CustomerID
where o.OrderDate is not null and o.OrderDate > '1998-01-01 00:00:00.000'
/*20*/
select c.ContactName cname, MAX(o.OrderDate) recentdata
from [Northwind].[dbo].[Orders] o inner join [Northwind].[dbo].[Customers] c
on o.CustomerID = c.CustomerID
where o.OrderDate is not null
group by c.ContactName
/*21*/
select c.ContactName cname, COUNT(d.Quantity) as countProduct
from ([Northwind].[dbo].[Orders] o 
inner join [Northwind].[dbo].[Order Details] d 
on o.OrderID = d.OrderID)
inner join [Northwind].[dbo].[Customers] c
on o.CustomerID = c.CustomerID
group by c.ContactName
/*22*/
select c.CustomerID, COUNT(d.Quantity) as countProduct
from ([Northwind].[dbo].[Orders] o 
inner join [Northwind].[dbo].[Order Details] d 
on o.OrderID = d.OrderID)
inner join [Northwind].[dbo].[Customers] c
on o.CustomerID = c.CustomerID
group by C.CustomerID
HAVING COUNT(d.Quantity) >= 100
/*23*/
select distinct su.CompanyName as 'Supplier Company Name',sh.CompanyName as 'Shipping Company Name'
From ((([dbo].Suppliers su join [dbo].Products p
on su.SupplierID = p.SupplierID
) inner join dbo.[Order Details] d
on d.ProductID = p.ProductID) 
inner join dbo.Orders o
on o.OrderID = d.OrderID) inner join dbo.Shippers sh
on sh.ShipperID = o.ShipVia
/*24*/
select distinct p.ProductName,o.OrderDate
from (dbo.Orders o inner join dbo.[Order Details] d
on o.OrderID = d.OrderID) inner join dbo.Products p
on p.ProductID = d.ProductID
/*25*/
select distinct CONCAT(e1.FirstName,e1.LastName) as name1, CONCAT(e2.FirstName, e2.LastName) as name2
from dbo.Employees e1 full join dbo.Employees e2
on e1.Title = e2.Title
where CONCAT(e1.FirstName,e1.LastName) != CONCAT(e2.FirstName, e2.LastName) 
/*26*/
select e2.EmployeeID, COUNT(e1.EmployeeID) 
from dbo.Employees e1 inner join dbo.Employees e2
on e1.ReportsTo = e2.EmployeeID
group by e2.EmployeeID
having COUNT(e1.EmployeeID) >= 2
/*27*/
(select City,ContactName, ContactTitle
From Customers c)
UNION
(SELECT City,CompanyName,ContactTitle
from Suppliers)