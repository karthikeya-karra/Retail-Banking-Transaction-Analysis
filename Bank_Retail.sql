/* ================================================================
   RETAIL BANKING TRANSACTION ANALYSIS
   MYSQL BUSINESS ANALYTICS PROJECT
   ================================================================

   PROJECT TITLE:
   Retail Banking Transaction Analysis

   ROLE:
   Data Analyst - Retail Banking

   DATABASE:
   retail_banking

   DATASETS:
   customers       = 500 rows, 13 columns
   accounts        = 700 rows, 10 columns
   branches        = 40 rows, 7 columns
   loans           = 300 rows, 13 columns
   loan_payments   = 2000 rows, 11 columns
   cards           = 600 rows, 10 columns
   transactions    = 5000 rows, 10 columns

*/


/* ================================================================
   PROJECT INTRODUCTION
   ================================================================ */

/*
PROJECT OBJECTIVE:

The objective of this project is to analyse retail banking data
using MySQL and generate meaningful business insights.

The project analyses:

1. Customer profiles and segmentation
2. Account usage
3. Branch activity
4. Transaction patterns
5. Loan performance
6. Loan repayment behaviour
7. Card usage
8. Product engagement
9. Cross-selling opportunities
10. Customer and business performance
*/


/* ================================================================
   COMPANY BACKGROUND
   ================================================================ */

/*
The company is a retail banking organization providing financial
products and services to individual customers.

The bank operates through multiple branches and provides:

- Bank accounts
- Loans
- Debit/Credit cards
- Transaction services

The bank maintains data related to:

- Customers
- Accounts
- Branches
- Loans
- Loan payments
- Cards
- Transactions

BUSINESS OBJECTIVES:

1. Improve customer satisfaction.
2. Understand customer behaviour.
3. Increase banking product usage.
4. Monitor transaction activity.
5. Improve loan risk management.
6. Identify cross-selling opportunities.
7. Improve branch performance.
8. Retain high-value customers.
*/


/* ================================================================
   ROLE
   ================================================================ */

/*
ROLE:
Data Analyst supporting the Retail Banking team.

RESPONSIBILITIES:

1. Understand business requirements.
2. Understand the ER diagram.
3. Create the relational database.
4. Import and validate CSV data.
5. Analyse customer profiles.
6. Analyse account and branch activity.
7. Analyse transaction patterns.
8. Analyse loans and repayments.
9. Analyse card usage.
10. Identify business opportunities.
11. Generate business insights.
12. Provide recommendations.
*/


/* ================================================================
   UNDERSTANDING THE ER DIAGRAM
   ================================================================ */

/*
TABLES:

1. customers
2. accounts
3. branches
4. loans
5. loan_payments
6. cards
7. transactions


PRIMARY KEYS:

customers.customer_id
accounts.account_id
branches.branch_id
loans.loan_id
loan_payments.payment_id
cards.card_id
transactions.transaction_id


FOREIGN KEY RELATIONSHIPS:

customers.customer_id
        |
        +---- accounts.customer_id
        |
        +---- loans.customer_id


branches.branch_id
        |
        +---- accounts.branch_id
        |
        +---- loans.branch_id


accounts.account_id
        |
        +---- cards.account_id
        |
        +---- transactions.account_id


loans.loan_id
        |
        +---- loan_payments.loan_id


TIME-BASED ANALYSIS RULE:

For time-based analysis such as card expiry and loan maturity,
the latest transaction_date in the transactions table is treated
as "today" instead of the actual current date.
*/


/* ================================================================
   ANALYTICAL THINKING FROM ER DIAGRAM
   NO SQL AT THIS STAGE
   ================================================================ */

