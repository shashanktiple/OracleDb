SET SERVEROUTPUT ON


---------------------------******************* NEED MORE WORK DID NOT UNDERSTAND ******************-----------------------------




SELECT * from x;


BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE X(A NUMBER)';
END;

--============================================================================== EXECUTE IMMEDIATE (NATIVE DYNAMIC SQL)
CREATE OR REPLACE PROCEDURE pp(cust_id IN NUMBER)
AS

BEGIN 
    EXECUTE IMMEDIATE 'UPDATE SALES set total_amount= total_amount * .9
                        where customer_id='||cust_id;
    
    COMMIT;
END;
/
select * from sales;

exec pp(11);


--============================================================================== ERROR in this example

CREATE OR REPLACE PROCEDURE p2(ord_id in number,cust_id in number)
AS

var varchar2(500):= 'sales_date, order_id, product_id, customer_id, 
    salesperson_id,quantity, unit_price,sales_amount, tax_amount, total_amount 
    from sales where 1=1';
    
v_rec sales%rowtype;

BEGIN

    if ord_id is not null then
        var:= var ||' and order_id: '||ord_id;
    end if;
    
    if cust_id is not null then
        var:= var ||' and customer_id: '||cust_id;
    end if;

    DBMS_OUTPUT.PUT_LINE(var);

    EXECUTE IMMEDIATE var into v_rec; ---- this statement is not getting executed----********
    
    DBMS_OUTPUT.PUT_LINE(v_rec.sales_date);
    DBMS_OUTPUT.PUT_LINE(v_rec.order_id);
    DBMS_OUTPUT.PUT_LINE(v_rec.product_id);
    DBMS_OUTPUT.PUT_LINE(v_rec.customer_id);
    DBMS_OUTPUT.PUT_LINE(v_rec.salesperson_id);
    DBMS_OUTPUT.PUT_LINE(v_rec.quantity);
    DBMS_OUTPUT.PUT_LINE(v_rec.unit_price);
    DBMS_OUTPUT.PUT_LINE(v_rec.sales_amount);
    DBMS_OUTPUT.PUT_LINE(v_rec.tax_amount);
    DBMS_OUTPUT.PUT_LINE(v_rec.total_amount);
    DBMS_OUTPUT.PUT_LINE('------------');

EXCEPTION 
    WHEN no_data_found THEN 
    dbms_output.put_line('No such customer!'); 
    WHEN TOO_MANY_ROWS THEN
    dbms_output.put_line('many entries found'); 
    WHEN others THEN 
    dbms_output.put_line('other Error!'); 
END; 
/

exec p2(null,11);
select * from sales;




