execute first_pack.exc(12);
execute first_pack.exceptn(12);
--execute first_pack.p(1269, c NUMBER); ----- ERROR
execute first_pack.PROC_IN(29,'s','a');
--execute first_pack.PROC_INOUT(idd,'OUT', 'procedure');----- ERROR
--execute first_pack.PROC_OUT(24,'OUT', 'procedure',tcount);----- ERROR

-----functions
select first_pack.FUN(to_date('1-jan-2015','dd-mon-yyyy')) from dual;
select first_pack.ff(10,3) from dual;
select first_pack.funny(10,3) from dual;
select first_pack.f_date(to_date('01-JAN-2015','DD-MON-YYYY')) from dual;