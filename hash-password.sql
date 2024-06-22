--hash password
DECLARE @Password NVARCHAR(50) = 'your_password_here';
DECLARE @PasswordHash VARBINARY(64);

SET @PasswordHash = HASHBYTES('SHA2_256', @Password);

INSERT INTO Users (Username, PasswordHash, Email, Phone)
VALUES ('TestUser', @PasswordHash, 'test@example.com', '1234567890');



--verify password
DECLARE @InputPassword NVARCHAR(50) = 'your_password_here';
DECLARE @InputPasswordHash VARBINARY(64);

SET @InputPasswordHash = HASHBYTES('SHA2_256', @InputPassword);

SELECT *
FROM Users
WHERE Username = 'TestUser' AND PasswordHash = @InputPasswordHash;


--schema for hashed password
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY,
    Username NVARCHAR(50) NOT NULL,
    PasswordHash VARBINARY(64) NOT NULL, -- Adjust the size as needed for different hash algorithms
    Email NVARCHAR(100),
    Phone NVARCHAR(15)
);


--hashing password
SELECT HASHBYTES('SHA2_256', 'your_password_here') AS HashedPassword;
