--creation of stored procedure
CREATE PROCEDURE CheckUserPassword
    @Username NVARCHAR(50),
    @Password NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StoredPassword NVARCHAR(100);
    DECLARE @InputPasswordHash NVARCHAR(100);

    -- Get the stored hashed password for the given username
    SELECT @StoredPassword = Password
    FROM Users
    WHERE Username = @Username;

    -- Hash the input password
    SET @InputPasswordHash = CONVERT(VARCHAR(100), HASHBYTES('SHA2_256', @Password), 2);

    -- Compare the hashed input password with the stored hashed password
    IF @StoredPassword = @InputPasswordHash
    BEGIN
        PRINT 'Password is correct';
    END
    ELSE
    BEGIN
        PRINT 'Password is incorrect';
    END
END;


--usage of the stored procedure
EXEC CheckUserPassword @Username = 'User1', @Password = 'Password1';