/* ================================================================================
LAB 5: SQL SERVER OBJECTS (PROCEDURES, FUNCTIONS, VIEWS, TRIGGERS, INDEXES)
================================================================================
*/

USE ElectronicSalesDB;
GO

--------------------------------------------------------------------------------
-- a. FUNCTIONS & STORED PROCEDURES (CRUD with 1-n Relationship)
-- Relationship: ProductCategories (1) -> Products (n)
--------------------------------------------------------------------------------

-- 1. FUNCTION: Validate that a price is positive
CREATE OR ALTER FUNCTION dbo.ufn_ValidatePrice (@Price FLOAT)
RETURNS INT
AS
BEGIN
    DECLARE @Status INT;
    IF @Price > 0 SET @Status = 1;
    ELSE SET @Status = 0;
    RETURN @Status;
END;
GO

-- 2. FUNCTION: Validate that a name is not empty or numeric
CREATE OR ALTER FUNCTION dbo.ufn_ValidateName (@Name VARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @Status INT;
    -- Returns 1 if valid (not empty and contains letters), 0 otherwise
    IF @Name IS NOT NULL AND LEN(LTRIM(RTRIM(@Name))) > 0 AND @Name LIKE '%[a-zA-Z]%'
        SET @Status = 1;
    ELSE
        SET @Status = 0;
    RETURN @Status;
END;
GO

-- 3. STORED PROCEDURE: CRUD for Products
-- This encapsulates the 1-n logic by allowing category association by name or ID
CREATE OR ALTER PROCEDURE dbo.usp_ManageProduct
    @Action VARCHAR(10), -- 'CREATE', 'READ', 'UPDATE', 'DELETE'
    @ProductID INT = NULL,
    @Name VARCHAR(50) = NULL,
    @MID INT = NULL,
    @CID INT = NULL,
    @Model VARCHAR(50) = NULL,
    @UnitPrice FLOAT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action IN ('CREATE', 'UPDATE')
    BEGIN
        IF dbo.ufn_ValidatePrice(@UnitPrice) = 0
        BEGIN
            RAISERROR('Invalid Price: Must be greater than 0.', 16, 1);
            RETURN;
        END
        
        IF dbo.ufn_ValidateName(@Name) = 0
        BEGIN
            RAISERROR('Invalid Name: Must contain characters and not be empty.', 16, 1);
            RETURN;
        END
    END

    -- CREATE
    IF @Action = 'CREATE'
    BEGIN
        INSERT INTO Products (ID, [Name], MID, CID, Model, UnitPrice)
        VALUES (@ProductID, @Name, @MID, @CID, @Model, @UnitPrice);
        PRINT 'Product created successfully.';
    END

    -- READ
    ELSE IF @Action = 'READ'
    BEGIN
        IF @ProductID IS NOT NULL
            SELECT * FROM Products WHERE ID = @ProductID;
        ELSE
            SELECT * FROM Products;
    END

    -- UPDATE
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Products 
        SET [Name] = @Name, MID = @MID, CID = @CID, Model = @Model, UnitPrice = @UnitPrice
        WHERE ID = @ProductID;
        PRINT 'Product updated successfully.';
    END

    -- DELETE
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Products WHERE ID = @ProductID;
        PRINT 'Product deleted successfully.';
    END
END;
GO

--------------------------------------------------------------------------------
-- b. VIEW (Data from 4 Tables)
-- Tables: Sales, Customers, Employees, Stores
--------------------------------------------------------------------------------

CREATE OR ALTER VIEW dbo.vw_SalesPerformanceDetail AS
SELECT 
    S.ID AS SaleID,
    S.[Date] AS SaleDate,
    C.FirstName + ' ' + C.LastName AS CustomerName,
    E.FirstName + ' ' + E.LastName AS EmployeeName,
    ST.[Name] AS StoreName,
    S.Amount,
    S.[Status]
FROM Sales S
JOIN Customers C ON S.CID = C.ID
JOIN Employees E ON S.EID = E.ID
JOIN Stores ST ON E.[SID] = ST.ID;
GO

-- Query the view for useful information: Total sales per store
SELECT StoreName, COUNT(SaleID) AS TotalTransactions, SUM(Amount) AS TotalRevenue
FROM dbo.vw_SalesPerformanceDetail
WHERE [Status] = 'Completed'
GROUP BY StoreName;
GO

--------------------------------------------------------------------------------
-- c. TRIGGER (Audit Log for SaleDetails)
--------------------------------------------------------------------------------

-- 1. Create the Log Table
IF OBJECT_ID('TableAuditLog', 'U') IS NULL
CREATE TABLE TableAuditLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    EventDate DATETIME DEFAULT GETDATE(),
    TriggerType VARCHAR(20),
    TableName VARCHAR(50),
    AffectedRecords INT
);
GO

