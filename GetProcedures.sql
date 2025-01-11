CREATE OR ALTER PROCEDURE dbo.usp_GetTariffs
    @Id INT = NULL,
    @Name NVARCHAR(70) = NULL,
    @SpeedMbpsMin INT = NULL,
    @SpeedMbpsMax INT = NULL,
    @MonthlyLimitGbMin SMALLINT = NULL,
    @MonthlyLimitGbMax SMALLINT = NULL,
    @DailyLimitGbMin SMALLINT = NULL,
    @DailyLimitGbMax SMALLINT = NULL,
    @HourlyLimitGbMin SMALLINT = NULL,
    @HourlyLimitGbMax SMALLINT = NULL,
    @PriceMin DECIMAL(19,4) = NULL,
    @PriceMax DECIMAL(19,4) = NULL,
    @DurationMin SMALLINT = NULL,
    @DurationMax SMALLINT = NULL,
    @IsActive BIT = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'Id',
    @SortDirection BIT = 0
AS
BEGIN
    IF @Id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM dbo.Tariff WHERE Id = @Id)
    BEGIN
        PRINT 'Incorrect value of @Id'
		RETURN
    END

    SELECT *
    FROM dbo.Tariff
    WHERE (@Id IS NULL OR Id = @Id)
    AND (@Name IS NULL OR [Name] LIKE '%' + @Name + '%')
    AND (@SpeedMbpsMin IS NULL OR SpeedMbps >= @SpeedMbpsMin)
    AND (@SpeedMbpsMax IS NULL OR SpeedMbps <= @SpeedMbpsMax)
    AND (@MonthlyLimitGbMin IS NULL OR MonthlyLimitGb >= @MonthlyLimitGbMin)
    AND (@MonthlyLimitGbMax IS NULL OR MonthlyLimitGb <= @MonthlyLimitGbMax)
    AND (@DailyLimitGbMin IS NULL OR DailyLimitGb >= @DailyLimitGbMin)
    AND (@DailyLimitGbMax IS NULL OR DailyLimitGb <= @DailyLimitGbMax)
    AND (@HourlyLimitGbMin IS NULL OR HourlyLimitGb >= @HourlyLimitGbMin)
    AND (@HourlyLimitGbMax IS NULL OR HourlyLimitGb <= @HourlyLimitGbMax)
    AND (@PriceMin IS NULL OR Price >= @PriceMin)
    AND (@PriceMax IS NULL OR Price <= @PriceMax)
    AND (@DurationMin IS NULL OR DurationDays >= @DurationMin)
    AND (@DurationMax IS NULL OR DurationDays <= @DurationMax)
    AND (@IsActive IS NULL OR IsActive = @IsActive)
    ORDER BY
    CASE WHEN @SortDirection = 0 AND @SortColumn = 'Id' THEN Id END ASC,
    CASE WHEN @SortDirection = 0 AND @SortColumn = 'Name' THEN [Name] END ASC,
    CASE WHEN @SortDirection = 0 AND @SortColumn = 'SpeedMbps' THEN SpeedMbps END ASC,
    CASE WHEN @SortDirection = 0 AND @SortColumn = 'Price' THEN Price END ASC,
    CASE WHEN @SortDirection = 1 AND @SortColumn = 'Id' THEN Id END DESC,
    CASE WHEN @SortDirection = 1 AND @SortColumn = 'Name' THEN [Name] END DESC,
    CASE WHEN @SortDirection = 1 AND @SortColumn = 'SpeedMbps' THEN SpeedMbps END DESC,
    CASE WHEN @SortDirection = 1 AND @SortColumn = 'Price' THEN Price END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END;
GO

CREATE OR ALTER PROCEDURE dbo.usp_GetEquipment
    @Id INT = NULL,
    @Name NVARCHAR(70) = NULL,
    @Description NVARCHAR(MAX) = NULL,
    @EquipmentType INT = NULL,
    @PriceMin DECIMAL(19,4) = NULL,
    @PriceMax DECIMAL(19,4) = NULL,
    @QuantityMin SMALLINT = NULL,
    @QuantityMax SMALLINT = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'Id',
    @SortDirection BIT = 0
