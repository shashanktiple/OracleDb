CREATE OR REPLACE PACKAGE BODY first_pack
AS

PROCEDURE exc(c_id IN NUMBER)
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
END exc; 

---------------------------------------------------------------------------------
PROCEDURE exceptn(c_id IN NUMBER)
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
END exceptn; 
---------------------------------------------------------------------------------
PROCEDURE p(p_orderID IN number, c_out OUT NUMBER )
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

---------------------------------------------------------------------------------
PROCEDURE PROC_IN
(
p_id IN NUMBER,  --cannot describe the length of the variable
p_fname IN VARCHAR2,
p_lname IN VARCHAR2
)
AS

BEGIN

    INSERT INTO customer(customer_id, first_name, last_name) 
        VALUES(p_id, p_fname, p_lname);

    COMMIT;
    dbms_output.put_line('date inserted successfully');

END PROC_IN;
---------------------------------------------------------------------------------
PROCEDURE PROC_INOUT
(
p_id IN OUT NUMBER,  --cannot describe the length of the variable
p_fname IN VARCHAR2,
p_lname IN VARCHAR2
)
AS

BEGIN

    INSERT INTO customer(customer_id, first_name, last_name) 
        VALUES(p_id, p_fname, p_lname);

    COMMIT;
    dbms_output.put_line('date inserted successfully');

    SELECT COUNT(1) INTO P_id FROM customer;

END PROC_INOUT;
---------------------------------------------------------------------------------
PROCEDURE PROC_OUT
(
p_id IN NUMBER,  --cannot describe the length of the variable
p_fname IN VARCHAR2,
p_lname IN VARCHAR2,
total_count OUT NUMBER

)
AS

BEGIN

    INSERT INTO customer(customer_id, first_name, last_name) 
        VALUES(p_id, p_fname, p_lname);

    COMMIT;
    dbms_output.put_line('date inserted successfully');

    SELECT COUNT(1) INTO total_count FROM customer;

END PROC_OUT;
---------------------------------------------------------------------------------
FUNCTION f_date(s_date sales.sales_date%type)
RETURN NUMBER
AS

ss NUMBER;
BEGIN
 SELECT COUNT(1) INTO ss FROM sales where sales_date = s_date;
 RETURN ss;

END f_date;
---------------------------------------------------------------------------------
FUNCTION ff(n1 IN NUMBER, n2 IN NUMBER)
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
---------------------------------------------------------------------------------
FUNCTION FUN(f_date IN date)
RETURN NUMBER
AS
num_sales NUMBER:=0; --declare variable

BEGIN
    SELECT COUNT(*) INTO num_sales FROM sales 
    WHERE sales_date = f_date;

    RETURN num_sales;

END FUN;
---------------------------------------------------------------------------------
FUNCTION funny(n1 IN NUMBER, n2 IN NUMBER)
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


END first_pack;