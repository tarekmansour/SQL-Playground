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

SELECT 
    ROW_NUMBER() OVER (PARTITION BY PostalCode ORDER BY SalesYTD DESC) AS "Row Number",
    p.LastName,
    s.SalesYTD,
    a.PostalCode
FROM Sales.SalesPerson AS s
    INNER JOIN Person.Person AS p
        ON s.BusinessEntityID = p.BusinessEntityID
    INNER JOIN Person.Address AS a
        ON a.AddressID = p.BusinessEntityID
WHERE TerritoryID IS NOT NULL
    AND SalesYTD <> 0
ORDER BY PostalCode;

SELECT
    SalesOrderID AS OrderNumber,
    ProductID,
    OrderQty AS Qty,
    SUM(OrderQty) OVER (ORDER BY SalesOrderID, ProductID) AS Total,
    AVG(OrderQty) OVER(PARTITION BY SalesOrderID ORDER BY SalesOrderID, ProductID) AS Avg,
    COUNT(OrderQty) OVER(ORDER BY SalesOrderID, ProductID ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING) AS Count
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN(43659,43664) AND
    ProductID LIKE '71%';