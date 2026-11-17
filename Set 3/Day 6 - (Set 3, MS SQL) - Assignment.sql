-- Day 6 (Set 3) --


-- Creating and Switching Database
IF DB_ID('TelecomDB') IS NULL BEGIN
    CREATE DATABASE TelecomDB;
END; GO
USE TelecomDB;

-- Creating Tables
CREATE TABLE Plans (
    PlanID           INT PRIMARY KEY IDENTITY(1, 1),
    PlanName         NVARCHAR(100) NOT NULL UNIQUE,
    MonthlyPrice     DECIMAL(10, 2) NOT NULL CHECK(MonthlyPrice >= 0),
    DataLimitGB      DECIMAL(10, 2) NOT NULL CHECK(DataLimitGB >= 0),
    CallLimitMinutes INT NOT NULL CHECK(CallLimitMinutes >= 0)
);

CREATE TABLE Subscribers (
    SubscriberID     INT PRIMARY KEY IDENTITY(1, 1),
    SubscriberName   NVARCHAR(100) NOT NULL,
    PhoneNumber      NVARCHAR(20) NOT NULL UNIQUE,
    Circle           NVARCHAR(50) NOT NULL,
    PlanID           INT NOT NULL REFERENCES Plans(PlanID),
    ActivationDate   DATE NOT NULL,
    SubscriberStatus NVARCHAR(20) NOT NULL DEFAULT('Active') CHECK(SubscriberStatus IN ('Active', 'Inactive', 'Suspended'))
);

CREATE TABLE CallRecords (
    RecordID         INT PRIMARY KEY IDENTITY(1, 1),
    SubscriberID     INT NOT NULL REFERENCES Subscribers(SubscriberID),
    CallDate         DATETIME2 NOT NULL,
    CallMinutes      DECIMAL(8, 2) NOT NULL DEFAULT(0) CHECK(CallMinutes >= 0),
    DataUsedGB       DECIMAL(8, 2) NULL CHECK(DataUsedGB >= 0),
    CallType         NVARCHAR(20) NOT NULL CHECK(CallType IN ('Voice', 'Data', 'SMS')),
    CellTower        NVARCHAR(50) NOT NULL
);

CREATE TABLE Invoices (
    InvoiceID        INT PRIMARY KEY IDENTITY(1, 1),
    InvoiceNumber    NVARCHAR(30) NOT NULL UNIQUE,
    SubscriberID     INT NOT NULL REFERENCES Subscribers(SubscriberID),
    InvoiceDate      DATE NOT NULL,
    DueDate          DATE NOT NULL,
    InvoiceAmount    DECIMAL(10, 2) NOT NULL CHECK(InvoiceAmount >= 0),
    PaymentStatus    NVARCHAR(20) NOT NULL DEFAULT('Pending') CHECK(PaymentStatus IN ('Paid', 'Pending', 'Overdue')),
    PaymentDate      DATE NULL,

    CONSTRAINT CK_Invoices_Dates CHECK(DueDate >= InvoiceDate)
);


-- Inserting Data

INSERT INTO Plans (PlanName, MonthlyPrice, DataLimitGB, CallLimitMinutes) VALUES
    ('Basic 199', 199.00, 2.00, 500),
    ('Smart 399', 399.00, 5.00, 1000),
    ('Plus 599', 599.00, 10.00, 1500),
    ('Premium 799', 799.00, 20.00, 2500),
    ('Unlimited 999', 999.00, 50.00, 5000);


INSERT INTO Subscribers (SubscriberName, PhoneNumber, Circle, PlanID, ActivationDate, SubscriberStatus) VALUES
    ('Arun Kumar', '+91 90000 00001', 'Chennai', 3, '2025-01-10', 'Active'),
    ('Priya Sharma', '+91 90000 00002', 'Coimbatore', 2, '2025-02-15', 'Active'),
    ('Rahul Verma', '+91 90000 00003', 'Madurai', 1, '2025-03-20', 'Active'),
    ('Sneha Reddy', '+91 90000 00004', 'Chennai', 4, '2025-04-05', 'Active'),
    ('Vikram Singh', '+91 90000 00005', 'Coimbatore', 5, '2025-05-12', 'Active'),
    ('Ananya Das', '+91 90000 00006', 'Trichy', 2, '2025-06-18', 'Active'),
    ('Karthik Raj', '+91 90000 00007', 'Madurai', 3, '2025-07-22', 'Active'),
    ('Meera Nair', '+91 90000 00008', 'Chennai', 1, '2025-08-30', 'Active'),
    ('Aditya Rao', '+91 90000 00009', 'Salem', 4, '2025-09-14', 'Inactive'),
    ('Divya Krishnan', '+91 90000 00010', 'Coimbatore', 2, '2025-10-01', 'Active');


