-- ########################## READ ME ########################## -- 
-- 1. Solution begins at line 222.
-- 2. Assumptions are documented as inline comments within the code.
-- 3. Scripts are written in Microsoft SQL Server (MSSQL) dialect.

DROP TABLE IF EXISTS #Company
CREATE TABLE #Company
(
	pkCompanyID BIGINT IDENTITY(1,1) NOT NULL,
	CompanyName VARCHAR(100)
)

INSERT INTO #Company (CompanyName)
SELECT 'Acme Industries'
UNION ALL
SELECT 'Globex Corporation'
UNION ALL
SELECT 'Krusty Krab'
UNION ALL
SELECT 'Wiley Coyote'

DROP TABLE IF EXISTS #Employee
CREATE TABLE #Employee
(
	pkEmployeeID	BIGINT  IDENTITY(1,1) NOT NULL,
	fkCompanyID		BIGINT,
	EmployeeNumber	VARCHAR(100),
	FirstName		VARCHAR(100),
	LastName		VARCHAR(100),
	DateOfBirth		DATE,
	Gender			VARCHAR(100),
	Nationality		VARCHAR(100),
	ManagerID		BIGINT
)

INSERT INTO #Employee (fkCompanyID, EmployeeNumber, FirstName, LastName, DateOfBirth, Gender, Nationality) 
SELECT 1, 'A1', 'Bugs', 'Bunny', '1999/02/04', 'Male', 'South African'
UNION  ALL
SELECT 1, 'A2', 'Donald', 'Duck', '1998/01/14', 'Male', 'South African'
UNION  ALL
SELECT 1, 'A3', 'Tweety', 'Bird', '1990/11/04', 'Female', 'South African'
UNION  ALL
SELECT 1, 'A4', 'Speedy', 'Gonzalez', '2000/01/01', 'Male', 'South African'
UNION ALL
SELECT 2, 'B1', 'Homer', 'Simpson', '1985/08/13', 'Male', 'American'
UNION  ALL
SELECT 2, 'B2', 'Bart', 'Simpson', '2003/06/10', 'Male', 'American'
UNION  ALL
SELECT 2, 'B3', 'Marge', 'Simpson', '1990/02/14', 'Female', 'American'
UNION  ALL
SELECT 2, 'B4', 'Lisa', 'Simpson', '2001/06/12', 'Female', 'American'
UNION ALL
SELECT 3, 'C1', 'Spongebob', 'Squarepants', '2003/04/02', 'Female', 'American'
UNION  ALL
SELECT 3, 'C2', 'Patrick', 'Star', '1995/05/05', 'Male', 'American'
UNION  ALL
SELECT 3, 'C3', 'Sandy', 'Cheeks', '2006/12/31', 'Female', 'American'
UNION  ALL
SELECT 5, 'D1', 'Johnny', 'Bravo', '1997/07/27', 'Male', 'American'


