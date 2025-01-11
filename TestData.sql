INSERT INTO dbo.Person (FirstName, LastName, Email, Phone, [Address])
VALUES
('John', 'Doe', 'john.doe@email.com', '123-456-7890', '123 Main St'),
('Jane', 'Smith', 'jane.smith@email.com', '234-567-8901', '456 Oak Ave'),
('Bob', 'Johnson', 'bob.johnson@email.com', '345-678-9012', '789 Pine Rd'),
('Alice', 'Brown', 'alice.brown@email.com', '456-789-0123', '321 Elm St'),
('John', 'Brown', 'john.brown@email.com', '456-785-0123', '351 Elm St'),
('Alice', 'Johnson', 'alice.johnson@email.com', '348-678-9012', '189 Pine Rd'),
('Jake', 'Bond', 'jake.bond@email.com', '234-567-8001', '456 Oak Rd'),
('John', 'Johnson', 'john.smith@email.com', '223-456-7890', '123 Second St, Kyiv');

INSERT INTO dbo.Position ([Name])
VALUES
('Technical Support'),
('Network Engineer'),
('Customer Service Representative'),
('Sales Representative'),
('System Administrator'),
('Director');

INSERT INTO dbo.ReviewType ([Name])
VALUES
('Service Quality'),
('Tarrif Quality'),
('Customer Support Quality'),
('Installation Quality'),
('Equipment Quality');

INSERT INTO dbo.EquipmentType ([Name])
VALUES
('Router'),
('Modem'),
('Network Cable'),
('WiFi Extender'),
('Network Switch');

INSERT INTO dbo.TransactionType ([Name])
VALUES
('Equipment Purchase'),
('Support Charge'),
('Tarrif Charge'),
('Service Charge'),
('Account replenishment');

INSERT INTO dbo.Equipment (EquipmentType, [Name], [Description], Price, Quantity)
VALUES
(1, 'Premium Router', 'High-speed wireless router', 199.99, 50),
(2, 'Basic Modem', 'Standard cable modem', 89.99, 75),
(3, 'Cat6 Cable', '50ft ethernet cable', 29.99, 100),
(4, 'WiFi Booster', 'Signal extension device', 79.99, 30);

INSERT INTO dbo.[Service] ([Name], DurationDays, [Description], Price, IsActive)
VALUES
('Static IP', 30, 'Static IP address service', 9.99, 1),
('Premium Support', 30, '24/7 priority support', 19.99, 1),
('Data Backup', 30, 'Cloud backup service', 14.99, 1),
('Security Suite', 30, 'Network security package', 24.99, 1);

INSERT INTO dbo.Tariff ([Name], DurationDays, SpeedMbps, MonthlyLimitGb, IsActive, Price)
VALUES
('Limited', 30, 100, 500, 1, 29.99),
('Basic', 30, 100, NULL, 1, 49.99),
('Gigabit', 30, 1000, NULL, 1, 99.99),
('Annual', 365, 1000, NULL, 1, 999.99),
('New Year', 30, 10, NULL, 0, 0.99);

INSERT INTO dbo.Client (PersonId, CurrentTariffId, PasswordHash, Balance, IpAddress, RegistrationDate, MonthlyTraffic)
VALUES
(5, 4, 'hash1', 100.00, 0x0A000001, '2023-01-01', NULL),
(6, 2, 'hash2', 150.00, 0x0A000002, '2023-05-01', NULL),
(7, 3, 'hash3', 200.00, 0x0A000003, '2023-05-02', NULL),
(8, 1, 'hash4', 250.00, 0x0A000004, '2023-05-03', 100);

