# SQL Query Breakdown

Explanation of every query in `03_analysis.sql`, covering both the technical SQL and what the results mean for HR.

---

## Section 1: Attrition Analysis

### 1.1 Overall Attrition Rate

```sql
SELECT 
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees;
```

**How it works:**
- `COUNT(*)` counts all rows (all employees)
- `SUM(CASE WHEN...)` counts only the ones where Attrition = 'Yes'
- `* 100.0` converts to percentage. Using 100.0 (not 100) forces decimal division
- `ROUND(..., 2)` rounds to 2 decimal places

**Result:** 1,470 total, 237 left, 16.12% attrition rate. That's above the 10-15% industry norm.

---

### 1.2 Attrition by Department

```sql
SELECT 
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY Department
ORDER BY attrition_rate DESC;
```

**How it works:** Same formula as 1.1 but `GROUP BY Department` splits it into 3 groups. `ORDER BY DESC` puts the worst department first.

**Result:** Sales (20.6%) > HR (19.0%) > R&D (13.8%). Sales is the problem area.

---

### 1.3 Attrition by Job Role

```sql
SELECT 
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY JobRole
ORDER BY attrition_rate DESC;
```

**How it works:** Same structure, grouped by JobRole instead of Department for a more detailed breakdown.

**Result:** Sales Representative at 39.76% is the standout. Lab Technician (23.9%) and HR (23.1%) follow. Managers and Research Directors are below 5%.

---

## Section 2: Satisfaction Analysis

### 2.1 Job Satisfaction vs Attrition

```sql
SELECT 
    JobSatisfaction,
    CASE JobSatisfaction
        WHEN 1 THEN 'Low'
        WHEN 2 THEN 'Medium'
        WHEN 3 THEN 'High'
        WHEN 4 THEN 'Very High'
    END AS satisfaction_level,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;
```

**How it works:** The `CASE WHEN` maps numbers (1-4) to readable labels. This makes the output easier to read in reports.

**Result:** Low satisfaction = 22.8% attrition, Very High = 11.2%. Roughly double the rate when employees are unhappy.

---

### 2.2 Environment Satisfaction vs Attrition

Same structure as 2.1 but using `EnvironmentSatisfaction`. Measures how people feel about their workspace.

**Result:** Low = 25.0%, Very High = 13.5%. Office environment matters.

---

### 2.3 Work-Life Balance vs Attrition

```sql
SELECT 
    WorkLifeBalance,
    CASE WorkLifeBalance
        WHEN 1 THEN 'Bad'
        WHEN 2 THEN 'Good'
        WHEN 3 THEN 'Better'
        WHEN 4 THEN 'Best'
    END AS wlb_level,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY WorkLifeBalance
ORDER BY WorkLifeBalance;
```

**Result:** Bad WLB = 31.3% attrition. This is the highest single-factor rate outside of specific job roles.

---

## Section 3: Compensation Analysis

### 3.1 Average Income by Attrition Status

```sql
SELECT 
    Attrition,
    ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income,
    MIN(MonthlyIncome) AS min_income,
    MAX(MonthlyIncome) AS max_income
FROM employees
GROUP BY Attrition;
```

**How it works:** `AVG()`, `MIN()`, `MAX()` give the spread. Grouping by Attrition lets us compare leavers vs stayers directly.

**Result:** Leavers averaged $4,787/month, stayers $6,832. A $2,045 gap, meaning people who left were earning about 30% less.

---

### 3.2 Income Brackets and Attrition

```sql
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
FROM employees
GROUP BY income_bracket
ORDER BY attrition_rate DESC;
```

**How it works:** Creates salary bands using `CASE` with `BETWEEN`. More useful than raw averages because HR can target specific groups.

**Result:** Under $3K = 25.8% attrition. $15K+ = 5.1%. Lower pay, higher turnover.

---

## Section 4: Tenure & Experience

### 4.1 Years at Company vs Attrition

```sql
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
FROM employees
GROUP BY tenure_group
ORDER BY attrition_rate DESC;
```

**Result:** New hires (0-1 year) leave at 26.4%. After 10+ years it drops to 8.5%. The first year is when people decide whether to stay.

---

### 4.2 Years Since Last Promotion vs Attrition

```sql
SELECT 
    YearsSinceLastPromotion,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY YearsSinceLastPromotion
ORDER BY YearsSinceLastPromotion;
```

**How it works:** No CASE grouping here. Kept as individual years so we can see the exact trend over time.

**Result:** The longer someone goes without a promotion, the more likely they leave. 5+ years = high risk.

---

## Section 5: Demographics

### 5.1 Age Group vs Attrition

Groups employees into generational bands (18-24, 25-34, etc.) using the same CASE pattern.

**Result:** 18-24 = 33.3% (exploring careers), 55+ = 8.9% (stable, near retirement).

### 5.2 Gender vs Attrition

Simple `GROUP BY Gender`.

**Result:** Male 17.0%, Female 14.8%. No significant gap.

### 5.3 Marital Status vs Attrition

**Result:** Single = 25.5%, Married = 12.6%. Single employees are about twice as likely to leave.

---

## Section 6: Overtime & Travel

### 6.1 Overtime vs Attrition

```sql
SELECT 
    OverTime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY OverTime;
```

**Result:** Overtime = 30.5% attrition. No overtime = 10.4%. This is a 3x multiplier and the single strongest factor in the dataset.

### 6.2 Business Travel vs Attrition

**Result:** Frequent travel = 24.9%, No travel = 8.0%. Frequent travelers are 3x more likely to leave.

---

## Section 7: Risk Scoring

### Employee Risk Score

```sql
SELECT 
    EmployeeNumber, Age, Department, JobRole, MonthlyIncome,
    JobSatisfaction, EnvironmentSatisfaction, WorkLifeBalance,
    YearsAtCompany, OverTime,
    (CASE WHEN JobSatisfaction = 1 THEN 2 WHEN JobSatisfaction = 2 THEN 1 ELSE 0 END +
     CASE WHEN EnvironmentSatisfaction = 1 THEN 2 WHEN EnvironmentSatisfaction = 2 THEN 1 ELSE 0 END +
     CASE WHEN WorkLifeBalance = 1 THEN 2 WHEN WorkLifeBalance = 2 THEN 1 ELSE 0 END +
     CASE WHEN OverTime = 'Yes' THEN 2 ELSE 0 END +
     CASE WHEN YearsAtCompany < 2 THEN 1 ELSE 0 END +
     CASE WHEN MonthlyIncome < 3000 THEN 2 ELSE 0 END) AS risk_score
FROM employees
WHERE Attrition = 'No'
ORDER BY risk_score DESC
LIMIT 20;
```

**How it works:**
- Adds up risk points from 6 factors (max 11 points total)
- Low satisfaction = +2, medium = +1, high/very high = 0
- Overtime = +2
- New hire (<2 years) = +1
- Low income (<$3K) = +2
- `WHERE Attrition = 'No'` filters to current employees only, since we're predicting who might leave next
- `LIMIT 20` focuses on the top 20 highest-risk people

**Why this matters:** Instead of reacting after someone resigns, HR can proactively reach out to high-risk employees. A $500/month raise costs $6K/year. Replacing them costs $15K+.

---

## Query Strategy

The queries follow a deliberate order:

1. **Broad to specific**: overall rate, then department, then role
2. **What, why, what next**: describe the problem, find causes, predict future risk
3. **Simple to complex**: start with counts, end with multi-factor scoring

*Analysis by: mwijiam*
