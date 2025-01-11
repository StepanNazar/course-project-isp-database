SELECT c.Id AS ClientId,
       CASE
           WHEN CurrentTariffId IS NOT NULL THEN 1
           ELSE 0
       END AS InternetPaid,
       CASE 
           WHEN tu.MonthlyLimitGb - c.MonthlyTraffic < 0 THEN 0 
           ELSE tu.MonthlyLimitGb - c.MonthlyTraffic 
       END AS MonthlyGbRemaining,
       CASE 
           WHEN tu.DailyLimitGb - c.DailyTraffic < 0 THEN 0 
           ELSE tu.DailyLimitGb - c.DailyTraffic 
       END AS DailyGbRemaining,
       CASE 
           WHEN tu.HourlyLimitGb - c.HourlyTraffic < 0 THEN 0 
           ELSE tu.HourlyLimitGb - c.HourlyTraffic 
       END AS HourlyGbRemaining,
       CASE 
           WHEN DATEDIFF(day, GETDATE(), tu.EndDate) < 0 THEN 0 
           ELSE DATEDIFF(day, GETDATE(), tu.EndDate)
       END AS DaysLeft
FROM dbo.Client c
CROSS APPLY (
    SELECT TOP 1 tu.ClientId, tu.EndDate, t.MonthlyLimitGb, t.DailyLimitGb, t.HourlyLimitGb
    FROM dbo.TariffUsage tu
    JOIN dbo.Tariff t ON tu.TariffId = t.Id
    WHERE c.Id = tu.ClientId
    ORDER BY tu.EndDate DESC
) tu;
GO

SELECT AVG(CAST(r.Score AS DECIMAL(5,2))) as AvgScore, 
       rt.[Name]
FROM dbo.Review r
JOIN dbo.ReviewType rt ON r.ReviewType = rt.Id
WHERE r.ReviewTime >= DATEADD(year, -1, GETDATE())
GROUP BY rt.[Name];
GO

SELECT ClientId, YEAR(StartTime) AS Year, MONTH(StartTime) AS Month, SUM(TrafficUsedGb) AS MonthUsage
FROM dbo.InternetSession
JOIN dbo.Client c ON ClientId = c.Id
GROUP BY ClientId, YEAR(StartTime), MONTH(StartTime);
GO

SELECT 
    YEAR(tu.StartDate) as [Year], 
    MONTH(tu.StartDate) as [Month], 
    t.Id as TariffId,
    SUM(t.Price) as TotalPrice
FROM dbo.TariffUsage tu
JOIN dbo.Tariff t ON tu.TariffId = t.Id
GROUP BY YEAR(tu.StartDate), MONTH(tu.StartDate), t.Id;
GO

SELECT 
    SUM(s.Price * s.Quantity) as TotalPrice,
    SUM(s.Quantity) as TotalQuantity,
    et.[Name] as [Type], 
    YEAR(s.SaleTime) as [Year], 
    MONTH(s.SaleTime) as [Month]
FROM dbo.Sale s
JOIN dbo.Equipment e ON s.EquipmentId = e.Id
JOIN dbo.EquipmentType et ON e.EquipmentType = et.Id
GROUP BY YEAR(s.SaleTime), MONTH(s.SaleTime), et.[Name];
GO