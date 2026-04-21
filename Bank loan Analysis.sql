--# Bank Loan Analysis:

SELECT * FROM financial_loan;

SELECT COUNT(*) AS TotalCounts FROM financial_loan;


--# Calculate the total loan application received :
SELECT
	COUNT(id) AS Total_loan_application
FROM financial_loan;

--# Calculate current loan application:
SELECT
	COUNT(id) AS MTD_total_loan
FROM financial_loan
WHERE issue_date BETWEEN '2021-12-01' AND '2021-12-31'; -- DEC 4314

--# Calculate Previous Month applications:
SELECT
	COUNT(id) AS PMTD_total_loan
FROM financial_loan
WHERE issue_date BETWEEN '2021-11-01' AND '2021-11-30'; --NOV 4035

--# Calculate MOM Total loan Applications Percentage:
WITH MTD_APP AS(
SELECT
	COUNT(id) AS MTD_total_loan
FROM financial_loan
WHERE issue_date BETWEEN '2021-12-01' AND '2021-12-31'),
PMTD_APP AS(
SELECT
	COUNT(id) AS PMTD_total_loan
FROM financial_loan
WHERE issue_date BETWEEN '2021-11-01' AND '2021-11-30'
)
SELECT 
	ROUND((CAST(MTD_total_loan - PMTD_total_loan AS FLOAT) / PMTD_total_loan)*100,2) AS MOM_Applications
FROM MTD_APP CROSS JOIN
PMTD_APP;



--# Calculate Total Funded(loan) Amount :
SELECT 
	SUM(loan_amount) AS Funded_Amt -- 435757075
FROM financial_loan;

--# Calculate current month Funded Amount(MTD):
SELECT
	SUM(loan_amount) AS MTD_total_loan  -- 53981425
FROM financial_loan
WHERE issue_date BETWEEN '2021-12-01' AND '2021-12-31';

--# Calculate Previous month Funded Amount(PMTD):
SELECT
	SUM(loan_amount) AS MTD_total_loan  -- 47754825
FROM financial_loan
WHERE issue_date BETWEEN '2021-11-01' AND '2021-11-30';

--# Calculate MOM Total Funded Amount Percentage:
WITH MTD_funded AS(
SELECT
	SUM(loan_amount) AS MTD_total_loan
FROM financial_loan
WHERE issue_date BETWEEN '2021-12-01' AND '2021-12-31'),
PMTD_funded AS(
SELECT
	SUM(loan_amount) AS PMTD_total_loan
FROM financial_loan
WHERE issue_date BETWEEN '2021-11-01' AND '2021-11-30'
)
SELECT 
	ROUND((CAST(MTD_total_loan - PMTD_total_loan AS FLOAT) / PMTD_total_loan)*100,2) AS MOM_funded_Percent --13.04
FROM MTD_funded CROSS JOIN
PMTD_funded;



--# Calculate Total Received Amount:
SELECT 
	SUM(total_payment) AS Received_Amt -- 473070933
FROM financial_loan;

--# Calculate current month Received Amount(MTD):
SELECT
	SUM(total_payment) AS MTD_total_loan  -- 58074380
FROM financial_loan
WHERE issue_date BETWEEN '2021-12-01' AND '2021-12-31';

--# Calculate Previous month Received Amount(PMTD):
SELECT
	SUM(total_payment) AS MTD_total_loan  -- 50132030
FROM financial_loan
WHERE issue_date BETWEEN '2021-11-01' AND '2021-11-30';

--# Calculate MOM Total Received Amount Percentage:
WITH MTD_Received AS(
SELECT
	SUM(total_payment) AS MTD_total_loan
FROM financial_loan
WHERE issue_date BETWEEN '2021-12-01' AND '2021-12-31'),
PMTD_Received AS(
SELECT
	SUM(total_payment) AS PMTD_total_loan
FROM financial_loan
WHERE issue_date BETWEEN '2021-11-01' AND '2021-11-30'
)
SELECT 
	ROUND((CAST(MTD_total_loan - PMTD_total_loan AS FLOAT) / PMTD_total_loan)*100,2) AS MOM_Received_Amt_percent -- 15.84
FROM MTD_Received CROSS JOIN 
PMTD_Received;



--# Calculate the Avg Int Rate :
SELECT 
	AVG(int_rate)*100 AS Avg_int_rate -- 0.12
FROM financial_loan;

--# Calculate current month AVG Rate (MTD):
SELECT
	AVG(int_rate) AS MTD_AVG_rate
FROM financial_loan
WHERE issue_date BETWEEN '2021-12-01' AND '2021-12-31';

--# Calculate Previous month AVG Rate (PMTD):
SELECT
	AVG(int_rate) AS MTD_AVG_rate
FROM financial_loan
WHERE issue_date BETWEEN '2021-11-01' AND '2021-11-30';

--# Calculate MOM AVG Rate:
WITH MTD_AVG AS(
SELECT
	AVG(int_rate) AS MTD_AVG_Rate
FROM financial_loan
WHERE issue_date BETWEEN '2021-12-01' AND '2021-12-31'),
PMTD_AVG AS(
SELECT
	AVG(int_rate) AS PMTD_AVG_Rate
FROM financial_loan
WHERE issue_date BETWEEN '2021-11-01' AND '2021-11-30'
)
SELECT 
	ROUND((CAST(MTD_AVG_Rate - PMTD_AVG_Rate AS FLOAT) / PMTD_AVG_Rate)*100,2) AS MOM_Received_Amt_percent -- 3.47