/*
------------------------------------------------------------------
SITUATION 1
------------------------------------------------------------------

BUSINESS QUESTION:

The Customer team wants to identify customers and understand
which customer segment they belong to.

TABLES REQUIRED:

customers

COLUMNS REQUIRED:

customer_id
first_name
last_name
gender
date_of_birth
city
state
customer_since
kyc_status
segment
annual_income
credit_score
is_active

LOGICAL APPROACH:

Use the customers table to examine customer demographics,
income, credit score, customer segment, KYC status and
customer activity.

Customers can be compared across different segments to
understand the characteristics of the customer base.
*/


/*
------------------------------------------------------------------
SITUATION 2
------------------------------------------------------------------

BUSINESS QUESTION:

Management wants to identify customers who have more than
one bank account.

TABLES REQUIRED:

customers
accounts

COLUMNS REQUIRED:

customers.customer_id
accounts.customer_id
accounts.account_id
accounts.account_type
accounts.status

RELATIONSHIP:

customers.customer_id -> accounts.customer_id

LOGICAL APPROACH:

Connect customers and accounts using customer_id.

Count the number of accounts owned by each customer and
identify customers having more than one account.
*/


/*
------------------------------------------------------------------
SITUATION 3
------------------------------------------------------------------

BUSINESS QUESTION:

The Branch team wants to compare the accounts associated
with different branches.

TABLES REQUIRED:

branches
accounts

COLUMNS REQUIRED:

branches.branch_id
branches.branch_name
branches.city
branches.region
accounts.account_id
accounts.branch_id
accounts.account_type
accounts.current_balance
accounts.status

RELATIONSHIP:

branches.branch_id -> accounts.branch_id

LOGICAL APPROACH:

Connect branches and accounts using branch_id.

Compare account count, account types, balances and account
status across branches.
*/


/*
------------------------------------------------------------------
SITUATION 4
------------------------------------------------------------------

BUSINESS QUESTION:

The bank wants to understand how customers are using their
accounts through transactions.

TABLES REQUIRED:

customers
accounts
transactions

COLUMNS REQUIRED:

customers.customer_id
accounts.customer_id
accounts.account_id
transactions.account_id
transactions.transaction_type
transactions.amount
transactions.transaction_date
transactions.channel
transactions.status

RELATIONSHIPS:

customers.customer_id -> accounts.customer_id
accounts.account_id -> transactions.account_id

LOGICAL APPROACH:

Connect customers to accounts and accounts to transactions.

Analyse transaction frequency, transaction values, transaction
types and transaction channels to understand account usage.
*/


/*
------------------------------------------------------------------
SITUATION 5
------------------------------------------------------------------

BUSINESS QUESTION:

Management wants to identify which types of transactions are
most common and through which channels they occur.

TABLE REQUIRED:

transactions

COLUMNS REQUIRED:

transaction_type
channel
amount
status
transaction_date

LOGICAL APPROACH:

Group transactions by transaction type and channel.

Compare transaction counts and transaction amounts to identify
the most commonly used transaction types and channels.
*/


/*
------------------------------------------------------------------
SITUATION 6
------------------------------------------------------------------

BUSINESS QUESTION:

The Loans team wants to understand which customers have loans
and what type of loans they have.

TABLES REQUIRED:

customers
loans

COLUMNS REQUIRED:

customers.customer_id
loans.customer_id
loans.loan_id
loans.loan_type
loans.principal_amount
loans.outstanding_balance
loans.loan_status
loans.purpose

RELATIONSHIP:

customers.customer_id -> loans.customer_id

LOGICAL APPROACH:

Connect customers and loans using customer_id.

Analyse loan types, purposes, principal amounts, outstanding
balances and loan statuses.
*/


