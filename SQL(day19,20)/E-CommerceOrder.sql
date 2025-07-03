CREATE DATABASE ECommerceDB;
USE ECommerceDB;

CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY AUTO_INCREMENT,
  FirstName VARCHAR(100) NOT NULL,
  LastName VARCHAR(100) NOT NULL,
  Email VARCHAR(255) UNIQUE NOT NULL,
  Phone VARCHAR(15),
  Address VARCHAR(255)
);

CREATE TABLE Products (
  ProductID INT PRIMARY KEY AUTO_INCREMENT,
  ProductName VARCHAR(150) NOT NULL,
  Description TEXT,
  Price DECIMAL(10,2) NOT NULL,
  StockQty INT NOT NULL DEFAULT 0
);

CREATE TABLE Orders (
  OrderID INT PRIMARY KEY AUTO_INCREMENT,
  CustomerID INT NOT NULL,
  OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  Status ENUM('Pending','Shipped','Completed','Cancelled') NOT NULL DEFAULT 'Pending',
  TotalAmount DECIMAL(12,2) AS (
    (SELECT IFNULL(SUM(oi.Quantity * oi.UnitPrice),0)
     FROM OrderItems oi WHERE oi.OrderID = Orders.OrderID)
  ) STORED,
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE OrderItems (
  OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
  OrderID INT NOT NULL,
  ProductID INT NOT NULL,
  Quantity INT NOT NULL,
  UnitPrice DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES ('Alice', 'Johnson', 'alice.j@example.com', '555-1234', '123 Maple St'),
       ('Bob', 'Williams', 'bob.w@example.com', NULL, '456 Oak Ave');

INSERT INTO Products (ProductName, Description, Price, StockQty)
VALUES ('T-shirt', '100% Cotton', 20.00, 150),
       ('Jeans', 'Denim blue', 40.00, 80),
       ('Sneakers', 'Unisex, size 8–12', 60.00, 60);

INSERT INTO Orders (CustomerID, Status)
VALUES (1, 'Pending'), (1, 'Completed'), (2, 'Pending');

INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice)
VALUES
  (1, 1, 2, 20.00),
  (1, 3, 1, 60.00),
  (2, 2, 1, 40.00),
  (2, 3, 2, 60.00),
  (3, 1, 5, 20.00);

SELECT o.OrderID, CONCAT(c.FirstName, ' ', c.LastName) AS Customer, o.OrderDate, o.Status,
       oi.ProductID, p.ProductName, oi.Quantity, oi.UnitPrice
FROM Orders o
JOIN Customers c USING (CustomerID)
JOIN OrderItems oi USING (OrderID)
JOIN Products p USING (ProductID)
WHERE o.Status = 'Pending';

SELECT o.OrderID, o.OrderDate, o.Status, o.TotalAmount
FROM Orders o
WHERE o.CustomerID = 1
ORDER BY o.OrderDate DESC;

SELECT p.ProductID, p.ProductName, SUM(oi.Quantity) AS TotalSold
FROM OrderItems oi
JOIN Products p USING (ProductID)
GROUP BY p.ProductID, p.ProductName
HAVING SUM(oi.Quantity) > 10;

SHOW TABLES;
