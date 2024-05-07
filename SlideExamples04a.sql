
psql -U postgres
postgres=#
postgres=#\l

--then quit
postgres=#\q


psql -U postgres -d dvdrental

-- See prompt
dvdrental=#

-- then quit
dvdrental=#\q


-- ## %%
psql -U postgres
postgres=#

CREATE USER testuser PASSWORD 'test123';
postgres=#\du
-- see user created

--then quit
postgres=#\q

-- ## cmd:
-- psql -U testuser
-- ...password: test123
--
-- SEE ERROR
-- 	psql: error: connection to server at "localhost" (::1), port  failed: FATAL:  
--  password authentication  user "testuser"






-- ## %%
-- ## cmd
psql -U postgres
postgres=#

-- ## connect to dvdrental
postgres=#\c dvdrental

-- ## from this "context"
-- ## GRANT permissions
GRANT SELECT ON ALL TABLES IN SCHEMA public to testuser;

--then quit
postgres=#\q

-- ## cmd:
psql -U testuser -d dvdrental

-- ## dvdrental=> 
SELECT * FROM staff;

-- ## dvdrental=> 
UPDATE staff SET first_name = 'Michael' where first_name = 'Mike';
--see error
ERROR:  permission denied for table staff


-- ## dvdrental=> 
\c postgres
\dt
\l

-- ## but...
postgres=> select * from booking;
-- see error
ERROR:  permission denied for table booking



-- ## %%
-- ## python to postgres
-- ## with psycopg2 adapter
-- ## follow sequence within...
-- test_psycopg2.ipynb

-- ## %%
-- ## GRANT UPDATE
GRANT UPDATE ON staff TO testuser;


-- ## %%
-- ## Test with psql
\c dvdrental testuser


-- ## dvdrental=> 
SELECT * FROM staff;

UPDATE staff SET first_name = 'Michael' where first_name = 'Mike';
SELECT * FROM staff;


-- ## 'rollback' concept (manually)
UPDATE staff SET first_name = 'Mike' where first_name = 'Michael';
SELECT * FROM staff;



-- ## %%
-- ## Revert back to Python .ipynb file demo



















