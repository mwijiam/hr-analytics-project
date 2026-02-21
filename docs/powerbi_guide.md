# Power BI Dashboard Guide - HR Analytics

Complete guide untuk bikin dashboard HR Analytics yang **WOW** recruiters! 🚀

**Guide ini step-by-step DETAIL per klik, sesuai data HR Analytics kamu.**

---

## 📋 Pre-requisites

✅ Power BI Desktop installed (free download dari Microsoft)
✅ Dataset ready (CSV file HR dari Kaggle)
✅ SQL analysis udah selesai (kamu tau insight-nya)

---

## 🎨 Dashboard Design Philosophy

### Golden Rules:
1. **Tell a story** - dari overview → deep dive → action
2. **Less is more** - jangan cramming semua visual di 1 page
3. **Consistent colors** - attrition = red, retention = green
4. **Interactive** - slicers, drill-through, tooltips

---

# 📖 STEP-BY-STEP TUTORIAL (DETAIL PER KLIK)

---

## STEP 0: IMPORT DATA (5 menit)

### 0.1 Get Data
1. Buka **Power BI Desktop**
2. Klik **"Get Data"** (tombol besar di tengah home screen)
3. Di window pop-up, ketik **"csv"** di search box
4. Pilih **"Text/CSV"**
5. Klik **"Connect"**

### 0.2 Pilih File
1. Browse ke folder `data/raw/`
2. Pilih file CSV kamu
3. Klik **"Open"**

### 0.3 Transform Data
1. Di preview window, klik **"Transform Data"** (JANGAN klik Load)
2. Power Query Editor akan terbuka

**Di Power Query Editor:**

3. **Rename table:**
   - Di panel kiri (Queries), klik kanan nama file
   - Pilih **"Rename"**
   - Ketik: **employees**
   - Enter

4. **Remove useless columns:**
   - Cari kolom `EmployeeCount` → klik kanan header → **Remove**
   - Cari kolom `Over18` → klik kanan header → **Remove**
   - Cari kolom `StandardHours` → klik kanan header → **Remove**

5. **Close & Apply:**
   - Klik **"Close & Apply"** di ribbon atas (Home tab, pojok kiri)
   - Tunggu loading selesai

### 0.4 Verify
1. Klik icon **Table** di panel kiri (icon kotak-kotak, yang tengah dari 3 icon)
2. Lihat status bar paling bawah → harusnya **"1,470 rows"**
3. Klik balik ke icon **Report** (icon chart, paling atas dari 3 icon)

✅ **Data loaded!**

---

## STEP 1: BIKIN CALCULATED COLUMNS (10 menit)

Sebelum bikin visual, kamu perlu bikin kolom tambahan.

### 1.1 Age Group
1. Klik tab **"Modeling"** di ribbon atas
2. Klik **"New Column"**
3. Di formula bar (atas canvas), **hapus semua** → paste ini:

```dax
Age Group = 
SWITCH(
    TRUE(),
    employees[Age] < 25, "18-24",
    employees[Age] < 35, "25-34",
    employees[Age] < 45, "35-44",
    employees[Age] < 55, "45-54",
    "55+"
)
```

4. Tekan **Enter**
5. Di Fields pane (kanan), cek kolom `Age Group` udah muncul di bawah table employees

### 1.2 Income Bracket
1. Klik **"New Column"** lagi (Modeling tab)
2. Paste:

```dax
Income Bracket = 
SWITCH(
    TRUE(),
    employees[MonthlyIncome] < 3000, "< $3K",
    employees[MonthlyIncome] < 6000, "$3K - $6K",
    employees[MonthlyIncome] < 10000, "$6K - $10K",
    employees[MonthlyIncome] < 15000, "$10K - $15K",
    "$15K+"
)
```

3. Enter

### 1.3 Tenure Group
1. Klik **"New Column"** lagi
2. Paste:

