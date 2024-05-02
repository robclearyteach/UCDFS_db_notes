--	# Sqlite/SQLiteStudio downloads
--		https://www.sqlite.org/download.html		#Recommend: choose: `sqlite-tools-... .zip`
--		https://sqlitestudio.pl/
--
-- ## sqlite-tools-win-x64-3450200.zip

-- ## extract into project folder
-- ## e.g. extracts to:
-- ## sqlite3.exe  (on Windows)

-- ## from this folder (or add to PATH and then from any folder)
-- ## cmd-line access via
-- ## 
$ sqlite3

sqlite> SELECT "Hello World!";


sqlite> SELECT 'Hello World'
   ...> ;
   
sqlite> .exit

-- ## %%
-- ## demo/sqlite/
-- ## demo/sqlite/sqlite3.exe  -- copy-paste app in

-- ## cd to demo/sqlite
-- ## below prompt
-- ## sqlite> 
CREATE TABLE facility(
   facid INT
 , name TEXT
);

INSERT INTO facility VALUES (0, 'Tennis Court 1'), (1, 'Tennis Court 2');       
SELECT * FROM facility;

CREATE TABLE booking(
    bookid INT
  , facid  INT
  , starttime DATE
);

INSERT INTO booking 
VALUES 
		 (1, 0, '2024-05-02 18:30:00')
		,(2, 0, '2024-05-02 19:30:00');  
		
SELECT * FROM booking;
.header on
SELECT * FROM booking;
.header off

.databases
.tables
.schema

.save test.db

.quit


sqlite3

.databases
.open test.db

.databases


-- ## %% .mode
-- ## see output from (windows)
.mode  					

.mode ?
	
SELECT * FROM booking;

.separator ' ** '
SELECT * FROM booking;

.separator '|'
SELECT * FROM booking;

.mode line
SELECT * FROM booking;

.mode table
SELECT * FROM booking;

.mode box
SELECT * FROM booking;

.mode insert
SELECT * FROM booking;


.open
.tables
create table test( a int, b int ); insert into test values (1, 1), (2, 2);
select * from test;

.databases
.save noname.db

.conn		

.quit

sqlite3
.open noname.db
.tables
SELECT * FROM test;

.quit

sqlite3 test.db
.tables

.quit


sqlite3
.open test.db
.mode csv
SELECT * FROM booking;
.output test.booking.csv
SELECT * FROM booking;

.output 				--reset to standard out

-- ## TASK: REPEAT above
-- ##       or similar with '.once' command

-- ## Using following from: DreamHome
-- ## DDL: POSTGRES VERSION 
				DROP TABLE IF EXISTS branch;

				CREATE TABLE branch
				(branchNo char(5) PRIMARY KEY,
				 street varchar(35),
				 city varchar(10),
				 postcode varchar(10)
				);

				INSERT INTO branch VALUES('B005','22 Deer Rd','London','SW1 4EH');
				INSERT INTO branch VALUES('B007','16 Argyll St', 'Aberdeen','AB2 3SU');
				INSERT INTO branch VALUES('B003','163 Main St', 'Glasgow','G11 9QX');
				INSERT INTO branch VALUES('B004','32 Manse Rd', 'Bristol','BS99 1NZ');
				INSERT INTO branch VALUES('B002','56 Clover Dr', 'London','NW10 6EU');

				DROP TABLE if EXISTS staff;

				CREATE TABLE staff
				(staffNo char(5) PRIMARY KEY,
				 fName varchar(10),
				 lName varchar(10),
				 position varchar(10),
				 sex char(1),
				 DOB date,
				 salary int,
				 branchNo char(5)
				);

				INSERT INTO staff VALUES('SL21','John','White','Manager','M','1965-10-01',30000,'B005');
				INSERT INTO staff VALUES('SG37','Ann','Beech','Assistant','F','1980-11-10',12000,'B003');
				INSERT INTO staff VALUES('SG14','David','Ford','Supervisor','M','1978-03-24',18000,'B003');
				INSERT INTO staff VALUES('SA9','Mary','Howe','Assistant','F','1990-02-19',9000,'B007');
				INSERT INTO staff VALUES('SG5','Susan','Brand','Manager','F','1960-06-03',24000,'B003');
				INSERT INTO staff VALUES('SL41','Julie','Lee','Assistant','F','1985-06-13',9000,'B005');


-- ## SQLite VERSION
-- ## Copy-paste below: save 'dreamhome_sqlite.sql'
				-- Drop table if exists
				DROP TABLE IF EXISTS branch;

				-- Create branch table
				CREATE TABLE branch (
					branchNo TEXT PRIMARY KEY,
					street TEXT,
					city TEXT,
					postcode TEXT
				);

				-- Insert data into branch table
				INSERT INTO branch VALUES('B005','22 Deer Rd','London','SW1 4EH');
				INSERT INTO branch VALUES('B007','16 Argyll St', 'Aberdeen','AB2 3SU');
				INSERT INTO branch VALUES('B003','163 Main St', 'Glasgow','G11 9QX');
				INSERT INTO branch VALUES('B004','32 Manse Rd', 'Bristol','BS99 1NZ');
				INSERT INTO branch VALUES('B002','56 Clover Dr', 'London','NW10 6EU');

				-- Drop table if exists
				DROP TABLE IF EXISTS staff;

				-- Create staff table
				CREATE TABLE staff (
					staffNo TEXT PRIMARY KEY,
					fName TEXT,
					lName TEXT,
					position TEXT,
					sex TEXT,
					DOB DATE,
					salary INTEGER,
					branchNo TEXT,
					FOREIGN KEY (branchNo) REFERENCES branch(branchNo)
				);

				-- Insert data into staff table
				INSERT INTO staff VALUES('SL21','John','White','Manager','M','1965-10-01',30000,'B005');
				INSERT INTO staff VALUES('SG37','Ann','Beech','Assistant','F','1980-11-10',12000,'B003');
				INSERT INTO staff VALUES('SG14','David','Ford','Supervisor','M','1978-03-24',18000,'B003');
				INSERT INTO staff VALUES('SA9','Mary','Howe','Assistant','F','1990-02-19',9000,'B007');
				INSERT INTO staff VALUES('SG5','Susan','Brand','Manager','F','1960-06-03',24000,'B003');
				INSERT INTO staff VALUES('SL41','Julie','Lee','Assistant','F','1985-06-13',9000,'B005');



.read dreamhome_sqlite.sql
.tables
.mode box
SELECT * FROM branch;


.mode csv
SELECT * FROM staff;
.once staff_data.csv

 .quit
 sqlite3
 .conn
 
 -- ## Use full dot-command below
 ".import --csv staff_data.csv temp_staff"
 .tables
SELECT * FROM temp_staff;

-- ## %% .dump
sqlite3
.conn
.tables
.read dreamhome_sqlite.sql
.tables
.save dreamhome.db
.quit

sqlite3 dreamhome.db .dump
sqlite3 dreamhome.db .dump > bak_dreamhome_sqlite.sql
-- ## %%
-- ## %%
-- ## =======SQLite Studio=========

-- ## %%
-- ## =======Practice=========
-- ## _querypractice03.sql
-- ## Also, work on anything outstanding, ask questions etc.