FROM MTD_AVG CROSS JOIN
PMTD_AVG;



--# Calculate the Avg DTI Rate :
SELECT 
	AVG(dti)*100 AS Avg_Dti_rate -- 13.3274331211432
FROM financial_loan;

--# Calculate current month AVG Rate (MTD):
SELECT
	AVG(dti) AS MTD_Avg_dti
FROM financial_loan
WHERE issue_date BETWEEN '2021-12-01' AND '2021-12-31';

--# Calculate Previous month AVG Rate (PMTD):
SELECT
	AVG(dti) AS PTD_AVG_Dti
FROM financial_loan
WHERE issue_date BETWEEN '2021-11-01' AND '2021-11-30';

--# Calculate MOM AVG Dti :
WITH MTD_AVG_DTI AS(
SELECT
	AVG(dti) AS MTD_AVG_Dti
FROM financial_loan
WHERE issue_date BETWEEN '2021-12-01' AND '2021-12-31'),
PMTD_AVG_DTI AS(
SELECT
	AVG(dti) AS PMTD_AVG_Dti
FROM financial_loan
WHERE issue_date BETWEEN '2021-11-01' AND '2021-11-30'
)
SELECT 
	ROUND((CAST(MTD_AVG_Dti - PMTD_AVG_Dti AS FLOAT) / PMTD_AVG_Dti)*100,2) AS MOM_Received_Amt_percent -- 2.73
FROM MTD_AVG_DTI CROSS JOIN 
PMTD_AVG_DTI;



--# Good Loan Application Percentage:
SELECT 
	COUNT(CASE WHEN loan_status ='Fully Paid' OR loan_status='Current' Then id END)*100.0 / COUNT(id) AS Good_loan_Percentage --86.175342181667
FROM financial_loan;

--# Loan Status Percentage:
SELECT 
    loan_status,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS Percentage
FROM financial_loan
GROUP BY loan_status;

--# Good Loan Applications:
SELECT 
	COUNT(*) AS Loan_app --33243
FROM financial_loan
WHERE loan_status IN('Fully Paid','Current');

--# Good Loan Funded Amount:
SELECT 
	SUM(loan_amount) AS Good_loan_funded --370224850
FROM financial_loan
WHERE loan_status IN('Fully Paid','Current');

--# Good Loan Received Amount:
SELECT 
	SUM(total_payment) AS Good_loan_Received --435786170
FROM financial_loan
WHERE loan_status IN('Fully Paid','Current');



--# Bad Loan Application Percentage:
SELECT 
	COUNT(CASE WHEN loan_status = 'Charged Off' Then id END)*100.0 / COUNT(id) AS Good_loan_Percentage -- 13.824657818332
FROM financial_loan;

--# Bad Loan Applications:
SELECT 
	COUNT(*) AS Loan_app -- 5333
FROM financial_loan
WHERE loan_status = 'Charged Off';

--# Bad Loan Funded Amount:
SELECT 
	SUM(loan_amount) AS Good_loan_funded -- 65532225
FROM financial_loan
WHERE loan_status = 'Charged Off';

--# Bad Loan Received Amount:
SELECT 
	SUM(total_payment) AS Good_loan_Received -- 37284763
FROM financial_loan
WHERE loan_status = 'Charged Off';


--# Loan ststus and total amount:
SELECT
	loan_status,
	SUM(loan_amount) AS Amount
FROM financial_loan
GROUP BY loan_status;


--# Calculate the Amount Received, Amount Funded, Avg_Int, Avg_Dti on the basis of loan Status:
SELECT 
	loan_status,
	SUM(total_payment) AS Amount_received,
	SUM(loan_amount) AS Amount_funded,
	AVG(int_rate) *100.0 AS Avg_interest,
	AVG(dti) *100.0  AS Avg_dti
FROM financial_loan
GROUP BY loan_status;



--# Calculate monthly Total Applications, Total Amount Received,Funded Amount: 
--# BANK LOAN REPORT | Monthly - Overview:
SELECT 
	MONTH(issue_date) AS Months,
	DATENAME(MONTH,issue_date) AS Month_name,
	COUNT(id) AS Total_applications,
	SUM(total_payment) AS Amount_received,
	SUM(loan_amount) AS Amount_funded
FROM financial_loan
GROUP BY MONTH(issue_date),DATENAME(MONTH,issue_date)
ORDER BY MONTH(issue_date);


--# BANK LOAN REPORT | Overiew - States
SELECT 
	address_state,
	COUNT(id) AS Total_applications,
	SUM(total_payment) AS Amount_received,
	SUM(loan_amount) AS Amount_funded
FROM financial_loan
GROUP BY address_state;


--# BANK LOAN REPORT | Overiew - Term
SELECT 
	term,
	COUNT(id) AS Total_applications,
	SUM(total_payment) AS Amount_received,
	SUM(loan_amount) AS Amount_funded
FROM financial_loan
GROUP BY term;


--# BANK LOAN REPORT | Overiew - Emp length
SELECT 
	emp_length,
	COUNT(id) AS Total_applications,
	SUM(total_payment) AS Amount_received,
	SUM(loan_amount) AS Amount_funded
FROM financial_loan
GROUP BY emp_length;


--# BANK LOAN REPORT | Overiew - Purpose
SELECT 
	purpose,
	COUNT(id) AS Total_applications,
	SUM(total_payment) AS Amount_received,
	SUM(loan_amount) AS Amount_funded
FROM financial_loan
GROUP BY purpose;




