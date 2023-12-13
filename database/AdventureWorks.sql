-- with GROUP BY
SELECT
    BusinessEntityID,
    SUM(SalesYTD) as TotalSalesYTD
FROM [Sales].SalesPerson
GROUP BY BusinessEntityID

-- with window function, a SUM for all rows without partition
SELECT
    BusinessEntityID,
    SUM(SalesYTD) OVER() as TotalSalesYTD
FROM [Sales].SalesPerson

-- with window function and partition by BusinessEntityID
SELECT
    BusinessEntityID,
    SUM(SalesYTD) OVER(PARTITION BY BusinessEntityID) as TotalSalesYTD,
    RANK() OVER(ORDER BY SalesYTD DESC)
FROM [Sales].SalesPerson