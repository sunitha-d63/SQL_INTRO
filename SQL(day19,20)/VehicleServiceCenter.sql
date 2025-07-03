CREATE DATABASE ServiceCenterDB;
USE ServiceCenterDB;

## 14. Vehicle Service Center Database
-- Tables: Vehicles, Customers, Services, ServiceRecords.
-- Insert records of vehicle services.
-- Query vehicles serviced in the last month.
-- Find customers with more than 2 services in a year.

CREATE TABLE  Customers (
  CustomerID INT PRIMARY KEY AUTO_INCREMENT,
  FirstName VARCHAR(100) NOT NULL,
  LastName VARCHAR(100) NOT NULL,
  Email VARCHAR(100) UNIQUE,
  Phone VARCHAR(20)
);
CREATE TABLE Vehicles (
  VehicleID INT PRIMARY KEY AUTO_INCREMENT,
  CustomerID INT NOT NULL,
  Make VARCHAR(50),
  Model VARCHAR(50),
  Year INT,
  VIN VARCHAR(17) UNIQUE,
  CONSTRAINT FK_Vehicles_Customers
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Services (
  ServiceID INT PRIMARY KEY AUTO_INCREMENT,
  ServiceName VARCHAR(100) NOT NULL,
  BaseCost DECIMAL(10,2) NOT NULL
);

CREATE TABLE ServiceRecords (
  RecordID INT PRIMARY KEY AUTO_INCREMENT,
  VehicleID INT NOT NULL,
  ServiceID INT NOT NULL,
  ServiceDate DATE NOT NULL,
  TotalCost DECIMAL(10,2) NOT NULL,
  CONSTRAINT FK_ServiceRecords_Vehicles
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT FK_ServiceRecords_Services
    FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

INSERT INTO Customers (FirstName, LastName, Email, Phone)
VALUES ('Alice','Baker','alice.b@example.com','9876543210'),
       ('Bob','Carter','bob.c@example.com','8765432109');

INSERT INTO Vehicles (CustomerID, Make, Model, Year, VIN)
VALUES 
 (1,'Toyota','Corolla',2018,'1HGCM82633A004352'),
 (1,'Honda','Civic',2020,'1HGCM82633A004353'),
 (2,'Ford','Focus',2019,'1HGCM82633A004354');

INSERT INTO Services (ServiceName, BaseCost)
VALUES ('Oil Change',50.00),('Brake Inspection',80.00),('Tire Rotation',40.00);

INSERT INTO ServiceRecords (VehicleID, ServiceID, ServiceDate, TotalCost)
VALUES 
 (1,1, CURDATE() - INTERVAL 20 DAY, 55.00),
 (2,2, CURDATE() - INTERVAL 10 DAY, 85.00),
 (1,3, CURDATE() - INTERVAL 300 DAY, 45.00),
 (3,1, CURDATE() - INTERVAL 200 DAY, 50.00),
 (3,1, CURDATE() - INTERVAL 150 DAY, 50.00);
 
 SELECT v.VehicleID, v.Make, v.Model, v.Year, c.FirstName, c.LastName, sr.ServiceDate
FROM ServiceRecords sr
JOIN Vehicles v USING (VehicleID)
JOIN Customers c USING (CustomerID)
WHERE sr.ServiceDate >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(sr.RecordID) AS ServicesCount
FROM ServiceRecords sr
JOIN Vehicles v USING (VehicleID)
JOIN Customers c USING (CustomerID)
WHERE sr.ServiceDate BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND CURDATE()
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING COUNT(sr.RecordID) > 2;



