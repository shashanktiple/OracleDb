
-----=========================================================================== OBJECT CREATION
CREATE TYPE table_col AS OBJECT 
(
s_date date,
s_order_id number,
s_customerID number,
s_procedureID number,
s_totalAMount number
)
-----=========================================================================== USING OBJECT 

CREATE TYPE table1 is table of table_col; ------ NESTED TABLE (collections)

-----=========================================================================== USING both the above features in the example

CREATE OR REPLACE FUNCTION fetch_table1(ord_id NUMBER)
RETURN table1
IS
    t1 table1 := table1(); ----- iinitiate the table

BEGIN
    for c IN (select sales_date, order_id,customer_id, product_id,total_amount 
                from sales where order_id = ord_id)
    loop
        t1.extend;
        t1(t1.last) := table_col(c.sales_date, c.order_id,c.customer_id,
                    c.product_id, c.total_amount);
                                    
    end loop;
    
    return t1;
END;
/

select * from (fetch_table1(1267));

-----=========================================================================== PIPELINE Function


CREATE OR REPLACE FUNCTION table2(ord_id NUMBER)
RETURN table1
PIPELINED ----initiate

IS

BEGIN
    for c IN (select sales_date, order_id,customer_id, product_id,total_amount 
                from sales where order_id = ord_id)
    loop
        
       pipe row (table_col(c.sales_date, c.order_id,c.customer_id, ------pipe
                    c.product_id, c.total_amount));
                                    
    end loop;
END;
/

select * from (table2(1267));




