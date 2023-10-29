SET SERVEROUTPUT ON


-----=========================================================================== ASSOCIATE TABLE
DECLARE
    type coll is table of varchar2(40) index by binary_integer;
    c coll;
    v number;
BEGIN
    c(1):='shashank';----------------INSERT IN TABLE
    c(2):='tiple';
    c(3):='monu';
    c(4):='sonu';
    c(8):='shanky';
    
    c.delete(3);  ---------------------DELETE method
    v:= c.first; ----------------FIRST ELEMENT
    
    while v is not null
    Loop
        DBMS_OUTPUT.PUT_LINE ('--'||c(v));
        v:= c.next(v);  --------------------------------NEXT method
    end loop;
    
END;
/
-----=========================================================================== NESTED TABLE

DECLARE
    type nest_coll is table of varchar2(50);
    cc nest_coll:= nest_coll();   -----------------INITIALIZE THE COLLECTION
    vv number;

BEGIN
    cc.extend(5); ----------------- ALLOCATE SIZE OF TABLE
    
    cc(1):='shashank';----------------INSERT IN TABLE
    cc(2):='tiple';
    cc(3):='monu';
    cc(4):='sonu';
  --cc(8):='shanky'; --------- THROWS ERROR
    cc(5):='shanky'; --------- INSEERT DATA IN SEQUENCE
    
    cc.delete(3);
    DBMS_OUTPUT.PUT_LINE ('first element '||cc(cc.first));
    DBMS_OUTPUT.PUT_LINE ('last element '||cc(cc.last));
    DBMS_OUTPUT.PUT_LINE ('---------');
    
    vv:= cc.first;
    while vv is not null
    loop
        DBMS_OUTPUT.PUT_LINE ('last element: '||cc(vv));
        vv:= cc.next(vv);
    end loop;

END;
/

-----=========================================================================== VARRAY

DECLARE
    type arr_coll is VARRAY(5) of varchar2(50); -- SPECIFY UPPER BOUND-- only 5 elements can be stored
    ccc arr_coll:= arr_coll();   -----------------INITIALIZE THE COLLECTION
    vvv number;

BEGIN
    ccc.extend(5); ----------------- ALLOCATE SIZE OF TABLE
    
    ccc(1):='shashank';----------------INSERT IN TABLE
    ccc(2):='tiple';
    ccc(3):='monu';
    ccc(4):='sonu';
  --ccc(8):='shanky'; --------- THROWS ERROR
    ccc(5):='shanky'; --------- INSEERT DATA IN SEQUENCE
    
    --ccc.delete(3); -------- CANNOT DELETE IN VARRAY
    
    DBMS_OUTPUT.PUT_LINE ('first element '||ccc(ccc.first));
    DBMS_OUTPUT.PUT_LINE ('last element '||ccc(ccc.last));
    DBMS_OUTPUT.PUT_LINE ('limit '||ccc.limit);
    DBMS_OUTPUT.PUT_LINE ('---------');
    
    vvv:= ccc.first;
    while vvv is not null
    loop
        DBMS_OUTPUT.PUT_LINE ('last element: '||ccc(vvv));
        vvv:= ccc.next(vvv);
    end loop;

END;
/
-----=========================================================================== MULTISET OPERATOR------ (NESTED TABLE)

DECLARE
    type mul_set is table of NUMBER;
    ms1 mul_set := mul_set(1,2,3,4,5,6);
    ms2 mul_set := mul_set(5,6,7,8,9,10);
    
    
BEGIN

    --ms1:= ms1 MULTISET UNION ms2;  -------------------------- MULTISET UNION (merge all values)
    --ms1:= ms1 MULTISET UNION DISTINCT ms2; ------------------ MULTISET UNION DISTINCT (merge distinct values)
    --ms1:= ms1 MULTISET EXCEPT ms2;  ------------------------- MULTISET EXCEPT (exclude right table values including common values)
    ms1:= ms1 MULTISET INTERSECT ms2; ----------------------- MULTISET INTERSECT (only common values)
    
    for i in ms1.first..ms1.last LOOP
        DBMS_OUTPUT.PUT_LINE('--'||ms1(i));
    end loop;
end;
/
        
-----=================================










