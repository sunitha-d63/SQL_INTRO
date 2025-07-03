-- 1️⃣ Create & Use Database
CREATE DATABASE IF NOT EXISTS ClinicDB;
USE ClinicDB;

## 20. Clinic Appointment Scheduling
-- Tables: Patients, Doctors, Appointments.
-- Insert appointments for patients and doctors.
-- Find doctors with most appointments in a week.
-- List patients with missed appointments.

CREATE TABLE IF NOT EXISTS Patients (
  PatientID INT PRIMARY KEY AUTO_INCREMENT,
  FullName VARCHAR(100) NOT NULL,
  Email VARCHAR(255) UNIQUE,
  Phone VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Doctors (
  DoctorID INT PRIMARY KEY AUTO_INCREMENT,
  FullName VARCHAR(100) NOT NULL,
  Specialty VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Appointments (
  AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
  PatientID INT NOT NULL,
  DoctorID INT NOT NULL,
  StartTime DATETIME NOT NULL,
  EndTime DATETIME NULL,
  Status ENUM('Scheduled','Completed','No-Show','Cancelled') NOT NULL DEFAULT 'Scheduled',
  FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Patients (FullName, Email, Phone) VALUES
  ('Alice Smith', 'alice@example.com','111-222-3333'),
  ('Bob Jones', 'bob@example.com','222-333-4444');

INSERT INTO Doctors (FullName, Specialty) VALUES
  ('Dr. John Doe', 'Cardiology'),
  ('Dr. Jane Roe', 'Dermatology');

INSERT INTO Appointments (PatientID, DoctorID, StartTime, EndTime, Status) VALUES
  (1, 1, NOW() - INTERVAL 5 DAY, NOW() - INTERVAL 5 DAY + INTERVAL 30 MINUTE, 'Completed'),
  (2, 1, NOW() - INTERVAL 2 DAY, NULL, 'Scheduled'),
  (1, 2, NOW() - INTERVAL 10 DAY, NULL, 'No-Show'),
  (2, 2, NOW() - INTERVAL 1 DAY, NOW() - INTERVAL 1 DAY + INTERVAL 45 MINUTE, 'Completed');

SELECT d.DoctorID, d.FullName, COUNT(a.AppointmentID) AS ApptCount
FROM Doctors d
JOIN Appointments a USING (DoctorID)
WHERE a.StartTime >= DATE_SUB(NOW(), INTERVAL 7 DAY)
GROUP BY d.DoctorID, d.FullName
ORDER BY ApptCount DESC
LIMIT 1;

SELECT p.PatientID, p.FullName, COUNT(a.AppointmentID) AS MissedCount
FROM Patients p
JOIN Appointments a USING (PatientID)
WHERE a.Status = 'No-Show'
GROUP BY p.PatientID, p.FullName;


