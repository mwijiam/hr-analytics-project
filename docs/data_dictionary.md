# Data Dictionary - IBM HR Analytics Dataset

Penjelasan lengkap setiap kolom dalam dataset.

---

## 📋 Identifiers

### EmployeeNumber
- **Tipe:** Integer
- **Deskripsi:** Unique ID untuk setiap karyawan
- **Contoh:** 1, 2, 3, ..., 1470
- **Kegunaan:** Identifier, primary key
- **Bisa Diubah?** ❌ No

---

## 👤 Demographics (Data Pribadi)

### Age
- **Tipe:** Integer
- **Deskripsi:** Umur karyawan dalam tahun
- **Range:** 18 - 60
- **Contoh:** 25, 35, 45
- **Kegunaan:** Segmentasi berdasarkan generasi
- **Bisa Diubah?** ❌ No (tapi bisa segment strategy per age group)

### Gender
- **Tipe:** Categorical
- **Values:** Male, Female
- **Kegunaan:** Diversity analysis, cek bias
- **Bisa Diubah?** ❌ No

### MaritalStatus
- **Tipe:** Categorical
- **Values:** Single, Married, Divorced
- **Kegunaan:** Stability indicator (married = lebih stable)
- **Bisa Diubah?** ❌ No

### DistanceFromHome
- **Tipe:** Integer
- **Deskripsi:** Jarak rumah ke kantor (dalam km)
- **Range:** 1 - 29
- **Kegunaan:** Commute burden analysis
- **Bisa Diubah?** ⚠️ Partial (bisa kasih remote work option)

---

## 🎓 Education

### Education
- **Tipe:** Integer (ordinal scale)
- **Values:** 
  - 1 = Below College
  - 2 = College
  - 3 = Bachelor
  - 4 = Master
  - 5 = Doctor
- **Kegunaan:** Skill level, career expectation
- **Bisa Diubah?** ❌ No (tapi bisa support further education)

### EducationField
- **Tipe:** Categorical
- **Values:** Life Sciences, Medical, Marketing, Technical Degree, Other, Human Resources
- **Kegunaan:** Match education dengan job role
- **Bisa Diubah?** ❌ No

---

## 💼 Job Information

### Department
- **Tipe:** Categorical
- **Values:** Sales, Research & Development, Human Resources
- **Kegunaan:** Compare attrition across departments
- **Bisa Diubah?** ✅ Yes (transfer department)

### JobRole
- **Tipe:** Categorical
- **Values:** Sales Executive, Research Scientist, Laboratory Technician, Manufacturing Director, Healthcare Representative, Manager, Sales Representative, Research Director, Human Resources
- **Kegunaan:** Granular analysis per role
- **Bisa Diubah?** ✅ Yes (promotion/transfer)

### JobLevel
- **Tipe:** Integer (ordinal)
- **Values:** 1 - 5 (1 = entry level, 5 = executive)
- **Kegunaan:** Career progression analysis
- **Bisa Diubah?** ✅ Yes (promotion)

### YearsAtCompany
- **Tipe:** Integer
- **Deskripsi:** Berapa tahun kerja di company ini
- **Range:** 0 - 40
- **Kegunaan:** Tenure analysis, loyalty indicator
- **Bisa Diubah?** ❌ No (time-based)

### YearsInCurrentRole
- **Tipe:** Integer
- **Deskripsi:** Berapa tahun di posisi/role sekarang
- **Range:** 0 - 18
- **Kegunaan:** Stagnation indicator
- **Bisa Diubah?** ✅ Yes (role change/promotion)

### YearsSinceLastPromotion
- **Tipe:** Integer
- **Deskripsi:** Berapa tahun sejak promosi terakhir
- **Range:** 0 - 15
- **Kegunaan:** Career growth indicator (>5 years = red flag)
- **Bisa Diubah?** ✅ Yes (kasih promosi!)

### YearsWithCurrManager
- **Tipe:** Integer
- **Deskripsi:** Berapa tahun dengan manager sekarang
- **Range:** 0 - 17
- **Kegunaan:** Manager relationship analysis
- **Bisa Diubah?** ✅ Yes (change manager)

### TotalWorkingYears
- **Tipe:** Integer
- **Deskripsi:** Total pengalaman kerja (semua company)
- **Range:** 0 - 40
- **Kegunaan:** Experience level
- **Bisa Diubah?** ❌ No (historical data)

### NumCompaniesWorked
- **Tipe:** Integer
- **Deskripsi:** Jumlah company yang pernah dikerjai sebelumnya
- **Range:** 0 - 9
- **Kegunaan:** Job hopping indicator (>5 = sering pindah)
- **Bisa Diubah?** ❌ No (historical data)

---

## 💰 Compensation

### MonthlyIncome
- **Tipe:** Integer
- **Deskripsi:** Gaji bulanan (dalam dollar)
- **Range:** $1,009 - $19,999
- **Kegunaan:** Main compensation metric
- **Bisa Diubah?** ✅ Yes (salary adjustment)

### MonthlyRate
- **Tipe:** Integer
- **Deskripsi:** Rate bulanan (unclear, mungkin billing rate)
- **Range:** $2,094 - $26,999
- **Kegunaan:** ⚠️ Kurang jelas, jarang dipake
- **Bisa Diubah?** ✅ Yes

### DailyRate
- **Tipe:** Integer
- **Deskripsi:** Rate harian
- **Range:** $102 - $1,499
- **Kegunaan:** ⚠️ Kurang jelas, jarang dipake
- **Bisa Diubah?** ✅ Yes

