-- Top 5 Data Science salaries in 2023

SELECT 
	year
	, job_title
	, salary_in_usd
FROM salaries
WHERE 
	year = 2023
	AND job_title = 'Data Scientist'
ORDER BY salary_in_usd DESC
LIMIT 5;

-- Average, min, max salary in 2023

SELECT
	ROUND(AVG(salary_in_usd), 2) AS salary_avg
	, MIN(salary_in_usd) AS salary_min
	, MAX (salary_in_usd) AS salary_max
FROM salaries
WHERE year = '2023'
LIMIT 10;

-- ML Engineers salary in 2023

SELECT 
	year
	, job_title
	, salary_in_usd AS salary
FROM salaries
WHERE
	year = 2023
	AND job_title = 'ML Engineer'
ORDER BY salary_in_usd
LIMIT 10;

-- Name a country where is the Data Scientist lowest salary in 2023

SELECT 
	comp_location AS country
	, year
	, job_title
	, salary_in_usd
FROM salaries
WHERE
	year = 2023
	AND job_title = 'Data Scientist'
ORDER BY salary_in_usd
LIMIT 1;

-- Top 5 remote specialists salaries 

SELECT
	job_title
	, salary_in_usd as salary
	, remote_ratio
FROM salaries
WHERE remote_ratio = 100
ORDER BY salary_in_usd DESC
LIMIT 5;

-- The number of unique values for a column

SELECT count(distinct comp_location)
FROM salaries;

-- The 5 highest salaries in 2023 for ML Engineer. Transfer the salary to UAH

SELECT 
	year
	, job_title
	, salary_in_usd
	, (salary_in_usd * 40) AS salary_in_uah
FROM salaries
WHERE
	year = 2023
	AND job_title = 'ML Engineer'
ORDER BY salary_in_usd DESC
LIMIT 5;