
-- ## Taking Postgres sample database `dvdrental`
-- ## ER Diagram (.pdf) in .zip folder
-- ## Looking at: 

-- ## Relationship
-- ## Customer->0---||-Address


-- ## Cardinality
-- ##	MANY - look at the many
-- ## Customer (Many) 

SELECT customer_id, first_name, last_name, address.address_id, address
FROM 	customer INNER JOIN address
		ON
		customer.address_id = address.address_id
		
		
-- ## boils down to...
SELECT customer_id, address.address_id
FROM 	customer INNER JOIN address
		ON
		customer.address_id = address.address_id
		
CREATE TABLE test_many
AS
SELECT customer_id, address.address_id
FROM 	customer INNER JOIN address
		ON
		customer.address_id = address.address_id
LIMIT 5;

SELECT * FROM test_many;

UPDATE test_many
SET address_id = 5
WHERE customer_id = 2;

SELECT * 
FROM test_many
ORDER BY customer_id;
-- ## see many on Customer side



-- ## Look at
-- ## "Can Have" (/Happen)
-- ## AND
-- ## Data at a POINT IN TIME
-- ##
--
SELECT customer_id, address_id
FROM test_many

-- ## Try:
-- ## (below fails)
SELECT customer_id, address_id
FROM test_many
GROUP BY address_id			

-- ## Apply to 
-- ## `dvdrental`
SELECT address.address_id, COUNT(customer_id)
FROM 	customer INNER JOIN address
		ON
		customer.address_id = address.address_id
GROUP BY address.address_id
HAVING COUNT(customer_id) > 1;

-- ## shows nothing (no records)
-- ## what does that tell us
-- ## (occular proof)
SELECT address.address_id, COUNT(customer_id)
FROM 	customer INNER JOIN address
		ON
		customer.address_id = address.address_id
GROUP BY address.address_id

-- ## TASK: Is the diagram WRONG?
-- ## 	NO (Data a point-in-time)
-- ## TASK: How to prove? (update customer address_id)
-- ##   like this for example
SELECT customer_id, address.address_id
FROM 	customer INNER JOIN address
		ON
		customer.address_id = address.address_id
LIMIT 5;

UPDATE Customer
SET address_id = 5
WHERE customer_id = 2;

SELECT customer_id, address.address_id
FROM 	customer INNER JOIN address
		ON
		customer.address_id = address.address_id
LIMIT 5;


-- ## LESSON:
-- ##  Data doesn't tell (only a point in time)
-- ##  Schema/constraints tell us
-- ##  Diagram COULD be wrong (also if not connected)	

-- ## MANY
-- ## Typically 'FOREIGN KEY'
-- ## a)
-- ##	See 
-- ## 	psql -U postgres dvdrental
-- ##	\d customer
-- ## 	(See column address_id FOREIGN KEY... analyze-meaning...)













-- ## NEW SECTION:
-- ## Participation
-- ## Address optional
SELECT *
FROM
	address LEFT JOIN customer
	ON
	customer.address_id = address.address_id
WHERE customer.customer_id IS NULL;



-- ## refined...
SELECT   address.address_id
	   , address.address 
	   , address.city_id 
	   , customer.customer_id
	   , customer.first_name
	   , customer.last_name
FROM
	address LEFT JOIN customer
	ON
	customer.address_id = address.address_id
WHERE customer.customer_id IS NULL;



-- ## MANY TO MANY
-- ## 

-- ## MOVE to PGExercises 
-- ##    facility--booking--Member

-- ## Start:
SELECT	  facilities.facid
		, facilities.name
		, booking.bookid
		, booking.facid
		, booking.memid
		, booking.starttime

FROM facilities INNER JOIN booking
	 ON 
	 facilities.facid = booking.facid;
	 


-- ## MOVE TO
SELECT	  facilities.facid
		, facilities.name
		, booking.bookid
		, booking.facid
		, booking.memid
		, booking.starttime
		, members.memid
		, members.firstname

FROM facilities INNER JOIN booking
	 ON 
	 facilities.facid = booking.facid
	 		INNER JOIN members
			ON
			booking.memid = members.memid;
			
			

-- ## What's the story?
-- ## Find the MANY-to-Many

INSERT INTO booking
VALUES
	(8, 0, 1, '2024-05-14 19:00', 2)
,	(9, 0, 3, '2024-05-14 19:00', 2);




-- ## Take out the booking table columns and 
-- ## see the MANY-TO-MANY
SELECT	  facilities.facid
		, facilities.name
-- 		, booking.bookid
-- 		, booking.facid
-- 		, booking.memid
-- 		, booking.starttime
		, members.memid
		, members.firstname

FROM facilities INNER JOIN booking
	 ON 
	 facilities.facid = booking.facid
	 		INNER JOIN members
			ON
			booking.memid = members.memid;