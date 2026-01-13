USE ElectronicSalesDB;

drop table if EXISTS Attendance;
drop table if EXISTS Atendees;
drop table if EXISTS Performances;
drop table if EXISTS Artists;
drop table if EXISTS Stages;
GO

CREATE TABLE Artists( 
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Genre VARCHAR(30),
    Country VARCHAR(30)
);

CREATE TABLE Stages (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Capacity INT,
    [Sound System] VARCHAR(50)
)

CREATE TABLE Performances (
    PerformanceID INT PRIMARY KEY IDENTITY(1,1),
    ArtistID INT FOREIGN KEY REFERENCES Artists(ID),
    StageID INT FOREIGN KEY REFERENCES Stages(ID),
    PerformanceDate DATETIME,
    StartTime DATETIME,
    EndTime DATETIME,
    [Status] VARCHAR(20),
);

CREATE TABLE Atendees (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(50),
    TicketType VARCHAR(30),
    PurchaseDate DATETIME
);
GO

CREATE TABLE Attendance (
    AtendeeID INT FOREIGN KEY REFERENCES Atendees(ID),
    PerformanceID INT FOREIGN KEY REFERENCES Performances(PerformanceID),
    Rating INT,
    Comment VARCHAR(255),
)
GO

ALTER PROCEDURE add_performance
    @ArtistID INT,
    @StageID INT,
    @PerformanceDate DATETIME,
    @StartTime DATETIME,
    @EndTime DATETIME,
    @Status VARCHAR(20)
AS 
BEGIN
    IF EXISTS (
        SELECT 1 FROM Performances 
        WHERE @StageID = StageID 
        AND @PerformanceDate = PerformanceDate
        AND @StartTime < EndTime 
        AND @EndTime > StartTime
    )
    BEGIN
        RAISERROR('Conflict: The Stage is already booked for another performance during this time.', 16, 1);
        RETURN;
    END

    INSERT INTO Performances(ArtistID, StageID, PerformanceDate, StartTime, EndTime, [Status])
    VALUES (@ArtistID, @StageID, @PerformanceDate, @StartTime, @EndTime, @Status);
    
    PRINT 'Performance scheduled successfully.';
END
GO

ALTER VIEW v_rank_stages AS
SELECT 
    S.Name AS StageName,
    COUNT(P.PerformanceID) AS TotalPerformances
FROM 
    Stages S
LEFT JOIN 
    Performances P ON S.ID = P.StageID
GROUP BY 
    S.Name
ORDER BY 
    TotalPerformances DESC
OFFSET 0 ROWS
GO


ALTER FUNCTION dbo.GetAtendees(@N INT)
RETURNS TABLE
AS 
RETURN 
(
    SELECT A.Name from Atendees A
    JOIN Attendance AT ON A.ID = AT.AtendeeID
    GROUP BY A.Name
    HAVING COUNT(AT.PerformanceID) >= @N
)

GO

INSERT INTO Artists (ID, Name, Genre, Country) VALUES
(1, 'DJ Alpha', 'House', 'USA'),
(2, 'Beat Master', 'Techno', 'Germany'),
(3, 'Synth Wave', 'Synthpop', 'UK');

INSERT INTO Stages (ID, Name, Capacity, [Sound System]) VALUES
(1, 'Main Stage', 5000, 'High-End'),
(2, 'Underground Stage', 2000, 'Mid-Range'),
(3, 'Chillout Zone', 1000, 'Basic');

INSERT INTO Atendees (ID, Name, Email, TicketType, PurchaseDate) VALUES
(1, 'Alex Johnson', 'alex.johnson@example.com', 'VIP', '2024-06-15'),
(2, 'Sergiu', 'sergiu@abc.com', 'General', '2024-06-16'),
(3, 'Petru', 'petru@abc.com', 'General', '2024-06-17'),
(4, 'Matei', 'matei@abc.com', 'General', '2024-06-18'),
(5, 'Sergiu', 'sergiu@abc.com', 'General', '2024-06-19'),
(6, 'Sergiu', 'sergiu@abc.com', 'General', '2024-06-20');
GO

INSERT INTO Performances (ArtistID, StageID, PerformanceDate, StartTime, EndTime, [Status]) VALUES
(1, 1, '2024-07-01', '2024-07-01 18:00:00', '2024-07-01 20:00:00', 'Scheduled'),
(2, 2, '2024-07-01', '2024-07-01 20:30:00', '2024-07-01 22:30:00', 'Ongoing'),
(3, 3, '2024-07-02', '2024-07-02 19:00:00', '2024-07-02 21:00:00', 'Completed'),
(1, 1, '2024-07-02', '2024-07-02 22:00:00', '2024-07-02 23:59:00', 'Canceled');
GO

INSERT INTO Attendance (AtendeeID, PerformanceID, Rating, Comment) VALUES
(1, 1, 5, 'Amazing performance!'),
(2, 1, 4, 'Great vibes!'),
(3, 2, 3, 'It was okay.'),
(4, 2, 4, 'Enjoyed the set!'),
(2, 3, 5, 'Loved it!'),
(5, 1, 4, 'Good show!'),
(6, 1, 5, 'Fantastic experience!');


-- fail
EXEC add_performance 
    @ArtistID = 2, 
    @StageID = 1, 
    @PerformanceDate = '2024-07-01', 
    @StartTime = '2024-07-01 19:00:00', 
    @EndTime = '2024-07-01 21:00:00', 
    @Status = 'Scheduled';

-- ok
EXEC add_performance 
    @ArtistID = 3, 
    @StageID = 1, 
    @PerformanceDate = '2024-07-01', 
    @StartTime = '2024-07-01 22:00:00', 
    @EndTime = '2024-07-01 23:59:00', 
    @Status = 'Scheduled';

SELECT * FROM v_rank_stages;
SELECT * FROM dbo.GetAtendees(3);
SELECT * FROM dbo.GetAtendees(1);

select * from Performances