/*
------------------------------------------------------------------
SITUATION 7
------------------------------------------------------------------

BUSINESS QUESTION:

The Loans team wants to examine whether loan customers are
making their payments on time.

TABLES REQUIRED:

customers
loans
loan_payments

COLUMNS REQUIRED:

customers.customer_id
loans.customer_id
loans.loan_id
loans.loan_type
loans.outstanding_balance
loan_payments.payment_id
loan_payments.payment_date
loan_payments.scheduled_amount
loan_payments.paid_amount
loan_payments.days_late
loan_payments.penalty
loan_payments.status

RELATIONSHIPS:

customers.customer_id -> loans.customer_id
loans.loan_id -> loan_payments.loan_id

LOGICAL APPROACH:

Connect customers to loans and loans to loan payments.

Compare scheduled amounts, paid amounts, payment status,
days late and penalties to identify repayment behaviour.
*/


/*
------------------------------------------------------------------
SITUATION 8
------------------------------------------------------------------

BUSINESS QUESTION:

Management wants to compare loan performance across
different branches.

TABLES REQUIRED:

branches
loans

COLUMNS REQUIRED:

branches.branch_id
branches.branch_name
loans.branch_id
loans.loan_id
loans.loan_type
loans.principal_amount
loans.outstanding_balance
loans.loan_status

RELATIONSHIP:

branches.branch_id -> loans.branch_id

LOGICAL APPROACH:

Connect branches and loans using branch_id.

Compare loan count, principal amount, outstanding balance
and loan status across branches.
*/


/*
------------------------------------------------------------------
SITUATION 9
------------------------------------------------------------------

BUSINESS QUESTION:

The bank wants to understand which customers have cards
linked to their accounts.

TABLES REQUIRED:

customers
accounts
cards

COLUMNS REQUIRED:

customers.customer_id
accounts.customer_id
accounts.account_id
cards.account_id
cards.card_id
cards.card_type
cards.network
cards.is_active
cards.outstanding_balance

RELATIONSHIPS:

customers.customer_id -> accounts.customer_id
accounts.account_id -> cards.account_id

LOGICAL APPROACH:

Connect customers to accounts and accounts to cards.

Identify customers with cards and compare card types,
networks, active status and outstanding balances.
*/


/*
------------------------------------------------------------------
SITUATION 10
------------------------------------------------------------------

BUSINESS QUESTION:

Management wants to understand how customers are using
different banking products such as accounts, cards and loans.

TABLES REQUIRED:

customers
accounts
cards
loans

COLUMNS REQUIRED:

customer_id
account_id
card_id
loan_id
account_type
card_type
loan_type
current_balance
outstanding_balance

RELATIONSHIPS:

customers -> accounts
customers -> loans
accounts -> cards

LOGICAL APPROACH:

Bring together customers, accounts, cards and loans.

Identify customers using one, two or multiple banking
products and analyse opportunities for cross-selling.
*/

-- =========================================================
-- DATABASE CREATION
-- =========================================================
CREATE DATABASE retail_banking;
use retail_banking;

-- =========================================================
-- CREATION OF TABLES
-- =========================================================

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(30),
    customer_since DATE,
    kyc_status VARCHAR(20),
    segment VARCHAR(30),
    annual_income DECIMAL(15,2),
    credit_score INT,
    is_active VARCHAR(3)
);
select * from customers;
CREATE TABLE branches (
	branch_id VARCHAR(10) PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(30),
    region VARCHAR(30),
    opening_date DATE,
    employee_count INT
);
select * from branches;
CREATE TABLE accounts (
    account_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    branch_id VARCHAR(10) NOT NULL,
    account_type VARCHAR(30),
    open_date DATE,
    close_date DATE,
    current_balance DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    overdraft_limit DECIMAL(12,2),
    status VARCHAR(20),

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);
select * from accounts;
DROP TABLE accounts_staging;
SELECT COUNT(*) AS total_accounts FROM accounts;
TRUNCATE TABLE accounts_staging;
CREATE TABLE accounts_staging (
    account_id VARCHAR(20),
    customer_id VARCHAR(20),
    branch_id VARCHAR(10),
    account_type VARCHAR(30),
    open_date VARCHAR(20),
    close_date VARCHAR(20),
    current_balance VARCHAR(50),
    interest_rate VARCHAR(50),
    overdraft_limit VARCHAR(50),
    status VARCHAR(20)
);
SELECT COUNT(*) AS current_accounts FROM accounts;
SELECT COUNT(*) AS total_staging FROM accounts_staging;
SELECT COUNT(*) AS blank_close_dates
FROM accounts_staging
WHERE close_date = '';
INSERT INTO accounts (
    account_id,
    customer_id,
    branch_id,
    account_type,
    open_date,
    close_date,
    current_balance,
    interest_rate,
    overdraft_limit,
    status
)
SELECT
    account_id,
    customer_id,
    branch_id,
    account_type,
    STR_TO_DATE(open_date, '%c/%e/%Y'),
    CASE
        WHEN close_date = '' THEN NULL
        ELSE STR_TO_DATE(close_date, '%c/%e/%Y')
    END,
    CAST(current_balance AS DECIMAL(15,2)),
    CAST(interest_rate AS DECIMAL(5,2)),
    CAST(overdraft_limit AS DECIMAL(12,2)),
    status
