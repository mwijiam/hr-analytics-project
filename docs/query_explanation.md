# SQL Query Explanation - Technical & Business Perspective

Penjelasan lengkap setiap query dalam `03_analysis.sql` dari sisi **teknis SQL** dan **business impact**.

---

## SECTION 1: ATTRITION ANALYSIS

### Query 1.1: Overall Attrition Rate

#### 📝 SQL Query
```sql
SELECT 
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees;
```

#### 🔧 Technical Explanation
- `COUNT(*)` → Hitung semua baris (total karyawan)
- `SUM(CASE WHEN...)` → Conditional sum, hitung cuma yang Attrition = 'Yes'
- `* 100.0` → Convert ke persentase (100.0 biar jadi decimal, bukan integer)
- `ROUND(..., 2)` → Bulatkan ke 2 decimal places

#### 💼 Business Impact
**Pertanyaan bisnis:** "Berapa persen karyawan yang resign dari total workforce?"

**Kenapa penting:**
- **Baseline metric** - starting point semua analysis
- **Benchmark** - compare dengan industry standard (10-15% normal)
- **Cost calculation** - kalau 20% attrition dari 1000 orang = 200 orang resign
  - Cost per hire ≈ $4,000
  - Total cost = $800,000/tahun!

**Contoh hasil:**
```
total_employees: 1470
total_left: 237
attrition_rate: 16.12%
```

**Insight:** 16% sedikit di atas normal (10-15%) → ada masalah yang perlu di-address.

**Action:** Investigate lebih lanjut - department/role mana yang paling tinggi?

---

### Query 1.2: Attrition by Department

#### 📝 SQL Query
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

#### 🔧 Technical Explanation
- `GROUP BY Department` → Pisahkan data per department
- `ORDER BY attrition_rate DESC` → Sort dari tertinggi ke terendah
- Logic sama dengan query 1.1, tapi **per group**

#### 💼 Business Impact
**Pertanyaan bisnis:** "Department mana yang paling banyak kehilangan karyawan?"

**Kenapa penting:**
- **Prioritize intervention** - fokus resources ke problem area
- **Root cause berbeda** - Sales vs R&D beda masalahnya
- **Budget allocation** - mana yang perlu retention budget lebih

**Contoh hasil:**
```
Sales:          20.6% attrition (highest)
HR:             19.0%
R&D:            13.8% (lowest)
```

**Insight:** Sales punya masalah serius - 1 dari 5 orang resign!

**Action:**
- Interview exit - kenapa Sales resign?
- Cek: commission structure, quota realistis ga, manager toxic?
- Benchmark salary Sales vs market

---

### Query 1.3: Attrition by Job Role

#### 📝 SQL Query
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

#### 🔧 Technical Explanation
- Sama struktur dengan 1.2, tapi group by `JobRole` (lebih granular)

#### 💼 Business Impact
**Pertanyaan bisnis:** "Role spesifik mana yang paling tinggi attrition-nya?"

**Kenapa penting:**
- **Lebih actionable** dari department
- Contoh: dalam Sales, mungkin Sales Rep resign banyak, tapi Sales Manager stabil
- **Targeted solution** - tiap role beda kebutuhan

**Contoh hasil:**
```
Sales Representative:      39.8% (CRISIS!)
Laboratory Technician:     23.9%
Human Resources:           23.0%
Sales Executive:           17.5%
Research Scientist:        16.1%
Manager:                    4.9% (stable)
```

**Insight:** Sales Rep hampir 40% resign - ini **EMERGENCY**!

**Action:**
- **Immediate:** Retention bonus untuk top performers
- **Short-term:** Review compensation & quota
- **Long-term:** Career path - Sales Rep → Sales Executive → Manager

---

## SECTION 2: SATISFACTION ANALYSIS

### Query 2.1: Job Satisfaction vs Attrition

#### 📝 SQL Query
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

#### 🔧 Technical Explanation
- `CASE JobSatisfaction WHEN 1 THEN 'Low'...` → Convert angka jadi label
- Kenapa? Biar output lebih **readable** di report
- `GROUP BY JobSatisfaction` → 4 groups (1, 2, 3, 4)

#### 💼 Business Impact
**Pertanyaan bisnis:** "Apakah karyawan yang ga puas lebih banyak resign?"

**Kenapa penting:**
- **Validate hypothesis** - satisfaction = retention?
- **Leading indicator** - low satisfaction sekarang = resign nanti
- **Actionable** - bisa improve job satisfaction

