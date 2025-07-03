CREATE database TravelAgency;
USE TravelAgency;

## 9. Travel Agency Booking System
-- Tables: Customers, Trips, Bookings.
-- Insert bookings for various trips.
-- Find all trips booked by a customer.
-- List trips with no bookings.

CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Email VARCHAR(100)
);

CREATE TABLE Trips (
  TripID INT PRIMARY KEY AUTO_INCREMENT,
  Destination VARCHAR(100),
  StartDate DATE,
  EndDate DATE,
  Price DECIMAL(10,2)
);

CREATE TABLE Bookings (
  BookingID INT PRIMARY KEY AUTO_INCREMENT,
  CustomerID INT,
  TripID INT,
  BookingDate DATE,
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
  FOREIGN KEY (TripID) REFERENCES Trips(TripID)
);

INSERT INTO Customers (Name, Email) VALUES
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com'),
('Charlie', 'charlie@example.com');

INSERT INTO Trips (Destination, StartDate, EndDate, Price) VALUES
('Paris', '2025-08-01', '2025-08-10', 1200.00),
('Tokyo', '2025-09-15', '2025-09-25', 1500.00),
('New York', '2025-07-20', '2025-07-30', 1000.00),
('Rome', '2025-10-05', '2025-10-12', 950.00);

INSERT INTO Bookings (CustomerID, TripID, BookingDate) VALUES
(1, 1, '2025-06-01'),  
(2, 2, '2025-06-10'),  
(1, 3, '2025-06-15'); 

SELECT c.Name, t.Destination, t.StartDate, t.EndDate, t.Price
FROM Bookings b
JOIN Customers c ON b.CustomerID = c.CustomerID
JOIN Trips t ON b.TripID = t.TripID
WHERE c.Name = 'Alice';

SELECT *
FROM Trips
WHERE TripID NOT IN (
  SELECT TripID
  FROM Bookings
);

SELECT b.BookingID, c.Name AS Customer, t.Destination, b.BookingDate
FROM Bookings b
JOIN Customers c ON b.CustomerID = c.CustomerID
JOIN Trips t ON b.TripID = t.TripID
ORDER BY b.BookingDate;








