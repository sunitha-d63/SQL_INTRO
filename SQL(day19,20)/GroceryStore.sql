CREATE DATABASE GroceryInventory;
USE GroceryInventory;

## 13. Inventory Management for a Grocery Store
-- Tables: Products, Suppliers, Stock.
-- Insert products with stock levels and suppliers.
-- Query low-stock products (below threshold).
-- List suppliers providing more than 5 products.

CREATE TABLE Products (
  ProductID INT PRIMARY KEY AUTO_INCREMENT,
  ProductName VARCHAR(255) NOT NULL,
  Description TEXT,
  Category VARCHAR(100),
  UnitPrice DECIMAL(10,2) NOT NULL,
  CurrentStock INT NOT NULL DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE Suppliers (
  SupplierID INT PRIMARY KEY AUTO_INCREMENT,
  SupplierName VARCHAR(255) NOT NULL,
  ContactPerson VARCHAR(100),
  Phone VARCHAR(20),
  Email VARCHAR(100)
);

CREATE TABLE Stock (
  StockID INT PRIMARY KEY AUTO_INCREMENT,
  ProductID INT NOT NULL,
  SupplierID INT NOT NULL,
  StockDate DATE NOT NULL,
  Quantity INT NOT NULL,
  UnitCost DECIMAL(10,2),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO Suppliers (SupplierName, ContactPerson, Phone, Email)
VALUES
  ('FreshFarms Co.', 'Raj Singh', '1234567890', 'raj@freshfarms.com'),
  ('Organic Goods Ltd.', 'Meena Patel', '0987654321', 'meena@organic.com');

INSERT INTO Products (ProductName, Description, Category, UnitPrice, CurrentStock)
VALUES
  ('Apple', 'Fresh Red Apple', 'Fruit', 30.00, 50),
  ('Milk 1L', 'Dairy milk full cream', 'Dairy', 45.00, 20),
  ('Rice 5kg', 'Basmati rice', 'Grains', 250.00, 8);

INSERT INTO Stock (ProductID, SupplierID, StockDate, Quantity, UnitCost)
VALUES
  (1, 1, CURDATE() - INTERVAL 15 DAY, 30, 25.00),
  (2, 2, CURDATE() - INTERVAL 40 DAY, 20, 40.00),
  (3, 1, CURDATE() - INTERVAL 5 DAY, 10, 220.00);
  
  SELECT ProductID, ProductName, CurrentStock
FROM Products
WHERE CurrentStock < 10;

SELECT s.SupplierID, s.SupplierName, COUNT(DISTINCT st.ProductID) AS ProductsSupplied
FROM Suppliers s
JOIN Stock st ON s.SupplierID = st.SupplierID
GROUP BY s.SupplierID, s.SupplierName
HAVING COUNT(DISTINCT st.ProductID) > 5;



