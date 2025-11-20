USE ElectronicSalesDB;
GO

---------------------------------------------------------
-- VERSION TABLE
---------------------------------------------------------
CREATE TABLE DBVersion(
    VersionNo INT PRIMARY KEY
);
INSERT INTO DBVersion VALUES(1);
GO


/* ======================================================
   =============== VERSION 2: ALTER COLUMN ===============
   Change column length: Customers.Email from 100 → 150
   ====================================================== */
CREATE PROCEDURE sp_v2_alter_column AS
BEGIN
    ALTER TABLE Customers ALTER COLUMN Email VARCHAR(150);
    UPDATE DBVersion SET VersionNo = 2;
END;
GO

CREATE PROCEDURE sp_v2_revert_column AS
BEGIN
    ALTER TABLE Customers ALTER COLUMN Email VARCHAR(100);
    UPDATE DBVersion SET VersionNo = 1;
END;
GO


/* ======================================================
   ============ VERSION 3: ADD DEFAULT CONST =============
   Add default value to Inventory.Stock (default = 0)
   ====================================================== */
CREATE PROCEDURE sp_v3_add_default AS
BEGIN
    ALTER TABLE Inventory 
        ADD CONSTRAINT DF_Inventory_Stock DEFAULT 0 FOR Stock;

    UPDATE DBVersion SET VersionNo = 3;
END;
GO

CREATE PROCEDURE sp_v3_remove_default AS
BEGIN
    ALTER TABLE Inventory
        DROP CONSTRAINT DF_Inventory_Stock;

    UPDATE DBVersion SET VersionNo = 2;
END;
GO


/* ======================================================
   ============= VERSION 4: ADD COLUMN ===================
   Add column: Shippers.Email VARCHAR(100)
   ====================================================== */
CREATE PROCEDURE sp_v4_add_column AS
BEGIN
    IF COL_LENGTH('Shippers','Email') IS NULL
        ALTER TABLE Shippers ADD Email VARCHAR(100);

    UPDATE DBVersion SET VersionNo = 4;
END;
GO

CREATE PROCEDURE sp_v4_remove_column AS
BEGIN
    IF COL_LENGTH('Shippers','Email') IS NOT NULL
        ALTER TABLE Shippers DROP COLUMN Email;

    UPDATE DBVersion SET VersionNo = 3;
END;
GO


/* ======================================================
   =============== VERSION 5: CREATE TABLE ===============
   Create a new table: Warehouses
   ====================================================== */
CREATE PROCEDURE sp_v5_create_table AS
BEGIN
    IF OBJECT_ID('Warehouses','U') IS NULL
        CREATE TABLE Warehouses(
            ID INT PRIMARY KEY,
            Name VARCHAR(50),
            Location VARCHAR(100)
        );

    UPDATE DBVersion SET VersionNo = 5;
END;
GO

CREATE PROCEDURE sp_v5_drop_table AS
BEGIN
    IF OBJECT_ID('Warehouses','U') IS NOT NULL
        DROP TABLE Warehouses;

    UPDATE DBVersion SET VersionNo = 4;
END;
GO



/* ======================================================
   =============== VERSION 6: ADD FOREIGN KEY ============
   Add FK: Inventory.PID → Products(ID) 
   ====================================================== */
CREATE PROCEDURE sp_v6_add_fk AS
BEGIN
    ALTER TABLE Inventory
        ADD CONSTRAINT FK_Inventory_Products
        FOREIGN KEY(PID) REFERENCES Products(ID);

    UPDATE DBVersion SET VersionNo = 6;
END;
GO

CREATE PROCEDURE sp_v6_remove_fk AS
BEGIN
    ALTER TABLE Inventory
        DROP CONSTRAINT FK_Inventory_Products;

    UPDATE DBVersion SET VersionNo = 5;
END;
GO



/* ======================================================
   ========== MAIN PROCEDURE: SET VERSION ================
   ====================================================== */
CREATE PROCEDURE sp_SetVersion @targetVersion INT
AS
BEGIN
    DECLARE @currentVersion INT;
    DECLARE @proc NVARCHAR(100);
    DECLARE @suffix NVARCHAR(50);

    SELECT @currentVersion = VersionNo FROM DBVersion;

    -- UPGRADE
    WHILE @currentVersion < @targetVersion
    BEGIN
        SET @currentVersion = @currentVersion + 1;

        SET @suffix = 
            CASE @currentVersion
                WHEN 2 THEN '_alter_column'
                WHEN 3 THEN '_add_default'
                WHEN 4 THEN '_add_column'
                WHEN 5 THEN '_create_table'
                WHEN 6 THEN '_add_fk'
            END;

        SET @proc = 'sp_v' + CAST(@currentVersion AS NVARCHAR(10)) + @suffix;

        PRINT 'Applying version ' + CAST(@currentVersion AS NVARCHAR(10)) + ' -> ' + @proc;
        EXEC sp_executesql @proc;
    END;

    -- DOWNGRADE
    WHILE @currentVersion > @targetVersion
    BEGIN
        SET @suffix =
            CASE @currentVersion
                WHEN 2 THEN '_revert_column'
                WHEN 3 THEN '_remove_default'
                WHEN 4 THEN '_remove_column'
                WHEN 5 THEN '_drop_table'
                WHEN 6 THEN '_remove_fk'
            END;

        SET @proc = 'sp_v' + CAST(@currentVersion AS NVARCHAR(10)) + @suffix;

        PRINT 'Reverting version ' + CAST(@currentVersion AS NVARCHAR(10)) + ' -> ' + @proc;
        EXEC sp_executesql @proc;

        SET @currentVersion = @currentVersion - 1;
    END;
END;
GO


---------------------------------------------------------
-- TESTING
---------------------------------------------------------
SELECT * FROM DBVersion
EXEC sp_SetVersion 6;   -- Upgrade to latest
EXEC sp_SetVersion 10;   -- Roll back to base
GO
