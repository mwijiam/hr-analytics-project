-- ============================================
-- SECTION 1: ATTRITION ANALYSIS
-- ============================================
-- 1.1 Overall Attrition Rate
SELECT
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_left,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM
	employees;
-- 1.2 Attrition by Department
SELECT
	Department,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM
	employees
GROUP BY
	Department
ORDER BY
	attrition_rate DESC;
-- 1.3 Attrition by Job Role
SELECT
	JobRole,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM
	employees
GROUP BY
	JobRole
ORDER BY
	attrition_rate DESC;
-- ============================================
-- SECTION 2: SATISFACTION ANALYSIS
-- ============================================
-- 2.1 Job Satisfaction vs Attrition
SELECT
	JobSatisfaction,
	CASE
		JobSatisfaction
        WHEN 1 THEN 'Low'
		WHEN 2 THEN 'Medium'
		WHEN 3 THEN 'High'
		WHEN 4 THEN 'Very High'
	END AS satisfaction_level,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM
	employees
GROUP BY
	JobSatisfaction
ORDER BY
	JobSatisfaction;
-- 2.2 Environment Satisfaction vs Attrition
SELECT
	EnvironmentSatisfaction,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM
	employees
GROUP BY
	EnvironmentSatisfaction
ORDER BY
	EnvironmentSatisfaction;
-- 2.3 Work-Life Balance vs Attrition
SELECT
	WorkLifeBalance,
	CASE
		WorkLifeBalance
        WHEN 1 THEN 'Bad'
		WHEN 2 THEN 'Good'
		WHEN 3 THEN 'Better'
		WHEN 4 THEN 'Best'
	END AS wlb_level,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM
	employees
GROUP BY
	WorkLifeBalance
ORDER BY
	WorkLifeBalance;
-- ============================================
-- SECTION 3: COMPENSATION ANALYSIS
-- ============================================
-- 3.1 Average Income by Attrition Status
SELECT
	Attrition,
	ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income,
	MIN(MonthlyIncome) AS min_income,
	MAX(MonthlyIncome) AS max_income
FROM
	employees
GROUP BY
	Attrition;
-- 3.2 Income Brackets and Attrition
SELECT
	CASE
		WHEN MonthlyIncome < 3000 THEN '< 3K'
		WHEN MonthlyIncome BETWEEN 3000 AND 5999 THEN '3K - 6K'
		WHEN MonthlyIncome BETWEEN 6000 AND 9999 THEN '6K - 10K'
		WHEN MonthlyIncome BETWEEN 10000 AND 14999 THEN '10K - 15K'
		ELSE '15K+'
	END AS income_bracket,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM
	employees
GROUP BY
	CASE
		WHEN MonthlyIncome < 3000 THEN '< 3K'
		WHEN MonthlyIncome BETWEEN 3000 AND 5999 THEN '3K - 6K'
		WHEN MonthlyIncome BETWEEN 6000 AND 9999 THEN '6K - 10K'
		WHEN MonthlyIncome BETWEEN 10000 AND 14999 THEN '10K - 15K'
		ELSE '15K+'
	END
ORDER BY
	attrition_rate DESC;
-- ============================================
-- SECTION 4: TENURE & EXPERIENCE ANALYSIS
-- ============================================
-- 4.1 Years at Company vs Attrition
SELECT
	CASE
		WHEN YearsAtCompany < 2 THEN '0-1 years'
		WHEN YearsAtCompany BETWEEN 2 AND 5 THEN '2-5 years'
		WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 years'
		ELSE '10+ years'
	END AS tenure_group,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM
	employees
GROUP BY
	CASE
		WHEN YearsAtCompany < 2 THEN '0-1 years'
		WHEN YearsAtCompany BETWEEN 2 AND 5 THEN '2-5 years'
		WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 years'
		ELSE '10+ years'
	END
ORDER BY
	attrition_rate DESC;
-- 4.2 Years Since Last Promotion vs Attrition
SELECT
	YearsSinceLastPromotion,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM
	employees
GROUP BY
	YearsSinceLastPromotion
ORDER BY
	YearsSinceLastPromotion;
-- ============================================
-- SECTION 5: DEMOGRAPHICS ANALYSIS
-- ============================================
-- 5.1 Age Group vs Attrition
SELECT
	CASE
		WHEN Age < 25 THEN '18-24'
		WHEN Age BETWEEN 25 AND 34 THEN '25-34'
		WHEN Age BETWEEN 35 AND 44 THEN '35-44'
		WHEN Age BETWEEN 45 AND 54 THEN '45-54'
		ELSE '55+'
	END AS age_group,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM
	employees
GROUP BY
	CASE
		WHEN Age < 25 THEN '18-24'
		WHEN Age BETWEEN 25 AND 34 THEN '25-34'
		WHEN Age BETWEEN 35 AND 44 THEN '35-44'
		WHEN Age BETWEEN 45 AND 54 THEN '45-54'
		ELSE '55+'
	END
ORDER BY
	attrition_rate DESC;
-- 5.2 Gender vs Attrition
SELECT
	Gender,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM
	employees
GROUP BY
	Gender
ORDER BY
	attrition_rate DESC;
-- 5.3 Marital Status vs Attrition
SELECT
	MaritalStatus,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM
	employees
GROUP BY
	MaritalStatus
ORDER BY
	attrition_rate DESC;
-- ============================================
-- SECTION 6: OVERTIME & TRAVEL ANALYSIS
-- ============================================
-- 6.1 Overtime vs Attrition
SELECT
	OverTime,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM
	employees
GROUP BY
	OverTime;
-- 6.2 Business Travel vs Attrition
SELECT
	BusinessTravel,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM
	employees
GROUP BY
	BusinessTravel
ORDER BY
	attrition_rate DESC;
-- ============================================
-- SECTION 7: HIGH RISK EMPLOYEES (Advanced)
-- ============================================
-- Identify employees with high attrition risk factors
SELECT
	EmployeeNumber,
	Age,
	Department,
	JobRole,
	MonthlyIncome,
	JobSatisfaction,
	EnvironmentSatisfaction,
	WorkLifeBalance,
	YearsAtCompany,
	OverTime,
	-- Risk Score (higher = more likely to leave)
    (CASE
		WHEN JobSatisfaction = 1 THEN 2
		WHEN JobSatisfaction = 2 THEN 1
		ELSE 0
	END +
     CASE
		WHEN EnvironmentSatisfaction = 1 THEN 2
		WHEN EnvironmentSatisfaction = 2 THEN 1
		ELSE 0
	END +
     CASE
		WHEN WorkLifeBalance = 1 THEN 2
		WHEN WorkLifeBalance = 2 THEN 1
		ELSE 0
	END +
     CASE
		WHEN OverTime = 'Yes' THEN 2
		ELSE 0
	END +
     CASE
		WHEN YearsAtCompany < 2 THEN 1
		ELSE 0
	END +
     CASE
		WHEN MonthlyIncome < 3000 THEN 2
		ELSE 0
	END) AS risk_score
FROM
	employees
WHERE
	Attrition = 'No'
	-- Only current employees
ORDER BY
	risk_score DESC
LIMIT 20;
