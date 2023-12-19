# SQL-Playground
Learning SQL tips and sharing knowledge.

## Window Functions

- Window functions perform aggregate operations on groups of rows. But they **produce a result FOR EACH ROW**.

- `OVER()`, clause constructs a window. When it's empty, the window will include all records, e.g:
    ```SQL
    SELECT Id,
        department,
        salary,
        AVG(salary) OVER (PARTITION BY department) AS dept_avg
    FROM [dbo].[Employees];
    ```
    - in this example, we calculate the average salary for each department.

- We can use aggregate functions(`MIN`, `MAX`, `AVG`) to calculate some numbers or signle value based on grouping, but information will be displayed with each individual row.

- `RANK`, window function works with `OVER` to allow us to find the rank of current row within its partition.
    ```SQL
    SELECT Id,
        department,
        salary,
        AVG(salary) OVER (PARTITION BY department) AS dept_avg,
        RANK() OVER(ORDER BY salary DESC) AS overall_rank
    FROM [dbo].[Employees];
    ```
    - in this example, we calculate the rank of each salary within a department and also the rank of each salary overall at the company, we used the `OVER (ORDER BY salary DESC)` inside of the OVER() clause to re-order rows within each window.

- `ROW_NUMBER`, window function is used to assign a unique integer value to each row within a partition of a result set. It is often used in conjunction with the `OVER` clause to define the window or partition.
    ```SQL
    SELECT
        ROW_NUMBER() OVER (PARTITION BY column1 ORDER BY column2) AS row_num,
        column1,
        column2
    FROM table_name;
    ```
    - in this example, `ROW_NUMBER()` assigns a unique row number for each row within each partition defined by column1, ordered by column2.