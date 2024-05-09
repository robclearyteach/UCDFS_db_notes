-- 1. If not present: create a folder
--    			/py_to_postgres
--   in your working folder
--   Then create a virtual environment within
--    e.g.
--    		py -m venv .venv
--    Activate it:
--    e.g.
--    		source ./.venv/Scripts/Activate
--          [Reminder:]
--			deactivate
--           [to deactivate it]
--	Once active:
--  pip install psycopg2
--


-- 2.
--	2.a Create a test user with a test password
--		and drop the user directly after

--  2.b Re-create the test user nd grant SELECT 
--		access (only) to the dvdrental 
--       postgres sample db.
--
--  2.c Test that SELECT access works
--		 AND that say, UPDATE access doesn't
--
--	2.d Grant UPDATE access on the Staff 
--		table of the dvdrental database
--
--  2.e	Execute a test UPDATE on the Staff
--		table to prove it works,
--		THEN execute a reversing
-- 		UPDATE to reverse (rollback)
-- 		the change made by the first UPDATE.
--



-- 3.  Within the virtual environment 
--		(created in the earlier step)
-- 		pip install psycopg2
--
-- 3.a
--		Using the file provided:
--		 `test_psycopg2.ipynb` 
--		 as a guide...
--
--		use psycopg2 to 
--      connect to the dvdrental
--		db with the tesst user
--      and password.
-- 		Carry out a SELECT * FROM Staff
--
-- 3.b  Write an example SQL String
--			that could suffer from 
-- 			an SQL injection attack
--
-- 3.c  Write an example SQL String
--			using SQL string parameters
--
-- 3.d	Carry out an SQL
--			UPDATE statement from python
--			using psycopg2
--
-- 3.e  CHECK that you can write
--			an SQL UPDATE
--			using parameters in the 
--			SQL string.
--
-- 3.f
--		CHECK that you can use the 
--		Python 'with' syntax 
-- 		to manage psycopg2 connection 
--		and cursor
--		and that you have used
--		cursor.fetchall() and fetchone()
--		functions.

-- 4.
--		DROP the test user
--		(Carry out any necessary commands needed.).



-- 5. FURTHER SQL
--		Using the Posgres example
--		DvdRental database
--
--  	Find a suitable 
--      scenario and write 
--      SQL queries for each of the 
--      following:

-- ## Use a scalar sub-query 
-- ## for = (equals) comparison

-- ## Use a scalar sub-query 
-- ## for arithmetic (minus) operation

-- ## Use nested sub-queries
-- ## double nested sub-query:

-- ## ANY and ALL 
-- ## Use the ANY operator
	-- ##  for a  > (greater than)
	-- ##  comparison with a sub-query

	-- ## Show ANY and SOME are synonymous

	-- ## Show another way ~equiv'
	-- ## without ANY/SOME	
	-- ##  using different sub-query

	-- ## Show another way ~equiv'
	-- ## using AND OR

-- ## ALL 
-- ## Use the ALL operator
	-- ##  for a > comparison with a sub-query

	-- ## Show another way ~equiv'
	-- ## without ALL	
	-- ##  using different sub-query

	-- ## Show another way ~equiv'
	-- ## using AND OR

-- ## JOINS
-- ## Different ways to write:
-- ## Show each of these
-- ## for a two-way join
	-- ## INNER JOIN
	-- ## JOIN
	-- ## USING
	-- ## NATURAL JOIN


-- ## Execute a three table JOIN 
-- ## (INNER JOIN)

-- ## Add an ORDER BY to a JOIN
-- ## to carry-out some
-- ## meaningful ordering/sorting

-- ## Add an GROUP BY to a JOIN
-- ## to carry-out some
-- ## meaningful Grouping

-- ## JOIN TYPES: 
-- ## Find a suitable scenario 
-- ## and write a two-way
-- ## JOIN for each of:
	-- ##  LEFT JOIN, 
	-- ##  RIGHT JOIN, 
	-- ##  OUTER JOIN

-- ## EXISTS operator
-- ## Use EXISTS with
-- ##  a 'correlated' sub-query


-- ## Do a suitable example for 
-- ## each of these:
	-- ## UNION (Set union) operator
	-- ## INTERSECT (Set intersection)operator
	-- ## EXCEPT (Set difference) operator


-- ## UPDATE
-- ## Find examples for: 
	-- ## Updating multiple rows/cols
	-- ## Update All Rows

	-- ## Update more-than-one Row
	-- ## WHERE something 

	-- ## Update multiple columns
	-- ## of one Row

	-- ## Update multiple columns
	-- ## of more-than-one Row




