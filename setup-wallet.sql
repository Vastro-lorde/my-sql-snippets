-- Create Users table
CREATE TABLE Users (
  Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  Username NVARCHAR(50) NOT NULL,
  Password NVARCHAR(100) NOT NULL,
  Email NVARCHAR(100) NOT NULL,
  Phone NVARCHAR(20) NULL
);

-- Create Wallets table
CREATE TABLE Wallets (
  Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  UserId UNIQUEIDENTIFIER NOT NULL,
  Balance DECIMAL(18,2) NOT NULL DEFAULT 0,
  Currency NVARCHAR(10) NOT NULL,
  CONSTRAINT FK_Wallets_Users FOREIGN KEY (UserId) REFERENCES Users(Id)
);

-- Create Transactions table
CREATE TABLE Transactions (
  Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  WalletId UNIQUEIDENTIFIER NOT NULL,
  Amount DECIMAL(18,2) NOT NULL,
  TransactionType NVARCHAR(10) NOT NULL, -- Deposit or Withdrawal
  TransactionDate DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT FK_Transactions_Wallets FOREIGN KEY (WalletId) REFERENCES Wallets(Id)
);

-- Create PaymentMethods table
CREATE TABLE PaymentMethods (
  Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  UserId UNIQUEIDENTIFIER NOT NULL,
  PaymentMethodName NVARCHAR(50) NOT NULL,
  PaymentMethodDetails NVARCHAR(100) NOT NULL,
  CONSTRAINT FK_PaymentMethods_Users FOREIGN KEY (UserId) REFERENCES Users(Id)
);

-- Create WalletPaymentMethods table (many-to-many relationship)
CREATE TABLE WalletPaymentMethods (
  Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  WalletId UNIQUEIDENTIFIER NOT NULL,
  PaymentMethodId UNIQUEIDENTIFIER NOT NULL,
  CONSTRAINT FK_WalletPaymentMethods_Wallets FOREIGN KEY (WalletId) REFERENCES Wallets(Id),
  CONSTRAINT FK_WalletPaymentMethods_PaymentMethods FOREIGN KEY (PaymentMethodId) REFERENCES PaymentMethods(Id)
);