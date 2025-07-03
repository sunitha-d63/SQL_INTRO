CREATE DATABASE BookstoreDB;
USE BookstoreDB;

CREATE TABLE IF NOT EXISTS Books (
  BookID INT PRIMARY KEY AUTO_INCREMENT,
  Title VARCHAR(255) NOT NULL,
  Author VARCHAR(255),
  Genre VARCHAR(100),
  Price DECIMAL(10,2) NOT NULL,
  StockQty INT NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS Customers (
  CustomerID INT PRIMARY KEY AUTO_INCREMENT,
  FirstName VARCHAR(100) NOT NULL,
  LastName VARCHAR(100) NOT NULL,
  Email VARCHAR(255) UNIQUE,
  Phone VARCHAR(20)
);

CREATE TABLE Sales (
  SaleID INT PRIMARY KEY AUTO_INCREMENT,
  CustomerID INT NOT NULL,
  BookID INT NOT NULL,
  SaleDate DATE NOT NULL,
  Quantity INT NOT NULL,
  TotalPrice DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (BookID) REFERENCES Books(BookID)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO Books (Title, Author, Genre, Price, StockQty)
VALUES
  ('Clean Code', 'Robert C. Martin', 'Software', 40.00, 100),
  ('The Pragmatic Programmer', 'Andrew Hunt', 'Software', 45.00, 75),
  ('Harry Potter', 'J.K. Rowling', 'Fantasy', 30.00, 200);

INSERT INTO Customers (FirstName, LastName, Email, Phone)
VALUES
  ('Alice', 'Smith', 'alice@example.com', '1234567890'),
  ('Bob', 'Johnson', 'bob@example.com', '0987654321');

INSERT INTO Sales (CustomerID, BookID, SaleDate, Quantity, TotalPrice)
VALUES (
  1,
  1,
  CURDATE(),
  2,
  2 * (SELECT Price FROM Books WHERE BookID = 1)
);

SELECT b.BookID, b.Title, SUM(s.Quantity) AS TotalSold
FROM Sales s
JOIN Books b USING (BookID)
GROUP BY b.BookID, b.Title
ORDER BY TotalSold DESC;

SELECT c.CustomerID, CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
       SUM(s.Quantity) AS TotalBooks
FROM Sales s
JOIN Customers c USING (CustomerID)
GROUP BY c.CustomerID, CustomerName
HAVING SUM(s.Quantity) > 3;





