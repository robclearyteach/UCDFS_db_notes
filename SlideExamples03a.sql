
-- ## WRITE a create table for 
-- ## `booking_recreate`
-- ## a) **With no constraints**
-- ##    Just want to allow the below
-- ##    INSERT to run.


INSERT INTO booking_recreate  
VALUES
(0, 3, 1, '2012-07-03 11:00:00', 2),
(1, 4, 1, '2012-07-03 08:00:00', 2),
(2, 6, 0, '2012-07-03 18:00:00', 2),
(3, 7, 1, '2012-07-03 19:00:00', 2),
(4, 8, 1, '2012-07-03 10:00:00', 1),
(5, 8, 1, '2012-07-03 15:00:00', 1),
(6, 0, 2, '2012-07-04 09:00:00', 3),
(7, 0, 2, '2012-07-04 15:00:00', 3),
(8, 4, 3, '2012-07-04 13:30:00', 2),
(9, 4, 0, '2012-07-04 15:00:00', 2); 

-- ##    (Test with a SELECT).

-- ## DROP the table facilities if it exists
-- ## and re-create it with this:
DROP TABLE IF EXISTS facilities;

CREATE TABLE facilities (
    facid integer NOT NULL,
    name character varying(100) NOT NULL,
    membercost numeric NOT NULL,
    guestcost numeric NOT NULL,
    initialoutlay numeric NOT NULL,
    monthlymaintenance numeric NOT NULL
);

INSERT INTO facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) 
VALUES
(0, 'Tennis Court 1', 5, 25, 10000, 200),
(1, 'Tennis Court 2', 5, 25, 8000, 200),
(2, 'Badminton Court', 0, 15.5, 4000, 50),
(3, 'Table Tennis', 0, 5, 320, 10),
(4, 'Massage Room 1', 35, 80, 4000, 3000),
(5, 'Massage Room 2', 35, 80, 4000, 3000),
(6, 'Squash Court', 3.5, 17.5, 5000, 80),
(7, 'Snooker Table', 0, 5, 450, 15),
(8, 'Pool Table', 0, 5, 400, 15);

-- ## RENAME THE TABLE `facility`


SELECT   facility.facid
		,facility.name
		,booking_recreate.bookingid
		,booking_recreate.facid
		,booking_recreate.starttime
FROM
		facility, booking_recreate;
		

-- ## ...
WHERE   facility.facid = booking_recreate.facid;




SELECT   booking_recreate.bookingid
		,facility.name
		,booking_recreate.starttime
FROM
		facility, booking_recreate
WHERE   facility.facid = booking_recreate.facid;




SELECT   bookingid
		,name
		,starttime
		,starttime + (booking_recreate.slots * INTERVAL '30 minutes') AS end_time
FROM
		facility, booking_recreate
WHERE   facility.facid = booking_recreate.facid;

-- ## 
-- ## Try add facid from booking and facid from facility now



-- ## Try this (see error)
SELECT   facility.facid AS fac.facid
		,facility.name	AS fac.name
		,booking_recreate.bookingid AS booking.bookid
		,booking_recreate.facid		AS booking.facid
		,booking_recreate.starttime AS booking.starttime
FROM
		facility, booking_recreate
WHERE   facility.facid = booking_recreate.facid;



SELECT   facility.facid AS "fac.facid"
		,facility.name	AS "fac.name"
		,booking_recreate.bookingid AS "booking.bookid"
		,booking_recreate.facid		AS "booking.facid"
		,booking_recreate.starttime AS "booking.starttime"
FROM
		facility, booking_recreate
WHERE   facility.facid = booking_recreate.facid;



SELECT * FROM facility;

INSERT INTO booking_recreate  
VALUES
(0, 99, 1, '2024-03-30 07:10:00', 2);  

SELECT * FROM booking_recreate;


INSERT INTO booking_recreate  
VALUES
(0, 99, 1, '2024-03-30 07:10:00', 2);


-- ## See: no (facid=99) in the join: no match in facility.facid
SELECT  
		 booking_recreate.bookingid AS "booking.bookid"
		,booking_recreate.facid		AS "booking.facid"
		,booking_recreate.starttime AS "booking.starttime"
		,facility.facid AS "fac.facid"
		,facility.name	AS "fac.name"

FROM
		facility, booking_recreate
