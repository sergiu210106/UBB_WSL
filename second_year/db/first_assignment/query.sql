USE master;
GO

ALTER DATABASE ElectronicSalesDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

DROP DATABASE ElectronicSalesDB;
GO  

CREATE DATABASE ElectronicSalesDB;
GO
USE ElectronicSalesDB;
GO  

CREATE TABLE ProductCategories (
    ID INT PRIMARY KEY,
    [Name] VARCHAR(50) NOT NULL UNIQUE,
    [Description] VARCHAR(255)
);


CREATE TABLE Manufacturers (
    ID INT PRIMARY KEY,
    [Name] VARCHAR(50) NOT NULL UNIQUE,
    Country VARCHAR(20)
);

CREATE TABLE Stores (
    ID INT PRIMARY KEY,
    [Name] VARCHAR(50) NOT NULL UNIQUE,
    [Address] VARCHAR(255)
);

CREATE TABLE Shippers (
    ID INT PRIMARY KEY,
    CompanyName VARCHAR(50) NOT NULL,
    Phone VARCHAR(20)
);

CREATE TABLE Products (
    ID INT PRIMARY KEY,
    [Name] VARCHAR(50) NOT NULL,
    MID INT NOT NULL, 
    CID INT NOT NULL,
    Model VARCHAR(50) UNIQUE,
    UnitPrice FLOAT NOT NULL,

    FOREIGN KEY (MID) REFERENCES Manufacturers(ID),
    FOREIGN KEY (CID) REFERENCES ProductCategories(ID) 
);

CREATE TABLE Customers (
    ID INT PRIMARY KEY, 
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    [Address] VARCHAR(255) 
);

CREATE TABLE Employees (
    ID INT PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    [SID] INT,
    Position VARCHAR(50),

    FOREIGN KEY ([SID]) REFERENCES Stores(ID)
);

CREATE TABLE Sales (
    ID INT PRIMARY KEY,
    CID INT NOT NULL,
    EID INT NOT NULL,
    [SID] INT,
    [Date] DATETIME,
    Amount FLOAT,
    [Status] VARCHAR(20),

    FOREIGN KEY (CID) REFERENCES Customers(ID),
    FOREIGN KEY (EID) REFERENCES Employees(ID),
    FOREIGN KEY ([SID]) REFERENCES Shippers(ID)
);

CREATE TABLE SaleDetails (
    ID INT PRIMARY KEY,
    SaleID INT NOT NULL,
    PID INT NOT NULL,
    QUANTITY INT NOT NULL,
    Price FLOAT NOT NULL,

    FOREIGN KEY (SaleID) REFERENCES Sales(ID),
    FOREIGN KEY (PID) REFERENCES Products(ID)
);

CREATE TABLE Inventory (
    ID INT PRIMARY KEY,
    PID INT NOT NULL,
    [SID] INT NOT NULL,
    Stock INT NOT NULL,
    LastUpdate DATETIME,

    FOREIGN KEY (PID) REFERENCES Products(ID),
    FOREIGN KEY ([SID]) REFERENCES Stores(ID)
);
GO 

-- =============================
-- INSERT DATA (Improved Version)
-- =============================

-- Product Categories
INSERT INTO ProductCategories (ID, [Name], [Description]) VALUES
(101, 'Laptops', 'High-Performance computing devices.'),
(102, 'Smartphones', 'Mobile communication and internet devices.'),
(103, 'Accessories', 'Peripherals and supporting devices'),
(104, 'Gaming Consoles', 'Dedicated gaming systems');

-- Manufacturers
INSERT INTO Manufacturers (ID, [Name], Country) VALUES 
(201, 'TechCorp', 'USA'),
(202, 'GlobalElectro', 'Japan'),
(203, 'EuroDevices', 'Germany'),
(204, 'DragonTech', 'China');

-- Stores
INSERT INTO Stores(ID, [Name], [Address]) VALUES 
(301, 'Iulius Mall', 'Str. Alexandru Vaida-Voevod 53B'),
(302, 'VIVO! Cluj-Napoca', 'Str. Avram Iancu 500'),
(303, 'Online E-Store', 'Virtual Plaza 99, Cloud City');

-- Shippers
INSERT INTO Shippers(ID, CompanyName, Phone) VALUES 
(401, 'Cargus', '0727347988'),
(402, 'FAN', '0773798231'),
(403, 'SameDay', '0768316731');

