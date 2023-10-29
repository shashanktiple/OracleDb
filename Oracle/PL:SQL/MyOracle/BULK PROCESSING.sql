SET SERVEROUTPUT ON


CREATE OR REPLACE PROCEDURE  update_tax(tax_rate In NUMBER)
AS

type asso_arry is table of sales.order_id%type index by pls_integer;
arr asso_arry;


BEGIN
    SELECT DISTINCT order_id bulk collect into arr from sales; --BULK COLLECT is a keyword
    
     DBMS_OUTPUT.PUT_LINE ('total ids found'|| arr.count);
    
    FORALL indx in 1.. arr.count ------------------------------------ FORALL is a keyword
        update sales s set s.tax_amount = s.total_amount * tax_rate
        where s.order_id = arr(indx);
END;
/

execute update_tax(.02);
select * from sales;

-----=========================================================================== MORE EXAMPLE

CREATE OR REPLACE PROCEDURE  update_tax2(tax_rate In NUMBER)
AS

type asso_arry is table of sales.order_id%type index by pls_integer;
arr1 asso_arry;
arr2 asso_arry;
b boolean;

BEGIN
    SELECT DISTINCT order_id bulk collect into arr1 from sales; 

    
    FOR indx in 1.. arr1.count
    LOOP
        check_eligible(arr1(indx), b);---------- check procedure
        if b then
            arr2(arr2.count+1):= arr1(indx);
        end if;
    END LOOP;
    
    FORALL indx in 1..arr2.count
        update sales s set s.tax_amount = s.total_amount * tax_rate
        where s.order_id = arr2(indx);
        
    COMMIT;
    
END;
/
--=====================

create or replace PROCEDURE check_eligible(val NUMBER, bool_val OUT BOOLEAN)
IS

i NUMBER;

BEGIN
SELECT SUM(total_amount)into i from sales where order_id = val;
if i>=1000 then
    bool_val :=TRUE;
END IF;

END;
/

exec update_tax2(.50);
select * from sales;

-----=========================================================================== BULK LIMIT and CURSOR



CREATE OR REPLACE PROCEDURE  update_tax3(tax_rate In NUMBER)
AS

type asso_arry is table of sales.order_id%type index by pls_integer;
arr1 asso_arry;
arr2 asso_arry;
b boolean;

cursor c_cursor is select distinct order_id from sales;

BEGIN

Open c_cursor;
    LOOP
        FETCH c_cursor bulk collect into arr1 LIMIT 100; -----------BULK LIMIT 
    
        FOR indx in 1.. arr1.count
            LOOP
            check_eligible(arr1(indx), b);----------refer check procedure from the above code
            if b then
                arr2(arr2.count+1):= arr1(indx);
            end if;
        END LOOP;
    EXIT when arr1.count = 0;
    
    END LOOP;
 
    FORALL indx in 1..arr2.count
        update sales s set s.tax_amount = s.total_amount * tax_rate
        where s.order_id = arr2(indx);
        
    COMMIT;
    
CLOSE c_cursor;

END;
/

exec update_tax3(1);

-----=========================================================================== BULK COLLECT with ROWTYPE(record)
CREATE OR REPLACE PROCEDURE BR(br_date date)
IS

cursor cd is select sales_date, order_id, product_id, customer_id, -------- cursot
    salesperson_id,quantity, unit_price,sales_amount, tax_amount, total_amount 
    from sales where sales_date = br_date;

type row_copy is table of sales%rowtype; --------- collection
rc row_copy;

BEGIN
    OPEN cd;
    
    loop 
        fetch cd bulk collect into rc limit 100;
        
        for i in 1..rc.count
        loop
            DBMS_OUTPUT.PUT_LINE(rc(i).sales_date);
            DBMS_OUTPUT.PUT_LINE(rc(i).order_id);
            DBMS_OUTPUT.PUT_LINE(rc(i).product_id);
            DBMS_OUTPUT.PUT_LINE(rc(i).customer_id);
            DBMS_OUTPUT.PUT_LINE(rc(i).salesperson_id);
            DBMS_OUTPUT.PUT_LINE(rc(i).quantity);
            DBMS_OUTPUT.PUT_LINE(rc(i).unit_price);
            DBMS_OUTPUT.PUT_LINE(rc(i).sales_amount);
            DBMS_OUTPUT.PUT_LINE(rc(i).tax_amount);
            DBMS_OUTPUT.PUT_LINE(rc(i).total_amount);
            DBMS_OUTPUT.PUT_LINE('------------');
        end Loop;
    
    Exit when cd%notfound;
    end loop;
    
    close cd;
END;
/
 exec br(to_date('01-jan-2015','dd-mm-yy'));
    







