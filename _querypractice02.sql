-- 1.
-- ## Go to:
-- https://pgexercises.com/gettingstarted.html

-- 2.
-- Manually create the tables cd.facilities and cd.members 
-- shown at the URL above (make cd.bookings too if you like)
-- [NOTE: you can just put the tables inside
--        the default `postgres` database for now.]

-- 2.a: For each table (facilities/members/bookings)
--		Explain what can... and what can't... happen?
--      {NOTE: ignore and references to 'FOREIGN KEY' for now]

-- 2.b: Do a SELCT * on each and see NO Data yet.

-- 2.c:
	-- Download the sql file for that DB here:
	-- https://pgexercises.com/dbfiles/clubdata.sql
	
-- Once downloaded `clubdata.sql` 
-- Scroll-down (line 3135)
-- and use the INSERTs for facilities and members
-- to populate those tables with some data

-- 2.d:
-- ## Go to:
-- https://pgexercises.com/questions/basic/selectall.html

-- and figure out what query to run
--  test it on your local clubdata tables


-- 3.
-- ## Follow this tutorial:
-- https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-date/


-- 4. 
-- ## Write the statement to 
-- ## DROP THE bookings table IF it exists

-- 5.
-- ## Recreate it and populate it with 
-- ## these limited inserts

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


-- 5. 
-- ## Rename the table to 'booking' (singular)


-- 6.
-- ## Remove the column 'mamid' 


-- 7.
-- ## assume a 'slot' is 20 minutes long...
-- ## Add an 'end_time' column that shows 
-- ## the 'starttime' with the number-of 'slots'
-- ## from the 'slots' column times 20minutes


-- 8.
-- ## Add a column 'payment_status'
-- ## and fill it with the value 'paid'

-- 9.
-- ## Put a constraint on the 'payment_status'
-- ## so that it can only store values
-- ## 'paid', 'un-paid' or  'chase-up'

-- 10.
-- ## Write a statement(s) to test the 
-- ## constraint is in effect.
-- ## (How could you use the psql cmd-line tool to check this?)

-- 11.
-- ## Rename the column 'starttime' to 'start_time'

-- 12.
-- ## Change the column 'payment_status' to have be
-- ## of type VARCHAR(7);

-- 13.
-- ## Make the booking table 'facid' be a 
-- ## foreign-key to the facilities table 'facid'
-- ## (Make a note of what had to be done to achieve this)

-- 14.
-- ## Write a statement(s) to show the effect
-- ## of making booking.facid a foreign-key.

-- 15.
-- ## Make and test a constraint to the effect 
-- ## that if you delete a record or 
-- ## update the 'facid' column value of facilities
-- ## the update/delete propogates to all 
-- ## referencing values in the booking table.

-- 16.
-- ## Make and test a constraint to the effect
-- ## that if the facilities.facid value is updated
-- ## any referencing values in booking.facid
-- ## are set to null

-- 17.
-- ## Repeat 16 for a delete of a record 
-- ## in the facilities.facid

-- 18. 
-- ## Repeat 16 and 17 so that instead of
-- ## referring values being set to null
-- ## they are set to some sensible 
-- ## default value.


