-- 1. Check total records
SELECT
	COUNT(*) AS total_employees
FROM
	employees;
-- 2. Check for NULL values in key columns
SELECT
	SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS null_age,
	SUM(CASE WHEN Attrition IS NULL THEN 1 ELSE 0 END) AS null_attrition,
	SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END) AS null_department,
	SUM(CASE WHEN MonthlyIncome IS NULL THEN 1 ELSE 0 END) AS null_income
FROM
	employees;
-- 3. Check unique values in categorical columns
SELECT
	DISTINCT Attrition
FROM
	employees;

SELECT
	DISTINCT Department
FROM
	employees;

SELECT
	DISTINCT JobRole
FROM
	employees;

SELECT
	DISTINCT Gender
FROM
	employees;

SELECT
	DISTINCT MaritalStatus
FROM
	employees;

SELECT
	DISTINCT BusinessTravel
FROM
	employees;

SELECT
	DISTINCT OverTime
FROM
	employees;
-- 4. Basic statistics for numerical columns
SELECT
	MIN(Age) AS min_age,
	MAX(Age) AS max_age,
	AVG(Age) AS avg_age,
	MIN(MonthlyIncome) AS min_income,
	MAX(MonthlyIncome) AS max_income,
	AVG(MonthlyIncome) AS avg_income,
	MIN(YearsAtCompany) AS min_tenure,
	MAX(YearsAtCompany) AS max_tenure,
	AVG(YearsAtCompany) AS avg_tenure
FROM
	employees;
-- 5. Distribution by department
SELECT
	Department,
	COUNT(*) AS employee_count,
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employees), 2) AS percentage
FROM
	employees
GROUP BY
	Department
ORDER BY
	employee_count DESC;
-- 6. Attrition overview
SELECT
	Attrition,
	COUNT(*) AS count,
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employees), 2) AS percentage
FROM
	employees
GROUP BY
	Attrition;
