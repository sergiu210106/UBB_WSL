USE master;
GO
-- Drop the database if it exists to start fresh
IF DB_ID('Lab4_DB') IS NOT NULL
BEGIN
    ALTER DATABASE ElectronicSalesDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ElectronicSalesDB;
END
GO

-- Create the database
CREATE DATABASE ElectronicSalesDB;
GO

USE ElectronicSalesDB;
GO

-------------------------------------------------------------------
-- PART 1: ORIGINAL DATABASE SCHEMA (from the prompt)
-------------------------------------------------------------------
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

-------------------------------------------------------------------
-- PART 2: TESTING FRAMEWORK SCHEMA
-------------------------------------------------------------------
CREATE TABLE Tests (
    ID INT PRIMARY KEY IDENTITY(1,1),
    [Name] VARCHAR(100) NOT NULL UNIQUE,
    Description VARCHAR(255)
);

CREATE TABLE Tables (
    ID INT PRIMARY KEY IDENTITY(1,1),
    [Name] VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE TestTables (
    TestID INT NOT NULL,
    TableID INT NOT NULL,
    [Position] INT NOT NULL, -- Order for deletion
    NoOfRows INT NOT NULL,   -- Number of rows to insert
    PRIMARY KEY (TestID, TableID),
    FOREIGN KEY (TestID) REFERENCES Tests(ID) ON DELETE CASCADE,
    FOREIGN KEY (TableID) REFERENCES Tables(ID) ON DELETE CASCADE
);

CREATE TABLE Views (
    ID INT PRIMARY KEY IDENTITY(1,1),
    [Name] VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE TestViews (
    TestID INT NOT NULL,
    ViewID INT NOT NULL,
    PRIMARY KEY (TestID, ViewID),
    FOREIGN KEY (TestID) REFERENCES Tests(ID) ON DELETE CASCADE,
    FOREIGN KEY (ViewID) REFERENCES Views(ID) ON DELETE CASCADE
);

CREATE TABLE TestRuns (
    ID INT PRIMARY KEY IDENTITY(1,1),
    TestID INT NOT NULL,
    StartTime DATETIME NOT NULL DEFAULT GETDATE(),
    EndTime DATETIME,
    [Status] VARCHAR(20) NOT NULL DEFAULT 'Running',
    FOREIGN KEY (TestID) REFERENCES Tests(ID)
);

CREATE TABLE TestRunTables (
    ID INT PRIMARY KEY IDENTITY(1,1),
    TestRunID INT NOT NULL,
    TableID INT NOT NULL,
    ExecutionTimeMS INT NOT NULL,
    FOREIGN KEY (TestRunID) REFERENCES TestRuns(ID) ON DELETE CASCADE,
    FOREIGN KEY (TableID) REFERENCES Tables(ID)
);

CREATE TABLE TestRunViews (
    ID INT PRIMARY KEY IDENTITY(1,1),
    TestRunID INT NOT NULL,
    ViewID INT NOT NULL,
    ExecutionTimeMS INT NOT NULL,
    FOREIGN KEY (TestRunID) REFERENCES TestRuns(ID) ON DELETE CASCADE,
    FOREIGN KEY (ViewID) REFERENCES Views(ID)
);
GO

-------------------------------------------------------------------
-- PART 3: TEST VIEWS
-------------------------------------------------------------------
CREATE VIEW vw_SingleTable AS
SELECT 
    ID, 
    [Name] AS ProductName, 
    Model, 
    UnitPrice 
FROM 
    Products
WHERE 
    UnitPrice > 500;
GO

CREATE VIEW vw_ProductDetails AS
SELECT 
    p.ID AS ProductID,
    p.[Name] AS ProductName,
    m.[Name] AS Manufacturer,
    pc.[Name] AS Category
FROM 
    Products p
JOIN 
    Manufacturers m ON p.MID = m.ID
JOIN 
    ProductCategories pc ON p.CID = pc.ID;
GO

CREATE VIEW vw_SalesByCategory AS
SELECT 
    pc.[Name] AS CategoryName,
    COUNT(DISTINCT p.ID) AS NumberOfProductsSold,
    SUM(sd.Quantity * sd.Price) AS TotalRevenue
FROM 
    SaleDetails sd
JOIN 
    Products p ON sd.PID = p.ID
JOIN 
    ProductCategories pc ON p.CID = pc.ID
GROUP BY 
    pc.[Name];
GO

-------------------------------------------------------------------
-- PART 4: TEST CONFIGURATION
-------------------------------------------------------------------
-- Define a new test
INSERT INTO Tests ([Name], Description) VALUES ('Core Performance Test', 'Tests a self-contained set of tables and views.');
DECLARE @TestID INT = SCOPE_IDENTITY();

-- Register the tables we will use for testing, including all dependencies
INSERT INTO Tables ([Name]) VALUES ('ProductCategories'), ('Manufacturers'), ('Stores'), ('Products'), ('Inventory');
-- Register the views we will use for testing
INSERT INTO Views ([Name]) VALUES ('vw_SingleTable'), ('vw_ProductDetails'), ('vw_SalesByCategory');

-- Configure tables and their deletion order (Position)
INSERT INTO TestTables (TestID, TableID, [Position], NoOfRows)
VALUES 
    (@TestID, (SELECT ID FROM Tables WHERE [Name] = 'Inventory'), 0, 2000),          -- Delete 1st (child)
    (@TestID, (SELECT ID FROM Tables WHERE [Name] = 'Products'), 1, 1000),           -- Delete 2nd (child)
    (@TestID, (SELECT ID FROM Tables WHERE [Name] = 'Stores'), 2, 50),               -- Delete 3rd (parent)
    (@TestID, (SELECT ID FROM Tables WHERE [Name] = 'Manufacturers'), 3, 100),       -- Delete 4th (parent)
    (@TestID, (SELECT ID FROM Tables WHERE [Name] = 'ProductCategories'), 4, 20);     -- Delete 5th (parent)

-- Configure which views are part of our test
INSERT INTO TestViews (TestID, ViewID)
VALUES 
    (@TestID, (SELECT ID FROM Views WHERE [Name] = 'vw_SingleTable')),
    (@TestID, (SELECT ID FROM Views WHERE [Name] = 'vw_ProductDetails')),
    (@TestID, (SELECT ID FROM Views WHERE [Name] = 'vw_SalesByCategory'));
GO


USE ElectronicSalesDB; -- Use your correct database name
GO

-------------------------------------------------------------------
-- STEP 1: Robust Cleanup of ALL Previous Test Data
-------------------------------------------------------------------
PRINT N'Performing a robust cleanup of ALL previous test data...';
DECLARE @TestID_ToDelete INT;
SELECT @TestID_ToDelete = ID FROM Tests WHERE [Name] = 'Core Performance Test';
IF @TestID_ToDelete IS NOT NULL
BEGIN
    PRINT N'Found TestID to delete: ' + CAST(@TestID_ToDelete AS VARCHAR(10));
    DELETE TRV FROM TestRunViews TRV JOIN TestRuns TR ON TRV.TestRunID = TR.ID WHERE TR.TestID = @TestID_ToDelete;
    DELETE TRT FROM TestRunTables TRT JOIN TestRuns TR ON TRT.TestRunID = TR.ID WHERE TR.TestID = @TestID_ToDelete;
    DELETE FROM TestRuns WHERE TestID = @TestID_ToDelete;
    DELETE FROM Tests WHERE ID = @TestID_ToDelete; -- Cascades to TestTables/TestViews
    PRINT N'Deleted all data for the old test.';
END
ELSE
BEGIN
    PRINT N'Test "Core Performance Test" not found, no cleanup needed for Tests.';
END
-- Clean up all previously registered tables and views
DELETE FROM Tables WHERE [Name] IN ('ProductCategories', 'Manufacturers', 'Stores', 'Products', 'Inventory', 'Employees');
DELETE FROM Views WHERE [Name] IN ('vw_SingleTable', 'vw_ProductDetails', 'vw_SalesByCategory');
PRINT N'Cleanup complete.';
GO

-------------------------------------------------------------------
-- STEP 2: Configure the NEW, Self-Contained Test
-------------------------------------------------------------------
PRINT N'Setting up the new, self-contained test configuration...';
INSERT INTO Tests ([Name], Description) VALUES ('Core Performance Test', 'Tests a self-contained set of tables and views.');
DECLARE @TestID INT = SCOPE_IDENTITY();

-- Register ONLY the tables needed for this self-contained test
INSERT INTO Tables ([Name]) VALUES ('ProductCategories'), ('Manufacturers'), ('Stores'), ('Products'), ('Inventory');
-- Register the views we will use for testing
INSERT INTO Views ([Name]) VALUES ('vw_SingleTable'), ('vw_ProductDetails'), ('vw_SalesByCategory');

-- Configure tables and their deletion order (Position)
-- NOTE: Employees, Sales, etc. are removed.
INSERT INTO TestTables (TestID, TableID, [Position], NoOfRows)
VALUES 
    (@TestID, (SELECT ID FROM Tables WHERE [Name] = 'Inventory'), 0, 2000),          -- Delete 1st (child)
    (@TestID, (SELECT ID FROM Tables WHERE [Name] = 'Products'), 1, 1000),           -- Delete 2nd (child)
    (@TestID, (SELECT ID FROM Tables WHERE [Name] = 'Stores'), 2, 50),               -- Delete 3rd (parent)
    (@TestID, (SELECT ID FROM Tables WHERE [Name] = 'Manufacturers'), 3, 100),       -- Delete 4th (parent)
    (@TestID, (SELECT ID FROM Tables WHERE [Name] = 'ProductCategories'), 4, 20);     -- Delete 5th (parent)

-- Configure which views are part of our test
INSERT INTO TestViews (TestID, ViewID)
VALUES 
    (@TestID, (SELECT ID FROM Views WHERE [Name] = 'vw_SingleTable')),
    (@TestID, (SELECT ID FROM Views WHERE [Name] = 'vw_ProductDetails')),
    (@TestID, (SELECT ID FROM Views WHERE [Name] = 'vw_SalesByCategory'));
PRINT N'Configuration setup complete.';
GO

-------------------------------------------------------------------
-- STEP 3: Final Stored Procedure (No more changes needed)
-------------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_RunTest
    @TestName VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @TestID INT, @TestRunID INT, @TableName VARCHAR(50), @TableID INT, @NoOfRows INT, @ViewName VARCHAR(50), @ViewID INT, @sql NVARCHAR(MAX);
    SELECT @TestID = ID FROM Tests WHERE [Name] = @TestName;
    IF @TestID IS NULL BEGIN RAISERROR('Test with name "%s" not found.', 16, 1, @TestName); RETURN; END
    INSERT INTO TestRuns (TestID, [Status]) VALUES (@TestID, 'Running');
    SET @TestRunID = SCOPE_IDENTITY();
    PRINT N'Starting Test Run with ID: ' + CAST(@TestRunID AS VARCHAR(10));
    
    -- Disable Constraints
    PRINT N'Step 0: Disabling constraints...';
    DECLARE disable_cursor CURSOR FOR SELECT T.[Name] FROM TestTables TT JOIN Tables T ON TT.TableID = T.ID WHERE TT.TestID = @TestID;
    OPEN disable_cursor; FETCH NEXT FROM disable_cursor INTO @TableName;
    WHILE @@FETCH_STATUS = 0 BEGIN SET @sql = N'ALTER TABLE ' + QUOTENAME(@TableName) + ' NOCHECK CONSTRAINT ALL;'; EXEC sp_executesql @sql; FETCH NEXT FROM disable_cursor INTO @TableName; END
    CLOSE disable_cursor; DEALLOCATE disable_cursor;

    -- Delete Data
    PRINT N'Step 1: Deleting data...';
    DECLARE delete_cursor CURSOR FOR SELECT T.[Name], T.ID FROM TestTables TT JOIN Tables T ON TT.TableID = T.ID WHERE TT.TestID = @TestID ORDER BY TT.[Position] ASC;
    OPEN delete_cursor; FETCH NEXT FROM delete_cursor INTO @TableName, @TableID;
    WHILE @@FETCH_STATUS = 0 BEGIN SET @sql = N'DELETE FROM ' + QUOTENAME(@TableName); EXEC sp_executesql @sql; FETCH NEXT FROM delete_cursor INTO @TableName, @TableID; END
    CLOSE delete_cursor; DEALLOCATE delete_cursor;

    -- Insert Data
    PRINT N'Step 2: Inserting data...';
    DECLARE insert_cursor CURSOR FOR SELECT T.[Name], T.ID, TT.NoOfRows FROM TestTables TT JOIN Tables T ON TT.TableID = T.ID WHERE TT.TestID = @TestID ORDER BY TT.[Position] DESC;
    OPEN insert_cursor; FETCH NEXT FROM insert_cursor INTO @TableName, @TableID, @NoOfRows;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT N'  Inserting ' + CAST(@NoOfRows AS VARCHAR(10)) + ' rows into ' + @TableName;
        DECLARE @InsertStartTime DATETIME = GETDATE(); DECLARE @i INT = 1;
        WHILE @i <= @NoOfRows
        BEGIN
            -- NOTE: The Employees case is removed.
            SET @sql = 
                CASE @TableName
                    WHEN 'ProductCategories' THEN N'INSERT INTO ProductCategories (ID, Name) VALUES (' + CAST(@i AS VARCHAR(10)) + ', ''Category ' + CAST(@i AS VARCHAR(10)) + ''');'
                    WHEN 'Manufacturers' THEN N'INSERT INTO Manufacturers (ID, Name, Country) VALUES (' + CAST(@i AS VARCHAR(10)) + ', ''Mfg ' + CAST(@i AS VARCHAR(10)) + ''', ''Country_' + CAST(@i % 20 + 1 AS VARCHAR(10)) + ''');'
                    WHEN 'Stores' THEN N'INSERT INTO Stores (ID, Name, Address) VALUES (' + CAST(@i AS VARCHAR(10)) + ', ''Store ' + CAST(@i AS VARCHAR(10)) + ''', ''Address ' + CAST(@i AS VARCHAR(10)) + ''');'
                    WHEN 'Products' THEN N'INSERT INTO Products (ID, Name, MID, CID, Model, UnitPrice) VALUES (' + CAST(@i AS VARCHAR(10)) + ', ''Product ' + CAST(@i AS VARCHAR(10)) + ''', ' + CAST((@i % 100 + 1) AS VARCHAR(10)) + ', ' + CAST((@i % 20 + 1) AS VARCHAR(10)) + ', ''Model_' + CAST(@i AS VARCHAR(10)) + ''', ' + CAST((@i * 10.5 + 50) AS VARCHAR(20)) + ');'
                    WHEN 'Inventory' THEN N'INSERT INTO Inventory (ID, PID, SID, Stock, LastUpdate) VALUES (' + CAST(@i AS VARCHAR(10)) + ', ' + CAST((@i % 1000 + 1) AS VARCHAR(10)) + ', ' + CAST((@i % 50 + 1) AS VARCHAR(10)) + ', ' + CAST((@i * 5 + 10) AS VARCHAR(10)) + ', GETDATE());'
                    ELSE N''
                END;
            IF @sql <> N'' EXEC sp_executesql @sql; SET @i = @i + 1;
        END
        INSERT INTO TestRunTables (TestRunID, TableID, ExecutionTimeMS) VALUES (@TestRunID, @TableID, DATEDIFF(millisecond, @InsertStartTime, GETDATE()));
        FETCH NEXT FROM insert_cursor INTO @TableName, @TableID, @NoOfRows;
    END
    CLOSE insert_cursor; DEALLOCATE insert_cursor;

    -- Re-enable Constraints
    PRINT N'Step 3: Re-enabling and checking constraints...';
    DECLARE enable_cursor CURSOR FOR SELECT T.[Name] FROM TestTables TT JOIN Tables T ON TT.TableID = T.ID WHERE TT.TestID = @TestID;
    OPEN enable_cursor; FETCH NEXT FROM enable_cursor INTO @TableName;
    WHILE @@FETCH_STATUS = 0 BEGIN SET @sql = N'ALTER TABLE ' + QUOTENAME(@TableName) + ' WITH CHECK CHECK CONSTRAINT ALL;'; EXEC sp_executesql @sql; FETCH NEXT FROM enable_cursor INTO @TableName; END
    CLOSE enable_cursor; DEALLOCATE enable_cursor;

    -- Evaluate Views
    PRINT N'Step 4: Evaluating views...';
    DECLARE view_cursor CURSOR FOR SELECT V.[Name], V.ID FROM TestViews TV JOIN Views V ON TV.ViewID = V.ID WHERE TV.TestID = @TestID;
    OPEN view_cursor; FETCH NEXT FROM view_cursor INTO @ViewName, @ViewID;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @ViewStartTime DATETIME = GETDATE(); SET @sql = N'SELECT * FROM ' + QUOTENAME(@ViewName); EXEC sp_executesql @sql;
        INSERT INTO TestRunViews (TestRunID, ViewID, ExecutionTimeMS) VALUES (@TestRunID, @ViewID, DATEDIFF(millisecond, @ViewStartTime, GETDATE()));
        FETCH NEXT FROM view_cursor INTO @ViewName, @ViewID;
    END
    CLOSE view_cursor; DEALLOCATE view_cursor;

    -- Finalize
    UPDATE TestRuns SET EndTime = GETDATE(), [Status] = 'Completed' WHERE ID = @TestRunID;
    PRINT N'Test Run completed successfully.';
