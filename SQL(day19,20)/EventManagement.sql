CREATE DATABASE EventDB;
USE EventDB;

## 19. Event Management System
-- Tables: Events, Attendees, Registrations.
-- Insert event registrations.
-- Query events with more than 100 attendees.
-- List attendees registered for multiple events.

CREATE TABLE IF NOT EXISTS Events (
  EventID INT PRIMARY KEY AUTO_INCREMENT,
  EventName VARCHAR(255) NOT NULL,
  EventDate DATE NOT NULL,
  Venue VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Attendees (
  AttendeeID INT PRIMARY KEY AUTO_INCREMENT,
  FullName VARCHAR(255) NOT NULL,
  Email VARCHAR(255) UNIQUE,
  Phone VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Registrations (
  RegistrationID INT PRIMARY KEY AUTO_INCREMENT,
  EventID INT NOT NULL,
  AttendeeID INT NOT NULL,
  RegistrationDate DATE NOT NULL,
  FOREIGN KEY (EventID) REFERENCES Events(EventID)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Events (EventName, EventDate, Venue) VALUES
  ('Tech Summit 2025', '2025-09-15', 'Convention Center'),
  ('Book Fair', '2025-08-01', 'City Library'),
  ('Health Expo', '2025-10-20', 'Expo Grounds');

INSERT INTO Attendees (FullName, Email, Phone) VALUES
  ('Alice Green', 'alice@example.com', '111-222-3333'),
  ('Bob Brown', 'bob@example.com', '222-333-4444'),
  ('Charlie Black', 'charlie@example.com', '333-444-5555');

INSERT INTO Registrations (EventID, AttendeeID, RegistrationDate) VALUES
  (1, 1, '2025-06-01'),
  (1, 2, '2025-06-02'),
  (1, 3, '2025-06-03'),
  (2, 1, '2025-06-05'),
  (2, 2, '2025-06-06'),
  (3, 1, '2025-06-10'),
  (3, 3, '2025-06-11');
  
  SELECT e.EventID, e.EventName, COUNT(r.AttendeeID) AS AttendeeCount
FROM Events e
JOIN Registrations r USING (EventID)
GROUP BY e.EventID, e.EventName
HAVING COUNT(r.AttendeeID) > 100;

SELECT a.AttendeeID, a.FullName, COUNT(r.EventID) AS EventCount
FROM Attendees a
JOIN Registrations r USING (AttendeeID)
GROUP BY a.AttendeeID, a.FullName
HAVING COUNT(r.EventID) > 1;



