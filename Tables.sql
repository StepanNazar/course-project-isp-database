CREATE DATABASE ISPDATABASE;
GO

use ISPDATABASE;
GO

CREATE TABLE dbo.Person (
    Id INT IDENTITY(1,1) NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL UNIQUE,
    Phone NVARCHAR(20),
    [Address] NVARCHAR(200),
    CONSTRAINT PK_Person PRIMARY KEY (Id)
);

CREATE TABLE dbo.Client (
    Id INT IDENTITY(1,1) NOT NULL,
    PersonId INT NOT NULL,
    CurrentTariffId INT,
    PasswordHash VARCHAR(128) NOT NULL,
    Balance DECIMAL(19,4) NOT NULL,
    IpAddress BINARY(4) NOT NULL UNIQUE,
    HourlyTraffic SMALLINT,
    DailyTraffic SMALLINT,
    MonthlyTraffic SMALLINT,
    RegistrationDate DATE NOT NULL,
    CONSTRAINT PK_Client PRIMARY KEY (Id)
);

CREATE TABLE dbo.Tariff (
    Id INT IDENTITY(1,1) NOT NULL,
    [Name] NVARCHAR(70) NOT NULL,
    DurationDays SMALLINT NOT NULL,
    SpeedMbps INT NOT NULL,
    HourlyLimitGb SMALLINT,
    DailyLimitGb SMALLINT,
    MonthlyLimitGb SMALLINT,
    IsActive BIT NOT NULL,
    Price DECIMAL(19,4) NOT NULL,
    CONSTRAINT PK_Tariff PRIMARY KEY (Id)
);

CREATE TABLE dbo.TariffUsage (
    Id INT IDENTITY(1,1) NOT NULL,
    ClientId INT NOT NULL,
    TariffId INT NOT NULL,
	TransactionId INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    CONSTRAINT PK_TariffUsage PRIMARY KEY (Id)
);

CREATE TABLE dbo.InternetSession (
    Id INT IDENTITY(1,1) NOT NULL,
    ClientId INT NOT NULL,
    StartTime DATETIME2(2) NOT NULL,
    EndTime DATETIME2(2) NOT NULL,
    TrafficUsedGb SMALLINT NOT NULL,
    CONSTRAINT PK_InternetSession PRIMARY KEY (Id)
);

CREATE TABLE dbo.ReviewType (
    Id INT IDENTITY(1,1) NOT NULL,
    [Name] NVARCHAR(70) NOT NULL,
    CONSTRAINT PK_ReviewType PRIMARY KEY (Id)
);

CREATE TABLE dbo.Review (
    Id INT IDENTITY(1,1) NOT NULL,
    ClientId INT NOT NULL,
    ReviewType INT NOT NULL,
    EquipmentId INT,
    TariffId INT,
    ServiceId INT,
    SupportRequestId INT,
    ReviewText NVARCHAR(1000),
    Score TINYINT NOT NULL CHECK (Score >= 1 AND Score <= 10),
    ReviewTime DATETIME2(2) NOT NULL,
    CONSTRAINT PK_Review PRIMARY KEY (Id)
);

CREATE TABLE dbo.Position (
    Id INT IDENTITY(1,1) NOT NULL,
    [Name] NVARCHAR(70) NOT NULL,
    CONSTRAINT PK_Position PRIMARY KEY (Id)
);

CREATE TABLE dbo.Employee (
    Id INT IDENTITY(1,1) NOT NULL,
    PersonId INT NOT NULL,
    Position INT NOT NULL,
    Salary DECIMAL(19,4) NOT NULL,
    HireDate DATE NOT NULL,
    TerminationDate DATE,
    CONSTRAINT PK_Employee PRIMARY KEY (Id)
);

CREATE TABLE dbo.TransactionType (
    Id INT IDENTITY(1,1) NOT NULL,
    [Name] NVARCHAR(70) NOT NULL,
    CONSTRAINT PK_TransactionType PRIMARY KEY (Id)
);

