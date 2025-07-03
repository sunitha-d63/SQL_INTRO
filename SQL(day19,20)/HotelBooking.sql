CREATE database HotelBooking;
USE HotelBooking;

## 12. Hotel Room Booking System
-- Tables: Rooms, Guests, Bookings.
-- Insert bookings for various rooms.
-- Find available rooms for a given date.
-- List guests with more than 3 bookings.

CREATE TABLE Rooms (
  RoomID INT PRIMARY KEY AUTO_INCREMENT,
  RoomNumber VARCHAR(10),
  RoomType VARCHAR(50),
  PricePerNight DECIMAL(10,2)
);

CREATE TABLE Guests (
  GuestID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Email VARCHAR(100)
);

CREATE TABLE Bookings (
  BookingID INT PRIMARY KEY AUTO_INCREMENT,
  RoomID INT,
  GuestID INT,
  CheckInDate DATE,
  CheckOutDate DATE,
  FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
  FOREIGN KEY (GuestID) REFERENCES Guests(GuestID)
);

INSERT INTO Rooms (RoomNumber, RoomType, PricePerNight) VALUES
('101', 'Single', 100.00),
('102', 'Double', 150.00),
('103', 'Suite', 250.00),
('104', 'Deluxe', 300.00);

INSERT INTO Guests (Name, Email) VALUES
('Alice', 'alice@gmail.com'),
('Bob', 'bob@gmail.com'),
('Charlie', 'charlie@gmail.com'),
('Diana', 'diana@gmail.com');

INSERT INTO Bookings (RoomID, GuestID, CheckInDate, CheckOutDate) VALUES
(1, 1, '2025-07-10', '2025-07-12'),
(2, 2, '2025-07-11', '2025-07-15'),
(3, 1, '2025-07-20', '2025-07-22'),
(1, 3, '2025-07-18', '2025-07-20'),
(2, 4, '2025-07-25', '2025-07-28'),
(1, 1, '2025-08-01', '2025-08-03'),
(3, 1, '2025-08-10', '2025-08-12'); 

SELECT * 
FROM Rooms 
WHERE RoomID NOT IN (
  SELECT RoomID
  FROM Bookings
  WHERE '2025-07-11' BETWEEN CheckInDate AND CheckOutDate
);

SELECT g.Name, COUNT(*) AS TotalBookings
FROM Bookings b
JOIN Guests g ON b.GuestID = g.GuestID
GROUP BY b.GuestID
HAVING COUNT(*) > 3;

SELECT b.BookingID, g.Name AS Guest, r.RoomNumber, b.CheckInDate, b.CheckOutDate
FROM Bookings b
JOIN Guests g ON b.GuestID = g.GuestID
JOIN Rooms r ON b.RoomID = r.RoomID
ORDER BY b.CheckInDate;







