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

/* Show all specialists who live in countries where 
the average salary is higher than the average among all countries*/

-- 1. Search avg salary
-- 2. Average salary by each country
-- 3. Compare, list of countries
-- 4. Specialists who lives in this countries

------ 1
SELECT AVG(salary_in_usd)
FROM salaries;

------ 2, 3

SELECT 
	comp_location
FROM salaries
WHERE year = 2023
GROUP BY 1
HAVING AVG(salary_in_usd) > 
(
	SELECT AVG(salary_in_usd)
	FROM salaries
	WHERE year = 2023
);

------ 4

SELECT *
FROM salaries
WHERE emp_location IN (
	SELECT 
	comp_location
FROM salaries
WHERE year = 2023
GROUP BY 1
HAVING AVG(salary_in_usd) > 
(
	SELECT AVG(salary_in_usd)
	FROM salaries
	WHERE year = 2023
)
);

/* Find the minimum wage among the maximum wages by country*/

-- 1. Max wage by country in 2023
-- 2. Find Min wage

------ 1

SELECT
	comp_location
	, MAX(salary_in_usd)
FROM salaries
GROUP BY 1;

------ 2

SELECT MIN(t.salary_in_usd)
FROM 
(
	SELECT
		comp_location
		, MAX(salary_in_usd) AS salary_in_usd
	FROM salaries
	GROUP BY 1
) AS t;

------------------ alternative

SELECT
		comp_location
		, MAX(salary_in_usd) AS salary_in_usd
FROM salaries
GROUP BY 1
ORDER BY 2 ASC
LIMIT 1;

/* Show the difference between the average salary
and the maximum salary of all specialists*/

-- 1. Max wage 
-- 2. Average wage
-- 3. Result

SELECT MAX(salary_in_usd)
FROM salaries;

SELECT
	job_title
	, AVG(salary_in_usd) -
(
	SELECT MAX(salary_in_usd)
	FROM salaries
) AS diff
FROM salaries
GROUP BY 1;

/* Display data on the employee who has the 
second largest salary in the table*/

SELECT *
FROM 
(
	SELECT *
	FROM salaries
	ORDER BY salary_in_usd DESC
	LIMIT 2
) AS t
ORDER BY salary_in_usd ASC
LIMIT 1;

----------- alternative

SELECT *
FROM salaries
ORDER BY salary_in_usd DESC
LIMIT 1 OFFSET 1;