AS
BEGIN
    IF @Id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM dbo.Equipment WHERE Id = @Id)
    BEGIN
        PRINT 'Incorrect value of @Id'
		RETURN
    END

    SELECT e.*, et.[Name] AS EquipmentTypeName
    FROM dbo.Equipment e
    JOIN dbo.EquipmentType et ON e.EquipmentType = et.Id
    WHERE (@Id IS NULL OR e.Id = @Id)
    AND (@Name IS NULL OR e.[Name] LIKE '%' + @Name + '%')
    AND (@Description IS NULL OR e.[Description] LIKE '%' + @Description + '%')
    AND (@EquipmentType IS NULL OR e.EquipmentType = @EquipmentType)
    AND (@PriceMin IS NULL OR e.Price >= @PriceMin)
    AND (@PriceMax IS NULL OR e.Price <= @PriceMax)
    AND (@QuantityMin IS NULL OR e.Quantity >= @QuantityMin)
    AND (@QuantityMax IS NULL OR e.Quantity <= @QuantityMax)
    ORDER BY
    CASE WHEN @SortDirection = 0 AND @SortColumn = 'Id' THEN e.Id END ASC,
    CASE WHEN @SortDirection = 0 AND @SortColumn = 'Name' THEN e.[Name] END ASC,
    CASE WHEN @SortDirection = 0 AND @SortColumn = 'Price' THEN e.Price END ASC,
    CASE WHEN @SortDirection = 0 AND @SortColumn = 'Quantity' THEN e.Quantity END ASC,
    CASE WHEN @SortDirection = 1 AND @SortColumn = 'Id' THEN e.Id END DESC,
    CASE WHEN @SortDirection = 1 AND @SortColumn = 'Name' THEN e.[Name] END DESC,
    CASE WHEN @SortDirection = 1 AND @SortColumn = 'Price' THEN e.Price END DESC,
    CASE WHEN @SortDirection = 1 AND @SortColumn = 'Quantity' THEN e.Quantity END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END;
GO

CREATE OR ALTER PROCEDURE dbo.usp_GetEmployees
    @Id INT = NULL,
    @FirstName NVARCHAR(50) = NULL,
    @LastName NVARCHAR(50) = NULL,
    @Email NVARCHAR(50) = NULL,
    @Phone NVARCHAR(20) = NULL,
    @Position INT = NULL,
    @SalaryMin DECIMAL(19,4) = NULL,
    @SalaryMax DECIMAL(19,4) = NULL,
    @HireDateStart DATE = NULL,
    @HireDateEnd DATE = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'Id',
    @SortDirection BIT = 0
AS
BEGIN
    IF @Id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM dbo.Employee WHERE Id = @Id)
    BEGIN
        PRINT 'Incorrect value of @Id'
		RETURN
    END

    SELECT 
        e.Id AS EmployeeId,
        e.Position,
        p.[Name] AS PositionName,
        e.Salary,
        e.HireDate,
        e.TerminationDate,
        per.Id AS PersonId,
        per.FirstName,
        per.LastName,
        per.Email,
        per.Phone,
        per.[Address]
    FROM dbo.Employee e
    JOIN dbo.Person per ON e.PersonId = per.Id
    JOIN dbo.Position p ON e.Position = p.Id
    WHERE (@Id IS NULL OR e.Id = @Id)
    AND (@FirstName IS NULL OR per.FirstName LIKE '%' + @FirstName + '%')
    AND (@LastName IS NULL OR per.LastName LIKE '%' + @LastName + '%')
    AND (@Email IS NULL OR per.Email LIKE '%' + @Email + '%')
    AND (@Phone IS NULL OR per.Phone LIKE '%' + @Phone + '%')
    AND (@Position IS NULL OR e.Position = @Position)
    AND (@SalaryMin IS NULL OR e.Salary >= @SalaryMin)
    AND (@SalaryMax IS NULL OR e.Salary <= @SalaryMax)
    AND (@HireDateStart IS NULL OR e.HireDate >= @HireDateStart)
    AND (@HireDateEnd IS NULL OR e.HireDate <= @HireDateEnd)
    ORDER BY
    CASE WHEN @SortDirection = 0 AND @SortColumn = 'Id' THEN e.Id END ASC,
    CASE WHEN @SortDirection = 0 AND @SortColumn = 'LastName' THEN per.LastName END ASC,
    CASE WHEN @SortDirection = 0 AND @SortColumn = 'Salary' THEN e.Salary END ASC,
    CASE WHEN @SortDirection = 0 AND @SortColumn = 'HireDate' THEN e.HireDate END ASC,
    CASE WHEN @SortDirection = 1 AND @SortColumn = 'Id' THEN e.Id END DESC,
    CASE WHEN @SortDirection = 1 AND @SortColumn = 'LastName' THEN per.LastName END DESC,
    CASE WHEN @SortDirection = 1 AND @SortColumn = 'Salary' THEN e.Salary END DESC,
    CASE WHEN @SortDirection = 1 AND @SortColumn = 'HireDate' THEN e.HireDate END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END;
GO

EXEC dbo.usp_GetTariffs
@id = 5,
@SortColumn = 'SpeedMbps',
@SortDirection = 0

EXEC dbo.usp_GetTariffs
@PriceMin = 45,
@SortColumn = 'Price',
@SortDirection = 1

EXEC dbo.usp_GetEquipment
@SortColumn = 'Price',
@SortDirection = 1

EXEC dbo.usp_GetEquipment
@EquipmentType = 2,
@QuantityMin = 10,
@SortColumn = 'Quantity',
@SortDirection = 1

EXEC dbo.usp_GetEmployees


EXEC dbo.usp_GetEmployees
@SalaryMin = 4500,
@SortColumn = 'Salary',
@SortDirection = 1