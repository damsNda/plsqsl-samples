CREATE OR REPLACE PROCEDURE dropTableSafe (tableToDrop IN VARCHAR2) IS
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE ' || tableToDrop;
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/
commit;

BEGIN
    dropTableSafe('EMPLOYEE_SALARY_HISTORY');
    dropTableSafe('EMPLOYEE');
    dropTableSafe('ORGANIZATION');
END;
/