-- ============================================
-- HR Analytics - Create Table
-- ============================================

-- Create the main employees table
CREATE TABLE employees (
    EmployeeNumber INT PRIMARY KEY,
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EmployeeCount INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(5),
    OverTime VARCHAR(10),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

-- Note: After creating table, import data from CSV
-- In MySQL: LOAD DATA INFILE 'path/to/file.csv' INTO TABLE employees
-- In PostgreSQL: COPY employees FROM 'path/to/file.csv' CSV HEADER
-- In SQL Server: Use Import Wizard or BULK INSERT
