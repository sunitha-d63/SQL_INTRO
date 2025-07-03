CREATE database StudentAttendance;
USE StudentAttendance;

-- MINI PROJECT:1  Student Attendance Tracker
-- Tables: Students, Courses, Attendance.
-- Insert attendance records for multiple students across different courses.
-- Query all students who have more than 90% attendance in a course.
-- List students absent on a specific date.

CREATE TABLE Students (
  StudentID INT PRIMARY KEY,
  Name VARCHAR(100)
);

CREATE TABLE Courses (
  CourseID INT PRIMARY KEY,
  Title VARCHAR(100)
);

CREATE TABLE Attendance (
  AttendanceID INT PRIMARY KEY AUTO_INCREMENT,
  StudentID INT,
  CourseID INT,
  Date DATE,
  Status ENUM('Present', 'Absent'),
  FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
  FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

SELECT 
  s.StudentID,
  s.Name,
  c.Title AS Course,
  ROUND(SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttendancePercentage
FROM Attendance a
JOIN Students s ON a.StudentID = s.StudentID
JOIN Courses c ON a.CourseID = c.CourseID
GROUP BY s.StudentID, c.CourseID
HAVING AttendancePercentage > 90;

SELECT s.StudentID, s.Name, c.Title AS Course
FROM Attendance a
JOIN Students s ON a.StudentID = s.StudentID
JOIN Courses c ON a.CourseID = c.CourseID
WHERE a.Date = '2025-07-02' AND a.Status = 'Absent';
