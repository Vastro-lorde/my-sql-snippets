-- Check if the Users table exists and create it if it doesn't
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Users')
BEGIN
    CREATE TABLE Users (
        Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
        Username NVARCHAR(50) NOT NULL,
        Password NVARCHAR(100) NOT NULL,
        Email NVARCHAR(100) NOT NULL,
        Phone NVARCHAR(20) NULL
    );
END

-- Create a temporary table to store the hashed passwords
CREATE TABLE #TempUsers (
    Id UNIQUEIDENTIFIER,
    Username NVARCHAR(50),
    HashedPassword NVARCHAR(100),
    Email NVARCHAR(100),
    Phone NVARCHAR(20)
);

-- Insert into the temporary table with hashed passwords
INSERT INTO #TempUsers (Id, Username, HashedPassword, Email, Phone)
SELECT 
    Id,
    Username,
    CONVERT(VARCHAR(100), HASHBYTES('SHA2_256', Password), 2) AS HashedPassword,
    Email,
    Phone
FROM Users;

-- Update the original Users table with the hashed passwords
UPDATE Users
SET Password = T.HashedPassword
FROM Users U
INNER JOIN #TempUsers T ON U.Id = T.Id;

-- Drop the temporary table
DROP TABLE #TempUsers;

-- Verify the updates
SELECT * FROM Users;