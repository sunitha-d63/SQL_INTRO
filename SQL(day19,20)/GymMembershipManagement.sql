create database GymManagement;
use GymManagement;

## 10. Gym Membership Management
-- Tables: Members, MembershipTypes, Payments.
-- Insert members and their payment records.
-- Query members with expired memberships.
-- List members who haven’t made a payment in the last month.

CREATE TABLE IF NOT EXISTS Members (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    JoinDate DATE NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS MembershipTypes (
    MembershipTypeID INT PRIMARY KEY AUTO_INCREMENT,
    TypeName VARCHAR(50) NOT NULL,
    DurationInMonths INT NOT NULL,
    Fee DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    MemberID INT NOT NULL,
    MembershipTypeID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Pay_Member
      FOREIGN KEY (MemberID)
      REFERENCES Members(MemberID)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    CONSTRAINT FK_Pay_MType
      FOREIGN KEY (MembershipTypeID)
      REFERENCES MembershipTypes(MembershipTypeID)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
) ENGINE=InnoDB;

INSERT INTO Members (FullName, Email, Phone, JoinDate)
VALUES 
  ('John Doe', 'john.doe@example.com', '1234567890', CURDATE()),
  ('Jane Smith', 'jane.smith@example.com', '0987654321', CURDATE());

INSERT INTO MembershipTypes (TypeName, DurationInMonths, Fee)
VALUES 
  ('Premium', 6, 500.00),
  ('Standard', 3, 250.00);

INSERT INTO Payments (MemberID, MembershipTypeID, PaymentDate, Amount)
VALUES
  (1, 1, CURDATE() - INTERVAL 190 DAY, 500.00), -- expired
  (2, 2, CURDATE() - INTERVAL 10 DAY, 250.00);  -- active

SELECT 
  m.MemberID, m.FullName, MAX(p.PaymentDate) AS LastPaymentDate,
  DATE_ADD(MAX(p.PaymentDate), INTERVAL mt.DurationInMonths MONTH) AS ExpiryDate
FROM Members m
JOIN Payments p ON m.MemberID = p.MemberID
JOIN MembershipTypes mt ON p.MembershipTypeID = mt.MembershipTypeID
GROUP BY m.MemberID, m.FullName
HAVING ExpiryDate < CURDATE();

SELECT m.MemberID, m.FullName
FROM Members m
LEFT JOIN (
  SELECT MemberID, MAX(PaymentDate) AS LastPaymentDate
  FROM Payments
  GROUP BY MemberID
) sub ON m.MemberID = sub.MemberID
WHERE sub.LastPaymentDate IS NULL
   OR sub.LastPaymentDate < DATE_SUB(CURDATE(), INTERVAL 30 DAY);






