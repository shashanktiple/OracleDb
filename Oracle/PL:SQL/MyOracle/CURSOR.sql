SET SERVEROUTPUT ON


create or replace procedure cur(c_id IN customer.customer_id%type)
AS
TYPE c_rec IS RECORD
(c_fname varchar2(50),
c_lname varchar2(30)
);

c c_rec;
total_count number;

BEGIN
    SELECT first_name, last_name into c from customer where customer_id=c_id;
    
    if sql%found then
        total_count:=sql%rowcount;
        DBMS_OUTPUT.PUT_LINE (total_count||' rows affected');
    end if;
    
    DBMS_OUTPUT.PUT_LINE ('Name: '|| c.c_fname);
    DBMS_OUTPUT.PUT_LINE ('Name: '||  c.c_lname);
END;
/
execute cur(14);

select * from customer;
-----=========================================================================== EXPLISIT CURSOR

create or replace procedure cur2(cust_id IN customer.customer_id%type)
AS

c_id customer.customer_id%type;
c_name customer.first_name%type;
c_city customer.city%type;
c_region customer.region%type;

cursor c is select customer_id, first_name, city, region -- CURSOR DECLARATION
    from customer where customer_id = cust_id; 
    
BEGIN
    
OPEN c;
    fetch c  
        into c_id, c_name, c_city, c_region; 
    
    DBMS_OUTPUT.PUT_LINE ('ID: '|| c_id);
    DBMS_OUTPUT.PUT_LINE ('Name: '|| c_name);
    DBMS_OUTPUT.PUT_LINE ('city: '|| c_city);
    DBMS_OUTPUT.PUT_LINE ('region: '|| c_region);

close c;
END;
/
execute cur2(14);
-----=========================================================================== multiple rows cursor


create or replace procedure cur3(cust_id IN customer.customer_id%type)
AS

c_id customer.customer_id%type;
c_name customer.first_name%type;
c_city customer.city%type;
c_region customer.region%type;

cursor c is select customer_id, first_name, city, region -- CURSOR DECLARATION
    from customer where customer_id = cust_id; 
    
BEGIN
    
OPEN c;

LOOP
    fetch c  
        into c_id, c_name, c_city, c_region; 
    
    EXIT WHEN c%notfound;  ---------------------------exit when not found
    
    DBMS_OUTPUT.PUT_LINE ('ID: '|| c_id);
    DBMS_OUTPUT.PUT_LINE ('Name: '|| c_name);
    DBMS_OUTPUT.PUT_LINE ('city: '|| c_city);
    DBMS_OUTPUT.PUT_LINE ('region: '|| c_region);
END LOOP;
close c;
END;
/
execute cur3(55);
-----=========================================================================== records in cursor


create or replace procedure cur4(cust_id IN customer.customer_id%type)
AS

type c_rec is record
(c_id NUMBER,
c_name varchar2(40),
c_city varchar2(40),
c_region varchar2(40)
);

r c_rec;

cursor c1 is select customer_id, first_name, city, region -- CURSOR DECLARATION
    from customer where customer_id = cust_id; 

BEGIN
    
OPEN c1;

LOOP
    fetch c1  
        into r; 
    
    EXIT WHEN c1%notfound;  ---------------------------exit when not found
    
    DBMS_OUTPUT.PUT_LINE ('ID: '|| r.c_id);
    DBMS_OUTPUT.PUT_LINE ('Name: '|| r.c_name);
    DBMS_OUTPUT.PUT_LINE ('city: '|| r.c_city);
    DBMS_OUTPUT.PUT_LINE ('region: '|| r.c_region);
END LOOP;
close c1;
END;
/

execute cur4(55);

-----=========================================================================== same as above but using for loop
create or replace procedure cur5(cust_id IN customer.customer_id%type)
AS

BEGIN

