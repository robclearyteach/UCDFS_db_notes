-- ## locate
-- ## LMS Unit 2: 
-- ## CaseStudy.zip-->Dreamhome_Database.sql

-- ## For ref:
-- ## https://www.postgresqltutorial.com/postgresql-administration/postgresql-create-database/


-- ## psql: create db
postgres=# CREATE DATABASE dreamhome;

-- ## then quit
\q

-- ## psql
-- ## (FROM same folder as `Dreamhome_database.sql`)
psql -U postgres -d dreamhome < Dreamhome_database.sql

-- ## log-in again
psql -U postgres -d dreamhome

-- ## describe tables
dreamhome=# \dt


-- ## sqlite
-- ## SQLite Studio
-- ## Create Database (GUI or SQL in QUERY EDITOR)
--
-- ## Query Editor --> toolbar 'open' (folder icon)
-- ##  Open/Load-in `dreamhome_sqlite.sql`
-- ##  Highlight all--> Run.

-- ## see tables created.


SELECT staffNo, fName, lName, position	
FROM Staff
WHERE branchNo =(
					SELECT branchNo		 
					FROM Branch		
					WHERE street = '163 Main St'
				);
 

SELECT * FROM branch;
SELECT * FROM staff;


SELECT branchNo		 
FROM Branch		
WHERE street = '163 Main St';

SELECT branchNo		 
FROM Branch		
WHERE city = 'London';

-- ## See query fail
-- ## WHERE branch = (non-scaler)
SELECT staffNo, fName, lName, position	
FROM Staff
WHERE branchNo =(
				 SELECT branchNo		 
				 FROM Branch		
				 WHERE city = 'London'
				);
				
			
		

SELECT 	  staffNo
		, fName
		, lName
		, position
		, salary - (SELECT AVG(salary) FROM Staff) As SalDiff
FROM Staff
WHERE salary >(
				SELECT AVG(salary) 
               	FROM Staff
			  );
			   
			   
SELECT AVG(salary) 
FROM Staff;


		



SELECT propertyNo, street, city, postcode, type, rooms, rent
FROM PropertyForRent 
WHERE staffNo 
IN  (
		SELECT staffNo  
      	FROM Staff  
      	WHERE branchNo = (	
      						SELECT branchNo	 
      	 				 	FROM Branch 
      	 					WHERE street = '163 Main St'
						 )
	);
		 
SELECT branchNo	 
FROM Branch 
WHERE street = '163 Main St'

SELECT staffNo  
FROM Staff  
WHERE branchNo = 'B003';

 
SELECT staffNo  
FROM Staff  
WHERE branchNo = (
					SELECT branchNo	 
					FROM Branch 
					WHERE street = '163 Main St'
				 );
			

	
SELECT propertyNo, street, city, postcode, type, rooms, rent
FROM PropertyForRent 
WHERE staffNo 
IN ('SG37', 'SG14', 'SG5');













-- ## ANY and ALL 
SELECT staffNo, fName, lName, position, salary
FROM Staff
WHERE salary > ANY	(
						SELECT salary			 
						FROM Staff			 
						WHERE branchNo = 'B003'
					);


SELECT salary			 
FROM Staff			 
WHERE branchNo = 'B003';


SELECT staffNo, fName, lName, position, salary
FROM Staff
WHERE salary > 12000 
		OR
	  salary > 18000
	  	OR
	  salary > 24000;

SELECT staffNo, fName, lName, position, salary
FROM Staff
WHERE salary > SOME	(
						SELECT salary			 
						FROM Staff			 
						WHERE branchNo = 'B003'
					);


SELECT staffNo, fName, lName, position, salary
FROM Staff
WHERE salary > (
    SELECT MIN(salary)
    FROM Staff
    WHERE branchNo = 'B003'
);		

-- ## Question: What happens if 'Bxxx'






-- ## ALL 
SELECT staffNo, fName, lName, position, salary
FROM Staff
WHERE salary > ALL		
               (SELECT salary			 
                FROM Staff			 
                WHERE branchNo = 'B003');


SELECT staffNo, fName, lName, position, salary
FROM Staff
WHERE salary > 12000 
		AND
	  salary > 18000
	  	AND
	  salary > 24000;
	

SELECT staffNo, fName, lName, position, salary
FROM Staff
WHERE salary > (
    SELECT MAX(salary)
    FROM Staff
    WHERE branchNo = 'B003'
);	








-- ## JOINS
SELECT 	  c.clientNo AS "c.client_no"
		, fName	AS "c.fname"
		, lName AS "c.lname"
		, propertyNo AS "v.property_no"
		, comment	 AS "v.comment"
FROM 	Client AS c , Viewing AS v
WHERE 	c.clientNo = v.clientNo;


SELECT 	  c.clientNo AS "c.client_no"
		, propertyNo AS "v.property_no"
FROM 	Client AS c , Viewing AS v;