-- Customers
INSERT INTO Customers (ID, FirstName, LastName, Email, Phone, [Address]) VALUES 
(501, 'Alice', 'Smith', 'alice@mail.com', '555-1001', '10 Elm St'),
(502, 'Bob', 'Johnson', NULL, '555-1002', '20 Oak Ave'),
(503, 'Charlie', 'Brown', 'charlie@mail.com', '555-1003', '30 Pine Ln'),
(504, 'Jane', 'Doe', 'jane@mail.com', '555-1004', 'Str. Libertatii 45'),
(505, 'John', 'White', 'john@mail.com', '555-1005', 'Str. Memorandumului 99'),
(506, 'Andrew', 'Green', 'andrew@mail.com', NULL, '50 Birch Ct');

-- Employees
INSERT INTO Employees (ID, FirstName, LastName, [SID], Position) VALUES
(601, 'David', 'Lee', 301, 'Manager'),
(602, 'Eve', 'Adams', 301, 'Sales Associate'),
(603, 'Frank', 'Harris', 302, 'Tech Specialist'),
(604, 'Grace', 'Miller', 303, 'Online Support');

-- Products
INSERT INTO Products (ID, [Name], MID, CID, Model, UnitPrice) VALUES
(701, 'Laptop Pro X1', 201, 101, 'LP-X1', 1899.99),
(702, 'Laptop Budget A5', 202, 101, 'L-A5', 750.00),
(703, 'Smartphone S20', 201, 102, 'S20', 1099.99),
(704, 'Wireless Mouse', 203, 103, 'WM-01', 45.50), 
(705, 'Gaming Console Z', 202, 104, 'GZ-Pro', 499.99), 
(706, 'Tablet Lite', 201, 102, 'TL-02', 399.00),
(707, 'Gaming Console X', 204, 104, 'GX-01', 299.99), 
(708, 'Smartphone Ultra 9', 204, 102, 'U9', 2100.00),
(709, 'Laptop Eco C2', 203, 101, 'LE-C2', 520.00);

-- Inventory
INSERT INTO Inventory (ID, PID, [SID], Stock, LastUpdate) VALUES
(801, 701, 301, 15, GETDATE()),
(802, 702, 301, 20, GETDATE()),
(803, 703, 302, 10, GETDATE()),
(804, 704, 303, 100, GETDATE()),
(805, 705, 302, 5, GETDATE()),
(806, 706, 303, 25, GETDATE()),
(807, 707, 301, 30, GETDATE()),
(808, 708, 303, 2, GETDATE()),
(809, 709, 302, 12, GETDATE());

-- Sales
INSERT INTO Sales (ID, CID, EID, [SID], [Date], Amount, [Status]) VALUES
(901, 501, 602, 401, '2023-10-01', 1945.49, 'Completed'),
(902, 503, 601, 402, '2023-10-05', 750.00, 'Completed'),
(903, 501, 603, 401, '2023-10-10', 1099.99, 'Completed'),
(904, 504, 604, 403, '2023-10-15', 91.00, 'Shipped'), 
(905, 505, 602, 402, '2023-10-20', 499.99, 'Pending'),
(906, 506, 603, 403, '2023-11-01', 2100.00, 'Completed'),
(907, 505, 601, 401, '2023-11-02', 299.99, 'Completed');

-- SaleDetails
INSERT INTO SaleDetails (ID, SaleID, PID, QUANTITY, Price) VALUES
(1001, 901, 701, 1, 1899.99),
(1002, 902, 702, 1, 750.00),
(1003, 903, 703, 1, 1099.99),
(1004, 904, 704, 2, 45.50), 
(1005, 905, 705, 1, 499.99), 
(1006, 901, 704, 1, 45.50), 
(1007, 905, 706, 1, 399.00),
(1008, 906, 708, 1, 2100.00),
(1009, 907, 707, 1, 299.99);

-- UPDATES
-- slightly increase price for products using BETWEEN
UPDATE Products
SET UnitPrice = UnitPrice * 1.05
WHERE UnitPrice BETWEEN 200.00 AND 400.00;  



-- 2) update Employees to Position Senior Associate for all with names starting with F and excluding the ones working in stores with id 301 and 303

UPDATE Employees
SET Position = 'Senior Associate'
WHERE [SID] NOT IN (301, 303) AND FirstName LIKE 'F%';

SELECT * FROM Employees
GO
-- DELETE
-- delete customers with id 503 or 505 or NULL Email and id not 501
-- only delete customers who have no sales (avoid FK violation)
DELETE FROM Customers
WHERE (ID IN (503, 505) OR Email IS NULL)
  AND ID <> 501
  AND ID NOT IN (SELECT CID FROM Sales);

