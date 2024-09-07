/* Count and make average salary for every job title and level */

SELECT
	job_title
	, exp_level
	, COUNT(*) AS job_nmb
	, ROUND(AVG(salary_in_usd), 2) AS salary_avg
FROM salaries
GROUP BY job_title, exp_level
ORDER BY 1,2;

/* Indicate the salary for positions that occur only once */

SELECT
	job_title
	, ROUND(AVG(salary_in_usd),2) AS salary
FROM salaries
WHERE year = 2023
GROUP BY job_title
HAVING COUNT(*) = 1
ORDER BY 2 ASC;

