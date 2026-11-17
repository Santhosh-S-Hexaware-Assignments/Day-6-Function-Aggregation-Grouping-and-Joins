-- Day 6 (Set 1) --

-- Creating and Switching Database
IF DB_ID('RetailSalesDB') IS NULL BEGIN
    CREATE DATABASE RetailSalesDB;
END; GO
USE RetailSalesDB;

-- Creating Tables
CREATE TABLE Customers (
    CustomerID       INT PRIMARY KEY IDENTITY(1, 1),
    CustomerName     NVARCHAR(100) NOT NULL,
    Email            NVARCHAR(100) NOT NULL UNIQUE,
    Phone            NVARCHAR(20) NOT NULL,
    City             NVARCHAR(50) NOT NULL
);

CREATE TABLE Products (
    ProductID        INT PRIMARY KEY IDENTITY(1, 1),
    ProductName      NVARCHAR(100) NOT NULL,
    Category         NVARCHAR(50) NOT NULL,
    UnitPrice        DECIMAL(10, 2) NOT NULL CHECK(UnitPrice >= 0)
);

CREATE TABLE Orders (
    OrderID          INT PRIMARY KEY IDENTITY(101, 1),
    CustomerID       INT NOT NULL REFERENCES Customers(CustomerID),
    OrderDate        DATE NOT NULL DEFAULT(GETDATE()),
    OrderStatus      NVARCHAR(20) NOT NULL DEFAULT('Placed')
                     CHECK(OrderStatus IN ('Placed', 'Shipped', 'Delivered', 'Cancelled'))
);

CREATE TABLE OrderItems (
    OrderItemID      INT PRIMARY KEY IDENTITY(1, 1),
    OrderID          INT NOT NULL REFERENCES Orders(OrderID) ON DELETE CASCADE,
    ProductID        INT NOT NULL REFERENCES Products(ProductID),
    Quantity         INT NOT NULL CHECK(Quantity > 0),
    UnitPrice        DECIMAL(10, 2) NOT NULL CHECK(UnitPrice >= 0)
);

CREATE TABLE Payments (
    PaymentID        INT PRIMARY KEY IDENTITY(1, 1),
    OrderID          INT NOT NULL UNIQUE REFERENCES Orders(OrderID),
    PaymentDate      DATE NOT NULL,
    Amount           DECIMAL(10, 2) NOT NULL CHECK(Amount >= 0),
    PaymentMethod    NVARCHAR(30) NOT NULL
);


-- Inserting Data

INSERT INTO Customers (CustomerName, Email, Phone, City) VALUES
    ('Arun Kumar', 'arun@gmail.com', '+91 90000 00001', 'Chennai'),
    ('Priya Sharma', 'priya@gmail.com', '+91 90000 00002', 'Coimbatore'),
    ('Rahul Verma', 'rahul@gmail.com', '+91 90000 00003', 'Chennai'),
    ('Sneha Reddy', 'sneha@gmail.com', '+91 90000 00004', 'Madurai'),
    ('Vikram Singh', 'vikram@gmail.com', '+91 90000 00005', 'Coimbatore'),
    ('Ananya Das', 'ananya@gmail.com', '+91 90000 00006', 'Chennai'),
    ('Karthik Raj', 'karthik@gmail.com', '+91 90000 00007', 'Trichy'),
    ('Meera Nair', 'meera@gmail.com', '+91 90000 00008', 'Madurai'),
    ('Aditya Rao', 'aditya@gmail.com', '+91 90000 00009', 'Coimbatore'),
    ('Divya Krishnan', 'divya@gmail.com', '+91 90000 00010', 'Salem');


INSERT INTO Products (ProductName, Category, UnitPrice) VALUES
    ('Wireless Mouse', 'Electronics', 799.00),
    ('Mechanical Keyboard', 'Electronics', 2499.00),
    ('USB-C Hub', 'Electronics', 1499.00),
    ('Office Chair', 'Furniture', 5999.00),
    ('Study Desk', 'Furniture', 7999.00),
    ('Notebook Pack', 'Stationery', 299.00),
    ('Pen Set', 'Stationery', 149.00),
    ('Water Bottle', 'Accessories', 499.00);