SELECT * FROM Customers;

GO
-- VIOLATION
INSERT INTO Sales (ID, CID, EID, [SID], [Date], Amount, [Status])
VALUES (9999, 99999, 601, 401, '2025-10-01', 50.00, 'Completed');

-- SELECT QUERIES --
    -- a) UNION && OR
    -- a.1) show all product names that are cheap or have Pro in the name, together with all product names that cost more than 2000

SELECT [Name] FROM Products 
WHERE UnitPrice < 500 OR [Name] LIKE '%Pro%'
UNION ALL
SELECT [Name] FROM Products 
WHERE UnitPrice > 2000
ORDER BY [Name];

    -- a.2) show all customer first names that start with 'A' or have no phone number, together with all customers who live on a street containing 'Str'

SELECT FirstName FROM Customers 
WHERE FirstName LIKE 'A%' OR Phone IS NULL 
UNION ALL 
SELECT FirstName FROM Customers 
WHERE [Address] LIKE '%Str%'
ORDER BY FirstName;

    -- INTERSECT && AND 
    -- b.1) Show products names that are both expensive ( > 1000) AND are made by Manufacturers from de USA

SELECT [Name] FROM Products 
WHERE UnitPrice > 1000 
INTERSECT
SELECT P.Name FROM Products P  
JOIN Manufacturers M on P.MID = M.ID 
WHERE M.Country = 'USA';
    -- b.2) INTERSECT
    -- Show customers who live on streets containing 'Str' AND who have made at least one sale
SELECT FirstName, LastName FROM Customers WHERE [Address] LIKE '%Str%'
INTERSECT
SELECT C.FirstName, C.LastName FROM Customers C
JOIN Sales S ON C.ID = S.CID;

    -- EXCEPT
    -- c.1) show all product names that belong to any category,
    -- except those made by manufacturers from 'china'

SELECT [Name] FROM Products 
EXCEPT 
SELECT P.Name FROM Products P
JOIN Manufacturers M ON P.MID = M.ID 
WHERE M.Country = 'China';

    -- NOT IN 
    -- c.2) Show all customers who have NOT made any sales.

SELECT FirstName, LastName FROM Customers 
WHERE ID NOT IN (SELECT CID FROM Sales);

    -- INNER JOIN 
    -- d.1) Show product name, category name and manufacturer name 

SELECT P.Name as ProductName, C.Name as Category, M.Name as Manufacturer FROM Products P  
INNER JOIN ProductCategories C ON P.CID = C.ID 
INNER JOIN Manufacturers M ON P.MID = M.ID 
ORDER BY P.Name;

    -- LEFT JOIN 
    -- d.2) show all customers and their sales if they exist 
SELECT C.FirstName, C.LastName, S.Amount FROM Customers C  
LEFT JOIN Sales S on C.ID = S.CID
ORDER BY C.LastName, C.FirstName;

    -- RIGHT JOIN 
    -- d.3) show all employees and the store they work in, even if some stores have no employees
SELECT E.FirstName, E.LastName, ST.Name AS StoreName 
FROM Employees E  
RIGHT JOIN Stores ST ON E.SID = ST.ID;

    -- FULL JOIN 
    -- d.4) show all possible links between sales, products, manufacturers and customers 

SELECT S.ID AS SaleID, C.FirstName, P.Name AS Product, M.Name as Manufacturer FROM Sales S  
FULL JOIN SaleDetails SD ON S.ID = SD.SaleID 
FULL JOIN Products P ON SD.PID = P.ID 
FULL JOIN Manufacturers M on P.MID = M.ID 
FULL JOIN Customers C ON S.CID = C.ID; 

    -- IN
    -- e.1) show all products sold in at least one sale

SELECT [Name] FROM Products 
WHERE ID in (SELECT PID FROM SaleDetails);

    -- Nested subquery
    -- e.2) show all customers who bought product made by manufacturers from 'USA'

SELECT FirstName, LastName FROM Customers 
WHERE ID IN (
    SELECT S.CID FROM Sales S  
    WHERE S.ID IN (
        SELECT SD.SaleID FROM SaleDetails SD 
        WHERE SD.PID IN (
            SELECT P.ID FROM Products P  
            INNER JOIN Manufacturers M ON P.MID = M.ID 
            WHERE M.Country = 'USA'
        )
    )
);

    -- EXISTS 
    -- f.1) show all customers who have at least one sale.
