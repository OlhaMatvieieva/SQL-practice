-- top 5 Data Science salaries in 2023

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

-- 