```dax
Tenure Group = 
SWITCH(
    TRUE(),
    employees[YearsAtCompany] < 2, "0-1 years",
    employees[YearsAtCompany] <= 5, "2-5 years",
    employees[YearsAtCompany] <= 10, "6-10 years",
    "10+ years"
)
```

3. Enter

### 1.4 Satisfaction Label
1. Klik **"New Column"** lagi
2. Paste:

```dax
Satisfaction Level = 
SWITCH(
    employees[JobSatisfaction],
    1, "1-Low",
    2, "2-Medium",
    3, "3-High",
    4, "4-Very High"
)
```

3. Enter

### 1.5 WLB Label
1. Klik **"New Column"** lagi
2. Paste:

```dax
WLB Level = 
SWITCH(
    employees[WorkLifeBalance],
    1, "1-Bad",
    2, "2-Good",
    3, "3-Better",
    4, "4-Best"
)
```

3. Enter

✅ **5 calculated columns created!**

---

## STEP 2: BIKIN MEASURES (10 menit)

Measures = formula yang calculate dinamis (berubah sesuai filter).

### 2.1 Total Employees
1. Klik tab **"Modeling"** → klik **"New Measure"**
2. Paste:

```dax
Total Employees = COUNTROWS(employees)
```

3. Enter

### 2.2 Employees Left
1. Klik **"New Measure"** lagi
2. Paste:

```dax
Employees Left = CALCULATE(COUNTROWS(employees), employees[Attrition] = "Yes")
```

3. Enter

### 2.3 Current Employees
1. **New Measure** → Paste:

```dax
Current Employees = CALCULATE(COUNTROWS(employees), employees[Attrition] = "No")
```

### 2.4 Attrition Rate
1. **New Measure** → Paste:

```dax
Attrition Rate = DIVIDE([Employees Left], [Total Employees], 0)
```

### 2.5 Average Income
1. **New Measure** → Paste:

```dax
Avg Income = AVERAGE(employees[MonthlyIncome])
```

### 2.6 Avg Income Left
1. **New Measure** → Paste:

```dax
Avg Income Left = CALCULATE(AVERAGE(employees[MonthlyIncome]), employees[Attrition] = "Yes")
```

### 2.7 Avg Income Stayed
1. **New Measure** → Paste:

```dax
Avg Income Stayed = CALCULATE(AVERAGE(employees[MonthlyIncome]), employees[Attrition] = "No")
```

### 2.8 Avg Tenure
1. **New Measure** → Paste:

```dax
Avg Tenure = AVERAGE(employees[YearsAtCompany])
```

✅ **8 measures created!** Measures icon di Fields pane = 📐 (beda dari kolom biasa)

---

## STEP 3: SET PAGE BACKGROUND (2 menit)

1. Klik **area kosong** di canvas (jangan klik visual manapun)
2. Di **Visualizations pane** (kanan), klik icon **Format** (icon roller cat/paint brush)
3. Cari **"Canvas background"** → expand
4. Color: klik → ketik **#F5F5F5** (light gray)
5. Transparency: **0%**

---

# 📄 PAGE 1: EXECUTIVE SUMMARY

---

## STEP 4: BIKIN HEADER (3 menit)

1. Klik tab **"Insert"** di ribbon
2. Klik **"Text Box"**
3. Taruh di **paling atas canvas** (drag ke atas)
4. Ketik: **HR ANALYTICS DASHBOARD**
5. Select text → Font: **Segoe UI Bold**, Size: **24**
6. Color: klik warna font → ketik **#263238** (dark gray)
7. Resize text box: lebar full canvas, tinggi secukupnya

---

## STEP 5: BIKIN KPI CARDS (10 menit)

Kamu bikin **3 card** berjajar horizontal.

### Card 1: Total Employees

1. Klik area kosong di canvas (di bawah title)
2. Di **Visualizations pane** (kanan atas), klik icon **"Card"**
   - Icon-nya: kotak kecil dengan angka, biasanya baris pertama
