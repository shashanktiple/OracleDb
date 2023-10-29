--A subquery can have only one column in the SELECT clause, unless multiple columns 
---------------------are in the main query for the subquery to compare its selected columns.

--An ORDER BY cannot be used in a subquery, although the main query can use an ORDER BY. 
--------------------The GROUP BY can be used to perform the same function as the ORDER BY in a subquery.

--Subqueries that return more than one row can only be used with multiple value operators, such as the IN operator





------------TABLE--------------
CREATE TABLE STUDENTS(IDD NUMBER,USN NUMBER, NAME VARCHAR2(30));
INSERT INTO STUDENTS VALUES (11,100,'SSDS');
INSERT INTO STUDENTS VALUES (22,125,'PSDSXSX');
INSERT INTO STUDENTS VALUES (33,144, 'QGFGGF');
INSERT INTO STUDENTS VALUES (44,122, 'RRTRYTY');
INSERT INTO STUDENTS VALUES (55,178, 'DGJGJJ');
INSERT INTO STUDENTS VALUES (66,126, 'VVNVNN');
SELECT * FROM STUDENTS;
DROP TABLE STUDENTS;

CREATE TABLE STU_DEPT(DEPT_ID NUMBER,USN NUMBER,COURSE VARCHAR2(30),CITY VARCHAR2(30),PINCODE NUMBER);
INSERT INTO STU_DEPT VALUES (21,125,'Operating system','Bangalore',560076);
INSERT INTO STU_DEPT VALUES (22,123,'Management','pune',426520);
INSERT INTO STU_DEPT VALUES (23,124,'Engineer','Mumbai',760548);
INSERT INTO STU_DEPT VALUES (24,122,'Microprocessor','Bangalore',560076);
INSERT INTO STU_DEPT VALUES (25,121,'Microcontroller','Bangalore',560076);
INSERT INTO STU_DEPT VALUES (26,126,'Semiconductor','Bangalore',560076);
SELECT * FROM STU_DEPT;
DROP TABLE STU_DEPT;

--SELECT DEPT_ID FROM STU_DEPT WHERE USN IN(SELECT USN FROM STUDENTS); ------OR-----
--SELECT DEPT_ID FROM STU_DEPT, STUDENTS WHERE STU_DEPT.USN = STUDENTS.USN;--------*************

















