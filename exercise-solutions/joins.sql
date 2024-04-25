-- Joins!

--1. List the product id, product name, unit price and category name of all products.
--Order by category name and within that, by product name.
SELECT Products.ProductID, Products.ProductName, Products.UnitPrice, Categories.CategoryName
FROM Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID
ORDER BY Categories.CategoryName, Products.ProductName

--2. List the product id, product name, unit price and supplier name of all products
--that cost more than $75. Order by product name.
SELECT Products.ProductID, Products.ProductName, Products.UnitPrice, Suppliers.CompanyName
FROM Products
JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE Products.UnitPrice > 75
ORDER BY Products.ProductName

--3. List the product id, product name, unit price, category name, and supplier name
--of every product. Order by product name.
SELECT Products.ProductID, Products.ProductName, Products.UnitPrice, Categories.CategoryName, Suppliers.CompanyName
FROM Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID
JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
ORDER BY Products.ProductName


--4. What is the product name(s) and categories of the most expensive products?
--HINT: Find the max price in a subquery and then use that in your more complex
--query that joins products with categories.
SELECT Products.ProductName, Categories.CategoryName
FROM Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Products.UnitPrice = (
	SELECT MAX(UnitPrice) FROM Products
)



--5. List the order id, ship name, ship address, and shipping company name of every
--order that shipped to Germany.
SELECT Orders.OrderID, Orders.ShipName, Orders.ShipAddress, Shippers.CompanyName
FROM Orders
JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
WHERE Orders.ShipCountry = 'Germany'


--6. List the order id, order date, ship name, ship address of all orders that ordered
--‘Sasquatch Ale’?
SELECT Orders.OrderID, Orders.OrderDate, Orders.ShipName, Orders.ShipAddress, Products.ProductName
FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE Products.ProductName = 'Sasquatch Ale'