SELECT COUNT(*) AS count_of_clients FROM client;
SELECT COUNT(*) AS count_of_viewing FROM Viewing;


SELECT * FROM viewing ORDER BY clientNo, propertyNo;




-- ## JOINS
-- ## Different ways to write:

-- ## INNER JOIN
SELECT 	  client.clientNo
		, client.fName
		, client.lName
		, viewing.propertyNo
		, viewing.comment
FROM 	client INNER JOIN viewing 
		ON 
		client.clientNo = viewing.clientNo;


-- ## JOIN
SELECT 	  client.clientNo
		, client.fName
		, client.lName
		, viewing.propertyNo
		, viewing.comment
FROM 	client JOIN viewing 
		ON 
		client.clientNo = viewing.clientNo;
		

-- ## USING
SELECT 	  client.clientNo
		, client.fName
		, client.lName
		, viewing.propertyNo
		, viewing.comment
FROM 	client JOIN viewing 
		USING (clientNo);

-- ## NATURAL JOIN
SELECT 	  client.clientNo
		, client.fName
		, client.lName
		, viewing.propertyNo
		, viewing.comment
FROM 	client NATURAL JOIN viewing;







-- ## Three table JOIN (INNER JOIN)
SELECT 	  Branch.branchNo
		, Branch.city
		, Staff.staffNo
		, Staff.fName
		, Staff.lName
		, PropertyForRent.propertyNo
FROM 	Branch INNER JOIN Staff 
		ON 
		Branch.branchNo = Staff.branchNo
					INNER JOIN PropertyForRent 
					ON 
					Staff.staffNo = PropertyForRent.staffNo;
					




-- ## JOIN TYPES: Inner, Left, Right, Outer
-- ## LEFT JOIN

SELECT    branch.branchno
		, branch.street
		, branch.city
		, staff.staffno
		, staff.fname
		, staff.lname
FROM branch LEFT JOIN staff
	 ON 
	 branch.branchNO = staff.branchNo;
	 

-- WHERE staff.staffno IS NULL;

SELECT    branch.branchno
		, branch.street
		, branch.city
FROM branch LEFT JOIN staff
	 ON 
	 branch.branchNO = staff.branchNo
WHERE staff.staffno IS NULL;
	 






-- ## RIGHT JOIN
SELECT    staff.staffno
		, staff.fname
		, staff.lname
		, PropertyForRent.propertyNo
		, PropertyForRent.street
		, PropertyForRent.city

FROM staff RIGHT JOIN PropertyForRent
	 ON 
	 staff.staffNo = PropertyForRent.staffNo;

-- WHERE staff.staffno IS NULL;


SELECT    PropertyForRent.propertyNo
		, PropertyForRent.street
		, PropertyForRent.city

FROM staff RIGHT JOIN PropertyForRent
	 ON 
	 staff.staffNo = PropertyForRent.staffNo
	 
WHERE staff.staffNo IS NULL;
	 




-- ## FULL OUTER JOIN
-- ## IDEA but what's wrong below
SELECT    PropertyForRent.propertyno
		, PropertyForRent.street
		, PropertyForRent.city
		, client.clientno
		, client.fname
		, client.lname
FROM 	propertyForRent FULL OUTER JOIN client 
		ON 
		propertyForRent.ownerNo = client.client
		
		
		
		
-- ## EXISTS operator
SELECT staffNo, fName, lName, position 
FROM Staff AS s
WHERE EXISTS
        (
			SELECT * 
			FROM Branch AS b 
			WHERE s.branchNo = b.branchNo AND city = 'London');
			

SELECT staffNo, fName, lName, position , branchno
FROM Staff; 


SELECT * 
FROM Branch; 






-- ## UNION (Set union) operator
SELECT DISTINCT city
FROM Branch	
	UNION 
SELECT DISTINCT city	
FROM PropertyForRent;


-- ## INTERSECT (Set intersection)operator
SELECT DISTINCT city
FROM Branch	
	INTERSECT 
SELECT DISTINCT city	
FROM PropertyForRent;



-- ## EXCEPT (Set difference) operator
SELECT DISTINCT city
FROM Branch	
	EXCEPT 
SELECT DISTINCT city	
FROM PropertyForRent;

-- PropertyForRent - Branch
SELECT DISTINCT city	
FROM PropertyForRent
	EXCEPT 
SELECT DISTINCT city
FROM Branch	



-- ## UPDATE
-- ## Updating multiple rows/cols

-- Update All Rows
-- Give all staff a 3% pay increase.
UPDATE Staff   
SET salary = salary*1.03;

--Give all Managers a 5% pay increase.
UPDATE Staff
SET salary = salary*1.05
WHERE position = ‘Manager’;

--Promote David Ford (staffNo=‘SG14’) to Manager and change his salary to 18,000.
UPDATE Staff
SET position = 'Manager', salary = 18000
WHERE staffNo = 'SG14';

