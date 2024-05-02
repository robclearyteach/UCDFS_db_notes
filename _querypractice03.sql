-- (Assuming created from previously)
-- (If not: Create the facilities/members/bookings
--          tables from the clubdata.sql
-- https://pgexercises.com/gettingstarted.html  
-- (@See link: 'download the SQL')



-- 1: After the table members and bookings
--    are created and some data inserted:
--    Experiment with a JOIN of the 
--    bookings and members table to see
--    what members booked what facility 
--    and when

-- 1.b:
-- 	 follow this tutorial
-- https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-joins/

-- (Recommend: experiment with creating the joins using 
--       a WHERE clause instead of the JOIN keyword)


-- 2: Create this same database in SQLite
--		(Recommend: make a note of all the steps you perform.)


-- 3: Using the DreamHome staff and branch tables
--    (See SlideExamples03b.sql for SQL)
--    Experiment with creating the tables where
--	  You specify TABLE constraints that you name
--    As opposed to the Column constraints currently used.


-- 4. Create a virtual environment in your working folder
--    e.g.
--    		py -m venv .venv
--    Activate it:
--    e.g.
--    		source ./.venv/Scripts/Activate
--          [Reminder:]
--			deactivate
--           [to deactivate it]
--	Once active:
--  pip install sqlalchemy
--
--  And then try this python example:
--  that assumes you have
--  the test.db file created at the
--  beginning of...
--  SlideExamples03b.sql
"""
from sqlalchemy import create_engine, text

connection_string = "sqlite:///test.db"
engine = create_engine(connection_string, echo=True)

with engine.connect() as conn:
    result = conn.execute( text("SELECT * FROM booking") )
    rows = result.all()

print(rows)
"""
