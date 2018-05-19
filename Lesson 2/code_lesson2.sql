--- El más caro ---

SELECT Invoice.InvoiceId, Invoice.CustomerId, Customer.FirstName, Customer.LastName, MAX(Invoice.Total)
FROM Invoice
INNER JOIN Customer ON Invoice.CustomerId=Customer.CustomerId;

--- El más barato ---

SELECT Invoice.InvoiceId, Invoice.CustomerId, Customer.FirstName, Customer.LastName, MIN(Invoice.Total)
FROM Invoice
INNER JOIN Customer ON Invoice.CustomerId=Customer.CustomerId
GROUP BY Customer.CustomerId;

--- Which city (BillingCity) has the most orders? ---

SELECT Invoice.BillingCity, COUNT(Invoice.BillingCity) AS Cantidad
FROM Invoice
GROUP BY Invoice.BillingCity
ORDER BY Cantidad DESC;

--- Calculate (or count) how many tracks have this MediaType: Protected AAC audio file ---

SELECT COUNT(Track.MediaTypeId)
FROM Track
WHERE Track.MediaTypeId='2';

--- Find out what Artist has the most albums? ---

SELECT Artist.Name, COUNT(Album.ArtistId) AS Cuanto
FROM Album
INNER JOIN Artist ON Album.ArtistId=Artist.ArtistId
GROUP BY Artist.Name
ORDER BY Cuanto DESC;

--- What genre has the most tracks? ---

SELECT Genre.Name, COUNT(Track.GenreId) AS Mosttr
FROM Track
INNER JOIN Genre ON Track.GenreId=Genre.GenreId
GROUP BY Genre.Name
ORDER BY Mosttr DESC;

--- Which customer spent the most money so far? ---

SELECT Invoice.CustomerId, Customer.FirstName, Customer.LastName, SUM(Invoice.Total) AS Total
FROM Invoice
INNER JOIN Customer ON Invoice.CustomerId=Customer.CustomerId
GROUP BY Customer.CustomerId --- ¿Por qué si lo agrupamos por first name sale una solución errónea?
ORDER BY Total DESC;

--- What songs were bought with each order? ---

SELECT Invoice.InvoiceId, Track.Name, Track.TrackId
FROM Invoice
INNER JOIN InvoiceLine ON Invoice.InvoiceId=InvoiceLine.InvoiceId
INNER JOIN Track ON InvoiceLine.TrackId=Track.TrackId
ORDER BY Invoice.InvoiceId ASC;