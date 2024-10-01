create database if not exists pga;

select * from pga.financial_loan;

-- question 1:-  number of columns    answer :- (24) --- 

select count(*) as col_number from  information_schema.columns 
where table_schema = "pga" and table_name = 'financial_loan';

-- question number of rows       answer :-  (38576) ---- 

select count(distinct id) as total_loan_application from pga.financial_loan;

-- question MTD Loan Applications

select count(id) as total_loan_application 
from pga.financial_loan where month(str_to_date(issue_date, '%d-%m-%Y')) = 12;


-- PMTD Loan Applications  answer (4035) 

SELECT COUNT(id) AS Total_Applications FROM pga.financial_loan
WHERE month(str_to_date(issue_date, '%d-%m-%Y')) = 11;

-- Total Funded Amount 

SELECT SUM(loan_amount) AS Total_Funded_Amount FROM pga.financial_loan;

-- MTD Total Funded Amount  answer (53981425) 

SELECT SUM(loan_amount) AS Total_Funded_Amount FROM pga.financial_loan
WHERE month(str_to_date(issue_date, '%d-%m-%Y'))= 12;

-- PMTD Total Funded Amount  answer (47754825) 

SELECT SUM(loan_amount) AS Total_Funded_Amount FROM pga.financial_loan
WHERE month(str_to_date(issue_date, '%d-%m-%Y'))= 11;

-- MTD Total Amount Received  answer ( 58074380) 

SELECT SUM(total_payment) AS Total_Amount_Collected FROM pga.financial_loan
WHERE month(str_to_date(issue_date, '%d-%m-%Y'))= 12;

-- PMTD Total Amount Received  answer (50132030) 

SELECT SUM(total_payment) AS Total_Amount_Collected FROM pga.financial_loan
WHERE month(str_to_date(issue_date, '%d-%m-%Y'))= 11;

-- Average Interest Rate  answer (12.048831397760178)

SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM pga.financial_loan;

-- MTD Average Interest  answer (12.356040797403738)

SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM pga.financial_loan
WHERE month(str_to_date(issue_date, '%d-%m-%Y'))= 12;

 -- PMTD Average Interest answer (11.941717472118796) 
  
SELECT AVG(int_rate)*100 AS PMTD_Avg_Int_Rate FROM pga.financial_loan
WHERE month(str_to_date(issue_date, '%d-%m-%Y'))= 11;  

-- Avg DTI  answer (13.32743311903776) 

SELECT AVG(dti)*100 AS Avg_DTI FROM pga.financial_loan;
 
-- MTD Avg DTI  answer (13.66553778395922) 

SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM pga.financial_loan
WHERE month(str_to_date(issue_date, '%d-%m-%Y'))= 12;


-- PMTD Avg DTI  answer (13.302733581164853) 

SELECT AVG(dti)*100 AS PMTD_Avg_DTI FROM pga.financial_loan
WHERE month(str_to_date(issue_date, '%d-%m-%Y'))= 11;
 
 
 
 -- GOOD LOAN ISSUED
-- Good Loan Percentage  answer (86.17534) 

SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM pga.financial_loan;
 
-- Good Loan Applications answer (33243) 

SELECT COUNT(id) AS Good_Loan_Applications FROM pga.financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';
 
-- Good Loan Funded Amount  answer (370224850)

SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM pga.financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';
 
-- Good Loan Amount Received answer (435786170) 

SELECT SUM(total_payment) AS Good_Loan_amount_received FROM pga.financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current' ;
 

-- BAD LOAN ISSUED

-- Bad Loan Percentage  answer (13.82466) 

SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM pga.financial_loan;
 
-- Bad Loan Applications  answer (5333) 

SELECT COUNT(id) AS Bad_Loan_Applications FROM pga.financial_loan
WHERE loan_status = 'Charged Off';
 
-- Bad Loan Funded Amount      answer (65532225)

SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM pga.financial_loan
WHERE loan_status = 'Charged Off';
 
-- Bad Loan Amount Received  answer (37284763)

SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM pga.financial_loan
WHERE loan_status = 'Charged Off';
 

-- LOAN STATUS

	SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        pga.financial_loan
    GROUP BY
        loan_status;
 

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM pga.financial_loan
WHERE  month(str_to_date(issue_date, '%d-%m-%Y'))= 12 
GROUP BY loan_status;
 
-- B.	BANK LOAN REPORT | OVERVIEW MONTH

SELECT 
	month(str_to_date(issue_date, '%d-%m-%Y')) as Month_Munber, 
	DATENAME(MONTH, str_to_date(issue_date, '%d-%m-%Y')) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(str_to_date(issue_date, '%d-%m-%Y')), DATENAME(MONTH,str_to_date(issue_date, '%d-%m-%Y'))
ORDER BY MONTH(str_to_date(issue_date, '%d-%m-%Y'));

-- STATE

SELECT 
    address_state AS State, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM pga.financial_loan
GROUP BY address_state
ORDER BY address_state;

-- TERM

SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM pga.financial_loan
GROUP BY term
ORDER BY term;
 
-- EMPLOYEE LENGTH

SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM pga.financial_loan
GROUP BY emp_length
ORDER BY emp_length;

-- PURPOSE

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM pga.financial_loan
GROUP BY purpose
ORDER BY purpose;
 
-- HOME OWNERSHIP

SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM pga.financial_loan
GROUP BY home_ownership
ORDER BY home_ownership
;

-- Note: We have applied multiple Filters on all the dashboards. You can check the results for the filters as well by modifying the query and comparing the results.
-- For e.g
-- See the results when we hit the Grade A in the filters for dashboards.

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM pga.financial_loan
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose
;





select * from pga.financial_loan;

describe pga.financial_loan;
