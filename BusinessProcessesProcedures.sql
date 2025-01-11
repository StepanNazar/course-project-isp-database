CREATE OR ALTER PROCEDURE dbo.usp_ChangeTariff
    @ClientId INT,
    @TariffId INT
AS
BEGIN
    BEGIN TRY
        DECLARE @price DECIMAL(19,4)
        SELECT TOP 1 @price = Price
        FROM dbo.Tariff
        WHERE Id = @TariffId AND IsActive = 1;

        IF @price IS NULL
        BEGIN
            PRINT 'Invaid TariffId'
            RETURN
        END

        DECLARE @balance DECIMAL(19,4), @oldTariffId INT
        SELECT TOP 1 @balance = Balance, @oldTariffId = CurrentTariffId
        FROM dbo.Client
        WHERE Id = @ClientId;

        IF @price > @balance
        BEGIN
            PRINT 'Not enough money'
            RETURN
        END
		print '4'
		SET @balance = @balance - @price;
		EXEC dbo.usp_SetClient
		@id = @ClientId,
		@Balance = @balance,
		@CurrentTariffId = @TariffId,
		@HourlyTraffic = 0,
        @DailyTraffic = 0,
        @MonthlyTraffic = 0
		print '5'

		DECLARE @TransactionId INT
		EXEC dbo.usp_SetTransaction
		@Id = @TransactionId OUTPUT,
		@ClientId = @ClientId,
		@Amount = @price,
		@TransactionType = 3

		DECLARE @TariffUsageId INT, @EndDate DATE
		SELECT TOP 1 @TariffUsageId = Id, @EndDate = EndDate
		FROM dbo.TariffUsage
		WHERE ClientId = @ClientId AND TariffId = @oldTariffId
		ORDER BY EndDate DESC

		DECLARE @Today DATE = GETDATE()
		IF @EndDate IS NOT NULL AND @EndDate > @Today
		BEGIN
			EXEC dbo.usp_SetTariffUsage
			@id = @TariffUsageId,
			@EndDate = @today
		END
		print 6
		EXEC dbo.usp_SetTariffUsage
		@ClientId = @ClientId,
		@TariffId = @TariffId,
		@TransactionId = @TransactionId;
		print 7
    END TRY
    BEGIN CATCH
		PRINT ERROR_MESSAGE()
	END CATCH
END;
GO

CREATE OR ALTER PROCEDURE dbo.usp_AutoRenewalTariff
    @ClientId INT
AS
BEGIN
    BEGIN TRY
        DECLARE @TariffId INT
        SELECT TOP 1 @TariffId = CurrentTariffId
        FROM dbo.Client
        WHERE Id = @ClientId;
        IF @TariffId IS NULL
        BEGIN
            RETURN
        END

        DECLARE @price DECIMAL(19,4), @balance DECIMAL(19,4)
        SELECT TOP 1 @price = Price
        FROM dbo.Tariff
        WHERE Id = @TariffId AND IsActive = 1;
        SELECT TOP 1 @balance = Balance
        FROM dbo.Client
        WHERE Id = @ClientId;
        IF @price > @balance
        BEGIN
			PRINT 'Not enough money'
			UPDATE dbo.Client
			SET CurrentTariffId = NULL
			WHERE id = @ClientId
            RETURN
        END

        SET @balance = @balance - @price;
        EXEC dbo.usp_SetClient
        @Id = @ClientId,
        @Balance = @balance,
        @HourlyTraffic = 0,
        @DailyTraffic = 0,
        @MonthlyTraffic = 0

        DECLARE @TransactionId INT
		EXEC dbo.usp_SetTransaction
		@Id = @TransactionId OUTPUT,
        @ClientId = @ClientId,
        @Amount = @price,
        @TransactionType = 3

		EXEC dbo.usp_SetTariffUsage
		@ClientId = @ClientId,
		@TariffId = @TariffId,
		@TransactionId = @TransactionId;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE dbo.usp_AccountDeposit
    @Amount DECIMAL(19,4),
    @ClientId INT
AS
BEGIN
    BEGIN TRY
        DECLARE @balance DECIMAL(19,4)
        SELECT TOP 1 @balance = Balance
        FROM dbo.Client
        WHERE Id = @ClientId;
        SET @balance = @balance + @Amount

        EXEC dbo.usp_SetTransaction
        @ClientId = @ClientId,
        @Amount = @Amount,
        @TransactionType = 2

        EXEC dbo.usp_SetClient
        @Id = @ClientId,
        @Balance = @balance
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE dbo.usp_BuyEquipment
    @Quantity SMALLINT,
    @ClientId INT,
    @EquipmentId INT
AS
BEGIN
    BEGIN TRY
        DECLARE @AvailableQuantity SMALLINT, @NewQuantity SMALLINT, 
                @Price DECIMAL(19,4), @Balance DECIMAL(19,4), @TotalCost DECIMAL(19,4)
        
        SELECT TOP 1 @Price = Price, @AvailableQuantity = Quantity
        FROM dbo.Equipment
        WHERE Id = @EquipmentId;
        
        IF @AvailableQuantity IS NULL OR @AvailableQuantity < @Quantity
        BEGIN
            PRINT 'Not enough items'
            RETURN
        END

        SELECT TOP 1 @Balance = Balance
        FROM dbo.Client
        WHERE Id = @ClientId;
        
        SET @TotalCost = @Price * @Quantity
        IF @Balance < @TotalCost
        BEGIN
            PRINT 'Not enough money'
            RETURN
        END

        SET @NewQuantity = @AvailableQuantity - @Quantity
        EXEC dbo.usp_SetEquipment
        @Id = @EquipmentId,
        @Quantity = @NewQuantity

        SET @Balance = @Balance - @TotalCost
        EXEC dbo.usp_SetClient
        @Id = @ClientId,
        @Balance = @Balance

        DECLARE @TransactionId INT
		EXEC dbo.usp_SetTransaction
		@Id = @TransactionId OUTPUT,
        @ClientId = @ClientId,
        @Amount = @TotalCost,
        @TransactionType = 4

        EXEC dbo.usp_SetSale
        @ClientId = @ClientId,
        @EquipmentId = @EquipmentId,
        @Quantity = @Quantity,
        @Price = @Price,
		@TransactionId = @TransactionId;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END;
GO


-- example of usage
SELECT * FROM dbo.Client
SELECT * FROM dbo.[Transaction]
SELECT * FROM dbo.TariffUsage
SELECT * FROM dbo.Equipment
SELECT * FROM dbo.Sale

DECLARE @id INT
EXEC dbo.usp_SetClient
@id = @id OUTPUT,
@FirstName = 'test1234',
@LastName = 'test1234',
@Email = 'test1234@email.com',
@IpAddress = 0x0A5B5424,
@PasswordHash = 'rg5df',
@Balance = 0
PRINT '1'
EXEC dbo.usp_AccountDeposit
@Amount = 1000,
@ClientId = @id
PRINT '2'
EXEC dbo.usp_ChangeTariff
@TariffId = 1,
@ClientId = @id
PRINT '3'
EXEC dbo.usp_BuyEquipment
@ClientId = @id,
@Quantity = 4,
@EquipmentId = 1

SELECT * FROM dbo.Client
SELECT * FROM dbo.[Transaction]
SELECT * FROM dbo.TariffUsage
SELECT * FROM dbo.Equipment
SELECT * FROM dbo.Sale