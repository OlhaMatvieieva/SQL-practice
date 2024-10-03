SELECT 
	t.TrackId 
	, t.Name 
	, a.Title 
	, a.ArtistId 
	, art.Name 
FROM Track t 
JOIN Album a ON t.AlbumId = a.AlbumId 
JOIN Artist art ON a.ArtistId = art.ArtistId
WHERE art.Name LIKE "A%"
LIMIT 100;

SELECT 
	art.Name 
	, COUNT(t.TrackId) 
FROM Track t 
JOIN Album a ON t.AlbumId = a.AlbumId 
JOIN Artist art ON a.ArtistId = art.ArtistId
WHERE art.Name LIKE "A%"
GROUP BY 1
ORDER BY 2 DESC 
LIMIT 100;

SELECT 
	i.InvoiceId 
	, i.CustomerId 
	, c.CustomerId 
	, c.FirstName 
FROM Invoice i 
LEFT JOIN Customer c ON i.CustomerId = c.CustomerId;

SELECT 
	i.InvoiceId 
FROM Invoice i 
LEFT JOIN Customer c ON i.CustomerId = c.CustomerId 
WHERE c.CustomerId IS NULL; 

SELECT *
FROM Invoice i 
RIGHT JOIN Customer c ON i.CustomerId;

SELECT COUNT(*)
FROM Invoice i 
RIGHT JOIN Customer c ON i.CustomerId = c.CustomerId 
WHERE c.Company IS NULL;

SELECT 
	i.InvoiceId 
	, i.CustomerId 
	, c.CustomerId 
	, c.FirstName 
FROM Invoice i 
FULL JOIN Customer c ON i.CustomerId = c.CustomerId;

-- self join

SELECT 
	g1.*
	, g2.Genre AS Main_genre_name
FROM Genre g1
INNER JOIN Genre g2 ON g1.Main_genre_id = g2.GenreId;

-- union
SELECT 
	'Customer' AS type
	,Email 
FROM Customer c

UNION

SELECT 
	'Employee' AS type
	,Email 
FROM Employee e;

--------
SELECT 
	'min_salary' AS parameter
	, MIN(salary_in_usd) AS value
FROM salaries

UNION

SELECT 
	'max_salary' AS parameter
	, MAX(salary_in_usd) AS value
FROM salaries;

/* Show customers who bought songs from three or more genres + CTE*/
--1. Join tables 
--2. Customers who already bought

WITH melomaniacs AS (
	SELECT 
		c.CustomerId 
		, c.FirstName 
		, c.LastName
		, COUNT(DISTINCT g.GenreId) AS nmb_genre
	FROM InvoiceLine il 
	LEFT JOIN Track t ON il.TrackId = t.TrackId 
	LEFT JOIN Genre g ON t.GenreId = g.GenreId
	LEFT JOIN Invoice i ON il.InvoiceId = i.InvoiceId 
	LEFT join Customer c on i.CustomerId = c.CustomerId 
	GROUP BY 1,2,3
	HAVING COUNT(DISTINCT g.GenreId) >= 3
)
, invoices AS (
	SELECT *
	FROM Invoice i 
	WHERE InvoiceDate BETWEEN '2008-01-01' AND '2009-01-01'
)

SELECT *
FROM melomaniacs m
WHERE m.CustomerId IN (SELECT CustomerId FROM invoices) 