**Contoh hasil:**
```
Low (1):        22.8% attrition
Medium (2):     16.5%
High (3):       15.7%
Very High (4):  11.2%
```

**Insight:** Clear correlation! Low satisfaction = 2x attrition vs Very High.

**Action:**
- **Survey:** Kenapa satisfaction rendah? (workload, manager, tools?)
- **Quick wins:** Fix pain points (software, equipment, process)
- **Long-term:** Culture improvement, manager training

---

### Query 2.2: Environment Satisfaction vs Attrition

#### 📝 SQL Query
```sql
SELECT 
    EnvironmentSatisfaction,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY EnvironmentSatisfaction
ORDER BY EnvironmentSatisfaction;
```

#### 🔧 Technical Explanation
- Struktur sama dengan 2.1
- Bedanya: kolom `EnvironmentSatisfaction`

#### 💼 Business Impact
**Pertanyaan bisnis:** "Apakah workplace environment pengaruh ke attrition?"

**Kenapa penting:**
- **Different from job satisfaction** - ini tentang office, culture, tools
- **Relatively cheap to fix** - upgrade office, better equipment
- **Affects everyone** - bukan individual issue

**Contoh hasil:**
```
Low (1):        25.0% attrition
Medium (2):     17.2%
High (3):       14.0%
Very High (4):  13.5%
```

**Insight:** Environment matters! Low env satisfaction = hampir 2x attrition.

**Action:**
- **Physical:** Better office space, ergonomic chairs, AC
- **Tools:** Upgrade software, faster computers
- **Culture:** Toxic culture? Micromanagement?

---

### Query 2.3: Work-Life Balance vs Attrition

#### 📝 SQL Query
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

#### 🔧 Technical Explanation
- CASE statement untuk labeling (Bad, Good, Better, Best)
- GROUP BY work-life balance level

#### 💼 Business Impact
**Pertanyaan bisnis:** "Apakah WLB yang jelek bikin orang resign?"

**Kenapa penting:**
- **Modern priority** - Gen Z/Millennial care about WLB
- **Burnout prevention** - bad WLB = burnout = resign
- **Actionable** - flexible hours, remote work, reduce overtime

**Contoh hasil:**
```
Bad (1):     31.3% attrition (HIGHEST!)
Good (2):    16.7%
Better (3):  15.2%
Best (4):    15.5%
```

**Insight:** Bad WLB = 2x attrition! Ini **major factor**.

**Action:**
- **Immediate:** Identify who has bad WLB - reduce workload
- **Policy:** Flexible hours, work from home
- **Culture:** No email after 6pm, respect boundaries
- **Hiring:** Hire more people to reduce individual workload

---

## SECTION 3: COMPENSATION ANALYSIS

### Query 3.1: Average Income by Attrition Status

#### 📝 SQL Query
```sql
SELECT 
    Attrition,
    ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income,
    MIN(MonthlyIncome) AS min_income,
    MAX(MonthlyIncome) AS max_income
FROM employees
GROUP BY Attrition;
```

#### 🔧 Technical Explanation
- `AVG(MonthlyIncome)` → Calculate average
- `MIN()` dan `MAX()` → Range check
- `GROUP BY Attrition` → Compare Yes vs No

#### 💼 Business Impact
**Pertanyaan bisnis:** "Apakah yang resign karena gaji terlalu rendah?"

**Kenapa penting:**
- **Salary competitiveness** - compare dengan market
- **Retention tool** - salary adjustment bisa prevent attrition
- **ROI calculation** - naikin gaji $500 vs cost of hiring baru $4,000

**Contoh hasil:**
```
Attrition = Yes:  $4,787 avg
Attrition = No:   $6,832 avg
Difference:       -$2,045 (30% lower!)
```

**Insight:** Yang resign earn significantly less! Salary **IS** a factor.

**Action:**
- **Market research:** Apakah $4,787 below market?
- **Salary adjustment:** Target low earners with good performance
- **Transparency:** Communicate salary bands & progression

---

### Query 3.2: Income Brackets and Attrition

#### 📝 SQL Query
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

#### 🔧 Technical Explanation
- **Nested CASE** → Create income brackets
- `BETWEEN` operator → Range check
- `GROUP BY` → Aggregate per bracket

**Kenapa bikin brackets?**
- Lebih **actionable** dari average
- HR bisa target specific bracket untuk salary adjustment

#### 💼 Business Impact
**Pertanyaan bisnis:** "Income bracket mana yang paling banyak resign?"

**Kenapa penting:**
- **Targeted intervention** - fokus budget ke bracket tertentu
- **Cost-effective** - ga perlu naikin gaji semua orang
- **Fairness** - pastiin ga ada underpaid segment

