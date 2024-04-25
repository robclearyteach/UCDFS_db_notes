

SELECT NOW();

SELECT now(), pg_typeof(now()) AS data_type;

SELECT NOW()::DATE;				-- postgres specific
SELECT CAST( NOW() AS DATE);	-- more generic SQL

-- ## Other systems-> SELECT DATE( 'now' ); --sqlite DATE( now() ); --mysql

SELECT CURRENT_DATE;

SELECT TO_CHAR( now(), 'yyyy-mm-dd' );
SELECT TO_CHAR( NOW(), 'Mon dd, yyy' );

CREATE TABLE document (
  document_id SERIAL PRIMARY KEY, 
  header_text VARCHAR (255) NOT NULL, 
  posting_date DATE NOT NULL DEFAULT CURRENT_DATE
);

SELECT * FROM document;

INSERT INTO document(header_text) VALUES ('title a'), ('title b');
INSERT INTO document(header_text) VALUES ('title c'), ('title d') RETURNING *;  
-- showing postgres 'RETURNING *'


SELECT * FROM document;


CREATE TABLE employee(
	  employee_id SERIAL PRIMARY KEY
	, first_name VARCHAR(20) NOT NULL
	, last_name VARCHAR(20) NOT NULL
	, birth_date DATE NOT NULL
	, hire_date DATE NOT NULL 
);


INSERT INTO employee(first_name, last_name, birth_date, hire_date)
VALUES
 ('jon', 'doe', '2004-05-25', '2022-05-24')
,('jin', 'dee', '2004-05-22', '2022-05-24')
RETURNING *;

SELECT * FROM employee;

SELECT 	  first_name
		, last_name
		, AGE(birth_date) as age
		, hire_date
		
FROM	employee;



SELECT    *
		, now() - hire_date AS days_hired
FROM employee;


SELECT 	  first_name
		, last_name
		, AGE(birth_date, hire_date) as age_when_hired  --SHOWS NEGATIVE
		, hire_date
FROM	employee;
SELECT 	  first_name
		, last_name
		, AGE(hire_date, birth_date) as age_when_hired  --CORRECTED
		, hire_date		
FROM	employee;


-- ## pg EXTRACT(): YEAR/MONTH/DAY/HOUR terms: 
-- ## e.g.
SELECT 	NOW(), EXTRACT( YEAR FROM now() );
SELECT 	NOW(), EXTRACT( HOUR FROM now() );

-- ## IN-USE...
SELECT 	  first_name
		, last_name
		, birth_date
		, EXTRACT( YEAR FROM birth_date) AS year_born
		, EXTRACT( MONTH FROM birth_date) AS month_born
		, EXTRACT( DAY   FROM birth_date) AS day_born
FROM	employee;

-- ## seconds in an hour/day
SELECT (60*60) as seconds_hr, (60*60)*24 as seconds_day;



SELECT 	  first_name
		, last_name
		, birth_date
		, DATE_PART( 'YEAR',  birth_date) AS year_born
		, DATE_PART( 'MONTH', birth_date) AS month_born
		, DATE_PART( 'DAY',   birth_date) AS day_born
FROM	employee;





 -- ## ====================================
 -- ## ALTER TABLE
 -- ## ====================================

CREATE TABLE bookings (
    bookid integer NOT NULL,
    facid integer NOT NULL,
    memid integer NOT NULL,
    starttime timestamp without time zone NOT NULL,
    slots integer NOT NULL
);
INSERT INTO bookings (bookid, facid, memid, starttime, slots) VALUES
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

-- ## just grab a few records to play 
-- ## (or fine if you have the whole thing)



ALTER TABLE bookings
RENAME TO booking;

SELECT * FROM bookings; -- Error now

SELECT * FROM booking;

ALTER TABLE booking
DROP COLUMN memid;

SELECT * from booking;

ALTER TABLE booking
ADD COLUMN booking_date DATE NOT NULL DEFAULT CURRENT_DATE;

SELECT * from booking;

-- Drop again
ALTER TABLE booking
DROP COLUMN booking_date;

SELECT * from booking;


ALTER TABLE booking
ADD COLUMN end_time TIMESTAMP;

SELECT * from booking;


SELECT CURRENT_TIME;

SELECT CURRENT_TIME + 30; --ERROR can't add INT to Timestamp

SELECT CURRENT_TIME + INTERVAL '60 seconds';
SELECT CURRENT_TIME + INTERVAL '1 minutes'; -- or 'minute'
SELECT CURRENT_TIME + INTERVAL '10 minutes';

SELECT INTERVAL '10 minutes';
SELECT 2 * INTERVAL '10 minutes';

UPDATE booking
SET end_time = starttime + (slots * INTERVAL '30 minutes');

