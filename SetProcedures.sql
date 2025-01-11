CREATE OR ALTER PROCEDURE dbo.usp_SetEquipmentType
@id INT = NULL OUTPUT,
@Name NVARCHAR(70) = NULL
AS
BEGIN
    IF @id IS NULL AND @Name IS NULL
    BEGIN
        PRINT 'Invalid input'
        RETURN
    END
    BEGIN TRY
        IF @id IS NULL
        BEGIN
            INSERT dbo.EquipmentType([Name])
            VALUES(@Name)
            SET @id = SCOPE_IDENTITY()
        END
        ELSE
            UPDATE TOP(1) dbo.EquipmentType
            SET [Name] = ISNULL(@Name, [Name])
            WHERE Id = @id
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_SetEquipment
@id INT = NULL OUTPUT,
@Name NVARCHAR(70) = NULL,
@Description NVARCHAR(MAX) = NULL,
@EquipmentType INT = NULL,
@Price DECIMAL(19,4) = NULL,
@Quantity SMALLINT = NULL
AS
BEGIN
    IF @id IS NULL AND (@Name IS NULL OR @EquipmentType IS NULL OR @Price IS NULL OR @Quantity IS NULL)
    BEGIN
        PRINT 'Invalid input'
        RETURN
    END
    BEGIN TRY
        IF @id IS NULL
        BEGIN
            INSERT dbo.Equipment([Name], [Description], EquipmentType, Price, Quantity)
            VALUES(@Name, @Description, @EquipmentType, @Price, @Quantity)
            SET @id = SCOPE_IDENTITY()
        END
        ELSE
            UPDATE TOP(1) dbo.Equipment
            SET [Name] = ISNULL(@Name, [Name]),
                [Description] = ISNULL(@Description, [Description]),
                EquipmentType = ISNULL(@EquipmentType, EquipmentType),
                Price = ISNULL(@Price, Price),
                Quantity = ISNULL(@Quantity, Quantity)
            WHERE Id = @id
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_SetTariff
@id INT = NULL OUTPUT,
@Name NVARCHAR(70) = NULL,
@DurationDays SMALLINT = NULL,
@SpeedMbps INT = NULL,
@MonthlyLimitGb SMALLINT = NULL,
@DailyLimitGb SMALLINT = NULL,
@HourlyLimitGb SMALLINT = NULL,
@Price DECIMAL(19,4) = NULL,
@IsActive BIT = NULL
AS
BEGIN
    IF @id IS NULL AND (@Name IS NULL OR @SpeedMbps IS NULL OR @Price IS NULL OR @DurationDays IS NULL OR @IsActive IS NULL)
    BEGIN
        PRINT 'Invalid input'
        RETURN
    END
    BEGIN TRY
        IF @id IS NULL
        BEGIN
            INSERT dbo.Tariff([Name], DurationDays, SpeedMbps, MonthlyLimitGb, DailyLimitGb, HourlyLimitGb, Price, IsActive)
            VALUES(@Name, @DurationDays, @SpeedMbps, @MonthlyLimitGb, @DailyLimitGb, @HourlyLimitGb, @Price, @IsActive)
            SET @id = SCOPE_IDENTITY()
        END
        ELSE
            UPDATE TOP(1) dbo.Tariff
            SET [Name] = ISNULL(@Name, [Name]),
                DurationDays = ISNULL(@DurationDays, DurationDays),
                SpeedMbps = ISNULL(@SpeedMbps, SpeedMbps),
                MonthlyLimitGb = ISNULL(@MonthlyLimitGb, MonthlyLimitGb),
                DailyLimitGb = ISNULL(@DailyLimitGb, DailyLimitGb),
                HourlyLimitGb = ISNULL(@HourlyLimitGb, HourlyLimitGb),
                Price = ISNULL(@Price, Price),
                IsActive = ISNULL(@IsActive, IsActive)
            WHERE Id = @id
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_SetReviewType
@id INT = NULL OUTPUT,
@Name NVARCHAR(70) = NULL
AS
BEGIN
    IF @id IS NULL AND @Name IS NULL
    BEGIN
        PRINT 'Invalid input'
        RETURN
    END
    BEGIN TRY
        IF @id IS NULL
        BEGIN
            INSERT dbo.ReviewType([Name])
            VALUES(@Name)
            SET @id = SCOPE_IDENTITY()
        END
        ELSE
            UPDATE TOP(1) dbo.ReviewType
            SET [Name] = ISNULL(@Name, [Name])
            WHERE Id = @id
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_SetReview
@id INT = NULL OUTPUT,
@ReviewType INT = NULL,
@ClientId INT = NULL,
@ReviewText NVARCHAR(1000) = NULL,
@Score TINYINT = NULL,
@ReviewTime DATETIME2(2) = NULL,
@EquipmentId INT = NULL,
@TariffId INT = NULL,
@ServiceId INT = NULL,
@SupportRequestId INT = NULL
AS
BEGIN
    IF @id IS NULL AND (@ReviewType IS NULL OR @ClientId IS NULL OR @Score IS NULL)
    BEGIN
        PRINT 'Invalid input'
        RETURN
    END
    IF @Score < 1 OR @Score > 10
    BEGIN
        PRINT 'Score must be between 1 and 10'
        RETURN
    END
    BEGIN TRY
        IF @id IS NULL
        BEGIN
            SET @ReviewTime = ISNULL(@ReviewTime, GETDATE())
            INSERT dbo.Review(ReviewType, ClientId, ReviewText, Score, ReviewTime, 
                            EquipmentId, TariffId, ServiceId, SupportRequestId)
            VALUES(@ReviewType, @ClientId, @ReviewText, @Score, @ReviewTime,
                  @EquipmentId, @TariffId, @ServiceId, @SupportRequestId)
            SET @id = SCOPE_IDENTITY()
        END
        ELSE
            UPDATE TOP(1) dbo.Review
            SET ReviewType = ISNULL(@ReviewType, ReviewType),
                ClientId = ISNULL(@ClientId, ClientId),
                ReviewText = ISNULL(@ReviewText, ReviewText),
                Score = ISNULL(@Score, Score),
                ReviewTime = ISNULL(@ReviewTime, ReviewTime),
                EquipmentId = ISNULL(@EquipmentId, EquipmentId),
                TariffId = ISNULL(@TariffId, TariffId),
                ServiceId = ISNULL(@ServiceId, ServiceId),
                SupportRequestId = ISNULL(@SupportRequestId, SupportRequestId)
            WHERE Id = @id
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_SetPosition
@id INT = NULL OUTPUT,
@Name NVARCHAR(70) = NULL
AS
BEGIN
    IF @id IS NULL AND @Name IS NULL
    BEGIN
        PRINT 'Invalid input'
        RETURN
    END
    BEGIN TRY
        IF @id IS NULL
        BEGIN
            INSERT dbo.Position([Name])
            VALUES(@Name)
            SET @id = SCOPE_IDENTITY()
        END
        ELSE
            UPDATE TOP(1) dbo.Position
            SET [Name] = ISNULL(@Name, [Name])
            WHERE Id = @id
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_SetTransactionType
@id INT = NULL OUTPUT,
@Name NVARCHAR(70) = NULL
AS
BEGIN
    IF @id IS NULL AND @Name IS NULL
    BEGIN
        PRINT 'Invalid input'
        RETURN
    END
    BEGIN TRY
        IF @id IS NULL
        BEGIN
            INSERT dbo.TransactionType([Name])
            VALUES(@Name)
            SET @id = SCOPE_IDENTITY()
        END
        ELSE
            UPDATE TOP(1) dbo.TransactionType
            SET [Name] = ISNULL(@Name, [Name])
            WHERE Id = @id
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_SetSale
@id INT = NULL OUTPUT,
@ClientId INT = NULL,
@EquipmentId INT = NULL,
@TransactionId INT = NULL,
@SaleTime DATETIME2(2) = NULL,
@Quantity SMALLINT = NULL,
@Price DECIMAL(19,4) = NULL
AS
BEGIN
    IF @id IS NULL AND (@ClientId IS NULL OR @EquipmentId IS NULL OR @TransactionId IS NULL OR @Quantity IS NULL OR @Price IS NULL)
    BEGIN
        PRINT 'Invalid input'
        RETURN
    END
    BEGIN TRY
        IF @id IS NULL
        BEGIN
            SET @SaleTime = ISNULL(@SaleTime, GETDATE())
            INSERT dbo.Sale(ClientId, EquipmentId, TransactionId, SaleTime, Quantity, Price)
            VALUES(@ClientId, @EquipmentId, @TransactionId, @SaleTime, @Quantity, @Price)
            SET @id = SCOPE_IDENTITY()
        END
        ELSE
            UPDATE TOP(1) dbo.Sale
            SET ClientId = ISNULL(@ClientId, ClientId),
                EquipmentId = ISNULL(@EquipmentId, EquipmentId),
                TransactionId = ISNULL(@TransactionId, TransactionId),
                SaleTime = ISNULL(@SaleTime, SaleTime),
                Quantity = ISNULL(@Quantity, Quantity),
                Price = ISNULL(@Price, Price)
            WHERE Id = @id
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_SetSupportRequest
@id INT = NULL OUTPUT,
@ClientId INT = NULL,
@RequestText NVARCHAR(1000) = NULL,
@RequestTime DATETIME2(2) = NULL,
@CompletionTime DATETIME2(2) = NULL,
@Cost DECIMAL(19,4) = NULL,
@TransactionId INT = NULL
AS
BEGIN
    IF @id IS NULL AND (@ClientId IS NULL OR @Cost IS NULL OR @TransactionId IS NULL)
    BEGIN
        PRINT 'Invalid input'
        RETURN
    END
    BEGIN TRY
        IF @id IS NULL
        BEGIN
            SET @RequestTime = ISNULL(@RequestTime, GETDATE())
            INSERT dbo.SupportRequest(ClientId, RequestText, RequestTime, CompletionTime, Cost, TransactionId)
            VALUES(@ClientId, @RequestText, @RequestTime, @CompletionTime, @Cost, @TransactionId)
            SET @id = SCOPE_IDENTITY()
        END
        ELSE
            UPDATE TOP(1) dbo.SupportRequest
            SET ClientId = ISNULL(@ClientId, ClientId),
                RequestText = ISNULL(@RequestText, RequestText),
                RequestTime = ISNULL(@RequestTime, RequestTime),
                CompletionTime = ISNULL(@CompletionTime, CompletionTime),
                Cost = ISNULL(@Cost, Cost),
                TransactionId = ISNULL(@TransactionId, TransactionId)
            WHERE Id = @id
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_SetInternetSession
@id INT = NULL OUTPUT,
@ClientId INT = NULL,
@StartTime DATETIME2(2) = NULL,
@EndTime DATETIME2(2) = NULL,
@TrafficUsedGb SMALLINT = NULL
AS
BEGIN
    IF @id IS NULL AND (@ClientId IS NULL OR @StartTime IS NULL OR @TrafficUsedGb IS NULL)
    BEGIN
        PRINT 'Invalid input'
        RETURN
    END
    BEGIN TRY
        IF @id IS NULL
        BEGIN
            SET @EndTime = ISNULL(@EndTime, GETDATE())
            INSERT dbo.InternetSession(ClientId, StartTime, EndTime, TrafficUsedGb)
            VALUES(@ClientId, @StartTime, @EndTime, @TrafficUsedGb)
            SET @id = SCOPE_IDENTITY()
        END
        ELSE
            UPDATE TOP(1) dbo.InternetSession
            SET ClientId = ISNULL(@ClientId, ClientId),
                StartTime = ISNULL(@StartTime, StartTime),
                EndTime = ISNULL(@EndTime, EndTime),
                TrafficUsedGb = ISNULL(@TrafficUsedGb, TrafficUsedGb)
            WHERE Id = @id
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_SetTransaction
@id INT = NULL OUTPUT,
@ClientId INT = NULL,
@TransactionType INT = NULL,
@Amount DECIMAL(19,4) = NULL,
@TransactionTime DATETIME2(2) = NULL
AS
BEGIN
    IF @id IS NULL AND (@ClientId IS NULL OR @Amount IS NULL OR @TransactionType IS NULL)
    BEGIN
        PRINT 'Invalid input'
        RETURN
    END
    BEGIN TRY
        IF @id IS NULL
        BEGIN
            SET @TransactionTime = ISNULL(@TransactionTime, GETDATE())
            INSERT dbo.[Transaction](ClientId, TransactionType, Amount, TransactionTime)
            VALUES(@ClientId, @TransactionType, @Amount, @TransactionTime)
            SET @id = SCOPE_IDENTITY()
        END
        ELSE
            UPDATE TOP(1) dbo.[Transaction]
            SET ClientId = ISNULL(@ClientId, ClientId),
                TransactionType = ISNULL(@TransactionType, TransactionType),
                Amount = ISNULL(@Amount, Amount),
                TransactionTime = ISNULL(@TransactionTime, TransactionTime)
            WHERE Id = @id
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_SetTariffUsage
@id INT = NULL OUTPUT,
@ClientId INT = NULL,
@TariffId INT = NULL,
@TransactionId INT = NULL,
@StartDate DATE = NULL,
@EndDate DATE = NULL
AS
BEGIN
    IF @id IS NULL AND (@ClientId IS NULL OR @TariffId IS NULL OR @TransactionId IS NULL)
    BEGIN
        PRINT 'Invalid input'
        RETURN
    END
    BEGIN TRY
        IF @id IS NULL
        BEGIN
            -- If start date not provided, use current date
            SET @StartDate = ISNULL(@StartDate, GETDATE())
    
            -- If end date not provided, calculate from tariff duration
            IF @EndDate IS NULL
            BEGIN
                SELECT @EndDate = DATEADD(day, DurationDays, @StartDate)
                FROM dbo.Tariff
                WHERE Id = @TariffId
            END
            INSERT dbo.TariffUsage(ClientId, TariffId, TransactionId, StartDate, EndDate)
            VALUES(@ClientId, @TariffId, @TransactionId, @StartDate, @EndDate)
            SET @id = SCOPE_IDENTITY()
        END
        ELSE
            UPDATE TOP(1) dbo.TariffUsage
            SET ClientId = ISNULL(@ClientId, ClientId),
                TariffId = ISNULL(@TariffId, TariffId),
                TransactionId = ISNULL(@TransactionId, TransactionId),
                StartDate = ISNULL(@StartDate, StartDate),
                EndDate = ISNULL(@EndDate, EndDate)
            WHERE Id = @id
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_SetPerson
@id INT = NULL OUTPUT,
@FirstName NVARCHAR(50) = NULL,
@LastName NVARCHAR(50) = NULL,
@Email NVARCHAR(50) = NULL,
@Phone NVARCHAR(20) = NULL,
@Address NVARCHAR(200) = NULL
AS
BEGIN
    IF @id IS NULL AND (@FirstName IS NULL OR @Email IS NULL)
    BEGIN
        PRINT 'Invalid input'
        RETURN
    END
    BEGIN TRY
        IF @id IS NULL
        BEGIN
            INSERT dbo.Person(FirstName, LastName, Email, Phone, [Address])
            VALUES(@FirstName, @LastName, @Email, @Phone, @Address)
            SET @id = SCOPE_IDENTITY()
        END
        ELSE
            UPDATE TOP(1) dbo.Person
            SET FirstName = ISNULL(@FirstName, FirstName),
                LastName = ISNULL(@LastName, LastName),
                Email = ISNULL(@Email, Email),
                Phone = ISNULL(@Phone, Phone),
                [Address] = ISNULL(@Address, [Address])
            WHERE Id = @id
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_SetEmployee
@id INT = NULL OUTPUT,
@Position INT = NULL,
@Salary DECIMAL(19,4) = NULL,
@PersonId INT = NULL,
@FirstName NVARCHAR(50) = NULL,
@LastName NVARCHAR(50) = NULL,
@Email NVARCHAR(50) = NULL,
@Phone NVARCHAR(20) = NULL,
@Address NVARCHAR(200) = NULL,
@HireDate DATE = NULL,
@TerminationDate DATE = NULL
AS
BEGIN
    BEGIN TRY
        -- Validate required fields for insert
        IF @id IS NULL AND (@Position IS NULL OR @Salary IS NULL OR 
            (@PersonId IS NULL AND (@FirstName IS NULL OR @Email IS NULL)))
        BEGIN
            PRINT 'Invalid input: Missing required fields'
            RETURN
        END

        IF @id IS NOT NULL AND @PersonId IS NOT NULL
        BEGIN
            PRINT 'Invalid input: Cannot change PersonId of existing Employee'
            RETURN
        END

        -- Check if PersonId already exists in Employee table
        IF @PersonId IS NOT NULL
        BEGIN
            IF EXISTS (SELECT 1 FROM dbo.Employee WHERE PersonId = @PersonId)
            BEGIN
                PRINT 'Error: Person is already assigned to another Employee'
                RETURN
            END
        END

        -- Create a new Person if needed
        IF @id IS NULL AND @PersonId IS NULL
        BEGIN
            DECLARE @NewPersonId INT
            EXEC dbo.usp_SetPerson 
                @id = @NewPersonId OUTPUT,
                @FirstName = @FirstName,
                @LastName = @LastName,
                @Email = @Email,
                @Phone = @Phone,
                @Address = @Address
            
            SET @PersonId = @NewPersonId
        END

        -- Set default HireDate if not provided
        SET @HireDate = ISNULL(@HireDate, GETDATE())

        -- New Employee
        IF @id IS NULL
        BEGIN
            INSERT dbo.Employee(Position, Salary, PersonId, HireDate, TerminationDate)
            VALUES(@Position, @Salary, @PersonId, @HireDate, @TerminationDate)
            SET @id = SCOPE_IDENTITY()
        END
        -- Update existing Employee (cannot update PersonId)
        ELSE
        BEGIN
            UPDATE TOP(1) dbo.Employee
            SET Position = ISNULL(@Position, Position),
                Salary = ISNULL(@Salary, Salary),
                HireDate = ISNULL(@HireDate, HireDate),
                TerminationDate = ISNULL(@TerminationDate, TerminationDate)
            WHERE Id = @id
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_SetClient
@id INT = NULL OUTPUT,
@PersonId INT = NULL,
@CurrentTariffId INT = NULL,
@PasswordHash VARCHAR(128) = NULL,
@Balance DECIMAL(19,4) = NULL,
@IpAddress BINARY(4) = NULL,
@HourlyTraffic SMALLINT = NULL,
@DailyTraffic SMALLINT = NULL,
@MonthlyTraffic SMALLINT = NULL,
@FirstName NVARCHAR(50) = NULL,
@LastName NVARCHAR(50) = NULL,
@Email NVARCHAR(50) = NULL,
@Phone NVARCHAR(20) = NULL,
@Address NVARCHAR(200) = NULL,
@RegistrationDate DATE = NULL
AS
BEGIN
    BEGIN TRY
        -- Validate required fields for insert
        IF @id IS NULL AND (@Balance IS NULL OR
            (@PersonId IS NULL AND (@FirstName IS NULL OR @Email IS NULL)))
        BEGIN
            PRINT 'Invalid input: Missing required fields'
            RETURN
        END
        
        -- Check for attempt to change PersonId of existing Client
        IF @id IS NOT NULL AND @PersonId IS NOT NULL
        BEGIN
            PRINT 'Invalid input: Cannot change PersonId of existing Client'
            RETURN
        END

        -- Check if PersonId already exists in Client table
        IF @PersonId IS NOT NULL
        BEGIN
            IF EXISTS (SELECT 1 FROM dbo.Client WHERE PersonId = @PersonId)
            BEGIN
                PRINT 'Error: Person is already assigned to another Client'
                RETURN
            END
        END

        -- Create a new Person if needed
        IF @id IS NULL AND @PersonId IS NULL
        BEGIN
            DECLARE @NewPersonId INT
            EXEC dbo.usp_SetPerson 
                @id = @NewPersonId OUTPUT,
                @FirstName = @FirstName,
                @LastName = @LastName,
                @Email = @Email,
                @Phone = @Phone,
                @Address = @Address
            
            SET @PersonId = @NewPersonId
        END

        -- Set default RegistrationDate if not provided
        SET @RegistrationDate = ISNULL(@RegistrationDate, GETDATE())

        -- New Client
        IF @id IS NULL
        BEGIN
            INSERT dbo.Client(
                PersonId,
                CurrentTariffId,
                PasswordHash,
                Balance,
                IpAddress,
                HourlyTraffic,
                DailyTraffic,
                MonthlyTraffic,
                RegistrationDate
            )
            VALUES(
                @PersonId,
                @CurrentTariffId,
                @PasswordHash,
                @Balance,
                @IpAddress,
                @HourlyTraffic,
                @DailyTraffic,
                @MonthlyTraffic,
                @RegistrationDate
            )
            SET @id = SCOPE_IDENTITY()
        END
        -- Update existing Client (cannot update PersonId)
        ELSE
        BEGIN
            UPDATE TOP(1) dbo.Client
            SET CurrentTariffId = ISNULL(@CurrentTariffId, CurrentTariffId),
                PasswordHash = ISNULL(@PasswordHash, PasswordHash),
                Balance = ISNULL(@Balance, Balance),
                IpAddress = ISNULL(@IpAddress, IpAddress),
                HourlyTraffic = ISNULL(@HourlyTraffic, HourlyTraffic),
                DailyTraffic = ISNULL(@DailyTraffic, DailyTraffic),
                MonthlyTraffic = ISNULL(@MonthlyTraffic, MonthlyTraffic)
            WHERE Id = @id
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO