-- CREATE TABLE staff(
--   	position VARCHAR(10) NOT NULL,
--     sex CHAR NOT NULL 
--   		CHECK (sex IN ('m', 'f'))
--   );


-- INSERT INTO staff
-- VALUES
-- 		 ('test', 'm')
-- 		,('test2', 'f');
        
-- SELECT * FROM staff;


-- #### Test out an insert that should
-- #### fail... see fail output...
-- INSERT INTO test_staff
-- VALUES
-- 		('test', 'g');
		

-- CREATE DOMAIN sextype
-- AS VARCHAR(2)
-- CHECK (VALUE IN ('m', 'f', 'nb'));

-- CREATE TABLE test_staff2(
-- 	 position varchar(10)
-- 	,sex sextype
-- );
-- SELECT * FROM test_staff2;		

-- INSERT INTO test_staff2
-- VALUES
-- 		('test', 'm');
-- SELECT * FROM test_staff2;

-- THen change above to test 'f' and say 'nx'
--	--	('test', 'f');
--	--	('test', 'nx');


-- Test/observe error output for...
-- DROP DOMAIN sextype RESTRICT;

-- Then try...
-- DROP DOMAIN sextype CASCADE;

-- read output
-- SEE effect on table test_staff2


-- ##CREATE TABLE => NOT NULL
-- ## Note: working on creating a table similar to 
-- ## https://pgexercises.com/gettingstarted.html

-- CREATE TABLE facility(
-- 	facility_id INT NOT NULL
-- 	,name VARCHAR(50) NOT NULL
-- );

-- SELECT * FROM facility;

-- INSERT INTO facility VALUES(1, 'pool-room');
-- SELECT * FROM facility;

-- INSERT INTO facility(name) VALUES ('steam-room');
-- INSERT INTO facility(facility_id) VALUES (2);


-- DROP TABLE IF EXISTS facility;
-- CREATE TABLE facility(
-- 	facility_id INT PRIMARY KEY
-- 	,name VARCHAR(50) NOT NULL
-- );

-- SELECT * FROM facility;

-- INSERT INTO facility VALUES (1, 'pool-room');
-- SELECT * FROM facility;
-- 
-- INSERT INTO facility(name) VALUES ('steam-room');
-- ## Observe error: what does this tell us?

-- SELECT * FROM facility;
-- INSERT INTO facility VALUES (1, 'steam-room');
-- ## Observe error: what does this tell us?


-- DROP TABLE IF EXISTS facility;
-- CREATE TABLE facility(
-- 	facility_id INT PRIMARY KEY
-- 	,name VARCHAR(50) NOT NULL DEFAULT 'facilityx'
-- );

-- INSERT INTO facility(facility_id) VALUES (1);
-- SELECT * FROM facility;

-- INSERT INTO facility(facility_id) VALUES (2);
-- SELECT * FROM facility;


-- DROP TABLE IF EXISTS facility;
-- CREATE TABLE facility(
-- 	facility_id INT PRIMARY KEY
-- 	,name VARCHAR(50) NOT NULL UNIQUE
-- );
-- SELECT * FROM facility;

-- INSERT INTO facility VALUES (1, 'pool-room');
-- SELECT * FROM facility;

-- INSERT INTO facility VALUES (2, 'steam-room');
-- SELECT * FROM facility;

-- INSERT INTO facility VALUES (3, 'pool-room');
-- SELECT * FROM facility;


-- DROP TABLE IF EXISTS facility;
-- CREATE TABLE facility(
-- 	 facility_id INT 
-- 	,name VARCHAR(50) NOT NULL 
-- 	,UNIQUE(name)
-- );
-- SELECT * FROM facility;

-- INSERT INTO facility VALUES (1, 'pool-room');
-- SELECT * FROM facility;

-- INSERT INTO facility VALUES (2, 'pool-room');


-- DROP TABLE IF EXISTS facility;
-- CREATE TABLE facility(
-- 	 facility_id INT 
-- 	,name VARCHAR(50) NOT NULL 
-- 	,PRIMARY KEY(facility_id)
-- );



-- DROP TABLE IF EXISTS facility;
-- CREATE TABLE facility(
-- 	 facility_id INT 
-- 	,name VARCHAR(50) NOT NULL 
-- 	,CONSTRAINT pkey_facility_id PRIMARY KEY(facility_id)
-- );


-- DROP TABLE IF EXISTS facility;
-- CREATE TABLE facility(
-- 	 facility_id INT 
-- 	,name VARCHAR(50) NOT NULL 
-- 	,CONSTRAINT key_facility_name UNIQUE(name)
-- );


-- DROP TABLE IF EXISTS facility;
-- CREATE TABLE facility(
-- 	 facility_id INT 
-- 	,name VARCHAR(50) NOT NULL 
-- 	,CONSTRAINT pkey_facility_id PRIMARY KEY(facility_id)
-- 	,CONSTRAINT key_facility_name UNIQUE(name)
-- );

-- DROP TABLE IF EXISTS facility;
-- CREATE TABLE facility(
-- 	 facility_id SERIAL 
-- 	,name VARCHAR(50) NOT NULL
-- );
-- SELECT * from facility;

-- INSERT INTO facility(name) VALUES ('test1'), ('test2');
-- SELECT * from facility;

-- INSERT INTO facility VALUES (DEFAULT, 'test3'), (DEFAULT, 'test4');
-- SELECT * from facility;


-- CREATE TABLE persons (
--   id SERIAL,
--   first_name VARCHAR(50),
--   last_name VARCHAR(50),
--   dob DATE,
--   email VARCHAR(255),
--   PRIMARY KEY (id)
-- );



-- \copy persons(first_name, last_name, dob, email)
-- FROM '.\persons.csv'
-- DELIMITER ','
-- CSV HEADER;

-- \copy persons
-- TO '.\persons_export.csv'
-- DELIMITER ','
-- CSV HEADER;

-- Open folder and see file `persons_export.csv` created
--  See data includes id

-- THEN

-- \copy persons(first_name, last_name, dob, email)
-- TO '.\persons_export2.csv'
-- DELIMITER ','
-- CSV HEADER;

-- Open folder and see file `persons_export2.csv` created
-- See data excludes id