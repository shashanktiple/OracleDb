CREATE OR REPLACE PACKAGE first_pack
AS
    PROCEDURE exc(c_id IN NUMBER);
    PROCEDURE exceptn(c_id IN NUMBER);
    PROCEDURE p(p_orderID IN number, c_out OUT NUMBER );
    PROCEDURE PROC_IN(p_id IN NUMBER, p_fname IN VARCHAR2,p_lname IN VARCHAR2);
    PROCEDURE PROC_OUT(p_id IN NUMBER, p_fname IN VARCHAR2, p_lname IN VARCHAR2, total_count OUT NUMBER);
    
    FUNCTION f_date(s_date sales.sales_date%type)
    RETURN NUMBER;
    FUNCTION ff(n1 IN NUMBER, n2 IN NUMBER)
    RETURN NUMBER;
    FUNCTION FUN(f_date IN date)
    RETURN NUMBER;
    FUNCTION funny(n1 IN NUMBER, n2 IN NUMBER)
    RETURN NUMBER;
END first_pack;