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




