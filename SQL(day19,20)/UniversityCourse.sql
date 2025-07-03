CREATE DATABASE UniversityDB;
USE UniversityDB;

## 16. University Course Enrollment System
-- Tables: Students, Courses, Enrollments.
-- Insert students enrolled in various courses.
-- Query courses with no enrollments.
-- List students enrolled in more than 2 courses.

CREATE TABLE IF NOT EXISTS Students (
  StudentID INT PRIMARY KEY AUTO_INCREMENT,
  FirstName VARCHAR(100) NOT NULL,
  LastName VARCHAR(100) NOT NULL,
  Email VARCHAR(255) UNIQUE
);

CREATE TABLE IF NOT EXISTS Coursestb (
  CourseID INT PRIMARY KEY AUTO_INCREMENT,
  CourseName VARCHAR(255) NOT NULL,
  Credits INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Enrollments (
  EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
  StudentID INT NOT NULL,
  CourseID INT NOT NULL,
  EnrollDate DATE NOT NULL,
  FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Students (FirstName, LastName, Email)
VALUES
  ('Alice', 'Smith', 'alice.smith@uni.edu'),
  ('Bob', 'Johnson', 'bob.johnson@uni.edu'),
  ('Charlie', 'Lee', 'charlie.lee@uni.edu');

INSERT INTO Coursestb (CourseName, Credits)
VALUES
  ('Calculus I', 4),
  ('Introduction to Programming', 3),
  ('Database Systems', 3),
  ('Philosophy 101', 2);
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO Enrollments (StudentID, CourseID, EnrollDate)
VALUES
  (1, 1, CURDATE() - INTERVAL 30 DAY),
  (1, 2, CURDATE() - INTERVAL 25 DAY),
  (1, 3, CURDATE() - INTERVAL 20 DAY),
  (2, 2, CURDATE() - INTERVAL 15 DAY),
  (2, 3, CURDATE() - INTERVAL 10 DAY),
  (3, 1, CURDATE() - INTERVAL 5 DAY);

SELECT * FROM Students WHERE StudentID IN (1,2,3);
SELECT * FROM Coursestb WHERE CourseID IN (1,2,3);

INSERT INTO Coursestb (CourseName, Credits) VALUES ('Some Course', 3);

SELECT c.CourseID, c.CourseName
FROM Coursestb c
LEFT JOIN Enrollments e USING (CourseID)
WHERE e.EnrollmentID IS NULL;

SELECT s.StudentID,
       CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
       COUNT(e.CourseID) AS CourseCount
FROM Students s
JOIN Enrollments e USING (StudentID)
GROUP BY s.StudentID, StudentName
HAVING COUNT(e.CourseID) > 2;