**Contoh hasil:**
```
< 3K:       25.8% attrition (HIGHEST)
3K - 6K:    20.2%
6K - 10K:   12.5%
10K - 15K:   8.3%
15K+:        5.1% (LOWEST)
```

**Insight:** Clear inverse correlation - lower income = higher attrition!

**Action:**
- **Immediate:** Salary adjustment untuk <3K bracket
- **Target:** Bring <3K to at least 3-4K range
- **Budget:** Calculate cost - berapa orang di <3K? Total budget needed?
- **ROI:** Compare dengan cost of replacing them

**Example calculation:**
- 100 employees di <3K bracket
- Naikin $500/month = $50K/year total
- Prevent 10 resignations = save $40K (10 × $4K hiring cost)
- **ROI positive!**

---

## SECTION 4: TENURE & EXPERIENCE ANALYSIS

### Query 4.1: Years at Company vs Attrition

#### 📝 SQL Query
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

#### 🔧 Technical Explanation
- CASE statement untuk tenure grouping
- Similar structure dengan income brackets

#### 💼 Business Impact
**Pertanyaan bisnis:** "Kapan karyawan paling likely resign?"

**Kenapa penting:**
- **Identify critical period** - when to focus retention efforts
- **Onboarding effectiveness** - kalau new hires resign = onboarding problem
- **Loyalty indicator** - 10+ years = very stable

**Contoh hasil:**
```
0-1 years:   26.4% attrition (HIGHEST - new hires!)
2-5 years:   18.2%
6-10 years:  12.1%
10+ years:    8.5% (LOWEST - loyal employees)
```

**Insight:** **First year is critical!** 1 dari 4 new hires resign.

**Action:**
- **Onboarding:** Improve first 90 days experience
  - Better training
  - Buddy system
  - Clear expectations
  - Regular check-ins
- **6-month review:** Catch issues early
- **Career path:** Show progression opportunities

**Why this matters:**
- Cost of losing new hire = wasted recruitment + training cost
- Early attrition = bad hire or bad onboarding

---

### Query 4.2: Years Since Last Promotion vs Attrition

#### 📝 SQL Query
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

#### 🔧 Technical Explanation
- No CASE statement (keep as individual years)
- Kenapa? Biar bisa lihat **trend** per year

#### 💼 Business Impact
**Pertanyaan bisnis:** "Apakah karyawan yang lama ga promosi lebih likely resign?"

**Kenapa penting:**
- **Career growth indicator** - stagnation = frustration
- **Retention tool** - promotion (even small) boost morale
- **Predictive** - 5+ years no promotion = high risk

**Contoh hasil:**
```
0 years:  15.2% (recently promoted - stable)
1 year:   16.8%
2 years:  18.5%
3 years:  20.1%
4 years:  22.3%
5+ years: 28.7% (HIGHEST - frustrated!)
```

**Insight:** Clear trend - longer without promotion = higher attrition!

**Action:**
- **Audit:** Who hasn't been promoted in 3+ years?
- **Review:** Are they stuck? Why?
  - Performance issue? → PIP or coaching
  - No opportunity? → Create new roles
  - Overlooked? → Promote now!
- **Policy:** Max 3 years in same level
- **Alternative:** Lateral moves, special projects, title changes

**Important note:**
- Promotion ≠ always salary increase
- Could be: title change, more responsibility, recognition

---

## SECTION 5: DEMOGRAPHICS ANALYSIS

### Query 5.1: Age Group vs Attrition

#### 📝 SQL Query
```sql
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
FROM employees
GROUP BY age_group
ORDER BY attrition_rate DESC;
```

#### 🔧 Technical Explanation
- Age brackets based on generational groups
- Standard demographic segmentation

#### 💼 Business Impact
**Pertanyaan bisnis:** "Age group mana yang paling banyak resign?"

**Kenapa penting:**
- **Different motivations** - Gen Z vs Boomer beda needs
- **Targeted benefits** - young = career growth, old = stability
- **Workforce planning** - predict future attrition

**Contoh hasil:**
```
18-24:  33.3% (HIGHEST - early career, exploring)
25-34:  20.1% (still mobile)
35-44:  14.2% (settling down)
45-54:  10.5% (stable)
55+:     8.9% (LOWEST - near retirement)
```

**Insight:** Younger = more likely to leave. Natural pattern.