INSERT INTO CallRecords (SubscriberID, CallDate, CallMinutes, DataUsedGB, CallType, CellTower) VALUES
    (1, '2026-11-01T09:15:00', 45.00, 6.00, 'Data', 'TOWER-CHN-01'),
    (1, '2026-11-03T14:30:00', 30.00, 5.00, 'Data', 'TOWER-CHN-02'),
    (2, '2026-11-02T10:00:00', 60.00, 2.00, 'Voice', 'TOWER-CBE-01'),
    (2, '2026-11-05T16:45:00', 25.00, 1.50, 'Data', 'TOWER-CBE-02'),
    (3, '2026-11-04T11:20:00', 35.00, 3.00, 'Data', 'TOWER-MDU-01'),
    (3, '2026-11-07T18:00:00', 20.00, 4.00, 'Data', 'TOWER-MDU-01'),
    (4, '2026-11-05T08:30:00', 90.00, 8.00, 'Voice', 'TOWER-CHN-01'),
    (4, '2026-11-08T13:15:00', 40.00, 6.00, 'Data', 'TOWER-CHN-02'),
    (5, '2026-11-06T12:00:00', 120.00, 12.00, 'Data', 'TOWER-CBE-01'),
    (5, '2026-11-09T19:30:00', 75.00, 10.00, 'Data', 'TOWER-CBE-01'),
    (6, '2026-11-07T09:45:00', 55.00, 2.00, 'Voice', 'TOWER-TRY-01'),
    (6, '2026-11-10T15:20:00', 35.00, 1.00, 'Data', 'TOWER-TRY-02'),
    (7, '2026-11-09T10:10:00', 65.00, 7.00, 'Data', 'TOWER-MDU-01'),
    (7, '2026-11-12T17:40:00', 40.00, 5.00, 'Data', 'TOWER-MDU-02'),
    (8, '2026-11-11T11:30:00', 30.00, 1.00, 'Voice', 'TOWER-CHN-01'),
    (8, '2026-11-13T20:00:00', 25.00, 0.50, 'Data', 'TOWER-CHN-01'),
    (9, '2026-11-12T08:00:00', 100.00, 15.00, 'Data', 'TOWER-SLM-01'),
    (9, '2026-11-14T14:00:00', 50.00, 8.00, 'Data', 'TOWER-SLM-02');


INSERT INTO Invoices (InvoiceNumber, SubscriberID, InvoiceDate, DueDate, InvoiceAmount, PaymentStatus, PaymentDate) VALUES
    ('INV-2026-001', 1, '2026-10-01', '2026-10-15', 599.00, 'Paid', '2026-10-10'),
    ('INV-2026-002', 2, '2026-10-01', '2026-10-15', 399.00, 'Pending', NULL),
    ('INV-2026-003', 3, '2026-10-05', '2026-10-20', 199.00, 'Overdue', NULL),
    ('INV-2026-004', 4, '2026-10-05', '2026-10-20', 799.00, 'Paid', '2026-10-18'),
    ('INV-2026-005', 5, '2026-10-10', '2026-10-25', 999.00, 'Paid', '2026-10-20'),
    ('INV-2026-006', 6, '2026-10-10', '2026-10-25', 399.00, 'Overdue', NULL),
    ('INV-2026-007', 7, '2026-11-01', '2026-11-15', 599.00, 'Pending', NULL),
    ('INV-2026-008', 8, '2026-11-01', '2026-11-15', 199.00, 'Paid', '2026-11-10'),
    ('INV-2026-009', 9, '2026-11-05', '2026-11-20', 799.00, 'Pending', NULL),
    ('INV-2026-010', 10, '2026-11-05', '2026-11-20', 399.00, 'Pending', NULL),
    ('INV-2026-011', 1, '2026-11-10', '2026-11-25', 599.00, 'Paid', '2026-11-12'),
    ('INV-2026-012', 4, '2026-11-10', '2026-11-25', 799.00, 'Pending', NULL);


-- Verify Inserted Data
SELECT * FROM Plans;
SELECT * FROM Subscribers;
SELECT * FROM CallRecords;
SELECT * FROM Invoices;

SELECT 'Plans' AS TableName, COUNT(*) AS TotalRecords FROM Plans;
SELECT 'Subscribers', COUNT(*) FROM Subscribers;
SELECT 'CallRecords', COUNT(*) FROM CallRecords;
SELECT 'Invoices', COUNT(*) FROM Invoices;


-- Query 1: Total Call Minutes per Plan
SELECT p.PlanID, p.PlanName, SUM(cr.CallMinutes) AS TotalCallMinutes, COUNT(cr.RecordID) AS TotalUsageRecords
    FROM Plans AS p
        INNER JOIN Subscribers AS s ON s.PlanID = p.PlanID
        INNER JOIN CallRecords AS cr ON cr.SubscriberID = s.SubscriberID
    GROUP BY p.PlanID, p.PlanName
    ORDER BY TotalCallMinutes DESC;


-- Query 2: Subscribers Exceeding their Data Limit
SELECT s.SubscriberID, UPPER(s.SubscriberName) AS SubscriberName, s.PhoneNumber, p.PlanName, p.DataLimitGB, SUM(cr.DataUsedGB) AS TotalDataUsedGB, ROUND(SUM(cr.DataUsedGB) - p.DataLimitGB, 2) AS ExcessDataGB
    FROM Subscribers AS s
        INNER JOIN Plans AS p ON p.PlanID = s.PlanID
        INNER JOIN CallRecords AS cr ON cr.SubscriberID = s.SubscriberID
    WHERE cr.CallDate >= '2026-11-01'
        AND cr.CallDate < '2026-12-01'
    GROUP BY s.SubscriberID,s.SubscriberName, s.PhoneNumber, p.PlanName, p.DataLimitGB
    HAVING SUM(cr.DataUsedGB) > p.DataLimitGB
    ORDER BY ExcessDataGB DESC;