;UPDATE e
SET e.ManagerID = (SELECT pkEmployeeID FROM #Employee WHERE EmployeeNumber = 'A2')
FROM #Employee e
WHERE e.EmployeeNumber = 'A1'

;UPDATE e
SET e.ManagerID = (SELECT pkEmployeeID FROM #Employee WHERE EmployeeNumber = 'A1')
FROM #Employee e
WHERE e.EmployeeNumber IN ('A3','A4')

;UPDATE e
SET e.ManagerID = (SELECT pkEmployeeID FROM #Employee WHERE EmployeeNumber = 'B3')
FROM #Employee e
WHERE e.EmployeeNumber IN ('B1','B2','B4')

DROP TABLE IF EXISTS #Address
CREATE TABLE #Address
(
	pkAddressID		BIGINT  IDENTITY(1,1) NOT NULL,
	Town			VARCHAR(100)
)

INSERT INTO #Address (Town)
SELECT 'Johannesburg'
UNION  ALL
SELECT 'Cape Town'

DROP TABLE IF EXISTS #TaxRates
CREATE TABLE #TaxRates
(
	pkTaxRatesID	BIGINT  IDENTITY(1,1) NOT NULL,
	RateFrom		INT,
	RateTo			INT, 
	RatePercentage	INT
)

INSERT INTO #TaxRates
SELECT 0, 7500, 10
UNION  ALL
SELECT 7501, 15000, 15
UNION  ALL
SELECT 15001, 23000, 18
UNION  ALL
SELECT 23001, 31000, 23
UNION  ALL
SELECT 31001, 40000, 30
UNION  ALL
SELECT 40001, 9999999, 40

DROP TABLE IF EXISTS #Salaries
CREATE TABLE #Salaries
(
	pkSalaryID		BIGINT IDENTITY(1,1) NOT NULL,
	fkEmployeeID	BIGINT,
	Salary			INT
)

INSERT INTO #Salaries (fkEmployeeID, Salary)
SELECT 1, 5000
UNION  ALL
SELECT 2, 24000
UNION  ALL
SELECT 3, 14000
UNION  ALL
SELECT 4, 32000
UNION  ALL
SELECT 5, 89000
UNION  ALL
SELECT 6, 10000
UNION  ALL
SELECT 7, 10000
UNION  ALL
SELECT 8, 20000
UNION  ALL
SELECT 9, 25000
UNION  ALL
SELECT 10, 35000
UNION  ALL
SELECT 11, 42000

DROP TABLE IF EXISTS #Position
CREATE TABLE #Position
(
	pkPositionID	BIGINT IDENTITY(1,1) NOT NULL,
	fkEmployeeID	BIGINT,
	Position		VARCHAR(100),
	EffectiveDate	DATE
)

INSERT INTO #Position (fkEmployeeID, Position, EffectiveDate)
SELECT 1, 'Junior Developer', '2019/01/01'
UNION  ALL
SELECT 1, 'Intermediate Developer', '2022/01/01'
UNION  ALL
SELECT 2, 'Junior Accountant', '2020/01/01'
UNION  ALL
SELECT 3, 'Associate Attorney', '2018/01/01'
UNION  ALL
SELECT 3, 'Senior Attorney', '2023/01/01'
UNION  ALL
SELECT 4, 'Junior Analyst', '2020/01/01'
UNION  ALL
SELECT 5, 'Junior Scientist', '2020/01/01'
UNION  ALL
SELECT 6, 'Junior Doctor', '2016/01/01'
UNION  ALL
SELECT 6, 'Senior Doctor', '2024/01/01'
UNION  ALL
SELECT 7, 'Junior Data Analyst', '2020/01/01'
UNION  ALL
SELECT 8, 'Junior Developer', '2020/01/01'
UNION  ALL
SELECT 9, 'Junior Finance Analyst', '2020/01/01'
UNION  ALL
SELECT 9, 'Intermediate Manager', '2022/01/01'
UNION  ALL
SELECT 10,'Junior Mediator', '2020/01/01'
UNION  ALL
SELECT 11,'Junior Consultant', '2020/01/01'
UNION  ALL
SELECT 11,'Senior Consultant', '2023/01/01'

;INSERT INTO #Employee (fkCompanyID,EmployeeNumber,FirstName,LastName,DateOfBirth,Gender,Nationality)
SELECT TOP 1 fkCompanyID,EmployeeNumber,FirstName,LastName,DateOfBirth,Gender,Nationality FROM #Employee

DROP TABLE IF EXISTS #Tickets
;CREATE TABLE #Tickets 
(
	SaleID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	EmployeeID BIGINT,
	ProductType VARCHAR(100),
	TicketAmount BIGINT,
	fkCompanyID BIGINT
)

INSERT INTO #Tickets (EmployeeID, fkCompanyID, ProductType, TicketAmount)
SELECT TOP 1 pkEmployeeID ,fkCompanyID , 'Support', 75 FROM #Employee WHERE EmployeeNumber = 'A3'
UNION 
SELECT TOP 1 pkEmployeeID ,fkCompanyID , 'Features', 100 FROM #Employee WHERE EmployeeNumber = 'A1'
UNION 
SELECT TOP 1 pkEmployeeID ,fkCompanyID , 'QA', 50 FROM #Employee WHERE EmployeeNumber = 'A1'
UNION 
SELECT TOP 1 pkEmployeeID ,fkCompanyID , 'Bugs', 250 FROM #Employee WHERE EmployeeNumber = 'A2'
UNION 
SELECT TOP 1 pkEmployeeID ,fkCompanyID , 'Bugs', 125 FROM #Employee WHERE EmployeeNumber = 'A4'
UNION 
SELECT TOP 1 pkEmployeeID ,fkCompanyID , 'QA', 150 FROM #Employee WHERE EmployeeNumber = 'B1'
UNION 
SELECT TOP 1 pkEmployeeID ,fkCompanyID , 'Support', 30 FROM #Employee WHERE EmployeeNumber = 'B2'
UNION 
SELECT TOP 1 pkEmployeeID ,fkCompanyID , 'Features', 85 FROM #Employee WHERE EmployeeNumber = 'B3'

Select * from #Company
Select * from #Employee
Select * from #Address
Select * from #TaxRates
Select * from #Salaries
Select * from #Position
Select * from #Tickets

---- ########################## SOLUTION ########################## ---

-- 1.> Please add a relationship between table Employee and table Address.

-- To establish a relationship between the Employee and Address tables:

-- Approach 1: Many-to-One Relationship
-- Assume: An employee can have only one address, and an address can belong to multiple employees -> Add a foreign key (fkaddressid) to the Employee table, referencing the Address table:

    -- -- sample code:
    --     ALTER TABLE Employee
    --     ADD fkaddressid BIGINT;
    --     ALTER TABLE Employee
    --     ADD CONSTRAINT FK_Employee_Address FOREIGN KEY (fkaddressid) 
    --         REFERENCES Address(pkaddressid);

-- Approach 2: Many-to-One Relationship
-- Assume: An employee can have multiple addresses, and an address can belong to multiple employees -> Create a junction table (EmployeeAddress) to map employees to addresses:

    -- -- sample code:
    --     CREATE TABLE EmployeeAddress (
    --         pkEmployeeID BIGINT NOT NULL,
    --         fkaddressid BIGINT NOT NULL,
    --         update_timestamp DATETIME2 DEFAULT SYSDATETIME(), 
    --         CONSTRAINT PK_EmployeeAddress PRIMARY KEY (pkEmployeeID, fkaddressid), -- composite primary key
    --         CONSTRAINT FK_EmployeeAddress_Employee FOREIGN KEY (pkEmployeeID) 
    --             REFERENCES Employee(pkEmployeeID),
    --         CONSTRAINT FK_EmployeeAddress_Address FOREIGN KEY (fkaddressid) 
    --             REFERENCES Address(fkaddressid)
    --     );

-- ** Recommendation:
-- Use Many-to-One: 
-- If the business requirement is clear that employees can only have one address, and this is unlikely to change, the many-to-one approach is simpler and more efficient.
-- Use Many-to-Many: If the business requirement allows employees to have multiple addresses or if you anticipate future changes, the junction table approach is more flexible and scalable.
-- If it is needed to track changes to employee addresses over time, the junction table approach with an update_timestamp is ideal

-- 2.> Please write a statement that would return the Tax Percentage of each employee, per company.
    
    -- -- sample code
    --     SELECT 
    --         pkEmployeeID, concat(FirstName, ' ',LastName) EmployeeName, CompanyName, Salary, RatePercentage
    --     FROM Employee t1 
    --     LEFT JOIN Company t2 ON t1.fkCompanyID = t2.pkCompanyID
    --     LEFT JOIN Salaries t3 ON t1.pkEmployeeID = t3.fkEmployeeID
    --     LEFT JOIN TaxRates t4 ON t3.Salary between t4.RateFrom and t4.RateTo
    --     --  WHERE RatePercentage is not null -- optional 

-- 3.> Please write a statement to create a Temporary Table that would house an employee�s full name, Salary and tax percentage, and subsequently populate it with a statement.

    -- -- sample code
    --     CREATE TABLE #EmployeeTaxInfo (
    --         pkEmployeeID BIGINT NOT NULL,
    --         EmployeeName VARCHAR(200),
    --         Salary BIGINT,
    --         TaxPercentage INT
    --     );

    --     INSERT INTO #EmployeeTaxInfo (pkEmployeeID, EmployeeName, Salary, TaxPercentage)
    --     SELECT
    --         t1.pkEmployeeID,
    --         CONCAT(t1.FirstName, ' ', t1.LastName) AS EmployeeName,
    --         t3.Salary,
    --         t4.RatePercentage
    --     FROM
    --         Employee t1
    --         LEFT JOIN Salaries t3 ON t1.pkEmployeeID = t3.fkEmployeeID
    --         LEFT JOIN TaxRates t4 ON t3.Salary BETWEEN t4.RateFrom AND t4.RateTo;

-- 4.> Please write a statement that returns the employee with the SECOND highest Salary, per company.
    
    -- sample code
        -- WITH CTE AS (
        --     SELECT
        --         CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
        --         c.CompanyName,
        --         s.Salary,
        --         DENSE_RANK() OVER (PARTITION BY c.CompanyName ORDER BY s.Salary DESC) AS rnk
        --     FROM
        --         Employee e
        --         LEFT JOIN Company c ON e.fkCompanyID = c.pkCompanyID
        --         LEFT JOIN Salaries s ON e.pkEmployeeID = s.fkEmployeeID
        --     WHERE
        --         c.CompanyName IS NOT NULL
        -- )
        -- SELECT
        --     EmployeeName,
        --     CompanyName,
        --     Salary
        -- FROM
        --     CTE
        -- WHERE
        --     rnk = 2;

-- 5.> Please write a statement that returns the total number of positions, grouped by company.

    -- -- sample code
    --     WITH CTE AS (
    --         SELECT
    --             p.fkEmployeeID,
    --             p.position,
    --             p.EffectiveDate,
    --             ROW_NUMBER() OVER (PARTITION BY p.fkEmployeeID ORDER BY p.EffectiveDate DESC) AS rnk
    --         FROM
    --             Position p
    --     )
    --     , CTE2 AS (
    --         SELECT
    --             CTE.fkEmployeeID,
    --             CTE.position,
    --             c.CompanyName
    --         FROM
    --             CTE 
    --         LEFT JOIN Employee e ON CTE.fkEmployeeID = e.pkEmployeeID
    --         LEFT JOIN Company c ON e.fkCompanyID = c.pkCompanyID
    --         WHERE
    --             CTE.rnk = 1
    --     )
    --     SELECT
    --         CompanyName,
    --         COUNT(fkEmployeeID) AS PositionCount
    --     FROM
    --         CTE2 
    --     GROUP BY
    --         CompanyName;



-- 6.> Please write a statement that returns all employees that are male, with a Salary of over 31000 and who are over 25 years of age.

    -- -- sample code
    --     SELECT 
    --         t1.pkEmployeeID, 
    --         CONCAT(t1.FirstName, ' ', t1.LastName) AS EmployeeName, 
    --         t1.Gender, 
    --         t2.Salary, 
    --         DATEDIFF(YEAR, t1.dateofbirth, GETDATE()) AS age
    --     FROM 
    --         Employee t1 
    --     INNER JOIN 
    --         Salaries t2 ON t1.pkEmployeeID = t2.fkEmployeeID 
    --     WHERE 
    --         t2.Salary > 31000
    --         AND DATEDIFF(YEAR, t1.dateofbirth, GETDATE()) > 25;

-- 7.> Please write a statement that returns employees that have a tax rate of over 20%, per company.

    -- -- sample code
    --     SELECT DISTINCT
    --         t1.pkEmployeeID,
    --         CONCAT(t1.FirstName, ' ', t1.LastName) AS EmployeeName,
    --         t2.CompanyName,
    --         t4.RatePercentage
    --     FROM
    --         Employee t1
    --         LEFT JOIN Company t2 ON t1.fkCompanyID = t2.pkCompanyID
    --         LEFT JOIN Salaries t3 ON t1.pkEmployeeID = t3.fkEmployeeID
    --         LEFT JOIN TaxRates t4 ON t3.Salary BETWEEN t4.RateFrom AND t4.RateTo
    --     WHERE
    --         t4.RatePercentage > 20;


-- 8.> Please improve, or optimise the below statement;

    -- -- sample code
    --     SELECT *
    --     FROM Employee
    --     WHERE DateOfBirth > '1990-01-15'
    --     AND Gender = 'Male'
    --     AND Nationality LIKE '%South African%';

-- 9.> After 5 years of service, employees are eligible for a bonus. 
-- Please write a statement to return company name, employee name, and position of the employees who will receive a bonus
    
    -- -- sample code
    --     SELECT
    --         t2.CompanyName,
    --         CONCAT(t1.FirstName, ' ', t1.LastName) AS EmployeeName,
    --         t3.position,
    --         DATEDIFF(YEAR, FirstEmployment.FirstEmploymentDate, GETDATE()) AS YearsOfService
    --     FROM
    --         Employee t1
    --         LEFT JOIN Company t2 ON t1.fkCompanyID = t2.pkCompanyID
    --         LEFT JOIN Position t3 ON t1.pkEmployeeID = t3.fkEmployeeID
    --         JOIN (SELECT fkEmployeeID, MIN(EffectiveDate) as FirstEmploymentDate FROM Position group by fkEmployeeID) as t4 on t1.pkEmployeeID = t4.fkEmployeeID
    --     WHERE
    --         DATEDIFF(YEAR, t4.FirstEmploymentDate, GETDATE()) >= 5;

-- 10.> Please write a statement that identifies duplicate records for the fkCompanyID and EmployeeNumber columns wthin the #Employee table.

    -- -- sample code
    --     SELECT *
    --     FROM (
    --         SELECT
    --             *,
    --             COUNT(*) OVER (PARTITION BY fkCompanyID, EmployeeNumber) AS nb_record
    --         FROM
    --             Employee
    --     ) t1
    --     WHERE
    --         nb_record > 1;

-- 11.> Please write a statement that returns ALL employees and their company names, if they exist.

    -- -- sample code
    --     SELECT
    --         pkEmployeeID,
    --         CONCAT(FirstName, ' ', LastName) AS EmployeeName,
    --         CompanyName
    --     FROM
    --         Employee t1
    --         LEFT JOIN Company t2 ON t1.fkCompanyID = t2.pkCompanyID;


-- 12.> Please write a statement that selects all employees latest positions and categorizes their positions into Junior, Intermediate and Senior

    -- -- sample code
    --     SELECT
    --         t1.fkEmployeeID,
    --         CONCAT(t2.FirstName, ' ', t2.LastName) AS EmployeeName,
    --         t1.position,
    --         CASE
    --             WHEN LOWER(t1.position) LIKE '%junior%' THEN 'Junior'
    --             WHEN LOWER(t1.position) LIKE '%intermediate%' THEN 'Intermediate'
    --             WHEN LOWER(t1.position) LIKE '%senior%' THEN 'Senior'
    --             ELSE 'Other' 
    --         END AS PositionCategory
    --     FROM (
    --         SELECT
    --             fkEmployeeID,
    --             position,
    --             EffectiveDate,
    --             ROW_NUMBER() OVER (PARTITION BY fkEmployeeID ORDER BY EffectiveDate DESC) AS rnk
    --         FROM
    --             Position
    --     ) t1
    --     LEFT JOIN
    --         Employee t2 ON t1.fkEmployeeID = t2.pkEmployeeID
    --     WHERE
    --         t1.rnk = 1;

-- 13.> Please write a statement that returns the direct reports (employees) for Bugs Bunny

    -- -- sample code
    --     WITH base AS (
    --         SELECT
    --             pkEmployeeID,
    --             CONCAT(FirstName, ' ', LastName) AS EmployeeName,
    --             ManagerId
    --         FROM
    --             Employee
    --     ),
    --     report AS (
    --         SELECT
    --             t1.pkEmployeeID,
    --             t1.EmployeeName,
    --             t2.EmployeeName AS l1ManagerName
    --         FROM
    --             base t1
    --             INNER JOIN base t2 ON t1.ManagerId = t2.pkEmployeeID
    --     )
    --     SELECT
    --         pkEmployeeID,
    --         EmployeeName,
    --         l1ManagerName
    --     FROM
    --         report
    --     WHERE
    --         l1ManagerName = 'Bugs Bunny';


-- 14.> Please write a statement that lists all employees under Donald Duck�s (A2) management (direct and indirect reports).

    -- -- sample code
    --     WITH base AS (
    --         SELECT
    --             pkEmployeeID,
    --             CONCAT(FirstName, ' ', LastName) AS EmployeeName,
    --             ManagerId,
    --             EmployeeNumber
    --         FROM
    --             Employee
    --     )
    --     , report AS (
    --         SELECT
    --             t1.EmployeeName,
    --             t2.EmployeeName AS l1ManagerName,
    --             t2.EmployeeNumber AS l1ManagerEmployeeNumber,
    --             t3.EmployeeName AS l2ManagerName,
    --             t3.EmployeeNumber AS l2ManagerEmployeeNumber
    --         FROM
    --             base t1
    --             LEFT JOIN base t2 ON t1.ManagerId = t2.pkEmployeeID
    --             LEFT JOIN base t3 ON t2.ManagerId = t3.pkEmployeeID
    --     )
    --     SELECT
    --         EmployeeName,
    --         COALESCE(l2ManagerName, l1ManagerName) AS manager_name
    --     FROM
    --         report
    --     WHERE
    --         COALESCE(l2ManagerEmployeeNumber, l1ManagerEmployeeNumber) = 'A2';

-- 15.> Please write a statement that returns the company name and the yearly amount each company owes in wages per year.

    -- -- sample code
    --     WITH base AS (
    --         SELECT
    --             t1.pkEmployeeID,
    --             CONCAT(t1.FirstName, ' ', t1.LastName) AS EmployeeName,
    --             t2.CompanyName,
    --             t3.Salary,
    --             COALESCE(t4.RatePercentage, 0) AS RatePercentage -- Handle NULL tax rates
    --         FROM
    --             Employee t1
    --             LEFT JOIN Company t2 ON t1.fkCompanyID = t2.pkCompanyID
    --             LEFT JOIN Salaries t3 ON t1.pkEmployeeID = t3.fkEmployeeID
    --             LEFT JOIN TaxRates t4 ON t3.Salary BETWEEN t4.RateFrom AND t4.RateTo
    --     )
    --     SELECT
    --         CompanyName,
    --         SUM(Salary * 12) AS YearlyWageBeforeTax,
    --         SUM(Salary * 12 * (1 - RatePercentage * 1.00 / 100)) AS YearlyWageAfterTax
    --     FROM
    --         base
    --     WHERE
    --         CompanyName IS NOT NULL
    --     GROUP BY
    --         1;

-- 16. Please write a statement that returns the Company name and Employee count in descending order of Employee Count

    -- -- sample code
    --     WITH base AS (
    --         SELECT
    --             t1.pkEmployeeID,
    --             CONCAT(t1.FirstName, ' ', t1.LastName) AS EmployeeName,
    --             t2.CompanyName
    --         FROM
    --             Employee t1
    --             LEFT JOIN Company t2 ON t1.fkCompanyID = t2.pkCompanyID
    --     )
    --     SELECT
    --         CompanyName,
    --         COUNT(DISTINCT pkEmployeeID) AS EmployeeCount
    --     FROM
    --         base
    --     WHERE
    --         CompanyName IS NOT NULL
    --     GROUP BY
    --         1
    --     ORDER BY
    --         2 DESC;


-- 17.> Employee Lisa Simpson has been promoted to Intermediate Developer. 
-- Please write a statement to add her new position and subsequently a statement returning her position details

    -- -- sample code
    --     ;WITH EmployeeID AS (
    --         SELECT pkEmployeeID
    --         FROM Employee
    --         WHERE LOWER(FirstName) = 'lisa' AND LOWER(LastName) = 'simpson'
    --     )
    --     INSERT INTO #Position (fkEmployeeID, position, EffectiveDate)
    --     SELECT pkEmployeeID, 'Intermediate Developer', GETDATE()
    --     FROM EmployeeID
    --     WHERE pkEmployeeID IS NOT NULL;

    --     SELECT *
    --     FROM Position
    --     WHERE fkEmployeeID = (SELECT pkEmployeeID FROM Employee WHERE LOWER(FirstName) = 'lisa' AND LOWER(LastName) = 'simpson');

-- 18.> Please write a statement that returns the Employee Count and Average Salary by Position using ROLLUP

    -- -- sample code
    --     WITH base AS (
    --         SELECT
    --             t1.fkEmployeeID,
    --             t1.position,
    --             t2.Salary,
    --             ROW_NUMBER() OVER (PARTITION BY t1.fkEmployeeID ORDER BY t1.EffectiveDate DESC) AS rnk
    --         FROM Position t1
    --         LEFT JOIN Salaries t2 ON t1.fkEmployeeID = t2.fkEmployeeID
    --     )
    --     SELECT
    --         COALESCE(position, 'All') as position,
    --         AVG(NULLIF(Salary,0)) AS AverageSalary,
    --         COUNT(fkEmployeeID) AS EmployeeCount
    --     FROM base
    --     WHERE rnk = 1
    --     GROUP BY position WITH ROLLUP;

--19.> Please write a statement that returns the total tickets amount (#tickets) for each type (QA, Support, Bugs, Features) by each employee using a pivot
    
    -- -- sample code
    --     SELECT 
    --         EmployeeName,
    --         [QA],
    --         [Support],
    --         [Bugs],
    --         [Features]
    --     FROM 
    --     (
    --         SELECT 
    --             t2.employeeid,
    --             concat(FirstName, ' ', LastName) EmployeeName,
    --             t1.producttype,
    --             t1.ticketamount -- Assuming ticketamount is the count of tickets
    --         FROM 
    --             Tickets t1
    --         JOIN 
    --             Employee t2 ON t1.EmployeeID = t2.pkEmployeeID
    --     ) AS SourceTable
    --     PIVOT
    --     (
    --         SUM(ticketamount)
    --         FOR producttype IN ([QA], [Support], [Bugs], [Features])
    --     ) AS pv;

--20.> Using the tables provided, please create a stored procedure, to return the following information, as detailed below;

-- Parameters
-- - CompanyName
-- - EmployeeNumber

-- The user should be able to specify either company name or employee number.
--  - Should the user specify company name, all employees information linked to the company must return
--  - Should the user specify employee number, only said employee information should return

-- Fields to return
--  - Company Name
--  - Employee Name
--  - Emp Number
--  - Salary
--  - Tax Percentage
--  - Number of Male and Female records per company
--  - Latest position name
--  - Order data by Employee DateOfBirth in descending order

    -- -- sample code
    --     CREATE PROCEDURE GetEmployeeInformation
    --         @CompanyName VARCHAR(100) = NULL,
    --         @EmployeeNumber VARCHAR(50) = NULL
    --     AS
    --     BEGIN
    --         SET NOCOUNT ON;

    --         IF @CompanyName IS NULL AND @EmployeeNumber IS NULL
    --         BEGIN
    --             RAISERROR('Please provide either CompanyName or EmployeeNumber.', 16, 1);
    --             RETURN;
    --         END;

    --         -- Main query
    --         SELECT
    --             t2.CompanyName,
    --             CONCAT(t1.FirstName, ' ', t1.LastName) AS employeename,
    --             t1.EmployeeNumber,
    --             t3.Salary,
    --             t4.RatePercentage,
    --             t5.MaleCount,
    --             t6.FemaleCount,
    --             t7.Position AS LatestPositionName
    --         FROM
    --             Employee t1
    --         JOIN
    --             Company t2 ON t1.fkCompanyID = t2.pkCompanyID
    --         LEFT JOIN
    --             Salaries t3 ON t1.pkEmployeeID = t3.fkEmployeeID
    --         LEFT JOIN
    --             Taxrates t4 ON t3.Salary BETWEEN t4.RateFrom AND t4.RateTo
    --         LEFT JOIN (SELECT fkCompanyID, COUNT(*) AS MaleCount FROM Employee WHERE Gender = 'Male' GROUP BY fkCompanyID) AS t5 ON t2.pkCompanyID = MaleCount.fkCompanyID
    --         LEFT JOIN (SELECT fkCompanyID, COUNT(*) AS FemaleCount FROM Employee WHERE Gender = 'Female' GROUP BY fkCompanyID) AS t6 ON t2.pkCompanyID = FemaleCount.fkCompanyID
    --         LEFT JOIN (select fkEmployeeID, position, ROW_NUMBER() OVER (PARTITION BY fkEmployeeID ORDER BY EffectiveDate DESC) as rnk from Position) t7 ON t1.pkEmployeeID = t7.fkEmployeeID and t7.rnk = 1
    --         WHERE
    --             (@CompanyName IS NOT NULL AND t2.CompanyName = @CompanyName)
    --             OR (@EmployeeNumber IS NOT NULL AND t1.EmployeeNumber = @EmployeeNumber)
    --         ORDER BY
    --             t1.dateofbirth DESC;
    --         END;

-- 21.> Explain what an Index is, and provide an example using the Employee Table.

-- From Microsoft SQL Server Documentation, an index is a data structure that improves the speed of data retrieval operations on a database table

-- How Indexes Work:
-- Data Structure: An index creates a separate data structure (typically a B-tree) that stores a copy of the indexed columns along with pointers to the corresponding rows in the original table.
-- Faster Lookups: When a query uses the indexed columns in its WHERE clause, the database can use the index to quickly locate the relevant rows, rather than scanning the entire table.
-- Trade-off: Indexes improve read performance but can slightly slow down write operations (inserts, updates, deletes) because the index also needs to be updated.

-- Example Using the Employee Table:

    -- -- sample code
    --     CREATE NONCLUSTERED INDEX IX_Employee_LastName_CompanyID
    --     ON Employee (LastName, fkCompanyID);

    -- Explaination
    -- Assuming the biz requirement frequently require info of employee LastName and fkCompanyID columns. By applying the index, Queries that filter on LastName and fkCompanyID will be significantly faster.
    
    -- -- sample code     
        -- SELECT *
        -- FROM Employee
        -- WHERE LastName = 'Bunny' AND fkCompanyID = 1;

-- From my personal experience:
-- Our e-commerce company has a "Product Reviews" feature.
-- The Reviews table is growing rapidly, with millions of reviews. 
-- The analytics team needs to generate a report showing the average rating for each product category, but the query is taking an unacceptably long time.

-- Identify the Bottleneck:
-- Using execution plans, we confirm that the JOIN on Reviews.ProductID and Products.ProductID is a major bottleneck.
-- The GROUP BY clause on Products.Category is also contributing to the slow performance.

-- Solution: 
    -- Index on Reviews.ProductID: This will significantly speed up the JOIN operation.

    -- -- sample code
    --     CREATE NONCLUSTERED INDEX IX_Reviews_ProductID
    --     ON Reviews (ProductID);

    -- Index on Products.Category: This will speed up the GROUP BY operation.

    -- -- sample code
    --     CREATE NONCLUSTERED INDEX IX_Products_Category
    --     ON Products (Category);

-- Impact testing:
-- We observe a dramatic improvement in query performance.
-- The execution plan now shows that the indexes are being used for the JOIN and GROUP BY operations, eliminating the full table scans.
-- We use the execution plan to verify that the query is using the new indexes