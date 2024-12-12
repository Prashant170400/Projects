
-- __________________________________________________IMPORTING THE DATA FROM .CSV FILE____________________________________________________________
create database project;

use project;

-- Imported the table halfway using "table data import wizard" and canceled it right away to get the column headers, truncated the table, 
-- then altered the data types for each column and at last used the bottom code
-- (Imported the table halfway bz it takes very very very ... long time to do so plus the data types are also inappropriate)

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Finance_1.csv'
INTO TABLE finance_1
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
IGNORE 1 ROWS
(@id, @member_id, @loan_amnt, @funded_amnt, @funded_amnt_inv, @term, @int_rate, @installment, 
 @grade, @sub_grade, @emp_title, @emp_length, @home_ownership, @annual_inc, @verification_status, 
 @issue_d, @loan_status, @pymnt_plan, @desc, @purpose, @title, @zip_code, @addr_state, @dti)
SET 
    id = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@id, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    member_id = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@member_id, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    loan_amnt = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@loan_amnt, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    funded_amnt = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@funded_amnt, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    funded_amnt_inv = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@funded_amnt_inv, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    term = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@term, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    int_rate = REPLACE(TRIM(REPLACE(REPLACE(REPLACE(@int_rate, '\t', ''), '\r', ''), '\n', '')), '%', ''),
    installment = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@installment, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    grade = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@grade, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    sub_grade = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@sub_grade, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    emp_title = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@emp_title, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    emp_length = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@emp_length, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    home_ownership = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@home_ownership, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    annual_inc = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@annual_inc, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    verification_status = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@verification_status, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    issue_d = STR_TO_DATE(CONCAT('01-', @issue_d), '%d-%b-%y'),
    loan_status = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@loan_status, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    pymnt_plan = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@pymnt_plan, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    `desc` = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@desc, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    purpose = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@purpose, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    title = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@title, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    zip_code = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@zip_code, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    addr_state = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@addr_state, '\t', ''), '$', ''), '\r', ''), '\n', '')),
    dti = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@dti, '\t', ''), '$', ''), '\r', ''), '\n', ''));
    

    
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Finance_2.csv'
INTO TABLE finance_2
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
IGNORE 1 LINES
(@col1, @col2, @col3, @col4, @col5, @col6, @col7, @col8, @col9, @col10, @col11, @col12, @col13, @col14, @col15, @col16, @col17, @col18, @col19, @col20, @col21, @col22, @col23, @col24, @col25)
SET 
    id = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(@col1,'\t',''), '$',''), '\r', ''), '\n', '')),
    delinq_2yrs = IF(@col2 = 'NA' OR @col2 = '', NULL, @col2),
    earliest_cr_line = IF(@col3 = 'NA' OR @col3 = '', NULL, STR_TO_DATE(@col3, '%b-%y')),
    inq_last_6mths = IF(@col4 = 'NA' OR @col4 = '', NULL, @col4),
    mths_since_last_delinq = IF(@col5 = 'NA' OR @col5 = '', NULL, @col5),
    mths_since_last_record = IF(@col6 = 'NA' OR @col6 = '', NULL, @col6),
    open_acc = IF(@col7 = 'NA' OR @col7 = '', NULL, @col7),
    pub_rec = IF(@col8 = 'NA' OR @col8 = '', NULL, @col8),
    revol_bal = IF(@col9 = 'NA' OR @col9 = '', NULL, @col9),
    revol_util = IF(@col10 = 'NA' OR @col10 = '', NULL, REPLACE(@col10, '%', '') * 1),
    total_acc = IF(@col11 = 'NA' OR @col11 = '', NULL, @col11),
    initial_list_status = IF(@col12 = 'NA' OR @col12 = '', NULL, @col12),
    out_prncp = IF(@col13 = 'NA' OR @col13 = '', NULL, @col13),
    out_prncp_inv = IF(@col14 = 'NA' OR @col14 = '', NULL, @col14),
    total_pymnt = IF(@col15 = 'NA' OR @col15 = '', NULL, @col15),
    total_pymnt_inv = IF(@col16 = 'NA' OR @col16 = '', NULL, @col16),
    total_rec_prncp = IF(@col17 = 'NA' OR @col17 = '', NULL, @col17),
    total_rec_int = IF(@col18 = 'NA' OR @col18 = '', NULL, @col18),
    total_rec_late_fee = IF(@col19 = 'NA' OR @col19 = '', NULL, @col19),
    recoveries = IF(@col20 = 'NA' OR @col20 = '', NULL, @col20),
    collection_recovery_fee = IF(@col21 = 'NA' OR @col21 = '', NULL, @col21),
    last_pymnt_d = IF(@col22 = 'NA' OR @col22 = '', NULL, STR_TO_DATE(@col22, '%b-%y')),
    last_pymnt_amnt = IF(@col23 = 'NA' OR @col23 = '', NULL, @col23),
    next_pymnt_d = IF(@col24 = 'NA' OR @col24 = '', NULL, STR_TO_DATE(@col24, '%b-%y')),
    last_credit_pull_d = IF(@col25 = 'NA' OR @col25 = '', NULL, STR_TO_DATE(@col25, '%b-%y'));
    