INSERT INTO Orders (CustomerID, OrderDate, OrderStatus) VALUES
    (1, '2026-10-01', 'Delivered'),
    (2, '2026-10-03', 'Delivered'),
    (1, '2026-10-05', 'Delivered'),
    (3, '2026-10-08', 'Shipped'),
    (4, '2026-10-12', 'Delivered'),
    (1, '2026-10-15', 'Delivered'),
    (5, '2026-10-15', 'Placed'),
    (6, '2026-10-20', 'Delivered'),
    (2, '2026-11-02', 'Delivered'),
    (1, '2026-11-05', 'Shipped'),
    (7, '2026-11-10', 'Placed'),
    (8, '2026-11-12', 'Placed');


INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES
    (101, 1, 2, 799.00),
    (101, 6, 3, 299.00),
    (102, 2, 1, 2499.00),
    (102, 7, 2, 149.00),
    (103, 3, 1, 1499.00),
    (103, 8, 2, 499.00),
    (104, 4, 1, 5999.00),
    (104, 6, 2, 299.00),
    (105, 5, 1, 7999.00),
    (105, 7, 3, 149.00),
    (106, 1, 1, 799.00),
    (106, 2, 1, 2499.00),
    (107, 8, 2, 499.00),
    (107, 6, 5, 299.00),
    (108, 3, 2, 1499.00),
    (108, 7, 4, 149.00),
    (109, 4, 1, 5999.00),
    (109, 1, 1, 799.00),
    (110, 5, 1, 7999.00),
    (110, 6, 4, 299.00),
    (111, 2, 1, 2499.00),
    (111, 8, 3, 499.00),
    (112, 1, 2, 799.00),
    (112, 7, 5, 149.00);


INSERT INTO Payments (OrderID, PaymentDate, Amount, PaymentMethod) VALUES
    (101, '2026-10-01', 2495.00, 'UPI'),
    (102, '2026-10-03', 2797.00, 'Card'),
    (103, '2026-10-05', 2497.00, 'UPI'),
    (105, '2026-10-12', 8446.00, 'Net Banking'),
    (106, '2026-10-15', 3298.00, 'Card'),
    (108, '2026-10-20', 3594.00, 'UPI'),
    (109, '2026-11-02', 6798.00, 'Card'),
    (110, '2026-11-05', 9195.00, 'Net Banking'),
    (112, '2026-11-12', 2343.00, 'UPI');


-- Verify Inserted Data

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderItems;
SELECT * FROM Payments;

SELECT 'Customers' AS TableName, COUNT(*) AS TotalRecords FROM Customers;
SELECT 'Products', COUNT(*) FROM Products;
SELECT 'Orders', COUNT(*) FROM Orders;
SELECT 'OrderItems', COUNT(*) FROM OrderItems;
SELECT 'Payments', COUNT(*) FROM Payments;


-- Query 1: Top 5 Products by Revenue
SELECT TOP 5 p.ProductID, p.ProductName, p.Category, SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue
    FROM Products AS p
        INNER JOIN OrderItems AS oi ON oi.ProductID = p.ProductID
        INNER JOIN Orders AS o ON o.OrderID = oi.OrderID
    WHERE o.OrderStatus <> 'Cancelled'
    GROUP BY p.ProductID, p.ProductName, p.Category
    ORDER BY TotalRevenue DESC;

-- Query 2: Month-wise Sales
SELECT FORMAT(o.OrderDate, 'MMM yyyy') AS SalesMonth, SUM(oi.Quantity * oi.UnitPrice) AS TotalSales, COUNT(DISTINCT o.OrderID) AS TotalOrders
    FROM Orders AS o
        INNER JOIN OrderItems AS oi ON oi.OrderID = o.OrderID
    WHERE o.OrderStatus <> 'Cancelled'
    GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate), FORMAT(o.OrderDate, 'MMM yyyy')
    ORDER BY YEAR(o.OrderDate), MONTH(o.OrderDate);