for r1 in (select customer_id, first_name, city, region 
    from customer where customer_id = cust_id)
    LOOP
        DBMS_OUTPUT.PUT_LINE ('ID: '|| r1.customer_id);
        DBMS_OUTPUT.PUT_LINE ('Name: '|| r1.first_name);
        DBMS_OUTPUT.PUT_LINE ('city: '|| r1.city);
        DBMS_OUTPUT.PUT_LINE ('region: '|| r1.region);
        DBMS_OUTPUT.PUT_LINE ('------------');
    END LOOP;

END;
/

execute cur5(55);
-----=========================================================================== cursor variable ********* dosent work for similar rows


create or replace FUNCTION cur6(c_id IN NUMBER) -----its a function
    RETURN SYS_REFCURSOR
IS
    re_cur SYS_REFCURSOR;

BEGIN
    open re_cur for 
        select  first_name, last_name
        from customer where customer_id = c_id;
    return re_cur;
end cur6;


create or replace procedure pcur6    ------------------procedure
IS
p_cur SYS_REFCURSOR;
f_name varchar2(50);
l_name varchar2(50);

BEGIN
    p_cur:= cur6(11);
    
    Loop
    fetch p_cur into f_name, l_name; 
    exit when p_cur%notfound;
    DBMS_OUTPUT.PUT_LINE ('Name: '||f_name);
    DBMS_OUTPUT.PUT_LINE ('last: '||l_name);
    END LOOP;
    close p_cur;
    
END;
/

execute pcur6();

-----=========================================================================== EXERCISE
create or replace procedure exc(e_d DATE)
IS

e_date sales.sales_date%type;
e_order sales.order_id%type;
e_unitp sales.unit_price%type;

cursor e is select sales_date, order_id, unit_price from sales where e_d = sales_date;

BEGIN
    OPEN e;
        LOOP
        fetch e into e_date, e_order, e_unitp;
        EXIT WHEN e%notfound;
        DBMS_OUTPUT.PUT_LINE ('date: '||e_date);
        DBMS_OUTPUT.PUT_LINE ('orderNumber: '||e_order);
        DBMS_OUTPUT.PUT_LINE ('price: '||e_unitp);
        END LOOP;
    close e;
end;
/

execute exc(TO_DATE('01-JAN-2015','DD-MON-YYYY'));
select * from sales;
---============================

create or replace procedure exc2(e_d DATE)
IS
BEGIN
    for r in (select sales_date, order_id, unit_price from sales where e_d = sales_date)
        LOOP
        DBMS_OUTPUT.PUT_LINE ('date: '||r.sales_date);
        DBMS_OUTPUT.PUT_LINE ('orderNumber: '||r.order_id);
        DBMS_OUTPUT.PUT_LINE ('price: '||r.unit_price);
        END LOOP;
end;
/
execute exc(TO_DATE('01-JAN-2015','DD-MON-YYYY'));
---============================


create or replace procedure p1(p1_date IN sales.sales_date%type, p1_cur OUT SYS_REFCURSOR)
IS

BEGIN
    OPEN p1_cur for
        select sales_date, order_id, unit_price from sales where p1_date = sales_date;
    
    
END;


create or replace procedure p2(p2_date DATE)
AS
e_date sales.sales_date%type;
e_order sales.order_id%type;
e_unitp sales.unit_price%type;
p2_cur SYS_REFCURSOR;

BEGIN 
     p1(p2_date, p2_cur);
    
    Loop
    fetch p2_cur into e_date, e_order,e_unitp; 
    exit when p2_cur%notfound;
    DBMS_OUTPUT.PUT_LINE ('date: '||e_date);
    DBMS_OUTPUT.PUT_LINE ('order: '||e_order);
    DBMS_OUTPUT.PUT_LINE ('unitPrice: '||e_unitp);
    END LOOP;
    close p2_cur;
    
END;
/

execute p2(TO_DATE('01-feb-2015','DD-MON-YYYY'));














