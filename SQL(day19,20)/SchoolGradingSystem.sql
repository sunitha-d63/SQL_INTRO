CREATE database SchoolGradingSystem;
USE SchoolGradingSystem;

## 8. School Grading System
-- Tables: Students, Subjects, Grades.
-- Insert grades for students in various subjects.
-- Query students with highest grade per subject.
-- List students who failed (grade below passing threshold).

CREATE TABLE Students (
  StudentID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100)
);

CREATE TABLE Subjects (
  SubjectID INT PRIMARY KEY AUTO_INCREMENT,
  SubjectName VARCHAR(100)
);

CREATE TABLE Grades (
  GradeID INT PRIMARY KEY AUTO_INCREMENT,
  StudentID INT,
  SubjectID INT,
  Grade DECIMAL(5,2),
  FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
  FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

INSERT INTO Students (Name) VALUES
('Alice'),
('Bob'),
('Charlie'),
('Diana');

INSERT INTO Subjects (SubjectName) VALUES
('Math'),
('Science'),
('English');

INSERT INTO Grades (StudentID, SubjectID, Grade) VALUES
(1, 1, 95.00),
(1, 2, 88.50),
(1, 3, 76.00),
(2, 1, 84.00),
(2, 2, 45.00),
(2, 3, 62.00),
(3, 1, 67.00),
(3, 2, 72.00),
(3, 3, 80.00),
(4, 1, 90.00),
(4, 2, 92.00),
(4, 3, 35.00);

SELECT s.SubjectName, st.Name, g.Grade
FROM Grades g
JOIN Students st ON g.StudentID = st.StudentID
JOIN Subjects s ON g.SubjectID = s.SubjectID
WHERE (g.SubjectID, g.Grade) IN (
  SELECT SubjectID, MAX(Grade)
  FROM Grades
  GROUP BY SubjectID
);

SELECT st.Name, s.SubjectName, g.Grade
FROM Grades g
JOIN Students st ON g.StudentID = st.StudentID
JOIN Subjects s ON g.SubjectID = s.SubjectID
WHERE g.Grade < 50;

SELECT st.Name AS Student, s.SubjectName, g.Grade
FROM Grades g
JOIN Students st ON g.StudentID = st.StudentID
JOIN Subjects s ON g.SubjectID = s.SubjectID
ORDER BY st.Name, s.SubjectName;







