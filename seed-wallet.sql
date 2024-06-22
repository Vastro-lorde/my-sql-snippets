-- Switch to the correct database
USE seun;
GO

-- Insert users
INSERT INTO dbo.Users (Username, Password, Email, Phone)
VALUES
    ('User1', 'Password1', 'user1@example.com', '1234567890'),
    ('User2', 'Password2', 'user2@example.com', '2345678901'),
    ('User3', 'Password3', 'user3@example.com', '3456789012'),
    ('User4', 'Password4', 'user4@example.com', '4567890123'),
    ('User5', 'Password5', 'user5@example.com', '5678901234');

-- Insert payment methods
INSERT INTO dbo.PaymentMethods (UserId, PaymentMethodName, PaymentMethodDetails)
VALUES
    ((SELECT Id FROM dbo.Users WHERE Username = 'User1'), 'Credit Card', '1234-5678-9012-3456'),
    ((SELECT Id FROM dbo.Users WHERE Username = 'User2'), 'Bank Transfer', 'Bank of America');

-- Insert wallets
INSERT INTO dbo.Wallets (UserId, Balance, Currency)
VALUES
    ((SELECT Id FROM dbo.Users WHERE Username = 'User1'), 100.00, 'USD'),
    ((SELECT Id FROM dbo.Users WHERE Username = 'User2'), 200.00, 'EUR'),
    ((SELECT Id FROM dbo.Users WHERE Username = 'User3'), 300.00, 'GBP'),
    ((SELECT Id FROM dbo.Users WHERE Username = 'User4'), 400.00, 'USD'),
    ((SELECT Id FROM dbo.Users WHERE Username = 'User5'), 500.00, 'EUR');

-- Insert transactions
INSERT INTO dbo.Transactions (WalletId, Amount, TransactionType)
VALUES
    ((SELECT Id FROM dbo.Wallets WHERE UserId = (SELECT Id FROM dbo.Users WHERE Username = 'User1')), 50.00, 'Deposit'),
    ((SELECT Id FROM dbo.Wallets WHERE UserId = (SELECT Id FROM dbo.Users WHERE Username = 'User2')), 75.00, 'Withdrawal'),
    ((SELECT Id FROM dbo.Wallets WHERE UserId = (SELECT Id FROM dbo.Users WHERE Username = 'User3')), 100.00, 'Deposit'),
    ((SELECT Id FROM dbo.Wallets WHERE UserId = (SELECT Id FROM dbo.Users WHERE Username = 'User4')), 150.00, 'Withdrawal'),
    ((SELECT Id FROM dbo.Wallets WHERE UserId = (SELECT Id FROM dbo.Users WHERE Username = 'User5')), 200.00, 'Deposit');

-- Insert wallet payment methods
INSERT INTO dbo.WalletPaymentMethods (WalletId, PaymentMethodId)
VALUES
    ((SELECT Id FROM dbo.Wallets WHERE UserId = (SELECT Id FROM dbo.Users WHERE Username = 'User1')), 
     (SELECT Id FROM dbo.PaymentMethods WHERE PaymentMethodName = 'Credit Card')),
    ((SELECT Id FROM dbo.Wallets WHERE UserId = (SELECT Id FROM dbo.Users WHERE Username = 'User2')), 
     (SELECT Id FROM dbo.PaymentMethods WHERE PaymentMethodName = 'Bank Transfer'));
