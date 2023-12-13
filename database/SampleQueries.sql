-- calculate average salary by department (without window function)
SELECT department, AVG(salary)
FROM [dbo].[Employees]
GROUP BY department;

-- with window function
SELECT Id,
       department,
       salary,
       AVG(salary) OVER (PARTITION BY department) AS dept_avg
FROM [dbo].[Employees];

 SELECT Id,
       department,
       salary,
       AVG(salary) OVER (PARTITION BY department) AS dept_avg,
       MIN(salary) OVER (PARTITION BY department) AS dept_min,
       MAX(salary) OVER (PARTITION BY department) AS dept_max
FROM [dbo].[Employees];

-- add the salary rank overall the company
SELECT Id,
    department,
    salary,
    AVG(salary) OVER (PARTITION BY department) AS dept_avg,
    RANK() OVER(ORDER BY salary DESC) AS overall_rank
FROM [dbo].[Employees];

--add the saalry rank by department
SELECT Id,
    department,
    salary,
    AVG(salary) OVER (PARTITION BY department) AS dept_avg,
    RANK() OVER(ORDER BY salary DESC) AS overall_rank,
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_rank
FROM [dbo].[Employees];