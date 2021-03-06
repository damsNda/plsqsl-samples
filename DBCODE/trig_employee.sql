/**
* Creation d une ligne d historique a chaque changement de salaire
*/
CREATE OR REPLACE TRIGGER employee_sal_history
AFTER UPDATE ON EMPLOYEE 
FOR EACH ROW 
WHEN (NEW.SALARY <> OLD.SALARY)
DECLARE

BEGIN
INSERT INTO EMPLOYEE_SALARY_HISTORY(PK_ID,FK_ID_EMPLOYEE,SALARY) VALUES(salary_history_seq.nextval,:NEW.PK_ID,:OLD.SALARY);
DBMS_OUTPUT.PUT_LINE('OLD SALAAAAARY' ||:OLD.SALARY);
END;
/