### HourlyRate
- **Tipe:** Integer
- **Deskripsi:** Rate per jam
- **Range:** $30 - $100
- **Kegunaan:** ⚠️ Kurang jelas, jarang dipake
- **Bisa Diubah?** ✅ Yes

### PercentSalaryHike
- **Tipe:** Integer
- **Deskripsi:** Persentase kenaikan gaji terakhir
- **Range:** 11% - 25%
- **Kegunaan:** Reward/recognition indicator
- **Bisa Diubah?** ✅ Yes (next salary review)

### StockOptionLevel
- **Tipe:** Integer
- **Values:** 0 - 3 (0 = no stock, 3 = highest)
- **Kegunaan:** Additional compensation, retention tool
- **Bisa Diubah?** ✅ Yes (grant stock options)

---

## 😊 Satisfaction & Engagement

### JobSatisfaction
- **Tipe:** Integer (Likert scale)
- **Values:** 1 - 4
  - 1 = Low
  - 2 = Medium
  - 3 = High
  - 4 = Very High
- **Kegunaan:** Direct attrition predictor
- **Bisa Diubah?** ✅ Yes (improve job conditions)

### EnvironmentSatisfaction
- **Tipe:** Integer (Likert scale)
- **Values:** 1 - 4 (same as above)
- **Kegunaan:** Workplace quality indicator
- **Bisa Diubah?** ✅ Yes (improve office, culture, etc)

### RelationshipSatisfaction
- **Tipe:** Integer (Likert scale)
- **Values:** 1 - 4
- **Kegunaan:** Team/manager relationship quality
- **Bisa Diubah?** ✅ Yes (team building, manager training)

### WorkLifeBalance
- **Tipe:** Integer (Likert scale)
- **Values:** 1 - 4
  - 1 = Bad
  - 2 = Good
  - 3 = Better
  - 4 = Best
- **Kegunaan:** Burnout indicator
- **Bisa Diubah?** ✅ Yes (flexible hours, reduce overtime)

### JobInvolvement
- **Tipe:** Integer (Likert scale)
- **Values:** 1 - 4
- **Kegunaan:** Engagement level
- **Bisa Diubah?** ✅ Yes (give meaningful work)

---

## ⚙️ Work Conditions

### OverTime
- **Tipe:** Categorical
- **Values:** Yes, No
- **Kegunaan:** Burnout indicator (overtime = high attrition)
- **Bisa Diubah?** ✅ Yes (reduce overtime, hire more)

### BusinessTravel
- **Tipe:** Categorical
- **Values:** 
  - Non-Travel
  - Travel_Rarely
  - Travel_Frequently
- **Kegunaan:** Work-life balance factor
- **Bisa Diubah?** ✅ Yes (reduce travel requirement)

### StandardHours
- **Tipe:** Integer
- **Deskripsi:** Jam kerja standard (semua isinya 80)
- **Kegunaan:** ❌ Ga berguna (constant value)
- **Bisa Diubah?** N/A

---

## 📈 Performance & Development

### PerformanceRating
- **Tipe:** Integer
- **Values:** 3 - 4
  - 3 = Excellent
  - 4 = Outstanding
- **Kegunaan:** ⚠️ Limited (cuma 2 values)
- **Bisa Diubah?** ✅ Yes (performance management)

### TrainingTimesLastYear
- **Tipe:** Integer
- **Deskripsi:** Jumlah training yang diikuti tahun lalu
- **Range:** 0 - 6
- **Kegunaan:** Development investment indicator
- **Bisa Diubah?** ✅ Yes (provide more training)

---

## 🎯 Target Variable

### Attrition
- **Tipe:** Categorical
- **Values:** Yes, No
- **Deskripsi:** Apakah karyawan resign?
- **Kegunaan:** **TARGET** - ini yang mau diprediksi/dianalisis
- **Bisa Diubah?** ✅ Yes (retention strategy!)

---

## 🗑️ Useless Columns (Bisa Diabaikan)

### EmployeeCount
- **Values:** Semua isinya 1
- **Kegunaan:** ❌ Ga ada (constant)

### Over18
- **Values:** Semua isinya "Y"
- **Kegunaan:** ❌ Ga ada (constant)

### StandardHours
- **Values:** Semua isinya 80
- **Kegunaan:** ❌ Ga ada (constant)

---

## 📊 Grouping by Importance

### 🔥 Critical (Must Analyze)
- Attrition (target)
- MonthlyIncome
- JobSatisfaction
- OverTime
- YearsAtCompany
- YearsSinceLastPromotion
- Department
- JobRole

### ⚠️ Important (Should Analyze)
- Age
- WorkLifeBalance
- EnvironmentSatisfaction
- JobLevel
- MaritalStatus
- BusinessTravel
- StockOptionLevel

### 💡 Nice to Have
- Gender
- Education
- DistanceFromHome
- NumCompaniesWorked
- TrainingTimesLastYear
- PerformanceRating

### ❌ Skip
- EmployeeCount
- Over18
- StandardHours
- DailyRate (unclear)
- MonthlyRate (unclear)
- HourlyRate (unclear)

---

## 🎓 Tips Baca Dataset Baru

1. **Cek constant columns** → skip
2. **Identify target variable** → Attrition
3. **Group by category** → demographics, job, compensation, satisfaction
4. **Prioritize actionable** → bisa diubah = valuable
5. **Understand relationships** → YearsAtCompany vs YearsInCurrentRole

---

*Sekarang kamu udah paham setiap kolom. Bisa mulai bikin analysis strategy!*
