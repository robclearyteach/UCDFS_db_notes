--Week 1 Slide Examples

--6.1
--List full details of all staff

SELECT staffNo, fName, lName, 
position, sex, DOB, salary, branchNo
FROM Staff;

--Can use * as an abbreviation for ‘all columns’:

SELECT *
FROM Staff;

--6.2
--Produce a list of salaries for all staff, showing only  staff number, first and last names, and salary

	SELECT staffNo, fName, lName, salary
	FROM Staff;

--6.3
--List the property numbers of all properties that have been viewed.

	SELECT propertyNo
	FROM Viewing;

--6.4
--Produce list of monthly salaries for all staff, showing staff number, first/last name, and  salary.

	SELECT staffNo, fName, lName, salary/12
	FROM Staff;

	--	Show rounded
	--							, ROUND(salary/12, 2)
	
--To name column, use AS clause:

   	SELECT staffNo, fName, lName, salary/12 
		AS monthlySalary
	   FROM Staff;

--6.5
--List all staff with a salary greater than 10,000.

SELECT staffNo, fName, lName, position, salary
FROM Staff
WHERE salary > 10000;

--6.6
--List addresses of all branch offices in London or Glasgow.
	SELECT *
	FROM Branch
	WHERE city = 'London' OR city = 'Glasgow';

--6.7
--List all staff with a salary between 20,000 and 30,000

SELECT staffNo, fName, lName, position, salary
FROM Staff
WHERE salary BETWEEN 15000 AND 30000;

--Also a negated version NOT BETWEEN

SELECT staffNo, fName, lName, position, salary
FROM Staff
WHERE salary NOT BETWEEN 15000 AND 30000;

--BETWEEN does not add much to SQL’s expressive power. Could also write:

SELECT staffNo, fName, lName, position, salary
FROM Staff
WHERE salary >= 15000 AND salary <= 30000;

--6.8
--List all managers and supervisors

SELECT staffNo, fName, lName, position
FROM Staff
WHERE position IN ('Manager', 'Supervisor');

--There is a negated version (NOT IN)
--IN does not add much to SQL’s expressive power. Could have expressed this as:

SELECT staffNo, fName, lName, position
FROM Staff
WHERE position='Manager' OR position='Supervisor';

--6.9
--Find all owners with the string ‘Glasgow’ in their address.

SELECT ownerNo, fName, lName, address, telNo
FROM PrivateOwner
WHERE address LIKE '%Glasgow%';


--6.10
--Find all viewings for property 'PG4' with no comment.

SELECT clientNo, viewDate
FROM Viewing
WHERE propertyNo = 'PG4' AND comment IS NULL;
	-- **NO RESULT** go back a view DDL stmt to see ''

		-- Fix 1: Change query to search for ''
		SELECT *
		FROM viewing
		WHERE propertyNo = 'PG4' AND comment = '';

		-- Fix 2: Update viewing and set comment to NULL for that record
		-- 2.1 First: find the right record with a select
		SELECT *
		FROM viewing
		WHERE propertyNo = 'PG4' 
		  AND viewDate = DATE '2015-05-26' 

		-- 2.2 Then: convert to UPDATE statement
		UPDATE viewing
		SET comment = NULL
		WHERE propertyNo = 'PG4' 
		  AND viewDate = DATE '2015-05-26'; 
		
		-- 2.3 try original SQL above
				

--6.11
--List salaries for all staff, arranged in descending order of salary.

SELECT staffNo, fName, lName, salary
FROM Staff
ORDER BY salary DESC;

--6.12
--Produce abbreviated list of properties in order of property type.

SELECT propertyNo, type, rooms, rent
FROM PropertyForRent
ORDER BY type;

--Four flats in this list - as no minor sort key specified, system arranges these rows in any order it chooses.
--To arrange in order of rent, specify minor order:

SELECT propertyNo, type, rooms, rent
FROM PropertyForRent
ORDER BY type, rent DESC;

--6.13
--How many properties cost more than 350 per month to rent?

SELECT COUNT(*) AS myCount
FROM PropertyForRent
WHERE rent > 350;

--6.14
--How many different properties viewed in May ‘15?

SELECT COUNT(DISTINCT propertyNo) AS myCount
FROM Viewing
WHERE viewDate BETWEEN '1-May-15' AND '31-May-15';

--6.15
--Find number of Managers and sum of their salaries.

SELECT COUNT(staffNo) AS myCount, 
SUM(salary) AS mySum
FROM Staff
WHERE position = 'Manager';

--6.16
--Find minimum, maximum, and average staff salary.

SELECT MIN(salary) AS myMin, 
MAX(salary) AS myMax,
AVG(salary) AS myAvg
FROM Staff;

--6.17
--Find number of staff in each branch and their total salaries.

SELECT branchNo, 
COUNT(staffNo) AS myCount,
SUM(salary) AS mySum
FROM Staff
GROUP BY branchNo
ORDER BY branchNo;

--6.18
--Find number of staff in each branch and their total salaries.

SELECT branchNo, 
COUNT(staffNo) AS myCount,
SUM(salary) AS mySum
FROM Staff
GROUP BY branchNo
HAVING COUNT(staffNo) > 1
ORDER BY branchNo;












