

-----=========================================================================== CLOB
CREATE table job_resume
(
resume_id number,
first_name varchar2(30),
last_name varchar2(30), --------------(store small files)
resume clob   ------------------------CLOB (stores bigger files)
);

insert into job_resume values(1, 'shashank','Tiple','Hello this is X calling 
from DePaul University Office of Student Accounts.  
I am reaching out to you today because you have a refund 
and we figured you do not have refund method setup in your CC, 
we have sent an email today at your depaul ID with the setps to 
how to set up the refund method in CC. I would recommend 
if you could follow the instructions so we can attempt the refund again.');

select * from job_resume;

select length(resume), dbms_lob.getlength(resume) from job_resume;-- use DBMS function for large files

select substr(resume,1,30),dbms_lob.substr(resume,30,1) from job_resume;

-----=========================================================================== BLOB ----ERROR COULDN'T form a directory

CREATE table job_resume1
(
resume_id number,
first_name varchar2(30),
last_name varchar2(30), 
profilepic blob  
);


create or replace directory mypic as '\Users\shashank\Documents';

--drop directory mypic;
--SELECT * FROM dba_directories WHERE directory_name = 'mypic';


declare
    src bfile := bfilename('mypic', '1.jpeg'); -------- COULDN'T form a directory
    dest blob;

BEGIN
    insert into job_resume1 values(1,'monu','tiple',empty_blob())
    returning profilepic into dest;
        
    DBMS_LOB.open(src,dbms_lob.lob_readonly);
    DBMS_LOB.LoadFromFile(dest, src, dbms_lob.getlength(src));
    DBMS_LOB.close(src);
    commit;
END;
/
-----=========================================================================== BFILE


CREATE table job_resume2
(
resume_id number,
first_name varchar2(30),
last_name varchar2(30), 
profilepic bfile  
);

insert into job_resume2 values(3, 'sha', 'tip',bfilename('mypic','1.jpeg'));


select * from job_resume2;









