ALTER TABLE dbo.Client
ADD CONSTRAINT FK_Client_Person 
FOREIGN KEY (PersonId) REFERENCES dbo.Person(Id);

ALTER TABLE dbo.Client
ADD CONSTRAINT FK_Client_Tariff 
FOREIGN KEY (CurrentTariffId) REFERENCES dbo.Tariff(Id);

ALTER TABLE dbo.TariffUsage
ADD CONSTRAINT FK_TariffUsage_Client 
FOREIGN KEY (ClientId) REFERENCES dbo.Client(Id);

ALTER TABLE dbo.TariffUsage
ADD CONSTRAINT FK_TariffUsage_Tariff 
FOREIGN KEY (TariffId) REFERENCES dbo.Tariff(Id);

ALTER TABLE dbo.InternetSession
ADD CONSTRAINT FK_InternetSession_Client 
FOREIGN KEY (ClientId) REFERENCES dbo.Client(Id);

ALTER TABLE dbo.Review
ADD CONSTRAINT FK_Review_Client 
FOREIGN KEY (ClientId) REFERENCES dbo.Client(Id);

ALTER TABLE dbo.Review
ADD CONSTRAINT FK_Review_ReviewType
FOREIGN KEY (ReviewType) REFERENCES dbo.ReviewType(Id);

ALTER TABLE dbo.Review
ADD CONSTRAINT FK_Review_Equipment 
FOREIGN KEY (EquipmentId) REFERENCES dbo.Equipment(Id);

ALTER TABLE dbo.Review
ADD CONSTRAINT FK_Review_Tariff 
FOREIGN KEY (TariffId) REFERENCES dbo.Tariff(Id);

ALTER TABLE dbo.Review
ADD CONSTRAINT FK_Review_Service 
FOREIGN KEY (ServiceId) REFERENCES dbo.[Service](Id);

ALTER TABLE dbo.Review
ADD CONSTRAINT FK_Review_SupportRequest
FOREIGN KEY (SupportRequestId) REFERENCES dbo.SupportRequest(Id);

ALTER TABLE dbo.Employee
ADD CONSTRAINT FK_Employee_Person 
FOREIGN KEY (PersonId) REFERENCES dbo.Person(Id);

ALTER TABLE dbo.Employee
ADD CONSTRAINT FK_Employee_Position 
FOREIGN KEY (Position) REFERENCES dbo.Position(Id);

ALTER TABLE dbo.[Transaction]
ADD CONSTRAINT FK_Transaction_Client 
FOREIGN KEY (ClientId) REFERENCES dbo.Client(Id);

ALTER TABLE dbo.[Transaction]
ADD CONSTRAINT FK_Transaction_TransactionType
FOREIGN KEY (TransactionType) REFERENCES dbo.TransactionType(Id);

ALTER TABLE dbo.Equipment
ADD CONSTRAINT FK_Equipment_EquipmentType
FOREIGN KEY (EquipmentType) REFERENCES dbo.EquipmentType(Id);

ALTER TABLE dbo.Sale
ADD CONSTRAINT FK_Sale_Client 
FOREIGN KEY (ClientId) REFERENCES dbo.Client(Id);

ALTER TABLE dbo.Sale
ADD CONSTRAINT FK_Sale_Equipment 
FOREIGN KEY (EquipmentId) REFERENCES dbo.Equipment(Id);

ALTER TABLE dbo.ServiceUsage
ADD CONSTRAINT FK_ServiceUsage_Client 
FOREIGN KEY (ClientId) REFERENCES dbo.Client(Id);

ALTER TABLE dbo.ServiceUsage
ADD CONSTRAINT FK_ServiceUsage_Service 
FOREIGN KEY (ServiceId) REFERENCES dbo.Service(Id);

ALTER TABLE dbo.SupportRequest
ADD CONSTRAINT FK_SupportRequest_Client 
FOREIGN KEY (ClientId) REFERENCES dbo.Client(Id);

ALTER TABLE dbo.ClientService
ADD CONSTRAINT FK_ClientService_Client 
FOREIGN KEY (ClientId) REFERENCES dbo.Client(Id);

ALTER TABLE dbo.ClientService
ADD CONSTRAINT FK_ClientService_Service 
FOREIGN KEY (ServiceId) REFERENCES dbo.Service(Id);

ALTER TABLE dbo.TariffUsage
ADD CONSTRAINT FK_TariffUsage_Transaction
FOREIGN KEY (TransactionId) REFERENCES dbo.[Transaction](Id);

ALTER TABLE dbo.Sale
ADD CONSTRAINT FK_Sale_Transaction
FOREIGN KEY (TransactionId) REFERENCES dbo.[Transaction](Id);

ALTER TABLE dbo.ServiceUsage
ADD CONSTRAINT FK_ServiceUsage_Transaction
FOREIGN KEY (TransactionId) REFERENCES dbo.[Transaction](Id);

ALTER TABLE dbo.SupportRequest
ADD CONSTRAINT FK_SupportRequest_Transaction
FOREIGN KEY (TransactionId) REFERENCES dbo.[Transaction](Id);