INSERT INTO dbo.[Transaction] (ClientId, TransactionType, Amount, TransactionTime)
VALUES
(1, 1, 199.99, '2024-01-01 10:00:00'),
(2, 1, 89.99, '2024-01-01 11:00:00'),
(3, 1, 119.96, '2024-01-01 12:00:00'),
(4, 1, 79.99, '2024-01-01 13:00:00'),
(1, 3, 999.99, '2024-01-01 09:00:00'),
(2, 3, 49.99, '2024-01-01 10:00:00'),
(3, 3, 99.99, '2024-01-01 11:00:00'),
(4, 3, 29.99, '2024-01-01 12:00:00'),
(1, 4, 9.99, '2024-01-01 09:00:00'),
(2, 4, 19.99, '2024-01-01 10:00:00'),
(3, 4, 14.99, '2024-01-01 11:00:00'),
(4, 4, 29.99, '2024-01-01 12:00:00'),
(1, 2, 0.00, '2024-01-01 10:00:00'),
(2, 2, 29.99, '2024-01-01 12:00:00'),
(3, 2, 0.0, '2024-01-01 14:00:00'),
(4, 2, 19.99, '2024-01-01 16:00:00'),
(1, 5, 1000.00, '2023-12-31 10:00:00'),
(2, 5, 1029.99, '2023-12-31 12:00:00'),
(3, 5, 1000.0, '2023-12-31 14:00:00'),
(4, 5, 1019.99, '2023-12-31 16:00:00');

INSERT INTO dbo.TariffUsage (ClientId, TariffId, TransactionId, StartDate, EndDate)
VALUES
(1, 1, 4, '2024-01-01', '2024-01-31'),
(2, 2, 2, '2024-01-01', '2024-01-31'),
(3, 3, 3, '2024-01-01', '2024-01-31'),
(4, 4, 1, '2024-01-01', '2024-01-31');

INSERT INTO dbo.Employee (PersonId, Position, Salary, HireDate)
VALUES
(1, 1, 45000.00, '2023-01-15'),
(2, 2, 65000.00, '2023-02-20'),
(3, 3, 40000.00, '2023-03-25'),
(4, 4, 50000.00, '2023-04-30'),
(5, 5, 100000.00, '2022-12-12');

INSERT INTO dbo.Sale (ClientId, EquipmentId, TransactionId, SaleTime, Quantity, Price)
VALUES
(1, 1, 1, '2024-01-01 10:00:00', 1, 199.99),
(2, 2, 2, '2024-01-01 11:00:00', 1, 89.99),
(3, 3, 3, '2024-01-01 12:00:00', 2, 59.98),
(4, 4, 4, '2024-01-01 13:00:00', 1, 79.99);

INSERT INTO dbo.ServiceUsage (ClientId, ServiceId, TransactionId, StartDate, EndDate)
VALUES
(1, 1, 1, '2024-01-01', '2024-01-31'),
(2, 2, 2, '2024-01-01', '2024-01-31'),
(3, 3, 3, '2024-01-01', '2024-01-31'),
(4, 4, 4, '2024-01-01', '2024-01-31');

INSERT INTO dbo.SupportRequest (ClientId, RequestText, RequestTime, CompletionTime, Cost, TransactionId)
VALUES
(1, 'Connection issues', '2024-01-01 10:00:00', '2024-01-01 11:00:00', 0.00, 1),
(2, 'Router setup help', '2024-01-01 12:00:00', '2024-01-01 13:00:00', 29.99, 2),
(3, 'Speed upgrade request', '2024-01-01 14:00:00', '2024-01-01 15:00:00', 0.00, 3),
(4, 'WiFi configuration', '2024-01-01 16:00:00', '2024-01-01 17:00:00', 19.99, 4);

INSERT INTO dbo.ClientService (ClientId, ServiceId)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

INSERT INTO dbo.InternetSession (ClientId, StartTime, EndTime, TrafficUsedGb)
VALUES
(1, '2024-01-01 08:00:00', '2024-01-01 10:00:00', 5),
(2, '2024-01-01 09:00:00', '2024-01-01 11:00:00', 8),
(3, '2024-01-01 10:00:00', '2024-01-01 12:00:00', 12),
(4, '2024-01-01 11:00:00', '2024-01-01 13:00:00', 15);

INSERT INTO dbo.Review (ClientId, ReviewType, ReviewText, Score, ReviewTime, EquipmentId, TariffId, ServiceId, SupportRequestId)
VALUES
(1, 1, 'Great service overall', 9, '2024-01-02 10:00:00', NULL, NULL, 1, NULL),
(2, 2, 'Speed as advertised', 8, '2024-01-02 11:00:00', NULL, 1, NULL, NULL),
(3, 3, 'Helpful support team', 9, '2024-01-02 12:00:00', NULL, NULL, NULL, 1),
(4, 5, 'Fair price!', 10, '2024-01-02 13:00:00', 1, NULL, NULL, NULL);