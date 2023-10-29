SET SERVEROUTPUT ON

CREATE OR REPLACE FUNCTION FUN(f_date IN date)
RETURN NUMBER
AS
num_sales NUMBER:=0; --declare variable

BEGIN
    SELECT COUNT(*) INTO num_sales FROM sales 
    WHERE sales_date = f_date;
    
    RETURN num_sales;
    
END FUN;
/
--========= CALLLING FUNCTION METHOD 1
select * from sales;

select FUN(to_date('1-jan-2015','dd-mon-yyyy')) AS datee from dual;

--========= CALLLING FUNCTION METHOD 2

DECLARE
s_count NUMBER :=0;
BEGIN
s_count := FUN(to_date('22-sep-2023','dd-mon-yyyy'));
dbms_output.put_line('---'||s_count);
END;
/


--================================---------EXERCISE---------====================
CREATE OR REPLACE FUNCTION funny(n1 IN NUMBER, n2 IN NUMBER)
RETURN NUMBER
AS
x NUMBER:=1;

BEGIN

    for a in 1..n2
    LOOP
        x := n1*x;
    END LOOP;
    RETURN x;
END funny;
/
--------
select funny(10,3) AS result from dual;

--============

CREATE OR REPLACE FUNCTION f_date(s_date sales.sales_date%type)
RETURN NUMBER
AS

ss NUMBER;
BEGIN
 SELECT COUNT(1) INTO ss FROM sales where sales_date = s_date;
 RETURN ss;
 
END f_date;
/
--METHOD1
select f_date(to_date('01-JAN-2015','DD-MON-YYYY')) FROM dual;
--METHOD2
DECLARE
sss NUMBER;
BEGIN
sss:=f_date(to_date('01-JAN-2015','DD-MON-YYYY'));
dbms_output.put_line('----'||sss);
END;







