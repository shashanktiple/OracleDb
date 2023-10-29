SET SERVEROUTPUT ON

---========================================== "IN" MODE (Read only)=============

CREATE OR REPLACE PROCEDURE PROC_IN
(p_id IN NUMBER, p_fname IN VARCHAR2, p_lname IN VARCHAR2)--cannot describe the length of the variable
AS

BEGIN
    INSERT INTO customer(customer_id, first_name, last_name) 
        VALUES(p_id, p_fname, p_lname);
    
    COMMIT;
    dbms_output.put_line('date inserted successfully');
    
END PROC_IN;
/

-------CALLING PROCEDURE METHOD 1

BEGIN
PROC_IN(23,'1st', 'procedure');
END;
/
select * from customer;


------CALLING PROCEDURE METHOD 2

BEGIN
PROC(p_id =>33,p_fname =>'2nd',p_lname =>'procedure');
END;
/


---====================================== "OUT" MODE (Write only)===============

CREATE OR REPLACE PROCEDURE PROC_OUT
(p_id IN NUMBER,p_fname IN VARCHAR2,p_lname IN VARCHAR2,total_count OUT NUMBER)
AS

BEGIN

    INSERT INTO customer(customer_id, first_name, last_name) 
        VALUES(p_id, p_fname, p_lname);
    
    COMMIT;
    dbms_output.put_line('date inserted successfully');
    
    SELECT COUNT(1) INTO total_count FROM customer;
    
END PROC_OUT;
/

-------CALLING PROCEDURE METHOD 1
DECLARE
tcount NUMBER(10);
BEGIN
    PROC_OUT(24,'OUT', 'procedure',tcount);
    dbms_output.put_line('total rows'|| tcount);
END;
/
select * from customer;
---====================================== "INOUT" MODE ========================

CREATE OR REPLACE PROCEDURE PROC_INOUT
(p_id IN OUT NUMBER,  p_fname IN VARCHAR2,p_lname IN VARCHAR2)
AS

BEGIN

    INSERT INTO customer(customer_id, first_name, last_name) 
        VALUES(p_id, p_fname, p_lname);
    
    COMMIT;
    dbms_output.put_line('date inserted successfully');
    
    SELECT COUNT(1) INTO P_id FROM customer;
    
END PROC_INOUT;
/

-------CALLING PROCEDURE
DECLARE
idd NUMBER(10):=55;
BEGIN
    PROC_INOUT(idd,'OUT', 'procedure');
    dbms_output.put_line('total rows'|| idd);
END;
/

--================================---------EXERCISE---------=================
SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE p(p_orderID IN number, c_out OUT NUMBER )
AS
p_date sales.sales_date%type;
p_productID sales.product_id%type;

BEGIN
    SELECT sales_date, product_id INTO p_date,p_productID 
    FROM sales WHERE order_ID = p_orderID;
    dbms_output.put_line(p_date);
    dbms_output.put_line(p_productID);
    
    select COUNT(1) INTO c_out FROM sales where sales_date = p_date;
    
EXCEPTION 
    WHEN no_data_found THEN 
    dbms_output.put_line('No such customer!'); 
    WHEN TOO_MANY_ROWS THEN
    dbms_output.put_line('many entries found'); 
    WHEN others THEN 
    dbms_output.put_line('other Error!'); 

END p;
/


--EXEC p(1269);

DECLARE
c_print NUMBER;
BEGIN
p(1269,c_print);
dbms_output.put_line('Total rows '||c_print);
END;
/
---==============

