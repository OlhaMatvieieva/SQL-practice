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