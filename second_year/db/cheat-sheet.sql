--PRACTICAL MODEL


CREATE TABLE Groups(
    Gid INT PRIMARY KEY,
    Number INT,
    Tutor VARCHAR(30),
    Leader VARCHAR(30)
);

CREATE TABLE Students(
    Sid INT PRIMARY KEY,
    Name VARCHAR(30),
    Surname VARCHAR(30),
    Gid INT FOREIGN KEY REFERENCES Groups(Gid),
    Birth DATE
);

CREATE TABLE Professors(
    Pid INT PRIMARY KEY,
    Name VARCHAR(30),
    Surname VARCHAR(30),
    Func VARCHAR(30)
);

CREATE TABLE Courses(
    Cid INT PRIMARY KEY,
    Name VARCHAR(30)
);

CREATE TABLE Exams(
    Sid INT FOREIGN KEY REFERENCES Students(Sid),
    Cid INT FOREIGN KEY REFERENCES Courses(Cid),
    Mark INT,
    Schedule DATE,
    PRIMARY KEY(Sid, Cid)
);

CREATE TABLE Specialisations(
    Pid INT FOREIGN KEY REFERENCES Professors(Pid),
    Cid INT FOREIGN KEY REFERENCES Courses(Cid),
    Specialisation VARCHAR(30),
    Credits INT,
    PRIMARY KEY(Pid, Cid)
);
GO
CREATE PROCEDURE add_exam
    @Sid INT,
    @Cid INT,
    @Mark INT,
    @Schedule DATE
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Exams WHERE Sid = @Sid AND Cid = @Cid)
    BEGIN
        INSERT INTO Exams(Sid, Cid, Mark, Schedule)
        VALUES (@Sid, @Cid, @Mark, @Schedule)
    END
    ELSE
    BEGIN
        UPDATE Exams
        SET Mark = @Mark, Schedule = @Schedule
        WHERE Sid = @Sid AND Cid = @Cid
    END
END
GO
CREATE VIEW V AS
SELECT DISTINCT g.Gid, g.Number, g.Tutor, g.Leader
FROM Groups g
JOIN Students s ON s.Gid = g.Gid
JOIN Exams e ON e.Sid = s.Sid
WHERE e.Mark = (SELECT MAX(Mark) FROM Exams)
GO

CREATE FUNCTION dbo.GetProfessors(@M INT)
RETURNS TABLE
AS
RETURN
(
    SELECT p.Name, p.Surname
    FROM Professors p
    JOIN Specialisations sp ON sp.Pid = p.Pid
    GROUP BY p.Pid, p.Name, p.Surname
    HAVING COUNT(sp.Cid) >= @M
)
GO

--Cheet Sheet

-- Numărare
COUNT(*)              -- toate rândurile (inclusiv NULL)
COUNT(Column)         -- doar NON-NULL
COUNT(DISTINCT Col)   -- valori unice

-- Alte agregări
SUM(Column)           -- suma
AVG(Column)           -- media
MAX(Column)           -- maximul
MIN(Column)           -- minimul

-- Exemplu complet
SELECT Category, 
       COUNT(*) AS Total,
       SUM(Price) AS TotalPrice,
       AVG(Price) AS AvgPrice,
       MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category
HAVING COUNT(*) > 5   -- filtrare DUPĂ grupare

-- Regula de aur: WHERE (înainte) vs HAVING (după grupare)
SELECT Category, COUNT(*) AS Total
FROM Products
WHERE Stock > 0              -- ✅ filtrează ÎNAINTE de grupare
GROUP BY Category            -- grupează
HAVING COUNT(*) > 5          -- ✅ filtrează DUPĂ grupare

-- Toate coloanele non-agregate trebuie în GROUP BY
SELECT Category, Color, COUNT(*)
FROM Products
GROUP BY Category, Color     -- ambele coloane!

-- INNER JOIN (doar match-uri)
SELECT * FROM T1
INNER JOIN T2 ON T1.ID = T2.ID

-- LEFT JOIN (toate din stânga + match-uri)
SELECT * FROM T1
LEFT JOIN T2 ON T1.ID = T2.ID

-- Multiple joins
SELECT * FROM Students s
JOIN Exams e ON e.Sid = s.Sid
JOIN Courses c ON c.Cid = e.Cid
WHERE e.Mark >= 5

-- În WHERE - găsește maximul
SELECT * FROM Products
WHERE Price = (SELECT MAX(Price) FROM Products)

-- În WHERE - comparație cu agregare
SELECT * FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products)