SELECT FirstName, LastName FROM Customers C  
WHERE EXISTS (
    SELECT 1 FROM Sales S  
    WHERE S.CID = C.ID
);

    -- subquery in FROM clause
    -- g.1) show average sale amount per customer, using a subquery in the FROM clause 

SELECT C.FirstName, C.LastName, T.AvgAmount FROM Customers C  
JOIN (
    SELECT CID, AVG(Amount) AS AvgAmount 
    FROM Sales 
    GROUP BY CID 
) AS T ON C.ID = T.CID 
ORDER BY T.AvgAmount DESC;

    -- GROUP BY 
    -- h.1) show total sales amount per employee 
SELECT EID, SUM(Amount) AS TotalSales FROM Sales 
GROUP BY EID
ORDER BY TotalSales DESC;

    -- GROUP BY with HAVING 
    -- h.2) show customers who made more than 2 purchases
SELECT CID, COUNT(ID) AS NumberOfSales FROM Sales 
GROUP BY CID 
HAVING COUNT(ID) > 2;

    -- GROUP BY with HAVING and subquery
    -- h.3) show manufacturers whose average product price is higher than the overall average 

SELECT M.Name AS Manufacturer, AVG(P.UnitPrice) AS AvgPrice FROM Products P  
JOIN Manufacturers M ON P.MID = M.ID 
GROUP BY M.Name 
HAVING AVG(P.UnitPrice) > (SELECT AVG(UnitPrice) FROM Products);

    -- ANY
    -- i.1) show products that are more expensive than any product in category 1
SELECT [Name], UnitPrice FROM Products 
WHERE UnitPrice > ANY (SELECT UnitPrice FROM Products WHERE CID = 1);

    -- ALL
    -- i.2) show products that are cheaper than all products made by manufacturer 2

SELECT [Name], UnitPrice FROM Products 
WHERE UnitPrice > ALL (SELECT UnitPrice FROM Products WHERE MID = 2);

    -- ANY with a different comparison
    -- i.3) show customers who spent equal to any sale amount made by employee 1  

SELECT DISTINCT C.FirstName, C.LastName FROM Customers C  
JOIN Sales S ON C.ID = S.CID
WHERE S.Amount = ANY (SELECT Amount FROM Sales WHERE EID = 1);

    -- ALL with inequality comparison 
    -- i.4) show employees who sold to all customers from the Sales table 

SELECT DISTINCT EID FROM Sales 
WHERE EID <> ALL (SELECT EID FROM Sales WHERE Amount > 0);


    -- rewritten i.1) : ANY -> MIN
SELECT [Name], UnitPrice FROM Products 
WHERE UnitPrice > (SELECT MIN(UnitPrice) FROM Products WHERE CID = 1);

    -- rewritten i.2) : ALL -> MIN
SELECT [Name], UnitPrice FROM Products
WHERE UnitPrice > (SELECT MAX(UnitPrice) FROM Products WHERE MID = 2);

    -- rewritten i.3) : ANY -> IN 
SELECT DISTINCT C.FirstName, C.LastName FROM Customers C  
JOIN Sales S ON C.ID = S.CID
WHERE S.Amount IN (SELECT Amount FROM Sales WHERE EID = 1);

    -- rewritten i.4) : ALL -> NOT IN
SELECT ID FROM Employees
WHERE ID NOT IN (
    SELECT EID FROM Sales
    WHERE Amount > 0
);

    -- composed AND, OR, NOT in the WHERE clause #1
SELECT Name, UnitPrice, Model FROM Products
WHERE (UnitPrice > 100 AND (Name LIKE '%Pro%' OR Model IS NULL))
  AND NOT (CID = 1)  
  AND Model NOT LIKE 'Second%' 
ORDER BY UnitPrice DESC;    
    -- # 2
SELECT FirstName, LastName, Email, Phone FROM Customers
WHERE (FirstName LIKE 'A%' OR Phone IS NULL)
  AND NOT (Address LIKE '%Bvd.%')
  AND ID <> 502  
ORDER BY LastName, FirstName;

    -- TOP 
SELECT TOP 3 C.FirstName, C.LastName, SUM(S.Amount) AS TotalSales FROM Customers C
JOIN Sales S ON C.ID = S.CID
GROUP BY C.FirstName, C.LastName
ORDER BY SUM(S.Amount) DESC;
GO