-- Create Table with fields id, name, age, address and salary; and insert suitable values into it. --

-- Creating Table
CREATE TABLE company(Id NUMERIC PRIMARY KEY NOT NULL, 
					 Name VARCHAR(30), 
					 Age NUMERIC, 
					 Address VARCHAR(30),
					 Salary MONEY)

-- Inserting Values into Table
INSERT INTO company(Id, Name, Age, Address, Salary)
			VALUES (1, 'Paul', 32, 'California', '20000'),
				   (2, 'Allen', 25, 'Texas', '15000'),
				   (3, 'Teddy', 23, 'Norway', '20000'),
				   (4, 'Mark', 25, 'Rich-Mond', '65000'),
				   (5, 'David', 27, 'Texas', '85000'),
				   (6, 'Kim', 22, 'South-Hall', '45000'),
				   (7, 'James', 24, 'Houston', '10000'),
				   (8, 'Prakash', 23, 'Italy', '50000');


-- DataTypes in PostgreSQL
/* Numeric --> smallint, integer, bigint, decimal, numeric, real, double precision, smallserial, serial, bigserial
   Monetary --> money
   Character --> character varying(n), varchar(n), character(n), char(n), text
   Bynary --> bitea
   Date/Time --> timestamp, TIMESTAMPTZ, date,time,interval
   Boolean --> boolean
   Enumerated --> ENUM
   Geometric --> point, line, path, polygon, circle, box
*/

-- Create database using command prompt
-- CREATE DATABASE my_database
-- createdb -h localhost -p 5432 -U postgress newdatabase
-- password *****

-- Select database--> \c my_database
-- Drop database using command prompt
-- DROP DATABASE my_database
-- dropdb -h localhost -p 5432 -U postgress my_database
-- Password for user postgress: *****
-- Drop table --> DROP TABLE table_name

-- Addition operators
SELECT (5+8) AS addition;

-- Showing Values of Table
SELECT * FROM company;
SELECT * FROM company WHERE salary='20000';
SELECT COUNT(*) FROM company AS Records;
SELECT * FROM company WHERE age >= 25 AND salary >= '65000';
SELECT * FROM company WHERE age >= 25 OR salary >= '65000';
SELECT * FROM company WHERE age IS NOT NULL;
SELECT * FROM company WHERE name LIKE 'P%';
SELECT * FROM company WHERE name LIKE 'Da%';
SELECT * FROM company WHERE address LIKE '%-%';
SELECT * FROM company WHERE age IN(25, 27);
SELECT * FROM company WHERE age NOT IN(25, 27);
SELECT * FROM company WHERE age BETWEEN 25 AND 27;
SELECT age FROM company WHERE EXISTS(SELECT age FROM company WHERE salary > '65000');
SELECT * FROM company WHERE age > (SELECT age FROM company WHERE salary > '65000');


-- UPDATE is used to change values of table
-- But ALTER is used to change/add/delete the columns with constraints.
UPDATE COMPANY SET SALARY = '15000' WHERE ID = 3;
DELETE FROM COMPANY WHERE ID = 8;

SELECT * FROM COMPANY WHERE AGE :: TEXT LIKE '2%';
SELECT * FROM COMPANY WHERE ADDRESS :: TEXT LIKE 'T%';
SELECT * FROM COMPANY LIMIT 5;
SELECT * FROM COMPANY ORDER BY AGE ASC LIMIT 5;
SELECT * FROM COMPANY ORDER BY SALARY DESC LIMIT 4;
SELECT * FROM COMPANY ORDER BY NAME ASC;
SELECT NAME, SUM(SALARY) FROM COMPANY GROUP BY NAME;
INSERT INTO COMPANY(ID,NAME,AGE,ADDRESS,SALARY)VALUES(9, 'Prakash', 23, 'Rolpa', '30000')
SELECT NAME, SUM(SALARY) FROM COMPANY GROUP BY NAME ORDER BY NAME ASC;


-- Common Table Expressions (CTE) which uses current temporary table and helps to simplify data using WITH statement.
WITH CTE AS
(SELECT ID, NAME, AGE, ADDRESS, SALARY 
 FROM COMPANY
) SELECT * FROM CTE;

WITH RECURSIVE T(N) AS (
SELECT SALARY FROM COMPANY WHERE SALARY < '20000'
)
SELECT SUM(N) FROM T;

CREATE TABLE NEXT_COMPANY(
	ID INT PRIMARY KEY NOT NULL,
	NAME TEXT NOT NULL,
	AGE INT NOT NULL,
	ADDRESS VARCHAR(50),
	SALARY MONEY
	)

-- Copy Data from Company to the Next_Company
WITH COPY_DATA AS (
	SELECT * FROM COMPANY
	)
INSERT INTO NEXT_COMPANY(SELECT * FROM COPY_DATA)

SELECT * FROM NEXT_COMPANY

-- Show Data Deleted From Next_Company
WITH CTE_DATA AS (
	DELETE FROM NEXT_COMPANY
	WHERE SALARY > '30000'
	RETURNING *
	)
SELECT * FROM CTE_DATA

/*
Having Clause
       SELECT -->Selects
	   FROM
	   WHERE
	   GROUP BY -->Groups all (takes only one name if two or more exists)
	   HAVING   -->Condition
	   ORDER BY
*/

SELECT NAME FROM COMPANY GROUP BY NAME HAVING COUNT(NAME) < 2;
SELECT NAME FROM COMPANY GROUP BY NAME HAVING COUNT(NAME) > 1;

-- To select distinct values from table
SELECT DISTINCT NAME FROM COMPANY;

-- ALTER command to add UNIQUE constraint in address column.
ALTER TABLE NEXT_COMPANY ADD CONSTRAINT uni_add UNIQUE (ADDRESS); 


CREATE TABLE NEW_DEPARTMENT(
	ID INT PRIMARY KEY NOT NULL,
	DEPT VARCHAR(50) NOT NULL,
	EMP_ID INT NOT NULL
	)
	
SELECT * FROM NEW_DEPARTMENT;

-- CROSS JOIN METHOD
	SELECT EMP_ID, NAME, DEPT 
	FROM COMPANY 
	CROSS JOIN NEW_DEPARTMENT;

-- INNER JOIN METHOD
	SELECT ND.EMP_ID, CM.NAME, ND.DEPT
	FROM COMPANY AS CM
	INNER JOIN NEW_DEPARTMENT AS ND
	ON CM.ID = ND.ID;

-- LEFT OUTER JOIN METHOD
	SELECT ND.EMP_ID, CM.NAME, ND.DEPT
	FROM COMPANY AS CM
	LEFT OUTER JOIN NEW_DEPARTMENT AS ND
	ON CM.ID = ND.ID;

-- RIGHT OUTER JOIN METHOD
	SELECT ND.EMP_ID, CM.NAME, ND.DEPT
	FROM COMPANY AS CM
	RIGHT OUTER JOIN NEW_DEPARTMENT AS ND
	ON CM.ID = ND.ID;

-- FULL OUTER JOIN METHOD
	SELECT ND.EMP_ID, CM.NAME, ND.DEPT
	FROM COMPANY AS CM
	FULL OUTER JOIN NEW_DEPARTMENT AS ND
	ON CM.ID = ND.ID
























