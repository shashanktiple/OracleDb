create table cust 
(cust_id number primary key, 
    dept_name varchar(20) not null, 
    phone NUMBER(10) UNIQUE CHECK(length(phone)=10));
drop table cust;


create table ord (ord_id number primary key, stud_name varchar(20),cust_id number references cust);
drop table ord;


insert into cust values (1, 'tiple', 1234567890);
insert into cust values (2, 'modi',2738493827);
insert into cust values (3, 'shini',1234567893);

insert into ord values (5, 'pomade',2);
insert into ord values (6, 'beauty_product', 3);
insert into ord values (7, 'cream',1);
insert into ord values (8, 'sunscrn',3);

select * from cust full join ord on cust.cust_id = ord.cust_id;