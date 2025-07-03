CREATE database OnlineStoreProduct;
USE OnlineStoreProduct;

## 4. Online Store Product Catalog
-- Tables: Products, Categories, Suppliers.
-- Insert products with prices and categories.
-- Query products by category, price range, or supplier.
-- Find the top 5 most expensive products.

CREATE TABLE Categories (
  CategoryID INT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL
);

CREATE TABLE Suppliers (
  SupplierID INT PRIMARY KEY,
  Name VARCHAR(100),
  ContactEmail VARCHAR(100)
);

CREATE TABLE Products (
  ProductID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Price DECIMAL(10, 2),
  CategoryID INT,
  SupplierID INT,
  FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
  FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

INSERT INTO Categories (CategoryID, Name) VALUES
(1, 'Electronics'),
(2, 'Books'),
(3, 'Home Appliances');

INSERT INTO Suppliers (SupplierID, Name, ContactEmail) VALUES
(1, 'TechWorld', 'support@techworld.com'),
(2, 'BookMania', 'info@bookmania.com'),
(3, 'HomeNeeds', 'contact@homeneeds.com');

INSERT INTO Products (Name, Price, CategoryID, SupplierID) VALUES
('Smartphone', 699.99, 1, 1),
('Laptop', 999.99, 1, 1),
('Fiction Novel', 15.99, 2, 2),
('Non-fiction Book', 22.50, 2, 2),
('Microwave Oven', 199.00, 3, 3),
('Air Purifier', 150.00, 3, 3),
('Tablet', 399.99, 1, 1),
('E-reader', 89.99, 1, 2),
('Blender', 70.00, 3, 3),
('Cookbook', 18.00, 2, 2);

SELECT p.Name, p.Price, c.Name AS Category
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.Name = 'Electronics';

SELECT Name, Price
FROM Products
WHERE Price BETWEEN 100 AND 500;

SELECT p.Name, s.Name AS Supplier
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.Name = 'BookMania';

SELECT Name, Price
FROM Products
ORDER BY Price DESC
LIMIT 5;

SELECT p.Name AS Product, p.Price, c.Name AS Category, s.Name AS Supplier
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN Suppliers s ON p.SupplierID = s.SupplierID;










