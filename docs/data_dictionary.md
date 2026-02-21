# Data Dictionary - IBM HR Analytics Dataset

This dataset has 1,470 rows and 35 columns. Below is a breakdown of what each column means, what values it holds, and whether HR can actually do something about it.

---

## Identifiers

| Column | Type | Description |
|--------|------|-------------|
| EmployeeNumber | Integer | Unique ID per employee (1-1470) |

---

## Demographics

| Column | Type | Values / Range | Notes |
|--------|------|---------------|-------|
| Age | Integer | 18 - 60 | Useful for generational segmentation |
| Gender | Categorical | Male, Female | Check for bias in attrition |
| MaritalStatus | Categorical | Single, Married, Divorced | Single = higher attrition |
| DistanceFromHome | Integer | 1 - 29 (km) | Long commute may push people out |

---

## Education

| Column | Type | Values | Notes |
|--------|------|--------|-------|
| Education | Integer | 1=Below College, 2=College, 3=Bachelor, 4=Master, 5=Doctor | Ordinal scale |
| EducationField | Categorical | Life Sciences, Medical, Marketing, Technical Degree, Other, HR | Background field |

---

## Job Information

| Column | Type | Values / Range | Notes |
|--------|------|---------------|-------|
| Department | Categorical | Sales, R&D, HR | 3 departments |
| JobRole | Categorical | 9 roles (Sales Exec, Research Scientist, Lab Tech, etc.) | More granular than Department |
| JobLevel | Integer | 1-5 | 1 = entry, 5 = executive |
| YearsAtCompany | Integer | 0-40 | Tenure with this company |
| YearsInCurrentRole | Integer | 0-18 | How long in current position |
| YearsSinceLastPromotion | Integer | 0-15 | >5 years = potential stagnation |
| YearsWithCurrManager | Integer | 0-17 | Manager relationship duration |
| TotalWorkingYears | Integer | 0-40 | Overall career experience |
| NumCompaniesWorked | Integer | 0-9 | >5 = job hopper pattern |

---

## Compensation

| Column | Type | Range | Notes |
|--------|------|-------|-------|
| MonthlyIncome | Integer | $1,009 - $19,999 | Main salary metric |
| PercentSalaryHike | Integer | 11% - 25% | Last raise percentage |
| StockOptionLevel | Integer | 0-3 | 0 = none, 3 = highest |
| DailyRate | Integer | $102 - $1,499 | Unclear definition, not very useful |
| MonthlyRate | Integer | $2,094 - $26,999 | Unclear definition, not very useful |
| HourlyRate | Integer | $30 - $100 | Unclear definition, not very useful |

---

## Satisfaction & Engagement

All rated 1-4 (1 = lowest, 4 = highest).

| Column | What It Measures | Actionable? |
|--------|-----------------|-------------|
| JobSatisfaction | How happy with the job itself | Yes, improve role and responsibilities |
| EnvironmentSatisfaction | Workplace quality (office, culture) | Yes, upgrade facilities, fix culture |
| RelationshipSatisfaction | Team and manager relationships | Yes, team building, manager coaching |
| WorkLifeBalance | 1=Bad, 2=Good, 3=Better, 4=Best | Yes, flexible hours, reduce overtime |
| JobInvolvement | How engaged with work | Yes, give meaningful projects |

---

## Work Conditions

| Column | Type | Values | Notes |
|--------|------|--------|-------|
| OverTime | Categorical | Yes, No | Overtime employees resign at 3x the rate |
| BusinessTravel | Categorical | Non-Travel, Travel_Rarely, Travel_Frequently | Frequent travelers leave more |

---

## Performance

| Column | Type | Values | Notes |
|--------|------|--------|-------|
| PerformanceRating | Integer | 3-4 only | Limited, everyone is "Excellent" or "Outstanding" |
| TrainingTimesLastYear | Integer | 0-6 | Number of trainings attended |

---

## Target Variable

| Column | Type | Values | Description |
|--------|------|--------|-------------|
| Attrition | Categorical | Yes, No | Whether the employee resigned. This is what we're analyzing |

---

## Columns to Skip

These columns have the same value for every row, so they're useless:

| Column | Value | Why Skip |
|--------|-------|----------|
| EmployeeCount | Always 1 | Constant |
| Over18 | Always "Y" | Constant |
| StandardHours | Always 80 | Constant |

---

## Priority for Analysis

**Must analyze:** Attrition, MonthlyIncome, JobSatisfaction, OverTime, YearsAtCompany, YearsSinceLastPromotion, Department, JobRole

**Worth checking:** Age, WorkLifeBalance, EnvironmentSatisfaction, JobLevel, MaritalStatus, BusinessTravel, StockOptionLevel

**Low priority:** Gender, Education, DistanceFromHome, NumCompaniesWorked, TrainingTimesLastYear

**Skip:** EmployeeCount, Over18, StandardHours, DailyRate, MonthlyRate, HourlyRate
