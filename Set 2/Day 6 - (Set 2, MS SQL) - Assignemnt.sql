-- Day 6 (Set 2) --

-- Creating and Switching Database
IF DB_ID('InsuranceDB') IS NULL BEGIN
    CREATE DATABASE InsuranceDB;
END; GO
USE InsuranceDB;

-- Creating Tables
CREATE TABLE Customers (
    CustomerID       INT PRIMARY KEY IDENTITY(1, 1),
    CustomerName     NVARCHAR(100) NOT NULL,
    DateOfBirth      DATE NOT NULL,
    Email            NVARCHAR(100) NOT NULL UNIQUE,
    Phone            NVARCHAR(20) NOT NULL
);

CREATE TABLE Agents (
    AgentID          INT PRIMARY KEY IDENTITY(1, 1),
    AgentName        NVARCHAR(100) NOT NULL,
    Email            NVARCHAR(100) NOT NULL UNIQUE,
    Branch           NVARCHAR(50) NOT NULL
);

CREATE TABLE Policies (
    PolicyID         INT PRIMARY KEY IDENTITY(1001, 1),
    PolicyNumber     NVARCHAR(30) NOT NULL UNIQUE,
    CustomerID       INT NOT NULL REFERENCES Customers(CustomerID),
    AgentID          INT NOT NULL REFERENCES Agents(AgentID),
    ProductName      NVARCHAR(50) NOT NULL,
    StartDate        DATE NOT NULL,
    ExpiryDate       DATE NOT NULL,
    PolicyStatus     NVARCHAR(20) NOT NULL DEFAULT('Active') CHECK(PolicyStatus IN ('Active', 'Expired', 'Cancelled')),
    PremiumAmount    DECIMAL(12, 2) NOT NULL CHECK(PremiumAmount >= 0),

    CONSTRAINT CK_Policies_Dates CHECK(ExpiryDate > StartDate)
);

CREATE TABLE Premiums (
    PremiumID        INT PRIMARY KEY IDENTITY(1, 1),
    PolicyID         INT NOT NULL REFERENCES Policies(PolicyID),
    PaymentDate      DATE NOT NULL,
    Amount           DECIMAL(12, 2) NOT NULL CHECK(Amount >= 0),
    PaymentStatus    NVARCHAR(20) NOT NULL CHECK(PaymentStatus IN ('Paid', 'Pending', 'Failed')),
    PaymentMethod    NVARCHAR(30) NOT NULL
);

CREATE TABLE Claims (
    ClaimID          INT PRIMARY KEY IDENTITY(1, 1),
    PolicyID         INT NOT NULL REFERENCES Policies(PolicyID),
    ClaimDate        DATE NOT NULL,
    ClaimAmount      DECIMAL(12, 2) NOT NULL CHECK(ClaimAmount >= 0),
    SettledAmount    DECIMAL(12, 2) NOT NULL DEFAULT(0) CHECK(SettledAmount >= 0),
    ClaimStatus      NVARCHAR(20) NOT NULL CHECK(ClaimStatus IN ('Submitted', 'Under Review', 'Approved', 'Rejected', 'Settled')),
    SettlementDate   DATE NULL
);


-- Inserting Data

INSERT INTO Customers (CustomerName, DateOfBirth, Email, Phone) VALUES
    ('Arun Kumar', '1985-05-15', 'arun@insurance.com', '+91 90000 00001'),
    ('Priya Sharma', '1992-08-20', 'priya@insurance.com', '+91 90000 00002'),
    ('Rahul Verma', '1978-03-10', 'rahul@insurance.com', '+91 90000 00003'),
    ('Sneha Reddy', '1998-11-25', 'sneha@insurance.com', '+91 90000 00004'),
    ('Vikram Singh', '1965-02-14', 'vikram@insurance.com', '+91 90000 00005'),
    ('Ananya Das', '2000-07-08', 'ananya@insurance.com', '+91 90000 00006'),
    ('Karthik Raj', '1988-09-12', 'karthik@insurance.com', '+91 90000 00007'),
    ('Meera Nair', '1972-12-30', 'meera@insurance.com', '+91 90000 00008'),
    ('Aditya Rao', '1995-06-18', 'aditya@insurance.com', '+91 90000 00009'),
    ('Divya Krishnan', '1982-04-22', 'divya@insurance.com', '+91 90000 00010');