-- EXISTS (verifică existență - RAPID!)
SELECT * FROM Students s
WHERE EXISTS (
    SELECT 1 FROM Exams e 
    WHERE e.Sid = s.Sid AND e.Mark = 10
)

-- NOT EXISTS (nu există)
SELECT * FROM Students s
WHERE NOT EXISTS (
    SELECT 1 FROM Exams e WHERE e.Sid = s.Sid
)

-- În SELECT (coloană calculată)
SELECT Name, 
       (SELECT COUNT(*) FROM Orders WHERE CustomerID = c.ID) AS Total
FROM Customers c

-- WHERE (condiții simple)
WHERE Column = Value
WHERE Column > 10
WHERE Column BETWEEN 10 AND 20
WHERE Column IN (1, 2, 3)
WHERE Column IS NULL / IS NOT NULL

-- LIKE (pattern matching)
WHERE Name LIKE '%ion%'    -- conține "ion"
WHERE Name LIKE 'A%'       -- începe cu "A"
WHERE Name LIKE '%u'       -- se termină cu "u"
WHERE Name LIKE '_a%'      -- a doua literă este "a"

-- ORDER BY (sortare)
ORDER BY Column ASC        -- crescător (implicit)
ORDER BY Column DESC       -- descrescător
ORDER BY Col1, Col2 DESC   -- multiple coloane

-- TOP (primele N)
SELECT TOP 10 * FROM Table
SELECT TOP 10 PERCENT * FROM Table

-- DISTINCT (valori unice)
SELECT DISTINCT Column FROM Table
SELECT DISTINCT Col1, Col2 FROM Table

-- UNION (combină rezultate, elimină duplicate)
SELECT Col FROM T1
UNION
SELECT Col FROM T2

-- UNION ALL (păstrează duplicate)
SELECT Col FROM T1
UNION ALL
SELECT Col FROM T2

-- Case în SELECT
SELECT Name, Mark,
       CASE 
           WHEN Mark >= 9 THEN 'Excellent'
           WHEN Mark >= 7 THEN 'Good'
           WHEN Mark >= 5 THEN 'Pass'
           ELSE 'Fail'
       END AS Grade
FROM Exams

-- Case în agregare
SELECT 
    SUM(CASE WHEN Status = 'Active' THEN 1 ELSE 0 END) AS Active,
    SUM(CASE WHEN Status = 'Inactive' THEN 1 ELSE 0 END) AS Inactive
FROM Users

-- Case în WHERE
WHERE CASE WHEN Condition THEN Value1 ELSE Value2 END = X

CONCAT(First, ' ', Last)           -- concatenare
LEN(Column)                        -- lungime
UPPER(Column) / LOWER(Column)      -- majuscule/minuscule
SUBSTRING(Column, start, length)   -- substring
REPLACE(Column, 'old', 'new')      -- înlocuire
TRIM(Column)                       -- elimină spații
LEFT(Column, n) / RIGHT(Column, n) -- primele/ultimele n caractere

-- INSERT
INSERT INTO Table(Col1, Col2) VALUES (Val1, Val2)
INSERT INTO Table(Col1, Col2) 
SELECT Col1, Col2 FROM OtherTable WHERE Condition

-- UPDATE
UPDATE Table 
SET Col1 = Val1, Col2 = Val2
WHERE Condition

-- DELETE
DELETE FROM Table WHERE Condition

CREATE PROCEDURE ProcName
    @Param1 INT,
    @Param2 VARCHAR(50)
AS
BEGIN
    -- Verifică existență
    IF EXISTS (SELECT 1 FROM Table WHERE ID = @Param1)
    BEGIN
        UPDATE Table SET Col = @Param2 WHERE ID = @Param1
    END
    ELSE
    BEGIN
        INSERT INTO Table(ID, Col) VALUES (@Param1, @Param2)
    END
END

-- Apelare
EXEC ProcName @Param1 = 10, @Param2 = 'test'

-- Table-Valued Function (returnează tabel)
CREATE FUNCTION dbo.GetData(@Param INT)
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM Table WHERE Col >= @Param
)

-- Apelare
SELECT * FROM dbo.GetData(10)

