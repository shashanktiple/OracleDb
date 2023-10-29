SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE recd(cust_id IN CUSTOMER.customer_id%type)
AS
c_rec customer%rowtype;
BEGIN
    select * into c_rec from customer where cust_id=customer_id;
    dbms_output.put_line('first_Name = '||c_rec.first_name);
    dbms_output.put_line('last_Name = '||c_rec.last_name);
    
END;
/
------------
BEGIN
    recd(11);
END;
-------------
EXECUTE recd(12);

--==============================================================================

CREATE OR REPLACE PROCEDURE recd_1(cust_id IN CUSTOMER.customer_id%type)
AS
c_rec customer%rowtype;
c_rec1 customer%rowtype;
BEGIN

    select * into c_rec from customer where cust_id=customer_id;
    
    c_rec.first_name :='mmmm'; -------To change the record
    
    c_rec1 := c_rec; ---copy data from 1st record to 2nd record.
    
    dbms_output.put_line('first_Name = '||c_rec.first_name);
    dbms_output.put_line('last_Name = '||c_rec.last_name);
    dbms_output.put_line('second rec last_Name = '||c_rec1.last_name);---2nd record 
    
END;
/
------------

execute  recd(11);
--==============================================================================reocrd as parameter



CREATE OR REPLACE PROCEDURE recd_2(cust_id IN CUSTOMER.customer_id%type)
AS
c_rec2 customer%rowtype;
BEGIN
    select * into c_rec2 from customer where cust_id=customer_id;
    show_cust(c_rec2);
END;
/


CREATE OR REPLACE PROCEDURE show_cust(cust IN CUSTOMER%rowtype)
AS
BEGIN
    dbms_output.put_line('first_Name = '||cust.first_name);
    dbms_output.put_line('last_Name = '||cust.last_name);
    dbms_output.put_line('last_Name = '||cust.city);
    INSERT INTO CUSTOMER VALUES cust; -----Insert data using RECORD
    COMMIT;
    
END;
/
execute recd_2(10);
select * from customer;

--============================================================================== UPDATE data using RECORDS

CREATE OR REPLACE PROCEDURE recd_3(cust_id IN CUSTOMER.customer_id%type)
AS
c_rec3 customer%rowtype;
BEGIN
    select * into c_rec3 from customer where cust_id=customer_id;
    c_rec3.region :='S-W';
    cust3(c_rec3);
END;
/


CREATE OR REPLACE PROCEDURE cust3(cust IN CUSTOMER%rowtype)
AS
BEGIN
    UPDATE CUSTOMER SET ROW= cust WHERE customer_id = cust.customer_id;
END;
/
execute recd_3(11);
select * from customer;

--============================================================================== USER DEFINED data RECORD

CREATE OR REPLACE PROCEDURE rec4(cust_id IN CUSTOMER.customer_id%type)
AS

TYPE myrec IS RECORD ----- RECORD DECLARATION
(first_name varchar2(50),
last_name varchar2(50)
);

c_rec myrec;

BEGIN
    select first_name, last_name into c_rec from customer where cust_id=customer_id;
    dbms_output.put_line('first_Name = '||c_rec.first_name);
    dbms_output.put_line('last_Name = '||c_rec.last_name);
    
END;
/
execute rec4(12);

