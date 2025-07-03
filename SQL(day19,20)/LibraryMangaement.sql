CREATE database LibraryManagement;
USE LibraryManagement;

-- MINI PROJECT:1
-- Create tables for Books, Authors, Members, and Loans.
-- Insert sample data (at least 5 books, 3 authors, 3 members).
-- Write queries to find books currently loaned out, overdue books, and members with the most loans.

CREATE TABLE Books (
  BookID INT PRIMARY KEY,
  Title VARCHAR(100),
  AuthorID INT,
  Available BOOLEAN
);

CREATE TABLE Authors (
  AuthorID INT PRIMARY KEY,
  Name VARCHAR(100)
);

CREATE TABLE Members (
  MemberID INT PRIMARY KEY,
  Name VARCHAR(100),
  Email VARCHAR(100)
);

CREATE TABLE Loans (
  LoanID INT PRIMARY KEY,
  BookID INT,
  MemberID INT,
  LoanDate DATE,
  ReturnDate DATE,
  DueDate DATE
);

INSERT INTO Authors (AuthorID, Name) VALUES
(1, 'J.K. Rowling'),
(2, 'George Orwell'),
(3, 'Jane Austen');

INSERT INTO Books (BookID, Title, AuthorID, Available) VALUES
(101, 'Harry Potter', 1, FALSE),
(102, '1984', 2, FALSE),
(103, 'Pride and Prejudice', 3, TRUE),
(104, 'Animal Farm', 2, TRUE),
(105, 'Emma', 3, TRUE);

INSERT INTO Members (MemberID, Name, Email) VALUES
(1, 'Viyona', 'viyona@gmail.com'),
(2, 'Yatvin', 'yatvin@gmail.com'),
(3, 'Swetha', 'swetha@gmail.com');

INSERT INTO Loans (LoanID, BookID, MemberID, LoanDate, ReturnDate, DueDate) VALUES
(1, 101, 1, '2025-06-20', NULL, '2025-06-30'),
(2, 102, 2, '2025-06-15', NULL, '2025-06-25'),
(3, 104, 1, '2025-06-01', '2025-06-10', '2025-06-15');

SELECT Books.Title, Members.Name AS BorrowedBy
FROM Loans
JOIN Books ON Loans.BookID = Books.BookID
JOIN Members ON Loans.MemberID = Members.MemberID
WHERE Loans.ReturnDate IS NULL;

SELECT Books.Title, Loans.DueDate
FROM Loans
JOIN Books ON Loans.BookID = Books.BookID
WHERE ReturnDate IS NULL AND DueDate < CURDATE();

SELECT Members.Name, COUNT(*) AS TotalLoans
FROM Loans
JOIN Members ON Loans.MemberID = Members.MemberID
GROUP BY Members.MemberID
ORDER BY TotalLoans DESC;