-- Query 3: Month-wise Revenue
SELECT FORMAT(InvoiceDate, 'MMM yyyy') AS RevenueMonth, SUM(InvoiceAmount) AS TotalRevenue, COUNT(InvoiceID) AS TotalInvoices
    FROM Invoices
    WHERE PaymentStatus = 'Paid'
    GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate), FORMAT(InvoiceDate, 'MMM yyyy')
    ORDER BY YEAR(InvoiceDate), MONTH(InvoiceDate);


-- Query 4: Invoices Overdue by More Than 15 Days
SELECT InvoiceID, CONCAT('INV-', RIGHT(InvoiceNumber, 8)) AS FormattedInvoiceNumber, s.SubscriberName, i.InvoiceDate, i.DueDate, i.InvoiceAmount, DATEDIFF(DAY, i.DueDate, CAST(GETDATE() AS DATE)) AS DaysOverdue,
    CASE
        WHEN i.PaymentStatus = 'Paid' THEN 'Paid'
        WHEN i.DueDate < DATEADD(DAY, -15, CAST(GETDATE() AS DATE))
             THEN 'Overdue by more than 15 days'
        WHEN i.DueDate < CAST(GETDATE() AS DATE)
             THEN 'Overdue'
        ELSE 'Not Due'
    END AS DueDateStatus
    FROM Invoices AS i
        INNER JOIN Subscribers AS s ON s.SubscriberID = i.SubscriberID
    WHERE i.PaymentStatus <> 'Paid'
        AND i.DueDate < DATEADD(DAY, -15, CAST(GETDATE() AS DATE))
    ORDER BY i.DueDate;


-- Query 5: Subscribers with No Usage
SELECT s.SubscriberID, s.SubscriberName, s.PhoneNumber, p.PlanName, s.SubscriberStatus
    FROM Subscribers AS s
        INNER JOIN Plans AS p ON p.PlanID = s.PlanID
        LEFT JOIN CallRecords AS cr ON cr.SubscriberID = s.SubscriberID
    WHERE cr.RecordID IS NULL
    ORDER BY s.SubscriberID;


-- Query 6: Average Revenue Per User (ARPU) by Circle
SELECT s.Circle, COUNT(DISTINCT s.SubscriberID) AS TotalSubscribers,
    SUM(CASE WHEN i.PaymentStatus = 'Paid' THEN i.InvoiceAmount ELSE 0 END) AS TotalRevenue,
    ROUND(
    SUM(CASE WHEN i.PaymentStatus = 'Paid' THEN i.InvoiceAmount ELSE 0 END) / NULLIF(COUNT(DISTINCT s.SubscriberID), 0), 2) AS ARPU
        FROM Subscribers AS s
            LEFT JOIN Invoices AS i ON i.SubscriberID = s.SubscriberID
        GROUP BY s.Circle
        ORDER BY ARPU DESC;

-- Query 7: Plan Popularity
SELECT p.PlanID, p.PlanName, COUNT(s.SubscriberID) AS TotalSubscribers, ROUND(COUNT(s.SubscriberID) * 100.0 / (SELECT COUNT(*) FROM Subscribers), 2) AS PopularityPercentage
    FROM Plans AS p
        LEFT JOIN Subscribers AS s ON s.PlanID = p.PlanID
    GROUP BY p.PlanID, p.PlanName
    ORDER BY TotalSubscribers DESC;


-- Query 8: Top 10 Data Consumers
SELECT TOP 10 s.SubscriberID, s.SubscriberName, s.Circle, p.PlanName, SUM(cr.DataUsedGB) AS TotalDataUsedGB, p.DataLimitGB
    FROM Subscribers AS s
        INNER JOIN Plans AS p ON p.PlanID = s.PlanID
        INNER JOIN CallRecords AS cr ON cr.SubscriberID = s.SubscriberID
    GROUP BY s.SubscriberID, s.SubscriberName, s.Circle, p.PlanName, p.DataLimitGB
    ORDER BY TotalDataUsedGB DESC;


-- Demonstrating NULL Behaviour in SUM() and AVG()
SELECT s.SubscriberID, s.SubscriberName, COUNT(*) AS JoinedRows, COUNT(cr.RecordID) AS UsageRecords, SUM(cr.DataUsedGB) AS TotalDataUsedGB, AVG(cr.DataUsedGB) AS AverageDataUsedGB, COALESCE(SUM(cr.DataUsedGB), 0) AS DataUsedWithZero
    FROM Subscribers AS s
        LEFT JOIN CallRecords AS cr ON cr.SubscriberID = s.SubscriberID
    GROUP BY s.SubscriberID, s.SubscriberName
    ORDER BY s.SubscriberID;