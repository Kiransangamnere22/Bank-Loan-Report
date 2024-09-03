
-- select Data from Database 

select * from [Bank Loan DB].[dbo].[Bank_Loan_Data];

-- Find Total Loan application

select COUNT(id) as Total_Loan_Application from [Bank Loan DB].[dbo].[Bank_Loan_Data];

-- Find Total(MTD) Loan Application   .. Month To Date

select COUNT(id) as MTD_Total_Loan_Application from [Bank Loan DB].[dbo].[Bank_Loan_Data]
 where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021;

 CREATE PROCEDURE GetTotalLoanApplication
    @Month INT,
    @Year INT
AS
BEGIN
    SELECT SUM(id) AS PMTD_Total_Loan_Appication
    FROM [Bank Loan DB].[dbo].[Bank_Loan_Data]
    WHERE MONTH(issue_date) = @Month AND YEAR(issue_date) = @Year;
END
EXEC GetTotalLoanApplication @Month = 9, @Year = 2021;

 -- Find (PMTD) Loan Application   .. Prevoius Month To Date

 select COUNT(id) as PMTD_Total_Loan_Application from [Bank Loan DB].[dbo].[Bank_Loan_Data]
 where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021;

 -- Total Funded Amount

 select SUM(loan_amount) as Toatal_Funded_Amount from [Bank Loan DB].[dbo].[Bank_Loan_Data];

 -- Total Funded Amount(MTD)

  select SUM(loan_amount) as MTD_Total_Funded_Amount from [Bank Loan DB].[dbo].[Bank_Loan_Data]
  where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021;

  -- Total Funded Amount(PMTD)

  select SUM(loan_amount) as PMTD_Total_Funded_Amount from [Bank Loan DB].[dbo].[Bank_Loan_Data]
  where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021;

  -- Total Funded Amount(PMTD) (Dynamic)
 CREATE PROCEDURE GetTotalFundedAmount
    @Month INT,
    @Year INT
AS
BEGIN
    SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount
    FROM [Bank Loan DB].[dbo].[Bank_Loan_Data]
    WHERE MONTH(issue_date) = @Month AND YEAR(issue_date) = @Year;
END
EXEC GetTotalFundedAmount @Month = 9, @Year = 2021;

select * from [Bank Loan DB].dbo.Bank_Loan_Data;

-- Total Amount Received

select SUM(total_payment) as Total_Amount_Received from [Bank Loan DB].[dbo].[Bank_Loan_Data];

-- Total Amount Received (MTD)

select SUM(total_payment) as MTD_Total_Amount_Received from [Bank Loan DB].[dbo].[Bank_Loan_Data]
  where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021;

-- Total Amount Received (PMTD)

select SUM(total_payment) as PMTD_Total_Amount_Received from [Bank Loan DB].[dbo].[Bank_Loan_Data]
  where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021;

-- Avg Interest Rate

select AVG(int_rate)* 100 as Avg_Interest_Rate from [Bank Loan DB].dbo.Bank_Loan_Data;
select Round(AVG(int_rate),4)* 100 as Avg_Interest_Rate from [Bank Loan DB].dbo.Bank_Loan_Data;

--MTD Avg Interest Rate
select Round(avg(int_rate),4)*100 as MTD_Avg_interest_rate from [Bank Loan DB].[dbo].[Bank_Loan_Data]
  where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021;

--PMTD Avg Interest Rate

select Round(avg(int_rate),4)*100 as PMTD_Avg_interest_rate from [Bank Loan DB].[dbo].[Bank_Loan_Data]
  where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021;

--Avg Dti Rate

select * from [Bank Loan DB].dbo.Bank_Loan_Data;

select Round(AVG(dti),4)* 100 as Avg_Dti_rate from [Bank Loan DB].dbo.Bank_Loan_Data;

--MTD Avg Dti Rate

select Round(avg(dti),4)*100 as MTD_Avg_dti_rate from [Bank Loan DB].[dbo].[Bank_Loan_Data]
  where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021;

--PMTD Avg Dti Rate

select Round(avg(dti),4)*100 as PMTD_Avg_dti_rate from [Bank Loan DB].[dbo].[Bank_Loan_Data]
  where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021;

-- Good loan Application

select COUNT(loan_status)as Good_loan_Application from [Bank Loan DB].dbo.Bank_Loan_Data
where loan_status='Fully Paid' or loan_status='Current';

-- Good Loan application Percentage

select 
    (COUNT(case when loan_status='Fully Paid' or loan_status='Current' then id end) *100)
	/
	COUNT(id) as Good_Loan_Percentage
from [Bank Loan DB].dbo.Bank_Loan_Data;

select * from [Bank Loan DB].dbo.Bank_Loan_Data;

-- Good loan Funded Amount

select sum(loan_amount)as Good_loan_Funded_Amount from [Bank Loan DB].dbo.Bank_Loan_Data
where loan_status='Fully Paid' or loan_status='Current';

-- Good loan Total Recived Amount

select sum(total_payment)as Good_loan_Total_Received_Amount from [Bank Loan DB].dbo.Bank_Loan_Data
where loan_status='Fully Paid' or loan_status='Current';

-- Bad Loan Application

select COUNT(loan_status)as Bad_loan_Application from [Bank Loan DB].dbo.Bank_Loan_Data
where loan_status='Charged off';

-- Bad Loan application Percentage

select 
    (COUNT(case when loan_status='Charged off' then id end) *100)
	/
	COUNT(id) as bad_Loan_Percentage
from [Bank Loan DB].dbo.Bank_Loan_Data;

-- Bad loan Funded Amount