-- 2. Create the Trigger
CREATE OR ALTER TRIGGER trg_SaleDetails_Audit
ON SaleDetails
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @Count INT = 0;
    DECLARE @Type VARCHAR(20);

    IF EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
    BEGIN
        SET @Type = 'UPDATE';
        SELECT @Count = COUNT(*) FROM inserted;
    END
    ELSE IF EXISTS(SELECT * FROM inserted)
    BEGIN
        SET @Type = 'INSERT';
        SELECT @Count = COUNT(*) FROM inserted;
    END
    ELSE
    BEGIN
        SET @Type = 'DELETE';
        SELECT @Count = COUNT(*) FROM deleted;
    END

    INSERT INTO TableAuditLog (TriggerType, TableName, AffectedRecords)
    VALUES (@Type, 'SaleDetails', @Count);
END;
GO

--------------------------------------------------------------------------------
-- d. INDEXES & EXECUTION PLAN OPERATORS
--------------------------------------------------------------------------------

-- Create a non-clustered index on Product names to facilitate seeks
CREATE NONCLUSTERED INDEX IX_Products_Name ON Products([Name]);
GO


-- Insert Initial Products (Using the Stored Procedure)
EXEC dbo.usp_ManageProduct 'CREATE', 10, 'iPhone 15', 1, 1, 'A3090', 999.99;
EXEC dbo.usp_ManageProduct 'CREATE', 20, 'Galaxy S23', 2, 1, 'SM-S911', 799.99;
EXEC dbo.usp_ManageProduct 'CREATE', 30, 'WH-1000XM5', 3, 3, 'SONY-WH1000', 349.99;

SELECT * FROM TableAuditLog;
SELECT * FROM dbo.vw_SalesPerformanceDetail;
-- This should throw an error because price <= 0
EXEC dbo.usp_ManageProduct 'UPDATE', @ProductID = 10, @Name = 'iPhone 15', @UnitPrice = -50;

/* ================================================================================
STEP 3: EXECUTION PLAN VERIFICATION
================================================================================ */

-- 1. CLUSTERED INDEX SCAN: Reads the entire clustered index (PK on ID).
SELECT * FROM Manufacturers;

-- 2. CLUSTERED INDEX SEEK: Uses the primary key (PK on ID) to jump directly to a row.
SELECT * FROM Products WHERE ID = 10;

-- 3. NONCLUSTERED INDEX SCAN: Reads the entire leaf level of the nonclustered index (IX_Products_Name).
SELECT [Name] FROM Products ORDER BY [Name];

-- 4. NONCLUSTERED INDEX SEEK: Uses the nonclustered index (IX_Products_Name) to jump directly to a row.
SELECT [Name] FROM Products WHERE [Name] = 'Product 10';

-- 5. KEY LOOKUP: Seeks the name in the nonclustered index, then performs a lookup to the clustered index to retrieve the missing column (UnitPrice).
SELECT [Name], UnitPrice FROM Products WHERE [Name] = 'Product 10';
GO
