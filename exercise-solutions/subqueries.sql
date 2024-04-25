-- Day 1 Review!




--Retrieve the EmployeeID, LastName, and FirstName from the Employees table, where employee lives in the US
SELECT EmployeeID, LastName, FirstName, City, Country
FROM Employees
WHERE Country = 'USA'


--Find the oldest order date from the Orders table.
SELECT MIN(OrderDate) AS EarliestOrderDate
FROM Orders


--Retrieve the average order amount for each customer. Include the CustomerID and the average order amount, grouped by CustomerID.
SELECT CustomerID, AVG(Freight) AS AvgOrderAmount
FROM Orders





-- Nested Queries

--1. What is the product name(s) of the most expensive products? HINT: Find the
--max price in a subquery and then use that value to find products whose price
--equals that value.
SELECT ProductName, UnitPrice FROM Products 
WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM Products)


--2. What is the order id, shipping name and shipping address of all orders shipped via
--‘Federal Shipping’? HINT: Find the shipper id of ‘Federal Shipping’ in a subquery
--and then use that value to find the orders that used that shipper.
SELECT OrderID, ShipName, ShipAddress, ShipVia
FROM Orders
WHERE ShipVia = (
	SELECT ShipperID
	FROM Shippers
	WHERE CompanyName = 'United Package'
)

--3. What are the order ids of the orders that ordered ‘Sasquatch Ale’? HINT: Find
--the product id of ‘Sasquatch Ale’ in a subquery and then use that value to find the
--matching orders from the `order details` table. Because the `order details` table
--has a space in its name, you will need to surround it with back ticks in the FROM
--clause.
SELECT OrderID
FROM [Order Details]
WHERE ProductID = (
	SELECT ProductID
	FROM Products
	WHERE ProductName = 'Sasquatch Ale'
)


--4. What is the name of the employee that sold order 10266?
SELECT CONCAT(FirstName, ' ', LastName) AS EmployeeName
FROM Employees
WHERE EmployeeID = (
	SELECT EmployeeID
	FROM Orders
	Where OrderID = 10266
)


--5. What is the name of the customer that bought order 10266?
SELECT CompanyName, ContactName
FROM Customers
WHERE CustomerID = (
	SELECT CustomerID
	FROM Orders
	WHERE OrderID = 10266
)



