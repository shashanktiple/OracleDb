CREATE TABLE OBJ(
    DEP_ID NUMBER,
    DEP_NAME VARCHAR2(30),
    DEP_TRAINER VARCHAR2(30));
    
INSERT INTO OBJ VALUES (1,'SHA','TIP');
INSERT INTO OBJ VALUES (2,'MON','LE');
INSERT INTO OBJ VALUES (3,'RST', 'DAND');

----------- VIEW---------------    
CREATE VIEW MYVIEW AS SELECT DEP_ID, DEP_NAME FROM OBJ  WHERE DEP_ID> 1;
SELECT * FROM MYVIEW;

SELECT DEP_ID FROM MYVIEW;
DROP VIEW MYVIEW;

------- SEQUENCE -------------
CREATE SEQUENCE SE 
START WITH 1
INCREMENT BY 1
MINVALUE 0
MAXVALUE 100
CYCLE;

INSERT INTO OBJ VALUES(SE.NEXTVAL, 'GAYA', 'ARM');
INSERT INTO OBJ VALUES(SE.NEXTVAL, 'RUC', 'DA');
INSERT INTO OBJ VALUES(SE.NEXTVAL, 'ABHI', 'RAT');
DROP TABLE OBJ;
SELECT * FROM OBJ;
DROP SEQUENCE SE;



------- INDEX -------------
CREATE INDEX IND ON OBJ (COL_NAME);
CREATE INDEX IND2 ON OBJ (COL_NAME, COL_NAME);
CREATE UNIQUE INDEX UIND ON OBJ (COL_NAME);

DROP INDEX INDEX_NAME;











