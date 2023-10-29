SET SERVEROUTPUT ON

--===================------SYSTEM DEFINED EXCEPTION----------=================
CREATE OR REPLACE PROCEDURE exceptn(c_id IN NUMBER)
AS 
   c_name customer.first_name%type; 
   c_addr customer.address_line1%type; 
BEGIN 
   SELECT  first_name, address_line1 INTO  c_name, c_addr 
   FROM customer
   WHERE customer_id = c_id;  
   DBMS_OUTPUT.PUT_LINE ('Name: '||  c_name); 
   DBMS_OUTPUT.PUT_LINE ('Address: ' || c_addr); 

EXCEPTION 
    WHEN no_data_found THEN 
    dbms_output.put_line('No such customer!'); 
    WHEN TOO_MANY_ROWS THEN
    dbms_output.put_line('many entries found'); 
    WHEN others THEN 
    dbms_output.put_line('other Error!'); 
END; 
/

BEGIN
exceptn(55);
END;
/
select * from customer;


--===================------USER DEFINED EXCEPTION----------=================


CREATE OR REPLACE PROCEDURE exc(c_id IN NUMBER)
AS 
c_name customer.first_name%type; 
c_addr customer.address_line1%type; 
user_excptn EXCEPTION; -----------------***
BEGIN 
    IF c_id <=0 THEN
        RAISE user_excptn; ----------------***
    END IF;
    
   SELECT  first_name, address_line1 INTO  c_name, c_addr 
   FROM customer
   WHERE customer_id = c_id;
   
   DBMS_OUTPUT.PUT_LINE ('Name: '||  c_name); 
   DBMS_OUTPUT.PUT_LINE ('Address: ' || c_addr); 

EXCEPTION 
    WHEN user_excptn THEN 
        dbms_output.put_line('my excptn');  
    WHEN no_data_found THEN 
        dbms_output.put_line('No such customer!'); 
    WHEN TOO_MANY_ROWS THEN
        dbms_output.put_line('many entries found'); 
    WHEN others THEN 
        dbms_output.put_line('other Error!'); 
END; 
/

BEGIN
exc(0);
END;


-----====================== EXERCISE====================

CREATE OR REPLACE FUNCTION ff(n1 IN NUMBER, n2 IN NUMBER)
RETURN NUMBER
AS
x NUMBER:=1;
exc_1 EXCEPTION;
exc_2 EXCEPTION;

BEGIN
    if (n1 is null OR n1 =0 OR n2 is null OR n2 =0) then
        RAISE exc_1;
    end if;
    if (n1>100 OR n2>100) then
        RAISE exc_2;
    END IF;
    
    
    for a in 1..n2
    LOOP
        x := n1*x;
    END LOOP;
    RETURN x;

EXCEPTION
    WHEN exc_1 THEN
        dbms_output.put_line('Invalid Number');    
        RETURN 0;
    WHEN exc_2 THEN
        dbms_output.put_line('“Number must be less than 100'); 
        RETURN 0;
    WHEN others THEN 
        dbms_output.put_line('other Error!');
END ff;
/
--------
select ff(10,3) from dual;


