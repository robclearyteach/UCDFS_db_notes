-- 1. Retrieve all information from the customer table.
-- SELECT *
-- FROM customer;

-- 2. Retrieve the film ID, title, and release year from the film table 
-- for films released between 2005 and 2010.
SELECT film_id, title, release_year 
FROM film
WHERE release_year >= 2005 AND release_year <= 2010;  
-- WHERE release_year BETWEEN 2005 AND 2010;

-- 3. Retrieve unique last names from the actor table.
SELECT DISTINCT last_name 
FROM actor;

-- 4. Show the title, rental duration, and rental rate and then the 
-- rental cost (rental duration multiplied by rental rate) for each film.
SELECT title
	 , rental_duration
	 , rental_rate
	 , (rental_duration * rental_rate) AS rental_cost
FROM film;

-- 5. Retrieve the title, rental rate, and length of films with a rental 
-- duration greater than 5 days.
-- (NOTE: rental_duration not shown, but used to select films)
SELECT title
	 , rental_rate
	 , length
FROM film
WHERE rental_duration > 5;

-- 6. Retrieve the title, rental rate, and length of films with a length 
-- 1.5 and 2 hours (i.e. between 90 and 120 minutes).
SELECT title
	 , rental_rate
	 , length
FROM film
WHERE length >= 90 AND length <= 120;
-- WHERE length BETWEEN 90 and 120;

-- 7. Retrieve the title and rating of films rated 'R' or 'PG'.
-- (Figure out which table holds that data).
SELECT title, rating
FROM film
WHERE rating IN ('PG', 'R');

-- 8. Retrieve the title, rental duration, rental rate, and rental cost 
-- (calculated field as above) for films where their 
-- rental cost is greater than €30.00.
SELECT title
	 , rental_duration
	 , rental_rate
	 , (rental_duration * rental_rate) AS rental_cost
FROM film
WHERE (rental_duration * rental_rate) > 30;

-- 9. Retrieve the maximum rental duration from the film table.
SELECT MAX(rental_duration) AS longest_rent_for
FROM film;

-- 10. Retrieve the title, rental duration, and rental rate of films 
-- with a rental duration between 1 and 3 days.
SELECT title, rental_duration, rental_rate
FROM film
WHERE rental_duration BETWEEN 1 and 3;

-- 11. Calculate the longest, shortest, and average rental duration of films.
-- (Try to show the average as just a whole-number of days: e.g. 5 not 5.23xxx)
SELECT 
		MAX(rental_duration)
		, MIN(rental_duration)
		, ROUND( AVG(rental_duration) )
		-- , CAST( AVG(rental_duration) AS INTEGER )
FROM film;

-- 12. Retrieve titles, rental durations, and rental rates of films with 
-- rental durations not in the range of 3 to 5 days.
SELECT title, rental_duration, rental_rate
FROM film
WHERE NOT (rental_duration >= 1 AND rental_duration <= 3);
-- WHERE rental_duration NOT BETWEEN 1 and 3;

-- 13. Retrieve city IDs, names, and country IDs for cities named 
-- 'La Paz', 'Lausanne', or 'London'.
SELECT city_id, city, country_id 
FROM city
WHERE city IN ('La Paz', 'Lausanne', 'London');

-- 14. Retrieve category IDs and names for categories labelled 
-- 'Action', 'Animation', 'Children', or 'Classics'.
SELECT * 
FROM category
WHERE name IN ('Action', 'Animation', 'Children', 'Classics');
-- WHERE name='Action' OR name='Animation' OR name='Children' OR name='Classics' ;

-- 15. Retrieve category IDs and names for categories not labelled 
-- 'Action', 'Animation', 'Children', or 'Classics'.
SELECT * 
FROM category
WHERE name NOT IN ('Action', 'Animation', 'Children', 'Classics');


-- 16. Retrieve address IDs and addresses containing 'Santiago' in 
-- any part of the address.
SELECT * 
FROM address
WHERE address LIKE '%Santiago%';

-- 17. Retrieve addresses and districts that have exactly four characters
-- in the district name.
-- SELECT address, district 
-- FROM address
-- -- WHERE LENGTH(district) = 4;
-- WHERE district LIKE '____';

SELECT address, district 
FROM address
WHERE LENGTH(district)=4;
-- WHERE district IN (SELECT DISTINCT district FROM address WHERE LENGTH(district)=4);



-- 18. Retrieve films with titles that begin with a seven-letter word
-- starting 'D-r-i' followed by a space and anything else.
-- SELECT title
-- FROM film
-- WHERE title LIKE 'Dri____ %';


-- 19. Retrieve films with titles starting with 
-- the word 'wonderful', or ending with the word 'wonderful'.
-- (Try to allow for any word with six letters and then 'ful'
--  e.g. 'beautiful', 'masterful', 'Colourful'.)
SELECT title 
FROM film
WHERE title LIKE '______ful%' OR title LIKE '%______ful' ;

-- 20. Retrieve all records from the actor table.
SELECT * FROM actor;

-- 21. Retrieve addresses, address lines 2, and districts where either 
-- address line 1 or address line 2 is NULL.
SELECT address, address2 
FROM address
WHERE address2 IS NULL; 

-- 22. Retrieve last names and first names of actors, 
-- ordered by last name alphabetically first and then for each
-- group of records shown with the same last_name - order the first names 
-- in descending order.
SELECT last_name, first_name
FROM actor
ORDER BY last_name ASC, first_name DESC;

-- 23. Retrieve last names and first names of actors, ordered by 
-- last name in descending order and first name in ascending order.
SELECT last_name, first_name
FROM actor
ORDER BY last_name DESC, first_name ASC;

-- 24. Count the occurrences of last names and the number of distinct 
-- last names in the actor table.
SELECT   COUNT(last_name) AS number_names_total 
		,COUNT(DISTINCT last_name) AS number_distinct_names
FROM actor;


-- 25. Count the occurrences of first names and the number of distinct 
-- first names in the actor table.
SELECT  COUNT(*) AS number_first_names
		,COUNT(DISTINCT first_name) AS number_distinct_first_names
FROM actor;



-- 26. Produce a list of Country ID's with a Count of the number of cities 
-- with that Country ID where the list is 
-- ordered by the Country ID.
SELECT  city, COUNT(country_id) 
FROM city
GROUP BY city
ORDER BY COUNT(country_id) DESC;

-- 27. Refine the above query to show a list, sorted by 
-- Country ID that shows a count of the citys with that Country ID
-- but where the Country has at least 30 cities.
SELECT  city, COUNT(country_id) 
FROM city
GROUP BY city
HAVING COUNT(country_id) <=30
ORDER BY COUNT(country_id) DESC;