-- Query 3: Customers with More Than 3 Orders
SELECT c.CustomerID, UPPER(c.CustomerName) AS CustomerName, COUNT(o.OrderID) AS TotalOrders, CONCAT(c.City, ', India') AS CustomerLocation
    FROM Customers AS c
        INNER JOIN Orders AS o ON o.CustomerID = c.CustomerID
    GROUP BY c.CustomerID, c.CustomerName, c.City
    HAVING COUNT(o.OrderID) > 3
    ORDER BY TotalOrders DESC;

-- Query 4: Average Basket Value per City
WITH OrderTotals AS (
    SELECT o.OrderID, c.City, SUM(oi.Quantity * oi.UnitPrice) AS BasketValue
    FROM Orders AS o
        INNER JOIN Customers AS c ON c.CustomerID = o.CustomerID
        INNER JOIN OrderItems AS oi ON oi.OrderID = o.OrderID
    WHERE o.OrderStatus <> 'Cancelled'
    GROUP BY o.OrderID, c.City
) SELECT City, COUNT(OrderID) AS TotalOrders, ROUND(AVG(BasketValue), 2) AS AverageBasketValue
    FROM OrderTotals
    GROUP BY City
    ORDER BY AverageBasketValue DESC;

-- Query 5: Orders Without Payment using LEFT JOIN
SELECT  o.OrderID, CONCAT('ORD-', o.OrderID) AS OrderNumber, c.CustomerName, o.OrderDate, DATEDIFF(DAY, o.OrderDate, GETDATE()) AS DaysSinceOrder, o.OrderStatus
    FROM Orders AS o
        INNER JOIN Customers AS c ON c.CustomerID = o.CustomerID
        LEFT JOIN Payments AS p ON p.OrderID = o.OrderID
    WHERE p.PaymentID IS NULL
    ORDER BY o.OrderDate;

-- Query 6: Customers with No Orders
SELECT c.CustomerID, UPPER(c.CustomerName) AS CustomerName, CONCAT(c.City, ', India') AS CustomerLocation
    FROM Customers AS c
        LEFT JOIN Orders AS o ON o.CustomerID = c.CustomerID
    WHERE o.OrderID IS NULL
    ORDER BY c.CustomerID;

-- Query 7: Product-category Revenue Share
WITH CategoryRevenue AS (
    SELECT p.Category, SUM(oi.Quantity * oi.UnitPrice) AS CategoryRevenue
    FROM Products AS p
        INNER JOIN OrderItems AS oi ON oi.ProductID = p.ProductID
        INNER JOIN Orders AS o ON o.OrderID = oi.OrderID
    WHERE o.OrderStatus <> 'Cancelled'
    GROUP BY p.Category
) SELECT Category, CategoryRevenue, ROUND(CategoryRevenue * 100.0 / SUM(CategoryRevenue) OVER(), 2) AS RevenuePercentage
    FROM CategoryRevenue
    ORDER BY RevenuePercentage DESC;

-- Query 8: Day with the Highest Sales
SELECT TOP 1 FORMAT(o.OrderDate, 'dd MMM yyyy') AS SalesDate, SUM(oi.Quantity * oi.UnitPrice) AS TotalSales, COUNT(DISTINCT o.OrderID) AS TotalOrders
    FROM Orders AS o
        INNER JOIN OrderItems AS oi ON oi.OrderID = o.OrderID
    WHERE o.OrderStatus <> 'Cancelled'
    GROUP BY o.OrderDate
    ORDER BY TotalSales DESC;

-- NULL Behaviour in COUNT(*) , COUNT(Column) and AVG()
SELECT COUNT(*) AS TotalOrders, COUNT(p.PaymentID) AS PaidOrders, AVG(p.Amount) AS AveragePaymentAmount
    FROM Orders AS o
        LEFT JOIN Payments AS p ON p.OrderID = o.OrderID;