3. Dari **Fields pane** (kanan bawah), drag **Total Employees** (measure) ke **"Fields"** di Visualizations
4. **Resize:** Klik visual → drag sudut sampai ukurannya kotak kecil (kira-kira 1/3 lebar canvas)
5. **Format:**
   - Klik visual → Klik icon **Format** (🎨) di Visualizations pane
   - **Callout value** → Font size: **40** → Color: **#1976D2** (blue)
   - **Category label** → toggle **ON** → Text: **Total Employees**
   - **General** → Effects → **Background** → Color: **#FFFFFF** (white)
   - **General** → Effects → **Border** → ON → Color: **#E0E0E0** → Radius: **8**

### Card 2: Employees Left

1. Copy Card 1: **Ctrl+C** → **Ctrl+V**
2. Drag card baru ke **samping kanan** Card 1
3. Klik card baru → di Fields (Visualizations pane) → hapus Total Employees → drag **Employees Left**
4. **Format:** Callout value → Color: **#D32F2F** (red)

### Card 3: Attrition Rate

1. Copy lagi: **Ctrl+C** → **Ctrl+V**
2. Drag ke **samping kanan** Card 2
3. Ganti field jadi **Attrition Rate**
4. **Format:** Callout value → Color: **#D32F2F** (red) → Display units: **None** → Decimal: **2**

**Hasil:**
```
┌──────────┐  ┌──────────┐  ┌──────────┐
│  1,470   │  │   237    │  │  16.12%  │
│  Total   │  │ Employees│  │ Attrition│
│ Employees│  │  Left    │  │  Rate    │
└──────────┘  └──────────┘  └──────────┘
```

✅ **KPI Cards done!**

---

## STEP 6: ATTRITION BY DEPARTMENT - Bar Chart (10 menit)

**Visual: Horizontal Bar Chart**
**Kenapa bar chart?** Compare 3 kategori (department) → bar chart paling clear.

### Bikin:
1. Klik **area kosong** di bawah KPI cards
2. Di Visualizations, klik icon **"Clustered Bar Chart"** (icon bar horizontal)
3. Dari Fields:
   - Drag **Department** ke **Y-axis**
   - Drag **Attrition Rate** (measure) ke **X-axis**

### Format:
4. Format (🎨):
   - **Title** → Text: **"Attrition Rate by Department"** → Font: Bold, 14pt
   - **Data labels** → toggle **ON** → Decimal: 2
   - **Bars** → Color: **#D32F2F** (red)
   - **General** → Effects → Background: **#FFFFFF** → Border: ON, Radius: 8

### Sort:
5. Klik **"..."** (titik tiga) di pojok kanan atas visual → **Sort axis** → **Attrition Rate** → Sort **descending**

**Hasil:** Sales paling atas (20.6%), lalu HR, lalu R&D.

---

## STEP 7: ATTRITION BY TENURE - Line Chart (10 menit)

**Visual: Line Chart**
**Kenapa line?** Ada urutan waktu (0-1, 2-5, 6-10, 10+) → line tunjukin **trend**.

### Bikin:
1. Area kosong (kiri bawah) → **Line Chart**
2. X-axis: **Tenure Group**
3. Y-axis: **Attrition Rate**

### Fix Sort (supaya urut):
Bikin sort column dulu:
1. Modeling → New Column:
```dax
Tenure Sort = 
SWITCH(
    employees[Tenure Group],
    "0-1 years", 1,
    "2-5 years", 2,
    "6-10 years", 3,
    "10+ years", 4
)
```
2. Klik **Tenure Group** di Fields pane
3. Di ribbon → tab **Column tools** → **"Sort by Column"** → pilih **Tenure Sort**

### Format:
- Title: **"Attrition by Tenure"**
- Line color: **#D32F2F** → Width: **3**
- Markers: ON → Size: 6
- Data labels: ON

**Insight:** 0-1 years paling tinggi → turun seiring tenure naik.

---

