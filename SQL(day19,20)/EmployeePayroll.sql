CREATE database EmployeePayroll;
USE EmployeePayroll;

## 3. Employee Payroll System
-- Tables: Employees, Departments, Salaries.
-- Insert data for at least 10 employees, 3 departments.
--  Retrieve all employees in a department earning above a certain salary.
--  Update salary for employees based on performance.

CREATE TABLE Departments (
  DepartmentID INT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL
);

CREATE TABLE Employees (
  EmployeeID INT PRIMARY KEY,
  Name VARCHAR(100),
  DepartmentID INT,
  FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Salaries (
  SalaryID INT PRIMARY KEY AUTO_INCREMENT,
  EmployeeID INT,
  BaseSalary DECIMAL(10, 2),
  PerformanceRating INT,
  FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Departments (DepartmentID, Name) VALUES
(1, 'HR'),
(2, 'Engineering'),
(3, 'Marketing');

INSERT INTO Employees (EmployeeID, Name, DepartmentID) VALUES
(1, 'Alice', 1),
(2, 'Bob', 2),
(3, 'Charlie', 2),
(4, 'David', 3),
(5, 'Eva', 1),
(6, 'Frank', 3),
(7, 'Grace', 2),
(8, 'Hannah', 2),
(9, 'Ivan', 3),
(10, 'Jack', 1);

INSERT INTO Salaries (EmployeeID, BaseSalary, PerformanceRating) VALUES
(1, 50000, 3),
(2, 70000, 5),
(3, 72000, 4),
(4, 55000, 2),
(5, 48000, 3),
(6, 60000, 5),
(7, 69000, 4),
(8, 68000, 3),
(9, 62000, 2),
(10, 51000, 5);

SELECT e.Name, d.Name AS Department, s.BaseSalary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
JOIN Salaries s ON e.EmployeeID = s.EmployeeID
WHERE d.Name = 'Engineering' AND s.BaseSalary > 68000;

SET SQL_SAFE_UPDATES = 0;
UPDATE Salaries
SET BaseSalary = 
  CASE
    WHEN PerformanceRating = 5 THEN BaseSalary * 1.10
    WHEN PerformanceRating = 4 THEN BaseSalary * 1.05
    ELSE BaseSalary
  END;
  
SELECT e.Name, s.BaseSalary, s.PerformanceRating
FROM Employees e
JOIN Salaries s ON e.EmployeeID = s.EmployeeID;