-- ________________________________________________________ QUERIES ____________________________________________________________________


-- Count Total Loans Issued
select count(id) as "Number of Loans" from finance_1;


-- Total loan amount vs total payment by year and month
SELECT 
    YEAR(issue_d) AS Year,
    MONTHNAME(issue_d) as Month,
    CONCAT(ROUND(SUM(loan_amnt) / 1000000, 2), ' M') AS 'Total Loan Amount',
    CONCAT(ROUND(SUM(f2.total_pymnt) / 1000000, 2),' M') AS 'Total Payment'
FROM
    finance_1 f1
        JOIN
    finance_2 f2 ON f1.id = f2.id
GROUP BY YEAR(issue_d) , MONTHNAME(issue_d)
ORDER BY YEAR(issue_d) , MONTH(issue_d);


--  Top 5 States with the Most Loans
SELECT f1.addr_state, COUNT(*) AS Total_Number_of_Loans
FROM finance_1 AS f1
LEFT JOIN finance_2 AS f2
ON f1.id = f2.id
GROUP BY f1.addr_state
ORDER BY Total_NUmber_of_Loans DESC
LIMIT 5;

-- Number of Loans with High Revolving Utilization (Above 50%)
SELECT COUNT(*) AS High_Revol_Utilization_Loans
FROM finance_1 AS f1
LEFT JOIN finance_2 AS f2
ON f1.id = f2.id
WHERE CAST(REPLACE(f2.revol_util, '%', '') AS DECIMAL) > 50;

-- Loans with Delinquency Issues
SELECT f1.id, f1.loan_amnt, f2.delinq_2yrs, f2.mths_since_last_delinq
FROM finance_1 AS f1
JOIN finance_2 AS f2
ON f1.id = f2.id
WHERE f2.delinq_2yrs > 0 OR f2.mths_since_last_delinq > 0;

-- Average Interest Rate by Grade
SELECT f1.grade, round(AVG(f1.int_rate),2) AS Average_Interest_Rate
FROM finance_1 AS f1
JOIN finance_2 AS f2
ON f1.id = f2.id
GROUP BY f1.grade
ORDER BY f1.grade;

-- Recoveries and Collection Fees for Charged Off Loans
SELECT 
    COUNT(f1.id) AS 'Total_count',
    f1.loan_status,
    CONCAT(ROUND(SUM(f2.recoveries) / 1000, 2),' K') AS Recoveries,
    CONCAT(ROUND(SUM(f2.collection_recovery_fee) / 1000, 2),' K') AS 'Collection_recovery_fee'
FROM
    finance_1 AS f1
        LEFT JOIN
    finance_2 AS f2 ON f1.id = f2.id
WHERE
    f1.loan_status = 'Charged Off';


-- Revolving Utilization Rate Distribution:
-- Breakdown loans into bands (e.g., 0-25%, 25-50%, 50-75%, etc.) and count:
SELECT 
    CASE 
        WHEN CAST(REPLACE(f2.revol_util, '%', '') AS DECIMAL) <= 25 THEN '0-25%'
        WHEN CAST(REPLACE(f2.revol_util, '%', '') AS DECIMAL) <= 50 THEN '26-50%'
        WHEN CAST(REPLACE(f2.revol_util, '%', '') AS DECIMAL) <= 75 THEN '51-75%'
        ELSE '76-100%' 
    END AS Utilization_Band,
    COUNT(*) AS Loan_Count
FROM finance_1 AS f1
JOIN finance_2 AS f2
ON f1.id = f2.id
GROUP BY Utilization_Band;

-- Top Borrower States by Total Payments:
SELECT f1.addr_state, CONCAT(ROUND(SUM(f2.total_pymnt) / 1000000, 2),' M') AS Total_Payments
FROM finance_1 AS f1
JOIN finance_2 AS f2
ON f1.id = f2.id
GROUP BY f1.addr_state
ORDER BY Total_Payments DESC;