**Action by age group:**
- **18-24:** Career development, mentorship, learning opportunities
- **25-34:** Work-life balance, competitive salary, growth path
- **35-44:** Stability, family benefits, leadership opportunities
- **45-54:** Recognition, flexibility, knowledge transfer roles
- **55+:** Retirement planning, part-time options, consulting roles

**Can't change age, but can adapt strategy!**

---

### Query 5.2: Gender vs Attrition

#### 📝 SQL Query
```sql
SELECT 
    Gender,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY Gender;
```

#### 🔧 Technical Explanation
- Simple GROUP BY Gender
- Only 2 values: Male, Female

#### 💼 Business Impact
**Pertanyaan bisnis:** "Apakah ada gender bias dalam attrition?"

**Kenapa penting:**
- **Diversity & inclusion** - red flag kalau ada huge gap
- **Policy effectiveness** - maternity leave, flexible hours working?
- **Legal risk** - discrimination issues

**Contoh hasil:**
```
Male:    17.0% attrition
Female:  14.8% attrition
```

**Insight:** Relatively balanced - no major bias. Good sign!

**If there was big gap (e.g., Female 30%, Male 10%):**
- Investigate: Toxic culture? Lack of female leadership? Maternity policy?
- Action: DEI initiatives, mentorship for women, flexible work

---

### Query 5.3: Marital Status vs Attrition

#### 📝 SQL Query
```sql
SELECT 
    MaritalStatus,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY MaritalStatus
ORDER BY attrition_rate DESC;
```

#### 🔧 Technical Explanation
- GROUP BY MaritalStatus
- 3 values: Single, Married, Divorced

#### 💼 Business Impact
**Pertanyaan bisnis:** "Apakah marital status affect stability?"

**Kenapa penting:**
- **Stability indicator** - married = more stable (family obligations)
- **Benefits design** - family benefits valuable for married employees
- **Relocation** - single = easier to relocate

**Contoh hasil:**
```
Single:    25.5% (HIGHEST - more mobile)
Divorced:  16.2%
Married:   12.6% (LOWEST - more stable)
```

**Insight:** Single employees 2x more likely to leave vs married.

**Action:**
- **Single employees:** Career growth, exciting projects, social culture
- **Married employees:** Family benefits, stability, work-life balance
- **Divorced:** Support programs, flexibility

---

## SECTION 6: OVERTIME & TRAVEL ANALYSIS

### Query 6.1: Overtime vs Attrition

#### 📝 SQL Query
```sql
SELECT 
    OverTime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY OverTime;
```

#### 🔧 Technical Explanation
- Simple binary: Yes or No
- Straightforward comparison

#### 💼 Business Impact
**Pertanyaan bisnis:** "Apakah overtime bikin orang resign?"

**Kenapa penting:**
- **Burnout indicator** - overtime = exhaustion = resign
- **Actionable** - reduce overtime or compensate better
- **Cost analysis** - overtime pay vs hiring more people

**Contoh hasil:**
```
OverTime = Yes:  30.5% attrition (CRITICAL!)
OverTime = No:   10.4% attrition
Difference:      3x higher!
```

**Insight:** Overtime employees **3x more likely** to resign! **MAJOR RED FLAG**.

**Action:**
- **Immediate:** Reduce overtime
  - Hire more people
  - Redistribute workload
  - Improve processes (automation, efficiency)
- **Compensation:** Overtime pay premium
- **Policy:** Max overtime hours per month
- **Culture:** Stop glorifying overwork

**ROI calculation:**
- 100 employees doing overtime
- 30 resign (30% attrition) = $120K hiring cost
- Hire 10 more people = $400K salary
- But save $120K + productivity loss
- **Plus:** Improve morale, reduce burnout

---

### Query 6.2: Business Travel vs Attrition

#### 📝 SQL Query
```sql
SELECT 
    BusinessTravel,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY BusinessTravel
ORDER BY attrition_rate DESC;
```

#### 🔧 Technical Explanation
- 3 categories: Non-Travel, Travel_Rarely, Travel_Frequently
- ORDER BY DESC to see highest first

#### 💼 Business Impact
**Pertanyaan bisnis:** "Apakah frequent travel bikin orang resign?"

**Kenapa penting:**
- **Work-life balance** - travel = time away from family
- **Role design** - some roles require travel, some don't
- **Actionable** - reduce travel or compensate

**Contoh hasil:**
```
Travel_Frequently:  24.9% (HIGHEST)
Travel_Rarely:      15.0%
Non-Travel:         8.0% (LOWEST)
```

**Insight:** Frequent travelers 3x more likely to resign vs non-travelers!