INSERT INTO Agents (AgentName, Email, Branch) VALUES
    ('Ramesh Kumar', 'ramesh@insurance.com', 'Chennai'),
    ('Kavitha Sharma', 'kavitha@insurance.com', 'Coimbatore'),
    ('Suresh Raj', 'suresh@insurance.com', 'Madurai'),
    ('Nithya Rao', 'nithya@insurance.com', 'Trichy'),
    ('Vijay Anand', 'vijay@insurance.com', 'Salem');


INSERT INTO Policies (PolicyNumber, CustomerID, AgentID, ProductName, StartDate, ExpiryDate, PolicyStatus, PremiumAmount) VALUES
    ('POL-2026-1001', 1, 1, 'Health', '2026-01-01', '2026-12-01', 'Active', 12000.00),
    ('POL-2026-1002', 1, 2, 'Life', '2026-02-01', '2027-02-01', 'Active', 18000.00),
    ('POL-2026-1003', 2, 1, 'Motor', '2026-03-01', '2026-12-05', 'Active', 8000.00),
    ('POL-2026-1004', 3, 3, 'Health', '2026-04-01', '2027-04-01', 'Active', 15000.00),
    ('POL-2026-1005', 4, 2, 'Travel', '2026-05-01', '2026-12-10', 'Active', 5000.00),
    ('POL-2026-1006', 5, 4, 'Life', '2026-06-01', '2027-06-01', 'Active', 22000.00),
    ('POL-2026-1007', 6, 5, 'Motor', '2026-07-01', '2026-11-25', 'Active', 9000.00),
    ('POL-2026-1008', 7, 3, 'Health', '2026-08-01', '2027-08-01', 'Active', 11000.00),
    ('POL-2026-1009', 8, 1, 'Travel', '2026-09-01', '2026-12-15', 'Active', 6000.00),
    ('POL-2026-1010', 9, 4, 'Life', '2026-01-15', '2026-11-01', 'Expired', 20000.00),
    ('POL-2026-1011', 2, 5, 'Health', '2026-10-01', '2027-10-01', 'Active', 13000.00),
    ('POL-2026-1012', 10, 2, 'Motor', '2026-11-01', '2027-11-01', 'Active', 7500.00);


INSERT INTO Premiums (PolicyID, PaymentDate, Amount, PaymentStatus, PaymentMethod) VALUES
    (1001, '2026-01-01', 12000.00, 'Paid', 'UPI'),
    (1002, '2026-02-01', 18000.00, 'Paid', 'Card'),
    (1003, '2026-03-01', 8000.00, 'Paid', 'UPI'),
    (1004, '2026-04-01', 15000.00, 'Paid', 'Net Banking'),
    (1005, '2026-05-01', 5000.00, 'Paid', 'Card'),
    (1006, '2026-06-01', 22000.00, 'Paid', 'UPI'),
    (1007, '2026-07-01', 9000.00, 'Paid', 'Card'),
    (1008, '2026-08-01', 11000.00, 'Paid', 'UPI'),
    (1009, '2026-09-01', 6000.00, 'Paid', 'Net Banking'),
    (1010, '2026-01-15', 20000.00, 'Paid', 'Card'),
    (1011, '2026-10-01', 13000.00, 'Paid', 'UPI'),
    (1012, '2026-11-01', 7500.00, 'Pending', 'Card');


INSERT INTO Claims (PolicyID, ClaimDate, ClaimAmount, SettledAmount, ClaimStatus, SettlementDate) VALUES
    (1001, '2026-03-10', 50000.00, 45000.00, 'Settled', '2026-04-10'),
    (1002, '2026-05-15', 100000.00, 100000.00, 'Settled', '2026-06-15'),
    (1003, '2026-06-20', 30000.00, 25000.00, 'Settled', '2026-07-20'),
    (1004, '2026-07-05', 60000.00, 0.00, 'Under Review', NULL),
    (1005, '2026-08-12', 15000.00, 0.00, 'Rejected', NULL),
    (1006, '2026-09-01', 80000.00, 70000.00, 'Settled', '2026-10-01'),
    (1007, '2026-09-15', 25000.00, 20000.00, 'Settled', '2026-10-15'),
    (1008, '2026-10-01', 40000.00, 0.00, 'Submitted', NULL),
    (1009, '2026-10-10', 12000.00, 0.00, 'Rejected', NULL),
    (1011, '2026-10-20', 35000.00, 30000.00, 'Settled', '2026-11-05');


