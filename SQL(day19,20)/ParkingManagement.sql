CREATE DATABASE ParkingDB;
USE ParkingDB;

## 17. Parking Lot Management
-- Tables: Lots, Vehicles, ParkingRecords.
-- Insert vehicle entry/exit times.
-- Find currently parked vehicles.
-- List lots that are full.
 
 
CREATE TABLE Lots (
  LotID INT PRIMARY KEY AUTO_INCREMENT,
  LotName VARCHAR(100) NOT NULL,
  Capacity INT NOT NULL
);

CREATE TABLE Vehicles (
  VehicleID INT PRIMARY KEY AUTO_INCREMENT,
  LicensePlate VARCHAR(20) UNIQUE NOT NULL,
  VehicleType VARCHAR(50)
);

CREATE TABLE ParkingRecords (
  RecordID INT PRIMARY KEY AUTO_INCREMENT,
  LotID INT NOT NULL,
  VehicleID INT NOT NULL,
  EntryTime DATETIME NOT NULL,
  ExitTime DATETIME DEFAULT NULL,
  FOREIGN KEY (LotID) REFERENCES Lots(LotID)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Lots (LotName, Capacity) VALUES
  ('Main Lot', 3),
  ('Overflow Lot', 2);

INSERT INTO Vehicles (LicensePlate, VehicleType) VALUES
  ('ABC-123', 'Car'),
  ('XYZ-789', 'Truck'),
  ('LMN-456', 'Car');

INSERT INTO ParkingRecords (LotID, VehicleID, EntryTime, ExitTime) VALUES
  (1, 1, NOW() - INTERVAL 2 HOUR, NULL), 
  (1, 2, NOW() - INTERVAL 3 HOUR, NOW() - INTERVAL 1 HOUR),
  (2, 3, NOW() - INTERVAL 30 MINUTE, NULL);
  
SELECT pr.RecordID, v.LicensePlate, pr.LotID, l.LotName, pr.EntryTime
FROM ParkingRecords pr
JOIN Vehicles v USING (VehicleID)
JOIN Lots l USING (LotID)
WHERE pr.ExitTime IS NULL;

SELECT l.LotID, l.LotName, l.Capacity,
       COUNT(pr.RecordID) AS Occupied
FROM Lots l
LEFT JOIN ParkingRecords pr
  ON l.LotID = pr.LotID AND pr.ExitTime IS NULL
GROUP BY l.LotID, l.LotName, l.Capacity
HAVING Occupied >= l.Capacity;


