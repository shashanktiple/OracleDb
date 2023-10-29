DECLARE

x constant number :=123; -- cannot be changed constant value
y number default 321;
cust varchar2(20):='Shashank';
d date:= '01-Jan-2022';
d2 date:= sysdate;

BEGIN

y := 000;
dbms_output.put_line('Date is '||d );
dbms_output.put_line('Date is '||d2 );
dbms_output.put_line('The number is '|| x ||'|'||y);
dbms_output.put_line('The name is ' || cust );
END;
/

--===========================================IF ELSE

DECLARE
total_amount number:=200;
discount number:=0;

BEGIN
    if (total_amount >=200)then
    
    discount:=total_amount * 0.2;
    
    elsif (total_amount >= 100 and total_amount <= 200)then
    
    discount:= total_amount*0.1;
        
    else 
    discount:= total_amount * 0.05;
    
    end if;
    dbms_output.put_line('Your discount is '||discount);
END;
/
--SET SERVEROUTPUT ON




--===========================================CASE
    

DECLARE
total_amount number:=200;
discount number:=0;

BEGIN
    CASE
    WHEN (total_amount >=200)then
    
    discount:=total_amount * 0.2;
    
    WHEN (total_amount >= 100 and total_amount <= 200)then
    
    discount:= total_amount*0.1;
        
    else 
    discount:= total_amount * 0.05;
    
    end CASE;
    dbms_output.put_line('Your discount is '||discount);
END;
/
    
--=========================================== WHILE LOOP

DECLARE

a number:= 10;

BEGIN

    WHILE a>=1
    LOOP
        dbms_output.put_line(a);
        a := a-1;
    END LOOP;
    
END;
/

--=========================================== FOR LOOP

DECLARE

a number:= 10;

BEGIN

    for  a in 10 ..20
    LOOP
        dbms_output.put_line(a);
        
    END LOOP;
    
END;
/
---------------------
DECLARE

a number:= 10;

BEGIN

    for  a in reverse 10 ..20
    LOOP
        dbms_output.put_line(a);
        
    END LOOP;
    
END;
/

--=========================================EXAMPLES
DECLARE 

Salary number:=520000;

BEGIN
    if (salary>100000)then
    dbms_output.put_line('GRADE a');
    
    elsif(salary>=50000 and salary<=100000)then
    dbms_output.put_line('GRADE b');
    
    elsif(salary>=25000 and salary<=50000) then
    dbms_output.put_line('GRADE c');
    
    else
    dbms_output.put_line('GRADE d');
    
    END if;
END;
/
--==============
DECLARE 

Salary number:=1000;

BEGIN
    CASE
    WHEN (salary>100000)then
    dbms_output.put_line('GRADE a');
    
    WHEN salary between 50000 and 100000 then
    dbms_output.put_line('GRADE b');
    
    WHEN salary between 25000 and 50000 then
    dbms_output.put_line('GRADE c');
    
    else
    dbms_output.put_line('GRADE d');
    
    END CASE;
END;
/
--===========

DECLARE

b number:=200;
BEGIN
    WHILE b<=300
    LOOP
    dbms_output.put_line(b);
    b:=b+1;
    END LOOP;
END;
/
--=========
DECLARE

b number;
BEGIN
    for  b in 200..300
    LOOP
    dbms_output.put_line(b);

    END LOOP;
END;
/
--=========
DECLARE 

v number:=3;
aa number:=300;
bb number;
BEGIN

    if v = 1 then
        while aa<=400
        LOOP
            dbms_output.put_line(aa);
            aa:= aa+1;
        END LOOP;
    dbms_output.put_line('---');
    
    elsif v=2 then
        for bb in 300 .. 400
        LOOP
            dbms_output.put_line(bb);
        END LOOP;
    dbms_output.put_line('---');   
        
    elsif v=3 then
        dbms_output.put_line('wrong option');
    
    end if;
    
end;
/









    
    
    