-- Verify Inserted Data
SELECT * FROM Customers;
SELECT * FROM Agents;
SELECT * FROM Policies;
SELECT * FROM Premiums;
SELECT * FROM Claims;

SELECT 'Customers' AS TableName, COUNT(*) AS TotalRecords FROM Customers;
SELECT 'Agents', COUNT(*) FROM Agents;
SELECT 'Policies', COUNT(*) FROM Policies;
SELECT 'Premiums', COUNT(*) FROM Premiums;
SELECT 'Claims', COUNT(*) FROM Claims;


-- Query 1: Policies Expiring in the Next 30 Days
SELECT PolicyID, CONCAT(LEFT(PolicyNumber, 4), '****', RIGHT(PolicyNumber, 4)) AS MaskedPolicyNumber, ProductName, ExpiryDate, DATEDIFF(DAY, CAST(GETDATE() AS DATE), ExpiryDate) AS DaysToExpiry
    FROM Policies
    WHERE PolicyStatus = 'Active'
        AND ExpiryDate >= CAST(GETDATE() AS DATE)
        AND ExpiryDate < DATEADD(DAY, 31, CAST(GETDATE() AS DATE))
    ORDER BY ExpiryDate;


-- Query 2: Premium Collected per Product
SELECT p.ProductName, SUM(pr.Amount) AS TotalPremiumCollected, COUNT(pr.PremiumID) AS TotalPayments
    FROM Policies AS p
        INNER JOIN Premiums AS pr ON pr.PolicyID = p.PolicyID
    WHERE pr.PaymentStatus = 'Paid'
    GROUP BY p.ProductName
    ORDER BY TotalPremiumCollected DESC;


-- Query 3: Customers with More Than One Active Policy
SELECT c.CustomerID, UPPER(c.CustomerName) AS CustomerName, COUNT(p.PolicyID) AS ActivePolicies
    FROM Customers AS c
        INNER JOIN Policies AS p ON p.CustomerID = c.CustomerID
    WHERE p.PolicyStatus = 'Active'
    GROUP BY c.CustomerID, c.CustomerName
    HAVING COUNT(p.PolicyID) > 1
    ORDER BY ActivePolicies DESC;


-- Query 4: Claim Ratio per Product
SELECT p.ProductName, SUM(c.ClaimAmount) AS TotalClaimAmount, SUM(pr.Amount) AS TotalPremiumCollected, ROUND(SUM(c.ClaimAmount) * 100.0 / NULLIF(SUM(pr.Amount), 0), 2) AS ClaimRatioPercentage
    FROM Policies AS p
        LEFT JOIN Claims AS c ON c.PolicyID = p.PolicyID
        LEFT JOIN Premiums AS pr
            ON pr.PolicyID = p.PolicyID AND pr.PaymentStatus = 'Paid'
    GROUP BY p.ProductName
    ORDER BY ClaimRatioPercentage DESC;


-- Query 5: Policies Without Claims
SELECT p.PolicyID, CONCAT(LEFT(p.PolicyNumber, 4), '****', RIGHT(p.PolicyNumber, 4)) AS MaskedPolicyNumber, c.CustomerName, p.ProductName, p.PolicyStatus
    FROM Policies AS p
        INNER JOIN Customers AS c ON c.CustomerID = p.CustomerID
        LEFT JOIN Claims AS cl ON cl.PolicyID = p.PolicyID
    WHERE cl.ClaimID IS NULL
    ORDER BY p.PolicyID;


