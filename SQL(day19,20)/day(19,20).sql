-- task1
-- A database is an organized collection of data that can be easily accessed, managed, and updated. It is designed to store, retrieve, and manage large amounts of information. Databases are typically used for applications ranging from websites to enterprise software systems. 

-- task2
-- Relational Database -Uses tables with rows and columns	2.Has a fixed schema (predefined structure)	 3.	Structured data with relationships	
-- Non-Relational Database- Uses documents, key-value pairs, graphs, etc. 2.Has a flexible or dynamic schema  3. Unstructured or semi-structured data, scalability

-- task3
-- Two key advantages of using a Database Management System (DBMS) are improved data security and reduced data redundancy. 

-- task4
-- RDBMS: MySQL.PostgreSQL ,Oracle Database
-- NoSQL Databases:MongoDB,Redis

-- task7
CREATE database school;
use school;

-- task8
CREATE TABLE Students (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Department VARCHAR(100)
);

-- task9
CREATE TABLE Courses (
    CourseID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100),
    Credits INT
);

-- task10
INSERT INTO Students (Name, Age, Department)
VALUES 
('Viyona', 20, 'Computer'),
('Yatvin', 22, 'Mathematics'),
('Swetha', 19, 'Physics');

-- task11
INSERT INTO Courses (Title, Credits)
VALUES 
('Python', 4),
('React', 3);

-- task12
INSERT INTO Students (Name, Age, Department)
VALUES 
('sudha', 21, 'Chemistry'),
('niyva', 20, 'Biology'),
('priya', 19, 'Computer Science');

-- task13
SELECT * FROM Students;

-- task14
SELECT Name,Age FROM Students;

-- task15
SELECT * FROM Courses;

-- task16
SELECT DISTINCT Department FROM Students;

-- task17
SELECT * FROM Students WHERE Age>20;

-- task18
SELECT * FROM Courses WHERE Credits >3;

-- task19
SELECT Name,Department FROM Students Where Department="Computer Science";

-- task20
SELECT Name,Age FROM Students WHERE Age!=20;

-- task21
SELECT * From Students WHERE Name LIKE "A%";

-- task22
SELECT * From Students WHERE Name LIKE "%n%";

-- task23
SELECT * FROM Students WHERE Name Like "s____a";

-- task24
SELECT Name,Age FROM Students WHERE Age BETWEEN 18 AND 22;

-- task25
SELECT * FROM Courses
WHERE CourseID IN (101, 102, 105);

-- task26
SELECT * FROM Students WHERE Department !="Physics";

-- task27
SELECT * FROM Students WHERE Department IS NULL;

-- task28
SELECT * FROM Students WHERE Department IS NOT NULL;

-- task29
SELECT * FROM Students WHERE Age >18 AND Department ="Mathematics";

-- task30
SELECT * FROM Students WHERE Department IN ('Biology', 'Chemistry');

-- task31
SELECT * FROM Students
WHERE Department !="History" AND Age<21;

-- task32
SELECT * FROM Students ORDER BY Name;

-- task33
SELECT * FROM Courses ORDER BY Credits DESC;

-- task34
SELECT * FROM Students
ORDER BY Department ASC, Age DESC;

-- task35
SELECT * FROM Students LIMIT 5;

-- task36
SELECT * FROM Courses
ORDER BY Credits DESC
LIMIT 2;

-- task37
ALTER TABLE Students
ADD Email VARCHAR(50);

-- task38
UPDATE Students
SET Email = 'viyona@example.com'
WHERE StudentID = 1;

-- task39
SET SQL_SAFE_UPDATES = 0;
DELETE FROM Students
WHERE Age > 25;
SET SQL_SAFE_UPDATES = 1;

-- task40
DELETE FROM Courses
WHERE CourseID = 101;

-- task41
INSERT INTO Students (Name, Age)
VALUES ('Anya', 20);

SELECT * FROM Students;

-- task42
SELECT * FROM Students
WHERE Department IS NULL;

-- task43
SET SQL_SAFE_UPDATES = 0;
UPDATE Students
SET Department = 'Engineering'
WHERE Name = 'Yatvin';
SET SQL_SAFE_UPDATES = 1;

-- task44
SET SQL_SAFE_UPDATES = 0;
UPDATE Students
SET Age = Age + 1;
SET SQL_SAFE_UPDATES = 1;

-- task45
SELECT * FROM Students
WHERE Name LIKE '%a';

-- task46
SELECT * FROM Students
WHERE Name LIKE '%at%';

-- task47
SELECT Name,Department FROM Students
WHERE Department IN ('Physics', 'Mathematics')
ORDER BY Age DESC;

-- task48
SELECT DISTINCT Age FROM Students
WHERE Department IS NOT NULL;

-- task49
SELECT * FROM Students
ORDER BY Name ASC
LIMIT 3;

-- task50
SET SQL_SAFE_UPDATES = 0;
DELETE FROM Students
WHERE Department IS NULL;
SET SQL_SAFE_UPDATES = 1;














