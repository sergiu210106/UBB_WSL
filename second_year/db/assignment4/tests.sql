-- create structure

use ElectronicSalesDB
CREATE TABLE Tests (
    ID INT PRIMARY KEY IDENTITY,
    [Name] VARCHAR(20),
    [Description] VARCHAR(255)
);

CREATE TABLE Tables (
    ID INT PRIMARY KEY IDENTITY,
    [Name] VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE TestTables (
    TestID INT FOREIGN KEY REFERENCES Tests(ID),
    TableID INT FOREIGN KEY REFERENCES Tables(ID),
    Position INT NOT NULL,                          -- deletion order
    NumberOfRows INT NOT NULL,                      -- rows to insert
    PRIMARY KEY (TestId, TableID)
);

CREATE TABLE Views (
    ID INT PRIMARY KEY IDENTITY,
    [Name] VARCHAR(100) UNIQUE NOT NULL 
)

CREATE TABLE TestViews (
    TestID INT FOREIGN KEY REFERENCES Tests(ID),
    ViewID INT FOREIGN KEY REFERENCES Views(ID),
    PRIMARY KEY (TestID, ViewID)
)

CREATE TABLE TestRuns ( 
    ID INT PRIMARY KEY IDENTITY,
    TestID INT FOREIGN KEY REFERENCES Tests(ID),
    [Date] DATETIME DEFAULT GETDATE()
);

CREATE TABLE TestRunTables (
    TestRunID INT FOREIGN KEY REFERENCES TestRuns(ID),
    TableID INT FOREIGN KEY REFERENCES Tables(ID),
    InsertTimeMs FLOAT,
    PRIMARY KEY (TestRunID, TableID)
);

CREATE TABLE TestRunViews (
    TestRunID INT FOREIGN KEY REFERENCES TestRuns(ID),
    ViewID INT FOREIGN KEY REFERENCES Views(ID),
    EvalTimeMs FLOAT,
    PRIMARY KEY (TestRunID, ViewID)
);
GO

-- 3 tables 
--  1. single column PK, no FKs -> use ProductCategories 
--  2. single column PK, FK -> use Products
-- 3. multi-column PK

CREATE TABLE WareHouseStock (
    PID INT NOT NULL,
    [SID] INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 0,
    PRIMARY KEY (PID, [SID]),
    FOREIGN KEY (PID) REFERENCES Products(ID),
    FOREIGN KEY ([SID]) REFERENCES Stores(ID)
);
GO 
-- VIEWS  
-- View selecting from one table
CREATE VIEW View_Products AS SELECT ID, Name, UnitPrice FROM Products;
GO  
-- View selecting from >= 2 tables
CREATE VIEW View_ProductManufacturers AS 
SELECT P.Name as ProductName, M.Name as Manufacturer, P.UnitPrice 
FROM Products P
JOIN Manufacturers M on P.MID = M.ID;
GO  
-- View using group by across >= 2 tables
CREATE VIEW View_SalesByStore as SELECT S.Name as StoreName, SUM(I.Stock) as TotalStock FROM Inventory I  
JOIN Stores S on I.SID = S.ID 
GROUP BY S.Name;
GO
-- insert tables and views
INSERT INTO Tables (Name) VALUES 
('ProductCategories'), ('Products'), ('WarehouseStock');
GO  

INSERT INTO Views(Name) VALUES 
('View_Products'), ('View_ProductManufacturers'), ('View_SalesByStore')

-- create a test definition
INSERT INTO Tests([Name], [Description]) VALUES 
('Performance Test 1', 'Testing inserts & view evaluation');
GO  

DECLARE @TestID INT = SCOPE_IDENTITY();

INSERT INTO Tables(Name) VALUES ('SaleDetails'), ('Sales'), ('Inventory')

INSERT INTO TestTables VALUES 
(@TestID, 3, 1, 2000),  -- WarehouseStock 
(@TestID, 2, 2, 1000),  -- Products
(@TestID, 1, 3, 500);   -- ProductCategories 

INSERT INTO TestViews VALUES 
(@TestID, 1),
(@TestID, 2),
(@TestID, 3);
GO

CREATE OR ALTER PROCEDURE RunTest @TestID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RunID INT;
    INSERT INTO TestRuns(TestID) VALUES (@TestID);
    SET @RunID = SCOPE_IDENTITY();


    ------------------------------------------------------------------
    -- Fix DB prerequisites for FK-safe inserts
    ------------------------------------------------------------------
    IF NOT EXISTS (SELECT 1 FROM Manufacturers WHERE ID = 1)
        INSERT INTO Manufacturers VALUES(1, 'M1', 'USA');

    IF NOT EXISTS (SELECT 1 FROM ProductCategories WHERE ID = 1)
        INSERT INTO ProductCategories VALUES(1, 'DefaultCat', 'default');

    IF NOT EXISTS (SELECT 1 FROM Stores WHERE ID = 1)
        INSERT INTO Stores VALUES(1, 'Store1', 'Address');
    

    ------------------------------------------------------------------
    -- Clear dependent children first
    ------------------------------------------------------------------
    DELETE FROM SaleDetails;
    DELETE FROM Sales;
    DELETE FROM Inventory;
    DELETE FROM WareHouseStock;


    ------------------------------------------------------------------
    -- DELETE TABLE DATA (TestTables order ASC)
    ------------------------------------------------------------------
    DECLARE @TableName SYSNAME;

    DECLARE delCur CURSOR FAST_FORWARD FOR
        SELECT Tbl.Name
        FROM TestTables TT
        JOIN Tables Tbl ON TT.TableID = Tbl.ID
        WHERE TT.TestID = @TestID
        ORDER BY TT.Position;

    OPEN delCur;
    FETCH NEXT FROM delCur INTO @TableName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC('DELETE FROM ' + @TableName);
        FETCH NEXT FROM delCur INTO @TableName;
    END

    CLOSE delCur;
    DEALLOCATE delCur;


    ------------------------------------------------------------------
    -- INSERT DATA (reverse order)
    ------------------------------------------------------------------
    DECLARE @TableID INT, @Rows INT, @i INT;
    DECLARE @Start DATETIME2, @End DATETIME2;

    DECLARE insCur CURSOR FAST_FORWARD FOR
        SELECT TT.TableID, Tbl.Name, TT.NumberOfRows
        FROM TestTables TT
        JOIN Tables Tbl ON Tbl.ID = TT.TableID
        WHERE TT.TestID = @TestID
        ORDER BY TT.Position DESC;

    OPEN insCur;
    FETCH NEXT FROM insCur INTO @TableID, @TableName, @Rows;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @Start = SYSUTCDATETIME();
        SET @i = 1;

        ------------------------------------------------------
        IF @TableName = 'ProductCategories'
        BEGIN
            WHILE @i <= @Rows
            BEGIN
                INSERT INTO ProductCategories(ID, Name, Description)
                VALUES(@i + 1000, 'Cat' + CAST(@i AS VARCHAR), 'Auto');
                SET @i += 1;
            END
        END
        ------------------------------------------------------
        ELSE IF @TableName = 'Products'
        BEGIN
            WHILE @i <= @Rows
            BEGIN
                INSERT INTO Products(ID, Name, MID, CID, Model, UnitPrice)
                VALUES(
                    @i + 2000,
                    'Prod' + CAST(@i AS VARCHAR),
                    1,
                    1,
                    'Model' + CAST(@i AS VARCHAR),
                    10
                );
                SET @i += 1;
            END
        END
        ------------------------------------------------------
        ELSE IF @TableName = 'WareHouseStock'
        BEGIN
            WHILE @i <= @Rows
            BEGIN
                INSERT INTO WareHouseStock(PID, SID, Quantity)
                VALUES(1, 1, 50);
                SET @i += 1;
            END
        END
        ------------------------------------------------------

        SET @End = SYSUTCDATETIME();
        
        INSERT INTO TestRunTables(TestRunID, TableID, InsertTimeMs)
        VALUES(@RunID, @TableID, DATEDIFF(ms, @Start, @End));

        FETCH NEXT FROM insCur INTO @TableID, @TableName, @Rows;
    END

    CLOSE insCur;
    DEALLOCATE insCur;


    ------------------------------------------------------------------
    -- Evaluate views
    ------------------------------------------------------------------
    DECLARE @ViewID INT, @ViewName SYSNAME;

    DECLARE viewCur CURSOR FAST_FORWARD FOR
        SELECT V.ID, V.Name
        FROM TestViews TV
        JOIN Views V ON TV.ViewID = V.ID
        WHERE TV.TestID = @TestID;

    OPEN viewCur;
    FETCH NEXT FROM viewCur INTO @ViewID, @ViewName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @Start = SYSUTCDATETIME();
        EXEC('SELECT * FROM ' + @ViewName);
        SET @End = SYSUTCDATETIME();

        INSERT INTO TestRunViews VALUES
        (@RunID, @ViewID, DATEDIFF(ms, @Start, @End));

        FETCH NEXT FROM viewCur INTO @ViewID, @ViewName;
    END

    CLOSE viewCur;
    DEALLOCATE viewCur;

END;
GO

EXEC RunTest @TestID = 1;
