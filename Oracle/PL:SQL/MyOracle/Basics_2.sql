SET SERVEROUTPUT ON
SELECT first_name, last_name INTO tt FROM customer WHERE first_name ='JOHN';

INSERT INTO tt SELECT first_name, last_name FROM customer where first_name ='JOHN';

----=======================================================

DECLARE

c_name varchar2(30);
c_last varchar2(30);

BEGIN

SELECT first_name, last_name into c_name, c_last from customer where first_name='JOHN';
dbms_output.put_line('-----'||c_name||' '||c_last);
END;
/

---==================

DECLARE

c_name customer.first_name%Type;
c_last customer.last_name%Type;

BEGIN

SELECT first_name, last_name into c_name, c_last from customer where first_name='JOHN';
dbms_output.put_line('-----'||c_name||' '||c_last);
END;
/

----=======================================================

DECLARE

c_id customer.customer_id%type:=14;
c_fname customer.first_name%type:='monu';
c_lname customer.last_name%type:='tiple';
c_mname customer.middle_name%type:='s';
c_addr1 customer.address_line1%type:='bhiwapur ward';
c_addr2 customer.address_line2%type:='vaishali nagar';
c_city customer.city%type:='chandrapur';
c_country customer.country%type:='India';
c_date customer.date_added%type:=sysdate;
c_region customer.region%type:='East';

BEGIN

insert into customer(customer_id, first_name, last_name, middle_name, 
address_line1, address_line2, city, country,date_added, region) 
values(c_id, c_fname,c_lname, c_mname,c_addr1, c_addr2,c_city,c_country,c_date, c_region);
COMMIT;
END;
/
select * from customer;

update customer set customer_id =13 where customer_id = 99;
delete from customer where customer_id= 99;


----==============================================------ EXERCISE
DECLARE

s_date sales.sales_date%type;
s_order sales.order_id%type:= 1269;
s_product sales.product_id%type;
s_customer sales.customer_id%type;
s_salesperson sales.salesperson_id%type;
s_quantity sales.quantity%type;
s_unit_price sales.unit_price%type;
s_sales_amount sales.sales_amount%type;
s_tax_amount sales.tax_amount%type;
s_total_amount sales.total_amount%type;

BEGIN

select  sales_date, order_id, product_id, customer_id,salesperson_id,quantity,
unit_price,sales_amount,tax_amount,total_amount
into s_date, s_order, s_product, s_customer ,s_salesperson, s_quantity,
s_unit_price,s_sales_amount,s_tax_amount, s_total_amount 
from sales where order_id = s_order;

dbms_output.put_line(s_date);
dbms_output.put_line(s_order);
dbms_output.put_line(s_product);
dbms_output.put_line(s_customer);
dbms_output.put_line(s_salesperson);
dbms_output.put_line(s_quantity);
dbms_output.put_line(s_unit_price);
dbms_output.put_line(s_sales_amount);
dbms_output.put_line(s_tax_amount);
dbms_output.put_line(s_total_amount);

END;
/
-------------