END
GO

-------------------------------------------------------------------
-- STEP 4: Execute the test and verify the results
-------------------------------------------------------------------
PRINT N'Running the final, clean test...';
EXEC sp_RunTest 'Core Performance Test';
GO

PRINT N'Verifying the results...';
PRINT N'--- VERIFICATION ---';
PRINT N'Recent Test Runs:';
SELECT tr.ID AS TestRunID, t.[Name] AS TestName, tr.StartTime, tr.EndTime, DATEDIFF(second, tr.StartTime, tr.EndTime) AS DurationSeconds, tr.[Status]
FROM TestRuns tr JOIN Tests t ON tr.TestID = t.ID ORDER BY tr.StartTime DESC;

PRINT N''; PRINT N'Performance for Table Inserts:';
SELECT trt.TestRunID, T.[Name] AS TableName, trt.ExecutionTimeMS
FROM TestRunTables trt JOIN Tables T ON trt.TableID = T.ID
WHERE trt.TestRunID = (SELECT TOP 1 ID FROM TestRuns ORDER BY ID DESC) ORDER BY T.[Name];

PRINT N''; PRINT N'Performance for View Evaluations:';
SELECT trv.TestRunID, V.[Name] AS ViewName, trv.ExecutionTimeMS
FROM TestRunViews trv JOIN Views V ON trv.ViewID = V.ID
WHERE trv.TestRunID = (SELECT TOP 1 ID FROM TestRuns ORDER BY ID DESC) ORDER BY V.[Name];
GO