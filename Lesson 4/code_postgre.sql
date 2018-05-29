select * from category

SELECT region.town, region.city, region.country, COUNT(region.town) AS cuanto
FROM region
INNER JOIN job ON region.region_id=job.region_id
GROUP BY region.town, region.city, region.country; --- si quitamos alguno de estos no funciona, con squlite no pasa, postgre te pide ser más específico por si falla alguno

SELECT COUNT(job.region_id) AS cuanto from job