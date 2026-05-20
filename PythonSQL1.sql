CREATE DATABASE TechcrushC6

-- Switching to TechcrushC6
USE TechcrushC6

CREATE TABLE Students(
RegNumber VARCHAR(25),
StudentName VARCHAR(25),
Gender VARCHAR(25),
Age INT,
MaritalStatus VARCHAR(25),
Course VARCHAR(25),
Tel_Number VARCHAR(25)
)

CREATE TABLE AcademicRecord(
RegNumber VARCHAR(25),
RecordID INT,
AccessmentType VARCHAR(25),
Grade VARCHAR(5),
Score DECIMAL(5,2)
)

INSERT INTO Students(RegNumber, StudentName, Gender, Age, MaritalStatus, Course, Tel_Number)
VALUES('REG-001', 'Donald Trump', 'Male', 30, 'Complicated', 'Zoology', '+44-567-895'),
('REG-002', 'Pascal Okara', 'Male', 40, 'Married', 'Data Science', '+44-676-895'),
('REG-003', 'Cynthia Morgan', 'Female', 25, 'Single', 'Data Analytics', '+44-567-875')

SELECT *
FROM Students

INSERT INTO AcademicRecord(RegNumber, RecordID, AccessmentType, Grade, Score)
VALUES('REG-001', 001, 'Quiz', 'A', 70),
('REG-002', 002,'Exam', 'B', 60),
('REG-003', 003, 'Exam', 'A', 80)

SELECT *
FROM AcademicRecord

ALTER TABLE Students
ADD Department VARCHAR(50)

UPDATE Students
SET Department = 'Zoology'
WHERE RegNumber = 'REG-001'

UPDATE Students
SET Department = 'Information Technology'
WHERE RegNumber = 'REG-002'

UPDATE Students
SET Department = 'IT'
WHERE RegNumber = 'REG-003'

DROP TABLE AcademicRecord

DELETE FROM Students
WHERE RegNumber = 'REG-003'

ALTER TABLE Students
DROP COLUMN Department

SELECT *
FROM employees

SELECT job_title, department
FROM employees

SELECT job_title, department, salary_year_avg
FROM employees
WHERE salary_year_avg > 70000
ORDER BY salary_year_avg DESC

SELECT job_title, department, salary_year_avg
FROM employees
WHERE job_title = 'Data Scientist' AND job_title = 'Data Analyst'
ORDER BY salary_year_avg DESC

SELECT job_title, department, salary_year_avg
FROM employees
WHERE job_title = 'Data Scientist' AND salary_year_avg > 70000
ORDER BY salary_year_avg DESC

SELECT job_title, department, salary_year_avg
FROM employees
WHERE NOT job_title = 'Data Scientist'
ORDER BY salary_year_avg DESC

SELECT job_title, department, salary_year_avg
FROM employees
WHERE job_title != 'Data Scientist'
ORDER BY salary_year_avg DESC


SELECT job_title, department, salary_year_avg
FROM employees
WHERE job_title IN ('Data Scientist', 'Data Analyst')
ORDER BY salary_year_avg DESC

SELECT *
FROM employees

SELECT job_title, department, salary_year_avg, location
FROM employees
WHERE location LIKE 'Port%' --WildCard

SELECT job_title, department, salary_year_avg, location
FROM employees
WHERE location LIKE 'A____'

-- Aggregations
SELECT COUNT(*) AS TotalEmployee
FROM employees

SELECT SUM(salary_year_avg) AS TotalSalary
FROM employees

SELECT AVG(salary_year_avg) AS AvgSalary
FROM employees

SELECT MIN(salary_year_avg) AS MINSalary
FROM employees

SELECT MAX(salary_year_avg) AS MaxSalary
FROM employees

-- GROUPBY
SELECT department, SUM(salary_year_avg) AS TotalSalary
FROM employees
GROUP BY department
HAVING department = 'IT'
ORDER BY SUM(salary_year_avg) DESC

SELECT department, SUM(salary_year_avg) AS TotalSalary
FROM employees
WHERE department = 'IT'
GROUP BY department
ORDER BY SUM(salary_year_avg) DESC

-- WHERE is used to filter rows and HAVING is used to filter Groups

-- LEN
SELECT job_title, department, LEN(department) AS number_of_characters
FROM employees

-- CONCATENATE
SELECT job_title, CONCAT(department,'',experience_level) AS combined_designation
FROM employees

SELECT department, REPLACE(department,'IT', 'Information Technology') AS New_department
FROM employees


-- JOINS
SELECT [Order Number], [Sales Date], Currency
FROM [Sales Table]

/* INNER JOIN - Returns only matching rows from both Tables. */

/* LEFT JOIN - Returns all rows from the left Table and Matching rows from the right 
and in places where there's no match, it returns NULL */

/* RIGHT JOIN - Returns all rows from  the right Table and Matching rows from the left Table 
and in places where there's no match, it returns NULL. */

-- INNER JOIN
SELECT ProductName, Revenue, [Sales Team]
FROM [Sales Table] AS st
INNER JOIN Products AS p
ON st.ProductIndex = p.ProductIndex
INNER JOIN [Sales team] AS s
ON st.Salesteamindex = s.Salesindex

-- LEFT JOIN
SELECT county, Revenue
FROM [Store Locations] AS sl
LEFT JOIN [Sales Table] AS s
ON sl.id = s.Storeindex


-- RIGHT JOIN
SELECT [Sales Team], Revenue
FROM [Sales Table] AS st
RIGHT JOIN [Sales Team] AS s
ON s.Salesindex = st.Salesteamindex


-- CTE(Common Table Expressions)
WITH CTE_Name AS (
	SELECT......
)
SELECT *
FROM CTE_Name


WITH ProductSales AS (
	SELECT ProductIndex, SUM([Order qty]) AS TotalSold
	FROM [Sales Table]
	GROUP BY ProductIndex
)
SELECT ProductName, TotalSold
FROM ProductSales AS ps
INNER JOIN Products AS p
ON ps.ProductIndex = p.ProductIndex
ORDER BY ps.TotalSold DESC

-- Subqueries
SELECT AVG(salary_year_avg) FROM employees

SELECT job_title, salary_year_avg
FROM employees
WHERE salary_year_avg > (SELECT AVG(salary_year_avg) FROM employees)


-- Calculate totalsales using subquery
SELECT ProductName, TotalSales
FROM (
	SELECT Productindex, SUM([Order qty]) AS TotalSales
	FROM [Sales Table]
	GROUP BY Productindex
)AS ProductSales 
INNER JOIN Products p ON Productsales.Productindex = p.ProductIndex
ORDER BY TotalSales DESC


SELECT ProductName, SUM([Order qty]) AS TotalSales
FROM [Sales Table] st
INNER JOIN Products p ON st.Productindex = p.ProductIndex
GROUP BY ProductName
ORDER BY SUM([Order qty]) DESC