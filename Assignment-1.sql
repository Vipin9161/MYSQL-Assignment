-- Creating the EmployeeDetails table
CREATE TABLE EmployeeDetails (
  EmpId INT PRIMARY KEY,
  FullName VARCHAR(100),
  ManagerId INT,
  DateOfJoining DATE,
  City VARCHAR(50)
);

-- Creating the EmployeeSalary table
CREATE TABLE EmployeeSalary (
  EmpId INT,
  Project VARCHAR(100),
  Salary DECIMAL(10,2),
  Variable VARCHAR(50),
  FOREIGN KEY (EmpId) REFERENCES EmployeeDetails(EmpId)
);

### SQL Query to fetch records that are present in one table but not in another table:
SELECT *
FROM EmployeeDetails
WHERE EmpId NOT IN (SELECT EmpId FROM EmployeeSalary)
   OR EmpId IN (SELECT EmpId FROM EmployeeSalary WHERE Salary IS NULL);
   
  ### SQL query to fetch all the employees who are not working on any project:
  SELECT *
FROM EmployeeDetails
WHERE EmpId NOT IN (SELECT EmpId FROM EmployeeSalary WHERE Project IS NOT NULL);


### SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020:
SELECT *
FROM EmployeeDetails
WHERE YEAR(DateOfJoining) = 2020;

### Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary:
SELECT *
FROM EmployeeDetails
WHERE EmpId IN (SELECT EmpId FROM EmployeeSalary);

### Write an SQL query to fetch a project-wise count of employees:
SELECT Project, COUNT(EmpId) AS EmployeeCount
FROM EmployeeSalary
GROUP BY Project;

#### Fetch employee names and salaries even if the salary value is not present for the employee:
SELECT EmployeeDetails.FullName, EmployeeSalary.Salary
FROM EmployeeDetails
LEFT JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId;

### Write an SQL query to fetch all the Employees who are also managers:
SELECT E1.FullName
FROM EmployeeDetails AS E1
JOIN EmployeeDetails AS E2 ON E1.EmpId = E2.ManagerId;

### Write an SQL query to fetch duplicate records from EmployeeDetails:
SELECT EmpId, COUNT(*)
FROM EmployeeDetails
GROUP BY EmpId
HAVING COUNT(*) > 1;

### Write an SQL query to fetch only odd rows from the table:
SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER (ORDER BY id) AS RowNum
  FROM EmployeeDetails
) AS SubQuery
WHERE RowNum % 2 <> 0;

### Write a query to find the 3rd highest salary from a table without top or limit keyword:

SELECT DISTINCT Salary
FROM EmployeeSalary AS E1
WHERE 3 = (
  SELECT COUNT(DISTINCT Salary)
  FROM EmployeeSalary AS E2
  WHERE E2.Salary >= E1.Salary
);





