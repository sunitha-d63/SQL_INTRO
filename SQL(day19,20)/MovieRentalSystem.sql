CREATE database MovieRentalSystem;
USE MovieRentalSystem;

## 6. Movie Rental System
-- Tables: Movies, Customers, Rentals.
-- Insert sample movies and rental records.
-- Query overdue rentals and customers who rented specific genres.
-- List top 3 most rented movies.

CREATE TABLE Movies (
  MovieID INT PRIMARY KEY AUTO_INCREMENT,
  Title VARCHAR(100),
  Genre VARCHAR(50),
  ReleaseYear INT
);

CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Email VARCHAR(100)
);

CREATE TABLE Rentals (
  RentalID INT PRIMARY KEY AUTO_INCREMENT,
  MovieID INT,
  CustomerID INT,
  RentalDate DATE,
  ReturnDate DATE,
  DueDate DATE,
  FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Movies (Title, Genre, ReleaseYear) VALUES
('Inception', 'Sci-Fi', 2010),
('The Godfather', 'Crime', 1972),
('Titanic', 'Romance', 1997),
('Avengers: Endgame', 'Action', 2019),
('Finding Nemo', 'Animation', 2003);

INSERT INTO Customers (Name, Email) VALUES
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com'),
('Charlie Brown', 'charlie@example.com');

INSERT INTO Rentals (MovieID, CustomerID, RentalDate, DueDate, ReturnDate) VALUES
(1, 1, '2025-06-20', '2025-06-25', NULL), -- Overdue
(2, 2, '2025-06-15', '2025-06-20', '2025-06-19'),
(3, 1, '2025-06-18', '2025-06-23', '2025-06-23'),
(1, 3, '2025-06-10', '2025-06-15', '2025-06-17'), -- Returned late
(4, 2, '2025-06-25', '2025-06-30', NULL); -- Active rental

SELECT r.RentalID, m.Title, c.Name AS Customer, r.RentalDate, r.DueDate
FROM Rentals r
JOIN Movies m ON r.MovieID = m.MovieID
JOIN Customers c ON r.CustomerID = c.CustomerID
WHERE r.ReturnDate IS NULL AND r.DueDate < CURDATE();

SELECT DISTINCT c.Name, c.Email
FROM Rentals r
JOIN Movies m ON r.MovieID = m.MovieID
JOIN Customers c ON r.CustomerID = c.CustomerID
WHERE m.Genre = 'Action';

SELECT m.Title, COUNT(*) AS RentalCount
FROM Rentals r
JOIN Movies m ON r.MovieID = m.MovieID
GROUP BY m.MovieID
ORDER BY RentalCount DESC
LIMIT 3;