CREATE TABLE dbo.[Transaction] (
    Id INT IDENTITY(1,1) NOT NULL,
    ClientId INT NOT NULL,
    TransactionType INT NOT NULL,
    Amount DECIMAL(19,4) NOT NULL,
    TransactionTime DATETIME2(2) NOT NULL,
    CONSTRAINT PK_Transaction PRIMARY KEY (Id)
);

CREATE TABLE dbo.EquipmentType (
    Id INT IDENTITY(1,1) NOT NULL,
    [Name] NVARCHAR(70) NOT NULL,
    CONSTRAINT PK_EquipmentType PRIMARY KEY (Id)
);

CREATE TABLE dbo.Equipment (
    Id INT IDENTITY(1,1) NOT NULL,
    EquipmentType INT NOT NULL,
    [Name] NVARCHAR(70) NOT NULL,
    [Description] NVARCHAR(MAX),
    Price DECIMAL(19,4) NOT NULL,
    Quantity SMALLINT NOT NULL,
    CONSTRAINT PK_Equipment PRIMARY KEY (Id)
);

CREATE TABLE dbo.Sale (
    Id INT IDENTITY(1,1) NOT NULL,
    ClientId INT NOT NULL,
    EquipmentId INT NOT NULL,
	TransactionId INT NOT NULL,
    SaleTime DATETIME2(2) NOT NULL,
    Quantity SMALLINT NOT NULL,
    Price DECIMAL(19,4) NOT NULL,
    CONSTRAINT PK_Sale PRIMARY KEY (Id)
);

CREATE TABLE dbo.[Service] (
    Id INT IDENTITY(1,1) NOT NULL,
    [Name] NVARCHAR(70) NOT NULL,
    DurationDays SMALLINT NOT NULL,
    [Description] NVARCHAR(MAX) NOT NULL,
    Price DECIMAL(19,4) NOT NULL,
    IsActive BIT NOT NULL,
    CONSTRAINT PK_Service PRIMARY KEY (Id)
);

CREATE TABLE dbo.ServiceUsage (
    Id INT IDENTITY(1,1) NOT NULL,
    ClientId INT NOT NULL,
    ServiceId INT NOT NULL,
	TransactionId INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    CONSTRAINT PK_ServiceUsage PRIMARY KEY (Id)
);

CREATE TABLE dbo.SupportRequest (
    Id INT IDENTITY(1,1) NOT NULL,
    ClientId INT NOT NULL,
    RequestText NVARCHAR(1000) NOT NULL,
    RequestTime DATETIME2(2) NOT NULL,
    CompletionTime DATETIME2(2),
    Cost DECIMAL(19,4) NOT NULL,
	TransactionId INT NOT NULL,
    CONSTRAINT PK_SupportRequest PRIMARY KEY (Id)
);

CREATE TABLE dbo.ClientService (
    ClientId INT NOT NULL,
    ServiceId INT NOT NULL,
    CONSTRAINT PK_ClientService PRIMARY KEY (ClientId, ServiceId)
);


ALTER TABLE dbo.Person ADD
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
        CONSTRAINT DF_Person_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
        CONSTRAINT DF_Person_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME(ValidFrom, ValidTo);
GO

ALTER TABLE dbo.Person
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Person_History));
GO

ALTER TABLE dbo.Employee ADD
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
        CONSTRAINT DF_Employee_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
        CONSTRAINT DF_Employee_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME(ValidFrom, ValidTo);
GO

ALTER TABLE dbo.Employee
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Employee_History));
GO

ALTER TABLE dbo.Equipment ADD
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
        CONSTRAINT DF_Equipment_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
        CONSTRAINT DF_Equipment_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME(ValidFrom, ValidTo);
GO

ALTER TABLE dbo.Equipment
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Equipment_History));
GO