## STEP 8: TOP ROLES TABLE (10 menit)

**Visual: Table**
**Kenapa table?** Butuh detail per role - angka exact yang bisa di-read.

### Bikin:
1. Area kosong (kanan bawah) → icon **Table**
2. Drag satu-satu: **JobRole**, **Total Employees**, **Employees Left**, **Attrition Rate**

### Sort:
3. Klik header **Attrition Rate** → sort descending

### Conditional Formatting:
4. Di Visualizations → tab **Fields** → klik dropdown **Attrition Rate** → **Conditional formatting** → **Background color**
5. Format style: **Rules**
   - If value >= 0.25 → Color: **#FFCDD2** (light red)
   - If value >= 0.15 → Color: **#FFF9C4** (light yellow)
   - If value < 0.15 → Color: **#C8E6C9** (light green)
6. OK

### Format:
- Title: **"Attrition by Job Role"**
- Style: **Alternating rows**

---

## STEP 9: SLICERS (5 menit)

**Visual: Slicer** - biar user bisa filter semua visual.

### Bikin:
1. Area kosong → icon **Slicer** (icon funnel)
2. Drag **Department** ke Field
3. Format → Slicer settings → Style: **"Tile"** (tombol-tombol)
4. Title: ON → **"Department"**

### Test:
- Klik **"Sales"** → semua visual berubah (filter Sales only)
- Klik lagi → deselect

✅ **Page 1 DONE!** 🎉

---

# 📄 PAGE 2: ATTRITION DEEP DIVE

---

## STEP 10: BIKIN PAGE BARU (1 menit)

1. Di bawah canvas, klik **"+"** (di sebelah tab Page 1)
2. **Double-click** tab baru → rename: **"Attrition Deep Dive"**
3. Set background: canvas → Format → Canvas background → **#F5F5F5**
4. Insert → Text Box → **"ATTRITION DEEP DIVE"** (Bold, 24pt)

---

## STEP 11: BY JOB ROLE - Bar Chart (8 menit)

**Visual: Horizontal Bar Chart** - lebih detail dari department.

1. Area kosong → **Clustered Bar Chart**
2. Y-axis: **JobRole** | X-axis: **Attrition Rate**
3. Sort descending
4. Title: **"Attrition Rate by Job Role"**
5. Color: **#D32F2F** | Data labels: ON
6. Resize: **lebar full, tinggi setengah page**

---

## STEP 12: BY AGE GROUP - Column Chart (8 menit)

**Visual: Column Chart**
**Kenapa column (bukan bar)?** Age punya urutan natural (muda→tua) → column bikin sequence jelas.

1. Area kosong (kiri bawah) → **Clustered Column Chart** (icon bar vertikal)
2. X-axis: **Age Group** | Y-axis: **Attrition Rate**

### Fix Sort:
```dax
Age Sort = 
SWITCH(
    employees[Age Group],
    "18-24", 1, "25-34", 2, "35-44", 3, "45-54", 4, "55+", 5
)
```
- Klik **Age Group** → Column tools → Sort by Column → **Age Sort**

3. Title: **"Attrition by Age Group"**
4. Color: **#1976D2** (blue, beda dari page 1)
5. Data labels: ON

---

## STEP 13: BY MARITAL STATUS - Donut Chart (8 menit)

**Visual: Donut Chart**
**Kenapa donut?** Cuma 3 kategori → proportion visual cocok. JANGAN pakai donut kalau >5 kategori!

1. Area kosong (kanan bawah) → **Donut Chart**
2. Legend: **MaritalStatus** | Values: **Employees Left**
3. Title: **"Employees Left by Marital Status"**
4. Colors:
   - Single: **#D32F2F** (red - paling banyak resign)
   - Married: **#388E3C** (green)
   - Divorced: **#F57C00** (orange)
5. Detail labels: ON → show Category + Value

✅ **Page 2 DONE!** 🎉

---

# 📄 PAGE 3: ROOT CAUSE ANALYSIS