-- Query 6: Average Premium by Age Band
SELECT
    CASE
        WHEN DATEDIFF(YEAR, c.DateOfBirth, GETDATE())
             - CASE
                   WHEN DATEADD(YEAR, DATEDIFF(YEAR, c.DateOfBirth, GETDATE()), c.DateOfBirth) > GETDATE()
                   THEN 1 ELSE 0
               END < 25 THEN 'Below 25'
        WHEN DATEDIFF(YEAR, c.DateOfBirth, GETDATE())
             - CASE
                   WHEN DATEADD(YEAR, DATEDIFF(YEAR, c.DateOfBirth, GETDATE()), c.DateOfBirth) > GETDATE()
                   THEN 1 ELSE 0
               END BETWEEN 25 AND 40 THEN '25-40'
        WHEN DATEDIFF(YEAR, c.DateOfBirth, GETDATE())
             - CASE
                   WHEN DATEADD(YEAR, DATEDIFF(YEAR, c.DateOfBirth, GETDATE()), c.DateOfBirth) > GETDATE()
                   THEN 1 ELSE 0
               END BETWEEN 41 AND 60 THEN '41-60'
        ELSE 'Above 60'
    END AS AgeBand,
    ROUND(AVG(p.PremiumAmount), 2) AS AveragePremium,
    COUNT(p.PolicyID) AS TotalPolicies
FROM Customers AS c
    INNER JOIN Policies AS p ON p.CustomerID = c.CustomerID
GROUP BY
    CASE
        WHEN DATEDIFF(YEAR, c.DateOfBirth, GETDATE())
             - CASE
                   WHEN DATEADD(YEAR, DATEDIFF(YEAR, c.DateOfBirth, GETDATE()), c.DateOfBirth) > GETDATE()
                   THEN 1 ELSE 0
               END < 25 THEN 'Below 25'
        WHEN DATEDIFF(YEAR, c.DateOfBirth, GETDATE())
             - CASE
                   WHEN DATEADD(YEAR, DATEDIFF(YEAR, c.DateOfBirth, GETDATE()), c.DateOfBirth) > GETDATE()
                   THEN 1 ELSE 0
               END BETWEEN 25 AND 40 THEN '25-40'
        WHEN DATEDIFF(YEAR, c.DateOfBirth, GETDATE())
             - CASE
                   WHEN DATEADD(YEAR, DATEDIFF(YEAR, c.DateOfBirth, GETDATE()), c.DateOfBirth) > GETDATE()
                   THEN 1 ELSE 0
               END BETWEEN 41 AND 60 THEN '41-60'
        ELSE 'Above 60'
    END
ORDER BY AgeBand;


-- Query 7: Monthly New Policies
SELECT FORMAT(StartDate, 'MMM yyyy') AS PolicyMonth, COUNT(PolicyID) AS NewPolicies, SUM(PremiumAmount) AS TotalPolicyPremium
    FROM Policies
    GROUP BY YEAR(StartDate), MONTH(StartDate), FORMAT(StartDate, 'MMM yyyy')
    ORDER BY YEAR(StartDate), MONTH(StartDate);


-- Query 8: Top 5 Agents by Premium
SELECT TOP 5 a.AgentID, UPPER(a.AgentName) AS AgentName, a.Branch, SUM(pr.Amount) AS TotalPremiumCollected, COUNT(DISTINCT p.PolicyID) AS TotalPolicies
    FROM Agents AS a
        INNER JOIN Policies AS p ON p.AgentID = a.AgentID
        INNER JOIN Premiums AS pr ON pr.PolicyID = p.PolicyID
    WHERE pr.PaymentStatus = 'Paid'
    GROUP BY a.AgentID, a.AgentName, a.Branch
    ORDER BY TotalPremiumCollected DESC;


-- WHERE vs HAVING Demonstration

-- WHERE filters individual records before grouping.
SELECT ProductName, COUNT(*) AS TotalPolicies
    FROM Policies
    WHERE PolicyStatus = 'Active'
    GROUP BY ProductName;

-- HAVING filters groups after aggregation.
SELECT CustomerID, COUNT(*) AS ActivePolicies
    FROM Policies
    WHERE PolicyStatus = 'Active'
    GROUP BY CustomerID
    HAVING COUNT(*) > 1;

-- WHERE filters rows; HAVING filters aggregated groups.
