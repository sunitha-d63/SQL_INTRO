CREATE database RestaurantReservationSystem;
USE RestaurantReservationSystem;

## 7. Restaurant Reservation System
-- Tables: Tables, Customers, Reservations.
-- Insert reservation entries for different dates and times.
-- Find available tables at a given time.
-- List customers with more than 2 reservations.

CREATE TABLE Tables (
  TableID INT PRIMARY KEY AUTO_INCREMENT,
  Capacity INT
);

CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Phone VARCHAR(15)
);

CREATE TABLE Reservations (
  ReservationID INT PRIMARY KEY AUTO_INCREMENT,
  TableID INT,
  CustomerID INT,
  ReservationDate DATE,
  ReservationTime TIME,
  FOREIGN KEY (TableID) REFERENCES Tables(TableID),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Tables (Capacity) VALUES
(2), (4), (4), (6), (8);

INSERT INTO Customers (Name, Phone) VALUES
('Alice', '9991112222'),
('Bob', '8883334444'),
('Charlie', '7775556666'),
('Diana', '9990001111');

INSERT INTO Reservations (TableID, CustomerID, ReservationDate, ReservationTime) VALUES
(1, 1, '2025-07-03', '19:00:00'),
(2, 2, '2025-07-03', '19:00:00'),
(3, 1, '2025-07-04', '20:00:00'),
(4, 3, '2025-07-04', '19:30:00'),
(2, 1, '2025-07-05', '18:00:00');

SELECT *
FROM Tables
WHERE TableID NOT IN (
  SELECT TableID
  FROM Reservations
  WHERE ReservationDate = '2025-07-03'
    AND ReservationTime = '19:00:00'
);

SELECT c.Name, COUNT(*) AS TotalReservations
FROM Reservations r
JOIN Customers c ON r.CustomerID = c.CustomerID
GROUP BY c.CustomerID
HAVING COUNT(*) > 2;

SELECT r.ReservationDate, r.ReservationTime, c.Name AS Customer, t.Capacity
FROM Reservations r
JOIN Customers c ON r.CustomerID = c.CustomerID
JOIN Tables t ON r.TableID = t.TableID
ORDER BY r.ReservationDate, r.ReservationTime;