---

## STEP 14: BIKIN PAGE BARU

1. Klik **"+"** → rename: **"Root Cause Analysis"**
2. Background: **#F5F5F5** | Title: **"ROOT CAUSE ANALYSIS"**

---

## STEP 15: JOB SATISFACTION VS ATTRITION - Column Chart (8 menit)

**Kenapa?** Tunjukin korelasi: rendah satisfaction → tinggi attrition.

1. Area kosong → **Clustered Column Chart**
2. X-axis: **Satisfaction Level** | Y-axis: **Attrition Rate**
3. Title: **"Job Satisfaction vs Attrition"**
4. Color: **#7B1FA2** (purple, beda dari page lain)
5. Data labels: ON
6. Resize: 1/3 lebar canvas (kiri)

---

## STEP 16: OVERTIME IMPACT - Bar Chart (8 menit)

**Kenapa bar?** Simple compare 2 kategori (Yes vs No) → paling jelas.

1. Area kosong (kanan atas) → **Clustered Bar Chart**
2. Y-axis: **OverTime** | X-axis: **Attrition Rate**
3. Title: **"Overtime Impact on Attrition"**
4. Data labels: ON
5. Coba set warna per bar:
   - Klik Format → Data colors → Show all → Yes: **#D32F2F** (red), No: **#388E3C** (green)

---

## STEP 17: INCOME GAP - Bar Chart (8 menit)

**Kenapa?** Compare avg income resign vs stay.

1. Area kosong → **Clustered Bar Chart**
2. Y-axis: **Attrition** | X-axis: **Avg Income** (measure)
3. Title: **"Avg Monthly Income: Left vs Stayed"**
4. Data labels: ON
5. Colors: Yes (left) **#D32F2F** | No (stayed) **#388E3C**

---

## STEP 18: WORK-LIFE BALANCE VS ATTRITION - Column Chart (8 menit)

1. Area kosong (bawah) → **Clustered Column Chart**
2. X-axis: **WLB Level** | Y-axis: **Attrition Rate**
3. Title: **"Work-Life Balance vs Attrition"**
4. Color: **#00838F** (teal)
5. Data labels: ON

**Insight:** Bad WLB = 31.3% attrition → BIGGEST factor!

✅ **Page 3 DONE!** 🎉

---

# 📄 PAGE 4: RISK & ACTION

---

## STEP 19: BIKIN PAGE + RISK SCORE

1. Klik **"+"** → rename: **"Risk & Action"**
2. Background: **#F5F5F5** | Title: **"RISK ANALYSIS & RECOMMENDATIONS"**

### Bikin Risk Score Column:
3. Modeling → **New Column**:

```dax
Risk Score = 
VAR LowJobSat = IF(employees[JobSatisfaction] = 1, 2, IF(employees[JobSatisfaction] = 2, 1, 0))
VAR LowEnvSat = IF(employees[EnvironmentSatisfaction] = 1, 2, IF(employees[EnvironmentSatisfaction] = 2, 1, 0))
VAR BadWLB = IF(employees[WorkLifeBalance] = 1, 2, IF(employees[WorkLifeBalance] = 2, 1, 0))
VAR HasOvertime = IF(employees[OverTime] = "Yes", 2, 0)
VAR NewHire = IF(employees[YearsAtCompany] < 2, 1, 0)
VAR LowIncome = IF(employees[MonthlyIncome] < 3000, 2, 0)
RETURN
    LowJobSat + LowEnvSat + BadWLB + HasOvertime + NewHire + LowIncome
```

---

## STEP 20: HIGH RISK TABLE (15 menit)

**Visual: Table** - detail per employee, actionable data.

### Bikin:
1. Area kosong → **Table**
2. Drag: **EmployeeNumber**, **Department**, **JobRole**, **MonthlyIncome**, **Risk Score**, **JobSatisfaction**, **OverTime**