ALTER TABLE booking
ADD COLUMN payment_status VARCHAR(20) NOT NULL DEFAULT 'paid';


UPDATE Booking
SET payment_status = 'pending'
WHERE bookid = 1;

SELECT * FROM booking; -- fine, but...

UPDATE Booking
SET payment_status = 'xxx'
WHERE bookid = 1;


-- DROP existing
ALTER TABLE booking
DROP COLUMN payment_status;


-- ADD without check constraint
ALTER TABLE booking
ADD COLUMN payment_status VARCHAR(20) NOT NULL DEFAULT 'paid';

SELECT * FROM booking;

-- show no constraint...
UPDATE booking
SET payment_status = 'xxx'
WHERE bookid = 1;

SELECT * FROM booking;

-- try add constraint
ALTER TABLE booking
ADD CONSTRAINT valid_payment_status CHECK( payment_status IN ('paid', 'pending', 'chase-up') );
	-- see error

-- correct
UPDATE booking
SET payment_status = 'paid'
WHERE bookid = 1;

ALTER TABLE booking
ADD CONSTRAINT valid_payment_status CHECK( payment_status IN ('paid', 'pending', 'chase-up') );

SELECT * FROM booking;

-- psql-> postgres=#> \d booking 
-- pgAdmin-->booking-->properties-->constraints-->check

UPDATE booking
SET payment_status = 'xxx'  -- won't allow
WHERE bookid = 1;


-- ## RENAME COLUMN old_name TO new_name
SELECT * FROM booking;
ALTER TABLE booking
RENAME COLUMN starttime TO start_time;
SELECT * FROM booking;


-- ## ALTER COLUMN col TYPE new_type
ALTER TABLE booking
ALTER COLUMN payment_status TYPE VARCHAR(8);

SELECT * FROM booking;


-- ## ======================================
-- ## REFERENCES (Referential constraint)
-- ## ======================================

SELECT * FROM booking;
SELECT * FROM facilities;

DROP TABLE booking;

-- old table def (no 'REFERENCES')
-- CREATE TABLE bookings (
--     bookid integer NOT NULL,
--     facid integer NOT NULL
--     memid integer NOT NULL,
--     starttime timestamp without time zone NOT NULL,
--     slots integer NOT NULL
-- );

-- new with 'REFERENCES' as Column constraint
-- try...
CREATE TABLE bookings (
    bookid integer NOT NULL,
    facid integer NOT NULL REFERENCES facilities(facid),
    memid integer NOT NULL,
    starttime timestamp without time zone NOT NULL,
    slots integer NOT NULL
);

-- see error
-- there is no unique constraint matching given keys for referenced table "facilities" 

ALTER TABLE facilities
ADD CONSTRAINT key_facid UNIQUE(facid);

INSERT INTO bookings (bookid, facid, memid, starttime, slots) VALUES
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


-- observe columns of both tables
SELECT facid FROM facilities;

SELECT facid FROM bookings;

-- valid insert
-- see bookings first
SELECT * FROM bookings;

-- do an insert
INSERT INTO bookings
VALUES
		(10, 3, 1, '2024-04-25 21:00', 2);
		
SELECT * FROM bookings;


INSERT INTO bookings
VALUES
		(10, 99, 1, '2024-04-25 21:00', 2);

-- psql-> postgres=#> \d booking 
-- see bookings_facid_key

ALTER TABLE bookings
DROP CONSTRAINT bookings_facid_fkey;


-- See insert works now
INSERT INTO bookings
VALUES
		(10, 99, 1, '2024-04-25 21:00', 2);

SELECT * FROM bookings;



ALTER TABLE bookings
ADD CONSTRAINT fkey_facid FOREIGN KEY(facid) REFERENCES facilities(facid);

-- psql-> postgres=#> \d booking 
-- see fkey_facid

SELECT * FROM bookings;
SELECT * FROM facilities WHERE facid = 3;

DELETE FROM facilities WHERE facid = 3;				-- disallowed default RESTRICT
UPDATE facilities SET facid = 10 WHERE facid = 3;   -- disallowed default RESTRICT


-- ## SEE ON DELETE CASCADE behaviour
ALTER TABLE bookings
DROP CONSTRAINT fkey_facid;

ALTER TABLE bookings
ADD CONSTRAINT fkey_facid 
		FOREIGN KEY(facid) REFERENCES facilities(facid)
		ON DELETE CASCADE;

-- psql-> postgres=#> \d booking 
-- see fkey_facid

SELECT * FROM bookings;
SELECT * FROM facilities;

DELETE FROM facilities WHERE facid=3;

SELECT * FROM facilities;
SELECT * FROM bookings;