WHERE   facility.facid = booking_recreate.facid;



-- try...
CREATE TABLE booking_recreate (
    bookid integer NOT NULL,
    facid integer NOT NULL REFERENCES facilities(facid),
    memid integer NOT NULL,
    starttime timestamp without time zone NOT NULL,
    slots integer NOT NULL
);

-- ## OBSERVE ERROR: fix (need UNIQUE facility.facid )
-- ERROR:  there is no unique constraint matching given keys for referenced table "facility" 


-- ## INSERT: data as previous below...
INSERT INTO booking_recreate  
VALUES
(0, 3, 1, '2012-07-03 11:00:00', 2),
(1, 4, 1, '2012-07-03 08:00:00', 2),
(2, 6, 0, '2012-07-03 18:00:00', 2),
(3, 7, 1, '2012-07-03 19:00:00', 2),
(4, 8, 1, '2012-07-03 10:00:00', 1),
(5, 8, 1, '2012-07-03 15:00:00', 1),
(6, 0, 2, '2012-07-04 09:00:00', 3),
(7, 0, 2, '2012-07-04 15:00:00', 3),
(8, 4, 3, '2012-07-04 13:30:00', 2),
(9, 4, 0, '2012-07-04 15:00:00', 2); 


INSERT INTO booking_recreate VALUES (10, 99, 1, '2024_04_30 19:35:00', 2);


INSERT INTO booking_recreate
VALUES
		(10, 3, 1, '2024_04_30 19:35:00', 2);

SELECT * FROM booking_recreate;


-- psql-> postgres=#> \d booking 
-- see booking_recreate_facid_fkey

ALTER TABLE booking_recreate
DROP CONSTRAINT booking_recreate_facid_fkey;


INSERT INTO booking_recreate VALUES (10, 99, 1, '2024_04_30 19:35:00', 2);

DELETE FROM booking_recreate WHERE facid=99;

ALTER TABLE booking_recreate
ADD CONSTRAINT fkey_facid FOREIGN KEY(facid) REFERENCES facility(facid);

INSERT INTO booking_recreate VALUES (10, 99, 1, '2024_04_30 19:35:00', 2);


SELECT  
		 booking_recreate.bookingid AS "booking.bookid"
		,booking_recreate.facid		AS "booking.facid"
		,booking_recreate.starttime AS "booking.starttime"
		,facility.facid AS "fac.facid"
		,facility.name	AS "fac.name"
FROM
		facility, booking_recreate
WHERE   facility.facid = booking_recreate.facid;


SELECT * FROM facility;
DELETE FROM facility WHERE facid = 3;				-- disallowed default RESTRICT
SELECT * FROM facility;
UPDATE facility SET facid = 10 WHERE facid = 3;   	-- disallowed default RESTRICT


-- SET UP ON UPDATE CASCADE  constraint
ALTER TABLE booking_recreate
DROP CONSTRAINT fkey_facid;

ALTER TABLE booking_recreate
ADD CONSTRAINT fkey_facid 
		FOREIGN KEY(facid) REFERENCES facility(facid)
		ON UPDATE CASCADE;

SELECT * FROM booking_recreate;
-- Observe booking facid = 3 present

SELECT * FROM facility;
-- Observe facility facid = 3 present

UPDATE facility
SET facid=33
WHERE facid = 3;

SELECT * FROM facility;
-- observe facility facid = 33
SELECT * FROM booking_recreate;
-- observe facility facid = 33

ALTER TABLE booking_recreate
DROP CONSTRAINT fkey_facid;

ALTER TABLE booking_recreate
ADD CONSTRAINT fkey_facid 
		FOREIGN KEY(facid) REFERENCES facility(facid)
		ON DELETE CASCADE								--added ON DELETE CASCADE
		ON UPDATE CASCADE;
		
		
SELECT * FROM facility;
DELETE FROM facility WHERE facid=33;

SELECT * FROM booking_recreate;


-- ## === late three way join example
SELECT
*
-- facility.facid,
-- booking_recreate.starttime,
-- members.firstname

FROM
		facility INNER JOIN booking_recreate
		ON	    facility.facid = booking_recreate.facid
		
		INNER JOIN
		members
		ON members.memid = booking_recreate.memid

ORDER BY facility.facid;
-- 		INNER JOIN members
-- 		ON  members.memid = booking_recreate.memid
;