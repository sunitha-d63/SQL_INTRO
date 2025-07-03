CREATE database HospitalManagement;
USE HospitalManagement;

## 5. Hospital Patient Record Management
-- Tables: Patients, Doctors, Appointments.
-- Insert appointments for different doctors and patients.
-- List appointments for a doctor within a date range.
-- Find patients without assigned doctors.

CREATE TABLE Doctors (
  DoctorID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Specialty VARCHAR(100)
);

CREATE TABLE Patients (
  PatientID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Age INT,
  DoctorID INT,  -- Optional assignment to a primary doctor
  FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Appointments (
  AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
  PatientID INT,
  DoctorID INT,
  AppointmentDate DATE,
  Reason VARCHAR(255),
  FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
  FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

INSERT INTO Doctors (Name, Specialty) VALUES
('Dr. Smith', 'Cardiology'),
('Dr. Gupta', 'Pediatrics'),
('Dr. Ahmed', 'Neurology');

INSERT INTO Patients (Name, Age, DoctorID) VALUES
('John Doe', 45, 1),
('Emily Clark', 12, 2),
('Michael Chan', 30, NULL),
('Sara Lee', 25, 1),
('Tom Hardy', 60, NULL);

INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Reason) VALUES
(1, 1, '2025-07-01', 'Routine check-up'),
(2, 2, '2025-07-03', 'Flu symptoms'),
(4, 1, '2025-07-02', 'Heart issue');

SELECT a.AppointmentID, p.Name AS Patient, a.AppointmentDate, a.Reason
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID
WHERE d.Name = 'Dr. Smith'
AND a.AppointmentDate BETWEEN '2025-07-01' AND '2025-07-10';


SELECT Name, Age
FROM Patients
WHERE DoctorID IS NULL;

SELECT a.AppointmentDate, p.Name AS Patient, d.Name AS Doctor, a.Reason
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID
ORDER BY a.AppointmentDate;