select sum(loan_amount)as Bad_loan_Funded_Amount from [Bank Loan DB].dbo.Bank_Loan_Data
where loan_status='Charged off';

-- Bad loan Total Recived Amount

select sum(total_payment)as bad_loan_Total_Received_Amount from [Bank Loan DB].dbo.Bank_Loan_Data
where loan_status='Charged off';

-- Loan Status

select 
loan_status,
COUNT(id) as Loan_Count,
SUM(loan_amount) as Total_Funded_Amount,
SUM(total_payment) as Total_Amount_Received,
Round(avg(int_rate),4)*100 as Avg_Interest_Rate,
Round(avg(dti),4)*100 as Avg_DTI
from [Bank Loan DB].dbo.Bank_Loan_Data
group by loan_status;

-- MTD Loan_Status

select 
loan_status,
SUM(loan_amount) as MTD_Total_Funded_Amount,
SUM(total_payment) as MTD_Total_Amount_Received
from [Bank Loan DB].dbo.Bank_Loan_Data
where MONTH(issue_date)=12  and  YEAR(issue_date) = 2021
group by loan_status;

-- DASHBORAD OVERVIEW

select * from [Bank Loan DB].dbo.Bank_Loan_Data;

-- Monthly Trends By Issue Date

select 
 MONTH(issue_date) as Month_Number,
 DATENAME(Month,issue_date) as Month_Name,
 COUNT(id) as Total_Loan_Application,
 SUM(loan_amount) as Total_Funded_Amount,
 SUM(total_payment) as Total_Received_Amount
from [Bank Loan DB].dbo.Bank_Loan_Data
group by MONTH(issue_date), DATENAME(Month,issue_date)
order by MONTH(issue_date);

-- Regional Analysis by State

select 
 address_state,
 COUNT(id) as Total_Loan_Application,
 SUM(loan_amount) as Total_Funded_Amount,
 SUM(total_payment) as Total_Received_Amount
from [Bank Loan DB].dbo.Bank_Loan_Data
group by address_state
order by SUM(loan_amount) desc;

-- Loan Term Analysis:

select 
 term,
 COUNT(id) as Total_Loan_Application,
 SUM(loan_amount) as Total_Funded_Amount,
 SUM(total_payment) as Total_Received_Amount
from [Bank Loan DB].dbo.Bank_Loan_Data
group by term
order by term;

-- Employee Length Analysis:

select 
 emp_length,
 COUNT(id) as Total_Loan_Application,
 SUM(loan_amount) as Total_Funded_Amount,
 SUM(total_payment) as Total_Received_Amount
from [Bank Loan DB].dbo.Bank_Loan_Data
group by emp_length
order by emp_length;

-- Perpose Analysis:

select 
 purpose,
 COUNT(id) as Total_Loan_Application,
 SUM(loan_amount) as Total_Funded_Amount,
 SUM(total_payment) as Total_Received_Amount
from [Bank Loan DB].dbo.Bank_Loan_Data
group by purpose
order by COUNT(id) desc;

select * from [Bank Loan DB].dbo.Bank_Loan_Data;

-- Home Ownership Analysis:

select 
 home_ownership,
 COUNT(id) as Total_Loan_Application,
 SUM(loan_amount) as Total_Funded_Amount,
 SUM(total_payment) as Total_Received_Amount
from [Bank Loan DB].dbo.Bank_Loan_Data
group by home_ownership
order by COUNT(id) desc;

-- Home Ownership Analysis for Grade A:

select 
 home_ownership,
 COUNT(id) as Total_Loan_Application,
 SUM(loan_amount) as Total_Funded_Amount,
 SUM(total_payment) as Total_Received_Amount
from [Bank Loan DB].dbo.Bank_Loan_Data
where grade='A'
group by home_ownership
order by COUNT(id) desc;

-- Dynamic

CREATE PROCEDURE GetLoanByHomeOwnership
    @Grade CHAR(1)  -- Define the grade parameter (assuming single character, e.g., 'A')
AS
BEGIN
    SELECT 
        home_ownership,
        COUNT(id) AS Total_Loan_Application,
        SUM(loan_amount) AS Total_Funded_Amount,
        SUM(total_payment) AS Total_Received_Amount
    FROM [Bank Loan DB].dbo.Bank_Loan_Data
    WHERE grade = @Grade
    GROUP BY home_ownership
    ORDER BY COUNT(id) DESC;
END

EXEC GetLoanByHomeOwnership @Grade = 'C';

select * from [Bank Loan DB].dbo.Bank_Loan_Data;

-- address_State

select 
 home_ownership,
 COUNT(id) as Total_Loan_Application,
 SUM(loan_amount) as Total_Funded_Amount,
 SUM(total_payment) as Total_Received_Amount
from [Bank Loan DB].dbo.Bank_Loan_Data
where grade='A' and address_state='TX'
group by home_ownership
order by COUNT(id) desc;

CREATE PROCEDURE GetLoanByStateAndGrade
    @Grade CHAR(1),              -- Parameter for loan grade
    @AddressState VARCHAR(5)     -- Parameter for address state 
AS
BEGIN
    SELECT 
        home_ownership,
        COUNT(id) AS Total_Loan_Application,
        SUM(loan_amount) AS Total_Funded_Amount,
        SUM(total_payment) AS Total_Received_Amount
    FROM [Bank Loan DB].dbo.Bank_Loan_Data
    WHERE grade = @Grade AND address_state = @AddressState
    GROUP BY home_ownership
    ORDER BY COUNT(id) DESC;
END

EXEC GetLoanByStateAndGrade @Grade = 'C', @AddressState = 'NY';