FROM accounts_staging;
SELECT COUNT(*) AS total_accounts FROM accounts;
SELECT COUNT(*) AS accounts_without_close_date FROM accounts WHERE close_date IS NULL;
-- created the account stagging to insert values from accounts_stagging to accounts
CREATE TABLE loans (
    loan_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    branch_id VARCHAR(10) NOT NULL,
    loan_type VARCHAR(30),
    principal_amount DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    tenure_months INT,
    disbursement_date DATE,
    maturity_date DATE,
    emi_amount DECIMAL(12,2),
    outstanding_balance DECIMAL(15,2),
    loan_status VARCHAR(20),
    purpose VARCHAR(50),

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE loan_payments (
    payment_id VARCHAR(20) PRIMARY KEY,
    loan_id VARCHAR(20) NOT NULL,
    payment_date DATE,
    scheduled_amount DECIMAL(12,2),
    paid_amount DECIMAL(12,2),
    principal_paid DECIMAL(12,2),
    interest_paid DECIMAL(12,2),
    penalty DECIMAL(12,2),
    days_late INT,
    payment_method VARCHAR(30),
    status VARCHAR(20),

    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

CREATE TABLE cards (
    card_id VARCHAR(20) PRIMARY KEY,
    account_id VARCHAR(20) NOT NULL,
    card_type VARCHAR(20),
    issue_date DATE,
    expiry_date DATE,
    credit_limit DECIMAL(12,2),
    outstanding_balance DECIMAL(12,2),
    reward_points INT,
    is_active VARCHAR(3),
    network VARCHAR(20),

    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE transactions (
    transaction_id VARCHAR(20) PRIMARY KEY,
    account_id VARCHAR(20) NOT NULL,
    transaction_date DATE,
    transaction_time TIME,
    transaction_type VARCHAR(30),
    amount DECIMAL(15,2),
    channel VARCHAR(30),
    description VARCHAR(50),
    balance_after DECIMAL(15,2),
    status VARCHAR(20),

    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- Verifying the Imported Data

SELECT 'customers' AS table_name, COUNT(*) AS total_records FROM customers
UNION ALL
SELECT 'branches', COUNT(*) FROM branches
UNION ALL
SELECT 'accounts', COUNT(*) FROM accounts
UNION ALL
SELECT 'loans', COUNT(*) FROM loans
UNION ALL
SELECT 'loan_payments', COUNT(*) FROM loan_payments
UNION ALL
SELECT 'cards', COUNT(*) FROM cards
UNION ALL
SELECT 'transactions', COUNT(*) FROM transactions;

-- =========================================================
-- DATA EXPLORATION
-- =========================================================

-- 11. What is the total number of customers?
SELECT COUNT(*) AS total_customers FROM customers;

-- 12. What is the total number of accounts?
SELECT COUNT(*) AS total_ccounts FROM accounts;

-- 13. What are the different account types available?
SELECT DISTINCT account_type FROM accounts;

-- 14. How many customers are currently active?
SELECT COUNT(*) AS active_customers FROM customers WHERE is_active = 'Yes';

-- 15. What are the different transaction types available?
SELECT DISTINCT transaction_type FROM transactions;

-- 16. What is the total amount of completed transactions?
SELECT SUM(amount) AS total_completed_transaction_amount FROM transactions WHERE status = 'Completed';

-- 17. What are the different loan types available?
SELECT DISTINCT loan_type FROM loans;

-- 18. What is the total number of loans?
SELECT COUNT(*) AS total_loans FROM loans;

-- 19. What are the different card types available? 
SELECT DISTINCT card_type FROM cards;

-- 20. What is the total outstanding loan balance?
SELECT SUM(outstanding_balance) AS total_outstanding_loan_balance FROM loans;


-- =========================================================
-- CUSTOMER PROFILE AND SEGMENTATION
-- =========================================================

-- Q21. How many customers are in each segment?
SELECT segment, COUNT(*) AS customer_count FROM customers GROUP BY segment ORDER BY customer_count DESC;

-- Q22. What is the average income and credit score for each segment?
SELECT segment, ROUND(AVG(annual_income), 2) AS average_income, ROUND(AVG(credit_score), 2) AS average_credit_score FROM customers
GROUP BY segment ORDER BY segment;

-- Q23. How many customers are there in each state?
SELECT state, COUNT(*) AS customer_count FROM customers GROUP BY state ORDER BY customer_count DESC;

-- Q24. What is the average income by customer segment?
SELECT segment, ROUND(AVG(annual_income), 2) AS average_income FROM customers GROUP BY segment ORDER BY average_income DESC;

-- Q25. What is the distribution of KYC status?
SELECT kyc_status, COUNT(*) AS customer_count FROM customers GROUP BY kyc_status ORDER BY customer_count DESC;

-- Q26. What is the distribution of active and inactive customers?
SELECT is_active, COUNT(*) AS customer_count FROM customers GROUP BY is_active;

-- Q27. Which customer segments have the highest average credit score?
SELECT segment, ROUND(AVG(credit_score), 2) AS average_credit_score FROM customers GROUP BY segment ORDER BY average_credit_score DESC;

-- Q28. How many accounts exist for each account type?
SELECT account_type, COUNT(*) AS account_count FROM accounts GROUP BY account_type ORDER BY account_count DESC;

-- Q29. What is the total balance for each account type?
SELECT account_type, ROUND(SUM(current_balance), 2) AS total_balance FROM accounts GROUP BY account_type ORDER BY total_balance DESC;

-- Q30. What is the average balance for each account type?
SELECT account_type, ROUND(AVG(current_balance), 2) AS average_balance FROM accounts GROUP BY account_type ORDER BY average_balance DESC;

-- Q31. How many accounts does each branch have?
SELECT b.branch_name, b.city, b.state, COUNT(a.account_id) AS account_count FROM branches b 
LEFT JOIN accounts a ON b.branch_id = a.branch_id GROUP BY b.branch_id, b.branch_name, b.city, b.state ORDER BY account_count DESC;

-- Q32. What is the total account balance for each branch?
SELECT b.branch_name, ROUND(SUM(a.current_balance), 2) AS total_balance FROM branches b 
JOIN accounts a ON b.branch_id = a.branch_id GROUP BY b.branch_id, b.branch_name ORDER BY total_balance DESC;

-- Q33. Compare active and closed accounts.
SELECT status, COUNT(*) AS account_count, ROUND(SUM(current_balance), 2) AS total_balance, ROUND(AVG(current_balance), 2) AS average_balance 
FROM accounts GROUP BY status ORDER BY account_count DESC;

-- Q34. What are the average interest rates for each account type?
SELECT account_type, ROUND(AVG(interest_rate), 2) AS average_interest_rate FROM accounts 
GROUP BY account_type ORDER BY average_interest_rate DESC;

-- Q35. Which customers have more than one account?
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, COUNT(a.account_id) AS account_count FROM customers c 
JOIN accounts a ON c.customer_id = a.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name HAVING COUNT(a.account_id) > 1 
ORDER BY account_count DESC;

-- =========================================================
-- TRANSACTION PATTERNS
-- =========================================================

-- Q36. What are the transaction counts and total amounts by transaction type?
SELECT transaction_type, COUNT(*) AS transaction_count, ROUND(SUM(amount), 2) AS total_amount FROM transactions 
GROUP BY transaction_type ORDER BY total_amount DESC;

-- Q37. Which transaction channels are most commonly used?
SELECT channel, COUNT(*) AS transaction_count, ROUND(SUM(amount), 2) AS total_amount FROM transactions 
GROUP BY channel ORDER BY transaction_count DESC;

-- Q38. What is the average transaction amount by transaction type?
SELECT transaction_type, ROUND(AVG(amount), 2) AS average_transaction_amount FROM transactions 
GROUP BY transaction_type ORDER BY average_transaction_amount DESC;

-- Q39. What are the most common transaction descriptions?
SELECT description, COUNT(*) AS transaction_count FROM transactions GROUP BY description ORDER BY transaction_count DESC LIMIT 10;

-- Q40. How does transaction activity change over time?
SELECT YEAR(transaction_date) AS transaction_year, MONTH(transaction_date) AS transaction_month, COUNT(*) AS transaction_count, 
ROUND(SUM(amount), 2) AS total_amount FROM transactions 
GROUP BY YEAR(transaction_date), MONTH(transaction_date) 
ORDER BY transaction_year, transaction_month;

-- Q41. Which accounts have the highest transaction activity?
SELECT account_id, COUNT(*) AS transaction_count, ROUND(SUM(amount), 2) AS total_transaction_amount FROM transactions 
GROUP BY account_id ORDER BY transaction_count DESC LIMIT 10;

-- Q42. Which transaction statuses have the highest transaction amounts?
SELECT status, COUNT(*) AS transaction_count, ROUND(SUM(amount), 2) AS total_amount FROM transactions 
GROUP BY status ORDER BY total_amount DESC;

-- Q43. Which customers have the highest transaction activity?
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, COUNT(t.transaction_id) AS transaction_count, 
ROUND(SUM(t.amount), 2) AS total_transaction_amount FROM customers c 
JOIN accounts a ON c.customer_id = a.customer_id JOIN transactions t ON a.account_id = t.account_id 
GROUP BY c.customer_id, c.first_name, c.last_name 
ORDER BY total_transaction_amount DESC LIMIT 10;

-- =========================================================
-- LOAN PERFORMANCE AND REPAYMENT BEHAVIOUR
-- =========================================================

-- Q44. How many loans exist for each loan type?
SELECT loan_type, COUNT(*) AS loan_count, ROUND(SUM(principal_amount), 2) AS total_principal FROM loans 
GROUP BY loan_type ORDER BY loan_count DESC;

-- Q45. What is the total outstanding balance by loan type?
SELECT loan_type, ROUND(SUM(outstanding_balance), 2) AS total_outstanding_balance FROM loans 
GROUP BY loan_type ORDER BY total_outstanding_balance DESC;

-- Q46. What are the most common loan purposes?
SELECT purpose, COUNT(*) AS loan_count, ROUND(SUM(principal_amount), 2) AS total_principal FROM loans 
GROUP BY purpose ORDER BY loan_count DESC;

-- Q47. How are loans distributed by loan status?
SELECT loan_status, COUNT(*) AS loan_count, ROUND(SUM(principal_amount), 2) AS total_principal, 
ROUND(SUM(outstanding_balance), 2) AS total_outstanding FROM loans GROUP BY loan_status ORDER BY loan_count DESC;

-- Q48. Which branches have the highest loan exposure?
SELECT b.branch_name, COUNT(l.loan_id) AS loan_count, ROUND(SUM(l.principal_amount), 2) AS total_principal, 
ROUND(SUM(l.outstanding_balance), 2) AS total_outstanding FROM branches b 
JOIN loans l ON b.branch_id = l.branch_id 
GROUP BY b.branch_id, b.branch_name 
ORDER BY total_outstanding DESC;

-- Q49. How many loan payments were late?
SELECT COUNT(*) AS late_payment_count FROM loan_payments WHERE days_late > 0;

-- Q50. What is the average number of days late by payment status?
SELECT status, COUNT(*) AS payment_count, ROUND(AVG(days_late), 2) AS average_days_late FROM loan_payments 
GROUP BY status ORDER BY average_days_late DESC;

-- Q51. Which payment methods are most commonly used?
SELECT payment_method, COUNT(*) AS payment_count, ROUND(SUM(paid_amount), 2) AS total_paid_amount FROM loan_payments 
GROUP BY payment_method ORDER BY payment_count DESC;

-- Q52. What is the total penalty collected from late payments?
SELECT ROUND(SUM(penalty), 2) AS total_penalty FROM loan_payments WHERE days_late > 0;

-- =========================================================
-- CARD USAGE AND PRODUCT ENGAGEMENT
-- =========================================================

-- Q53. How many cards exist for each card type?
SELECT card_type, COUNT(*) AS card_count FROM cards GROUP BY card_type ORDER BY card_count DESC;

-- Q54. Compare credit limits and outstanding balances by card type.
SELECT card_type, COUNT(*) AS card_count, ROUND(AVG(credit_limit), 2) AS average_credit_limit, 
ROUND(AVG(outstanding_balance), 2) AS average_outstanding_balance FROM cards 
GROUP BY card_type ORDER BY average_credit_limit DESC;

-- Q55. Compare active and inactive cards.
SELECT is_active, COUNT(*) AS card_count, ROUND(SUM(credit_limit), 2) AS total_credit_limit, 
ROUND(SUM(outstanding_balance), 2) AS total_outstanding_balance FROM cards GROUP BY is_active;

-- Q56. Which card networks are most commonly used?
SELECT network, COUNT(*) AS card_count, ROUND(SUM(reward_points), 0) AS total_reward_points FROM cards 
GROUP BY network ORDER BY card_count DESC;

-- Q57. Which accounts have multiple cards?
SELECT a.account_id, a.customer_id, COUNT(c.card_id) AS card_count FROM accounts a 
JOIN cards c ON a.account_id = c.account_id GROUP BY a.account_id, a.customer_id HAVING COUNT(c.card_id) > 1 ORDER BY card_count DESC;

-- Q58. How many banking products does each customer have?
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, COUNT(DISTINCT a.account_id) AS account_count, 
COUNT(DISTINCT ca.card_id) AS card_count, COUNT(DISTINCT l.loan_id) AS loan_count FROM customers c 
LEFT JOIN accounts a ON c.customer_id = a.customer_id 
LEFT JOIN cards ca ON a.account_id = ca.account_id 
LEFT JOIN loans l ON c.customer_id = l.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name 
ORDER BY account_count DESC, card_count DESC, loan_count DESC;

/* ================================================================
   FINAL BUSINESS INSIGHTS
   ================================================================ */

/*
INSIGHT 1 - CUSTOMER SEGMENTATION

Customer segmentation analysis helps the bank understand
differences in customer count, income, credit score,
demographics, KYC status and customer activity.

The bank can use these differences to design more relevant
products and marketing strategies for each customer segment.
*/


/*
INSIGHT 2 - ACCOUNT USAGE

Account analysis identifies account types, customer account
ownership, branch-level activity and account balances.

Customers with multiple accounts and high balances may represent
stronger banking relationships and should be considered for
retention and additional product opportunities.
*/


/*
INSIGHT 3 - TRANSACTION PATTERNS

Transaction analysis identifies frequently used transaction
types, preferred channels, transaction values and transaction
activity over time.

This information can help the bank improve transaction services
and encourage customers to use convenient banking channels.
*/


/*
INSIGHT 4 - LOAN PERFORMANCE

Loan analysis provides information about loan types, loan
purposes, outstanding balances, loan statuses and branch-level
loan performance.

Defaulted and arrears loans should receive closer monitoring
because they can increase portfolio risk.
*/


/*
INSIGHT 5 - REPAYMENT BEHAVIOUR

Loan payment analysis identifies late payments, days late,
penalties, payment methods and collection performance.

These measures help the bank identify repayment problems and
develop early-warning mechanisms.
*/


/*
INSIGHT 6 - CARD ENGAGEMENT

Card analysis helps the bank understand card types, networks,
credit limits, outstanding balances, reward points and active
card usage.

This information can be used to improve card engagement and
customer loyalty programs.
*/


/*
INSIGHT 7 - CROSS-SELLING

Customers who already maintain accounts but do not use cards
or loans represent potential cross-selling opportunities.

The bank can use customer income, credit score, segment and
account activity to identify suitable product offers.
*/


/*
INSIGHT 8 - HIGH-VALUE CUSTOMERS

Customers with high account balances, high transaction values
or multiple banking products may represent high-value customer
relationships.

These customers should receive appropriate retention and
relationship-management strategies.
*/


/* ================================================================
   BUSINESS RECOMMENDATIONS
   ================================================================ */

/*
RECOMMENDATION 1 - CUSTOMER-BASED MARKETING

Create personalized offers for different customer segments
based on income, credit score, demographics, account usage
and financial needs.
*/


/*
RECOMMENDATION 2 - PRODUCT CROSS-SELLING

Identify active customers who have accounts but do not have
cards or loans.

Offer suitable products based on customer profile and
eligibility.
*/


/*
RECOMMENDATION 3 - LOAN RISK MONITORING

Monitor customers with late payments, high outstanding balances,
arrears and defaulted loans.

Use early-warning indicators to identify potential repayment
problems.
*/


/*
RECOMMENDATION 4 - DIGITAL TRANSACTION PROMOTION

Analyse customer transaction channels and encourage appropriate
use of convenient digital channels.

This can improve customer convenience and digital engagement.
*/


/*
RECOMMENDATION 5 - HIGH-VALUE CUSTOMER RETENTION

Identify customers with high balances, high transaction values
or multiple products.

Provide appropriate relationship-management services and
loyalty benefits to strengthen long-term relationships.
*/


/*
RECOMMENDATION 6 - BRANCH PERFORMANCE MANAGEMENT

Compare branches based on account balances, account volumes,
loan volumes and outstanding loan balances.

High-performing branches can be studied for best practices,
while lower-performing branches can receive targeted support.
*/


/* ================================================================
   FINAL CONCLUSION
   ================================================================ */

/*
FINAL CONCLUSION:

The Retail Banking Transaction Analysis project provides a
data-driven understanding of customers, accounts, branches,
transactions, loans, loan payments and cards.

The project follows the complete Data Analyst workflow:

1. Understand the business requirement.
2. Understand the ER diagram.
3. Plan analytical solutions.
4. Build the relational MySQL database.
5. Import and validate project data.
6. Perform basic data exploration.
7. Formulate analytical questions.
8. Perform objective-based analysis.
9. Interpret the results.
10. Identify business insights.
11. Develop business recommendations.

The analysis can help the bank understand customer segments,
account usage, transaction behaviour, loan repayment patterns,
card engagement, branch performance and cross-selling
opportunities.

The project demonstrates how MySQL can be used to transform
retail banking data into meaningful business information
that can support customer management, product strategy,
risk management and business decision-making.
*/


