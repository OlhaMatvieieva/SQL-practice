-- aggregation functions

WITH cte AS (
	SELECT 
		job_title
		, salary_in_usd 
		, AVG(salary_in_usd) OVER(PARTITION BY job_title) AS avg_salary
		, MIN(salary_in_usd) OVER(PARTITION BY job_title) AS min_salary
		, MAX(salary_in_usd) OVER(PARTITION BY job_title) AS max_salary
		, COUNT(salary_in_usd) OVER(PARTITION BY job_title) AS job_cnt
	FROM salaries s 
	WHERE year = 2023
)

SELECT *
	, salary_in_usd::FLOAT / max_salary AS ratio_max --CAST()
	, salary_in_usd / avg_salary AS ratio_avg
FROM cte;

WITH cte AS (
	SELECT 
		job_title
		, salary_in_usd 
		, SUM(salary_in_usd) OVER(PARTITION BY job_title order by salary_in_usd) AS sum_salary
	FROM salaries s 
	WHERE year = 2023
)

WITH cte AS (
	SELECT 
		job_title
		, salary_in_usd 
		, AVG(salary_in_usd) OVER(PARTITION BY job_title) AS avg_salary
	FROM salaries s 
	WHERE year = 2023
)

SELECT *
FROM cte
WHERE salary_in_usd > avg_salary;

-------
SELECT *
FROM cte;

SELECT 
	InvoiceDate
	, Total
	, SUM(Total) OVER(ORDER BY InvoiceDate) AS cumm_sum
FROM Invoice i;

------range functions
WITH cte AS (
SELECT 
	InvoiceId 
	, CustomerId 
	, Total 
	, ROW_NUMBER()  OVER(PARTITION BY CustomerId ORDER BY Total DESC) AS invoice_nmb
	, RANK() 		OVER(PARTITION BY CustomerId  ORDER BY Total DESC) AS invoice_rank
	, DENSE_RANK()  OVER(PARTITION BY CustomerId  ORDER BY Total DESC) AS invoice_rank1
FROM Invoice i 
ORDER BY CustomerId 
)

SELECT *
FROM cte
WHERE invoice_nmb = 2;

-----transact functions
SELECT 
	InvoiceId 
	, CustomerId 
	, InvoiceDate 
	, Total 
	, LAG(Total, 1) OVER(PARTITION BY CustomerId ORDER BY InvoiceDate) AS lag_total
	, LAG(InvoiceDate, 1) OVER(PARTITION BY CustomerId ORDER BY InvoiceDate) AS lag_total
	, JULIANDAY(InvoiceDate) - JULIANDAY(LAG(InvoiceDate, 1) OVER(PARTITION BY CustomerId ORDER BY InvoiceDate)) AS diff_in_days
	, LEAD(Total, 1) OVER(PARTITION BY CustomerId ORDER BY InvoiceDate) AS lead_total
FROM Invoice i
ORDER BY CustomerId;

----
SELECT 
	InvoiceId 
	, CustomerId 
	, InvoiceDate 
	, Total 
	, FIRST_VALUE(Total) OVER(PARTITION BY CustomerId ORDER BY InvoiceDate ASC) AS first_amount
FROM Invoice i;