**Action:**
- **Reduce travel:** Virtual meetings, regional hires
- **Compensate:** Travel allowance, upgrade accommodations
- **Rotate:** Don't burden same people
- **Hire:** Preference for people who like travel (or don't need to)

---

## SECTION 7: HIGH RISK EMPLOYEES (ADVANCED)

### Query 7: Risk Scoring

#### 📝 SQL Query
```sql
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
    (CASE WHEN JobSatisfaction = 1 THEN 2 WHEN JobSatisfaction = 2 THEN 1 ELSE 0 END +
     CASE WHEN EnvironmentSatisfaction = 1 THEN 2 WHEN EnvironmentSatisfaction = 2 THEN 1 ELSE 0 END +
     CASE WHEN WorkLifeBalance = 1 THEN 2 WHEN WorkLifeBalance = 2 THEN 1 ELSE 0 END +
     CASE WHEN OverTime = 'Yes' THEN 2 ELSE 0 END +
     CASE WHEN YearsAtCompany < 2 THEN 1 ELSE 0 END +
     CASE WHEN MonthlyIncome < 3000 THEN 2 ELSE 0 END) AS risk_score
FROM employees
WHERE Attrition = 'No'  -- Only current employees
ORDER BY risk_score DESC
LIMIT 20;
```

#### 🔧 Technical Explanation
**Complex scoring system:**
- Multiple CASE statements **added together**
- Each factor contributes points:
  - Low satisfaction (1) = +2 points
  - Medium satisfaction (2) = +1 point
  - High/Very High (3-4) = 0 points
  - Overtime = +2 points
  - New hire (<2 years) = +1 point
  - Low income (<$3K) = +2 points

**Max possible score:** 11 points (all risk factors present)

**WHERE Attrition = 'No':**
- Only look at **current employees**
- Kenapa? Biar bisa **prevent** mereka resign

**LIMIT 20:**
- Top 20 highest risk
- Focus on most critical cases

#### 💼 Business Impact
**Pertanyaan bisnis:** "Siapa yang bakal resign next? Gimana prevent?"

**Kenapa penting:**
- **PROACTIVE vs REACTIVE** - prevent instead of react
- **Cost savings** - retention cheaper than replacement
- **Targeted intervention** - focus on high-risk individuals

**Contoh hasil:**
```
EmployeeNumber: 1234
Risk Score: 9/11 (CRITICAL!)
- JobSatisfaction: 1 (Low) → +2
- EnvironmentSatisfaction: 1 (Low) → +2
- WorkLifeBalance: 1 (Bad) → +2
- OverTime: Yes → +2
- YearsAtCompany: 1 → +1
- MonthlyIncome: $2,500 → +2
```

**Insight:** This person is **about to resign** if nothing changes!

**Action (Immediate Intervention):**
1. **Manager 1-on-1:** "How are you doing? What can we improve?"
2. **Salary adjustment:** Bring to at least $3K
3. **Reduce overtime:** Redistribute workload
4. **Environment:** Move to better team/office?
5. **Career path:** Show growth opportunities

**ROI:**
- Cost of intervention: $500/month salary increase = $6K/year
- Cost of replacement: $4K hiring + $10K training + 3 months productivity loss
- **Saving: $8K+ per person retained**

**Scaling:**
- Run this query monthly
- Track top 50 high-risk employees
- Assign retention manager
- Measure: How many did we save?

---

## 🎯 SUMMARY: Query Strategy

### Why This Order?

1. **BROAD → SPECIFIC**
   - Overall → Department → Role
   - Gives context before diving deep

2. **DESCRIPTIVE → DIAGNOSTIC → PREDICTIVE**
   - What happened? (Attrition rates)
   - Why happened? (Satisfaction, compensation)
   - What will happen? (Risk scoring)

3. **SIMPLE → COMPLEX**
   - Start with counts & percentages
   - End with multi-factor scoring

### Business Value Hierarchy

| Priority | Query Type | Business Value |
|----------|-----------|----------------|
| 🔥 Critical | Overall attrition, Overtime, Risk scoring | Immediate action needed |
| ⚠️ High | Satisfaction, Compensation, Tenure | Major factors |
| 💡 Medium | Demographics, Travel | Context & targeting |
| 📊 Low | Gender, Marital status | Nice to know |

---

## 💡 Key Takeaways

1. **Every query answers a business question** - not just "playing with data"
2. **Actionable > Interesting** - focus on what can be changed
3. **ROI mindset** - retention cheaper than replacement
4. **Proactive > Reactive** - predict and prevent, don't just analyze past

---

*Now you understand not just HOW to write queries, but WHY each query matters for business!*