### Filter (PENTING):
3. Di **Filters pane** (biasanya di samping Visualizations):
   - Drag **Attrition** ke **"Filters on this visual"** → centang **"No"** only
   - Drag **Risk Score** ke Filters → set **"is greater than or equal to"** → **5**

### Sort:
4. Klik header **Risk Score** → sort descending

### Conditional Formatting:
5. Risk Score dropdown → Conditional formatting → Background color
   - >= 8: **#D32F2F** (red) 🔴
   - >= 6: **#F57C00** (orange) 🟠
   - >= 4: **#FFF9C4** (yellow) 🟡
6. OK

### Format:
- Title: **"High Risk Employees (Current)"**
- Style: Alternating rows

---

## STEP 21: RECOMMENDATIONS TEXT BOX (5 menit)

1. Insert → **Text Box**
2. Taruh di samping atau bawah table
3. Ketik:

```
KEY RECOMMENDATIONS:

1. URGENT: Reduce overtime for Sales team
   - Overtime = 3x higher attrition!

2. Salary adjustment for income < $3K bracket
   - Low income = 25% attrition rate

3. Promotion review for 3+ years stagnant
   - No promotion = frustration = resign

4. Improve work-life balance
   - Bad WLB = 31% attrition (highest!)

5. 1-on-1 with top 20 high-risk employees
   - Proactive retention before they resign
```

4. Format: Bold headers, font 11-12pt

✅ **Page 4 DONE!** 🎉

---

# 🏁 FINISHING TOUCHES

---

## STEP 22: RENAME PAGE TABS

1. Double-click **Page 1** → **Executive Summary**
2. Page 2 → **Attrition Deep Dive**
3. Page 3 → **Root Cause Analysis**
4. Page 4 → **Risk & Action**

---

## STEP 23: SYNC SLICERS

1. Klik slicer Department di Page 1
2. Tab **"View"** → klik **"Sync Slicers"**
3. Centang **semua pages**

---

## STEP 24: SAVE & SCREENSHOT

### Save:
1. File → Save As → `hr-analytics-project/powerbi/hr_dashboard.pbix`

### Screenshot:
1. Per page → **Win + Shift + S** → save ke `docs/screenshots/`

---

# 📊 VISUAL CHEAT SHEET

| Situasi | Visual yang Cocok | Contoh |
|---------|-------------------|--------|
| Compare kategori | **Bar Chart** (horizontal) | Department, Job Role, Overtime |
| Urutan/sequence | **Column Chart** (vertikal) | Age Group, Satisfaction Level, WLB |
| Proporsi (≤5 item) | **Donut Chart** | Marital Status |
| Single big number | **Card** | Total Employees, Attrition Rate |
| Detail per row | **Table** | High Risk Employees, Job Role detail |
| Trend over time | **Line Chart** | Attrition by Tenure |

### HINDARI:
- ❌ Pie chart untuk >5 kategori
- ❌ 3D charts (distort data)
- ❌ Terlalu banyak warna (max 5-6 per page)
- ❌ Semua di 1 page (4 pages > 1 messy page)

---

# 🎨 COLOR GUIDE

```
Attrition/Negative:  #D32F2F (Red)
Retention/Positive:  #388E3C (Green)
Neutral/Info:        #1976D2 (Blue)
Warning:             #F57C00 (Orange)
Satisfaction:        #7B1FA2 (Purple)
WLB:                 #00838F (Teal)
Background:          #F5F5F5 (Light Gray)
Cards:               #FFFFFF (White)
Text:                #263238 (Dark Gray)
```

---

# ✅ FINAL CHECKLIST

- [ ] 4 pages complete
- [ ] All visuals punya title jelas
- [ ] Data labels visible
- [ ] Colors consistent
- [ ] Slicers work across pages
- [ ] Numbers formatted (%, $)
- [ ] File saved .pbix
- [ ] Screenshots taken

---

**DASHBOARD SELESAI!** 🎉🎉🎉

Kalau stuck di step tertentu, tanya gw!
