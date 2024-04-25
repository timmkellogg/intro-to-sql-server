--1. Add a new supplier.
INSERT INTO Suppliers(CompanyName, ContactName, ContactTitle, Address, Phone)
VALUES('Some Cool Company', 'Tim', 'Awesome guy', '12345', '210-555-5555')
 
--2. Add a new product provided by that supplier.
INSERT INTO Products(ProductName, SupplierID, UnitPrice, UnitsInStock)
VALUES('Some Cool Burgers', (SELECT MAX(SupplierID) FROM Suppliers), 20, 999)

--3. List all products and their suppliers.
SELECT Products.ProductName, Suppliers.CompanyName
FROM Products
JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID

--4. Raise the price of your new product by 15%.
UPDATE Products
SET UnitPrice = UnitPrice * 1.15, QuantityPerUnit = '6 patties'
Where ProductName = 'Some Cool Burgers'

--5. List the products and prices of all products from that supplier.
SELECT ProductName, UnitPrice
FROM Products
WHERE SupplierID = (SELECT MAX(SupplierID) FROM Suppliers)

--6. Delete the new product.
DELETE FROM Products
WHERE ProductID = (SELECT MAX(ProductID) FROM Products)

--7. Delete the new supplier.
DELETE FROM Suppliers
WHERE SupplierID = (SELECT MAX(SupplierID) FROM Suppliers)

--8. List all products.
SELECT * FROM Products

--9. List all suppliers.
SELECT * FROM Suppliers