-- Scalar Function (returnează o valoare)
CREATE FUNCTION dbo.CalcTotal(@ID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Total INT
    SELECT @Total = SUM(Amount) FROM Table WHERE ID = @ID
    RETURN @Total
END

-- Apelare
SELECT dbo.CalcTotal(10)

CREATE TRIGGER TriggerName
ON TableName
FOR INSERT, UPDATE, DELETE
AS
BEGIN
    -- inserted = rânduri noi (INSERT/UPDATE)
    -- deleted = rânduri vechi (DELETE/UPDATE)
    
    SELECT * FROM inserted   -- date noi
    SELECT * FROM deleted    -- date vechi
    
    -- Exemplu: verifică diferență
    SELECT i.Col - d.Col AS Diff
    FROM inserted i
    JOIN deleted d ON i.ID = d.ID
END


SELECT s.Name, s.Surname, AVG(e.Mark) AS Medie
FROM Students s
JOIN Exams e ON e.Sid = s.Sid
GROUP BY s.Sid, s.Name, s.Surname
HAVING AVG(e.Mark) > 8
ORDER BY Medie DESC

SELECT TOP 3 c.Name, AVG(e.Mark) AS AvgMark
FROM Courses c
JOIN Exams e ON e.Cid = c.Cid
GROUP BY c.Cid, c.Name
ORDER BY AVG(e.Mark) ASC

SELECT c.Name, COUNT(*) AS NumExams, AVG(e.Mark) AS AvgMark
FROM Courses c
JOIN Exams e ON e.Cid = c.Cid
GROUP BY c.Cid, c.Name
HAVING COUNT(*) > 15 AND AVG(e.Mark) > 7

SELECT g.Gid, 
       COUNT(DISTINCT s.Sid) AS NumStudents,
       AVG(e.Mark) AS AvgMark
FROM Groups g
JOIN Students s ON s.Gid = g.Gid
LEFT JOIN Exams e ON e.Sid = s.Sid
GROUP BY g.Gid


-- 1. Cursuri cu mai multe credite decât CEL PUȚIN UN curs de Databases
SELECT * FROM Courses
WHERE NoOfCredits > ANY (
    SELECT NoOfCredits FROM Courses WHERE Title LIKE '%Database%'
)

-- 2. Cursuri cu mai multe credite decât TOATE cursurile de Math
SELECT * FROM Courses
WHERE NoOfCredits > ALL (
    SELECT NoOfCredits FROM Courses WHERE Title = 'Math'
)

-- 3. Studenți cu note mai mari decât CEL PUȚIN O notă de la cursul 'Databases'
SELECT DISTINCT s.Name, s.Surname
FROM Students s
JOIN Exams e ON e.Sid = s.Sid
WHERE e.Mark > ANY (
    SELECT e2.Mark 
    FROM Exams e2 
    JOIN Courses c ON c.CoId = e2.CoId
    WHERE c.Title = 'Databases'
)

-- 4. Studenți cu note mai mari decât TOATE notele de la 'Math'
SELECT DISTINCT s.Name, s.Surname
FROM Students s
JOIN Exams e ON e.Sid = s.Sid
WHERE e.Mark > ALL (
    SELECT e2.Mark 
    FROM Exams e2 
    JOIN Courses c ON c.CoId = e2.CoId
    WHERE c.Title = 'Math'
)

-- 3. CREĂM CLUSTERED INDEX pe Sid
CREATE CLUSTERED INDEX IDX_Students_Sid 
ON Students(Sid ASC);

-- ACUM datele sunt FIZIC sortate după Sid!
SELECT * FROM Students;
-- Rezultat: Sid = 1, 2, 3, 5 (ordine fizică)

-- 4. CREĂM NONCLUSTERED INDEX pe Name
CREATE NONCLUSTERED INDEX IDX_Students_Name 
ON Students(Name ASC);

-- Datele rămân în ordinea Sid (clustered)
-- Dar acum avem un INDEX SEPARAT pentru Name
```

-- SETUP
CREATE TABLE Students(
    Sid INT PRIMARY KEY,  -- clustered automat
    Name VARCHAR(30),
    Gid INT
);

CREATE NONCLUSTERED INDEX IDX_Name ON Students(Name);
CREATE NONCLUSTERED INDEX IDX_Gid ON Students(Gid);

-- 1. CLUSTERED INDEX SCAN
SELECT * FROM Students;

-- 2. CLUSTERED INDEX SEEK  
SELECT * FROM Students WHERE Sid = 5;

-- 3. NONCLUSTERED INDEX SCAN
SELECT Name FROM Students ORDER BY Name;

-- 4. NONCLUSTERED INDEX SEEK
SELECT Sid, Name FROM Students WHERE Name = 'Ana';

-- 5. KEY LOOKUP
SELECT Name, Gid FROM Students WHERE Name = 'Ion';* FROM Students WHERE Sid BETWEEN 3 AND 7;  -- range pe PK
