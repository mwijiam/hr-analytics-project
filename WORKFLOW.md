---
description: Workflow untuk menyelesaikan HR Analytics project dari download dataset sampai dashboard
---

# HR Analytics Project Workflow

Ikuti step-by-step ini untuk menyelesaikan project. **Jangan skip!** Setiap step punya tujuan.

---

## Phase 1: Data Acquisition (30 menit)

### Step 1.1: Download Dataset
1. Buka browser, pergi ke: https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset
2. Klik "Download" (perlu login Kaggle, gratis)
3. Extract ZIP file
4. Rename file jadi `hr_data.csv`
5. Pindahkan ke `hr-analytics-project/data/raw/`

**Checkpoint:** File `hr_data.csv` ada di folder `data/raw/`

### Step 1.2: Quick Look di Excel
1. Buka `hr_data.csv` di Excel
2. Jawab pertanyaan ini di notes kamu:
   - Berapa total baris data?
   - Berapa total kolom?
   - Kolom mana yang categorical vs numerical?
   - Ada missing value ga? 
3. Save as `hr_data_original.xlsx` di folder `excel/`

**Checkpoint:** Kamu tau struktur basic dataset

---

## Phase 2: Database Setup (45 menit)

### Step 2.1: Pilih Database
Pilih SATU dari opsi ini:
- **MySQL** (recommended, paling banyak dipake)
- **PostgreSQL** (lebih advanced)
- **SQLite** (paling simple, no server)
- **SQL Server** (kalau udah familiar)

Kalau belum install, google: "install [database pilihan] windows"

### Step 2.2: Create Database
1. Buka database client (MySQL Workbench / pgAdmin / DBeaver / SSMS)
2. Create new database:
```sql
CREATE DATABASE hr_analytics;
USE hr_analytics;
```

### Step 2.3: Create Table
1. Buka file `sql/01_create_table.sql`
2. Jalankan query di database client
3. Verify: `SHOW TABLES;` atau `\dt` (PostgreSQL)

**Checkpoint:** Table `employees` sudah exist

### Step 2.4: Import CSV
Cara import berbeda per database. Google: "import csv to [database kamu]"

Setelah import, verify:
```sql
SELECT COUNT(*) FROM employees;
-- Harus return 1470 rows
```

**Checkpoint:** Data sudah masuk ke database

---

## Phase 3: Data Exploration (1 jam)

### Step 3.1: Run Exploration Queries
1. Buka `sql/02_data_exploration.sql`
2. Jalankan query SATU-SATU (jangan sekaligus!)
3. Untuk SETIAP query:
   - Tulis di notes: "Apa yang query ini mau cari tau?"
   - Lihat hasilnya
   - Tulis insight singkat
   
**Contoh notes:**
```
Query: Check NULL values
Result: Semua kolom 0 null
Insight: Data quality bagus, ga perlu handle missing values
```

### Step 3.2: Dokumentasikan Findings
Buat file baru: `docs/data_exploration_notes.md`

Isi dengan:
- Jumlah total karyawan
- Jumlah kolom dan tipenya
- Distribusi per department
- Attrition rate keseluruhan
- Anomali yang ditemukan (kalau ada)

**Checkpoint:** Notes exploration udah lengkap

---

## Phase 4: SQL Analysis (2-3 jam)

### Step 4.1: Attrition Analysis
1. Buka `sql/03_analysis.sql`
2. Jalankan SECTION 1 (Attrition Analysis)
3. Untuk setiap query, catat:
   - Attrition rate per department
   - Attrition rate per job role
   - Mana yang paling tinggi? Kenapa menurutmu?

### Step 4.2: Satisfaction Analysis
1. Jalankan SECTION 2
2. Jawab di notes:
   - Apakah job satisfaction rendah = attrition tinggi?
   - Factor satisfaction mana yang paling pengaruh?

### Step 4.3: Compensation Analysis
1. Jalankan SECTION 3
2. Jawab:
   - Income bracket mana yang attrition-nya tertinggi?
   - Berapa perbedaan avg income antara yang stay vs leave?

### Step 4.4: Tenure Analysis
1. Jalankan SECTION 4
2. Jawab:
   - Tenure group mana yang paling banyak resign?
   - Apakah karyawan baru lebih gampang resign?

### Step 4.5: Demographics Analysis
1. Jalankan SECTION 5
2. Catat pattern yang menarik

### Step 4.6: Overtime & Travel
1. Jalankan SECTION 6
2. Jawab:
   - Apakah overtime relate dengan attrition?
   - Bagaimana dengan business travel?

### Step 4.7: Risk Scoring
1. Jalankan SECTION 7
2. Pahami logic risk score-nya
3. Export hasil ke CSV untuk Power BI nanti

**Checkpoint:** Semua analysis query udah dijalankan, notes lengkap

---

## Phase 5: Excel Deep Dive (1-2 jam)

