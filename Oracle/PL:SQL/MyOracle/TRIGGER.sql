CREATE TABLE AUDIT_TABLE ( TABLE_NAME VARCHAR2(100),   USERID VARCHAR2(100),   OPERATION_DATE DATE,   OPERATION VARCHAR2(100)); 
CREATE TABLE AUDIT_LOG( USERID VARCHAR2(100), OPERATION_DATE DATE, B_CUSTOMERID NUMBER, A_CUSTOMERID NUMBER, B_FIRSTNAME VARCHAR2(100), A_FIRSTNAME VARCHAR2(100));


-----=========================================================================== STATEMENT LEVEL TRIGGER

CREATE OR REPLACE TRIGGER Trig1 BEFORE UPDATE ON CUSTOMER  
DECLARE
    v_user varchar2(40);
BEGIN
    SELECT user into v_user from DUAL; ----- user who is performing the action.
    
    INSERT INTO AUDIT_TABLE(table_name, userid,operation_date, operation) 
    values ('customer', v_user, sysdate, 'before update operation - Trig1');
END;
/

SELECT * FROM AUDIT_TABLE;
SELECT * FROM CUSTOMER;

UPDATE customer set first_name ='Chick_Fil_e' where first_name='monu';

-----=========================================================================== STATEMENT LEVEL TRIGGER (more than 1 statement)

CREATE OR REPLACE TRIGGER Trig2 AFTER INSERT OR DELETE OR UPDATE on customer

DECLARE
    v_user varchar2(50);
BEGIN
    select user into v_user from dual;

    If INSERTING then   ---------- INSERTING/ UPDATING/ DELETING are keywords
        INSERT INTO AUDIT_TABLE(table_name, userid,operation_date, operation) 
        values ('customer', v_user, sysdate, 'Inserting values from customer- Trig2');
    ELSIF UPDATING then
        INSERT INTO AUDIT_TABLE(table_name, userid,operation_date, operation) 
        values ('customer', v_user, sysdate, 'Updating values in customer- Trig2');
    ElSIF DELETING then
        INSERT INTO AUDIT_TABLE(table_name, userid,operation_date, operation) 
        values ('customer', v_user, sysdate, 'Deleting values from customer- Trig2');
    END IF;
    
END;
/
SELECT * FROM AUDIT_TABLE;
SELECT * FROM CUSTOMER;

UPDATE customer set first_name = 'shake shack' where first_name='shashank';
delete from customer where first_name = 'OUT';

-----=========================================================================== ROW LEVEL TRIGGER

CREATE OR REPLACE TRIGGER Trig3 BEFORE UPDATE ON CUSTOMER  
FOR EACH ROW --this indicate row lvl trigger rest all is same 
DECLARE
    v_user varchar2(40);
BEGIN
    SELECT user into v_user from DUAL; ----- user who is performing the action.
    
    INSERT INTO AUDIT_TABLE(table_name, userid,operation_date, operation) 
    values ('customer', v_user, sysdate, 'row updated- Trig3');
END;
/
SELECT * FROM AUDIT_TABLE;
SELECT * FROM CUSTOMER;

UPDATE customer set address_line1='dharam peth' where first_name='1st';
UPDATE customer set city ='pune', address_line1='baner wakad', country='India',
        date_added =sysdate, region='West' where first_name='s';



-----=========================================================================== OLD and NEW Pseudo Records


CREATE OR REPLACE TRIGGER Trig4 AFTER UPDATE ON CUSTOMER  
FOR EACH ROW --this indicate row lvl trigger rest all is same 
DECLARE
    v_user varchar2(40);
BEGIN
    SELECT user into v_user from DUAL; ----- user who is performing the action.
    
    INSERT INTO AUDIT_LOG(userid, operation_date,b_customerid, 
                            a_customerid,b_firstname, a_firstname) 
    values (v_user, sysdate, :OLD.customer_id, :NEW.customer_id, 
                            :old.first_name, :NEW.first_name);
END;
/

select * from audit_log;
select * from customer;

update customer 
set customer_id = 50, first_name='shweta', last_name = 'Raut' 
where customer_id=29;

-----=========================================================================== ROW level TRIGGER  with WHEN condition 

----------------- ABOVE TRIGGERS AFFECT THE TABLE so USE ANOTHER TAB TO CARRY OUT THESE OPERARTIONS----------

CREATE OR REPLACE TRIGGER Trig5 AFTER UPDATE ON CUSTOMER  
FOR EACH ROW 
WHEN (OLD.REGION ='SOUTH') -----CONDITION ---

DECLARE
    v_user varchar2(40);
BEGIN
    SELECT user into v_user from DUAL; ----- user who is performing the action.
    
    INSERT INTO AUDIT_LOG(userid, operation_date,b_customerid, 
                            a_customerid,b_firstname, a_firstname) 
    values (v_user, sysdate, :OLD.customer_id, :NEW.customer_id, 
                            :old.first_name, :NEW.first_name);
END;
/

select * from audit_log;
select * from customer;

update customer 
set  middle_name='z'
where customer_id=35;

-----=========================================================================== OF condition

CREATE OR REPLACE TRIGGER Trig5 AFTER UPDATE 
OF customer_id -------------this is the condition syntax
ON CUSTOMER  
FOR EACH ROW 


DECLARE
    v_user varchar2(40);
BEGIN
    SELECT user into v_user from DUAL; ----- user who is performing the action.
    
    INSERT INTO AUDIT_LOG(userid, operation_date,b_customerid, 
                            a_customerid,b_firstname, a_firstname) 
    values (v_user, sysdate, :OLD.customer_id, :NEW.customer_id, 
                            :old.first_name, :NEW.first_name);
END;
/

select * from audit_log;
select * from customer;

update customer set last_name= 'gray' where first_name='shake shack';


-----=========================================================================== Disable/ Drop/ Rename 
/* 
Disable a Trigger 
ALTER TRIGGER <trigger_name> DISABLE; 

Enable a Trigger 
ALTER TRIGGER <trigger_name> ENABLE; 

Disable all the Triggers present on the table 
ALTER TABLE <table_name> DISABLE ALL TRIGGERS; 

Dropping a Trigger 
DROP TRIGGER <trigger_name>;

Renaming a Trigger name 
ALTER TRIGGER <old_trigger_name> RENAME TO <new_trigger_name>;
*/
