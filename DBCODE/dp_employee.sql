/**
* Employee management package
*/
CREATE OR REPLACE PACKAGE employeePackage AUTHID DEFINER IS 
    /*
    * Retrieve the list of employee by organization
    **/
    FUNCTION findEmployeeByOrg(idOrganization IN INT) RETURN EmployeeTblType;
    /*
    * Create an employee
    */
    PROCEDURE createEmployee(idEmployee IN INT,idOrganization IN INT,lastName IN VARCHAR2, firstName IN VARCHAR2, salary IN NUMBER);
    /*
    *Update employee
    */
    PROCEDURE updateEmployee(idEmployee IN INT,lastName IN VARCHAR2, firstName IN VARCHAR2, sal IN NUMBER);
    PROCEDURE deleteEmployee(idEmployee IN INT) ;

END employeePackage;
/
CREATE OR REPLACE PACKAGE BODY employeePackage IS 
    
    FUNCTION findEmployeeByOrg(idOrganization IN INT) RETURN EmployeeTblType IS
    employees EmployeeTblType :=EmployeeTblType();
    CURSOR employees_cursor IS SELECT PK_ID, FK_ID_ORGANIZATION,LAST_NAME,FIRST_NAME,SALARY FROM EMPLOYEE WHERE FK_ID_ORGANIZATION=idOrganization;
    idEmployee EMPLOYEE.PK_ID%type;
    lastName EMPLOYEE.LAST_NAME%type;
    firstName EMPLOYEE.FIRST_NAME%type;
    salary  EMPLOYEE.SALARY%type;
    idOrg EMPLOYEE.FK_ID_ORGANIZATION%type;
    i INT:=1;
    BEGIN
         OPEN  employees_cursor ;
            LOOP
              FETCH employees_cursor into idEmployee,idOrg ,lastName, firstName,salary; 
              EXIT WHEN employees_cursor%notfound; 
                employees.extend();
                employees(i):=EmployeeType(idEmployee,idOrg,lastName,firstName,salary);    
                i:=i+1;
            END LOOP; 
            CLOSE employees_cursor;  
            RETURN employees;
    END findEmployeeByOrg;
    
    
    PROCEDURE createEmployee(idEmployee IN INT,idOrganization IN INT,lastName IN VARCHAR2, firstName IN VARCHAR2, salary IN NUMBER) IS 
    BEGIN
        INSERT INTO EMPLOYEE(PK_ID,FK_ID_ORGANIZATION,LAST_NAME,FIRST_NAME,SALARY) VALUES(idEmployee,idOrganization,lastName,firstName,salary);
    END createEmployee;
    
    PROCEDURE updateEmployee(idEmployee IN INT ,lastName IN VARCHAR2, firstName IN VARCHAR2, sal IN NUMBER) IS 
    BEGIN
        UPDATE EMPLOYEE emp SET emp.LAST_NAME=lastName, emp.FIRST_NAME=firstName, emp.SALARY=sal where PK_ID=idemployee;
    END updateEmployee;
    
    PROCEDURE deleteEmployee(idEmployee IN INT) IS 
    BEGIN
        DELETE FROM EMPLOYEE where PK_ID=idEmployee;
    END deleteEmployee;
    
END employeePackage;
/