### Step 5.1: Pivot Table Analysis
1. Buka `hr_data.csv` di Excel
2. Insert > PivotTable
3. Buat pivot table untuk:
   - Attrition count by Department
   - Attrition count by Age Group
   - Average Income by Attrition status
   - Job Satisfaction distribution

### Step 5.2: Charts
Untuk setiap pivot table, buat chart yang sesuai:
- Bar chart untuk comparisons
- Pie chart untuk proportions (sparingly!)
- Line chart kalau ada time element

### Step 5.3: Conditional Formatting
1. Buat summary table
2. Apply conditional formatting:
   - Merah = High attrition rate
   - Hijau = Low attrition rate

### Step 5.4: Save
Save sebagai `exploratory_analysis.xlsx` di folder `excel/`

**Checkpoint:** Excel file lengkap dengan pivot tables dan charts

---

## Phase 6: Power BI Dashboard (3-4 jam)

### Step 6.1: Connect Data
1. Buka Power BI Desktop
2. Get Data > Text/CSV atau Database
3. Load `hr_data.csv` atau connect ke database

### Step 6.2: Data Modeling
1. Transform Data (Power Query)
2. Check column data types
3. Create calculated columns kalau perlu:
   - Age Group
   - Income Bracket
   - Tenure Group

### Step 6.3: DAX Measures
Create measures ini:
```
Total Employees = COUNTROWS(employees)
Employees Left = CALCULATE(COUNTROWS(employees), employees[Attrition] = "Yes")
Attrition Rate = DIVIDE([Employees Left], [Total Employees], 0)
Avg Satisfaction = AVERAGE(employees[JobSatisfaction])
```

### Step 6.4: Build Dashboard Pages

**Page 1: Executive Summary**
- KPI cards: Total Employees, Attrition Rate, Avg Tenure
- Attrition trend (kalau ada date)
- Department breakdown

**Page 2: Attrition Deep Dive**
- Attrition by Department (bar chart)
- Attrition by Job Role (bar chart)
- Attrition by Age Group (bar chart)

**Page 3: Satisfaction & Compensation**
- Satisfaction levels matrix
- Income vs Attrition
- Work-Life Balance impact

**Page 4: Risk Analysis**
- High risk employees table
- Risk factors breakdown

### Step 6.5: Interactivity
1. Add slicers: Department, Gender, JobRole
2. Sync slicers across pages
3. Add drill-through kalau perlu

### Step 6.6: Polish
1. Consistent color theme
2. Clear titles
3. Proper number formatting
4. Add your name/branding

### Step 6.7: Save & Export
1. Save as `hr_dashboard.pbix` di folder `powerbi/`
2. Export screenshots ke `docs/screenshots/`

**Checkpoint:** Dashboard complete dan interactive

---

## Phase 7: Documentation (30 menit)

### Step 7.1: Update README
1. Update `README.md` dengan:
   - Key findings (3-5 bullet points)
   - Dashboard screenshot
   - Your name

### Step 7.2: Write Key Insights
Buat file `docs/key_insights.md`:
```markdown
# Key Insights

## 1. Overall Attrition
- [Tulis temuan kamu]

## 2. High Risk Groups
- [Tulis temuan kamu]

## 3. Key Factors
- [Tulis temuan kamu]

## 4. Recommendations
- [Tulis rekomendasi berdasarkan data]
```

---

## Phase 8: GitHub (Optional tapi Recommended)

### Step 8.1: Init Repo
```bash
cd hr-analytics-project
git init
git add .
git commit -m "Initial commit: HR Analytics project"
```

### Step 8.2: Push to GitHub
1. Create new repo di GitHub
2. Push local ke remote
3. Make sure README.md keliatan bagus di GitHub

---

## 🎯 Success Criteria

Kamu DONE kalau:
- [ ] Dataset downloaded dan diimport
- [ ] Semua SQL queries dijalankan
- [ ] Notes exploration dan analysis lengkap
- [ ] Excel pivot tables dibuat
- [ ] Power BI dashboard complete (4 pages)
- [ ] README updated dengan findings
- [ ] (Bonus) Pushed ke GitHub

---

## ⏱️ Estimated Time

| Phase | Duration |
|-------|----------|
| Data Acquisition | 30 min |
| Database Setup | 45 min |
| Data Exploration | 1 hr |
| SQL Analysis | 2-3 hr |
| Excel | 1-2 hr |
| Power BI | 3-4 hr |
| Documentation | 30 min |
| **Total** | **9-12 hours** |

Bisa di-split jadi 3-4 hari kerja.

---

## 🆘 Kalau Stuck

1. Google error message-nya
2. Coba breakdown problem jadi lebih kecil
3. Cek Stack Overflow
4. Tanya gw kalau beneran stuck

**Yang penting: JANGAN SKIP STEPS. Setiap step bikin kamu lebih paham.**

Good luck! 🚀
