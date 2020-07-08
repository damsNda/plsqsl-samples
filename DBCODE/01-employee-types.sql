CREATE OR REPLACE TYPE EmployeeType AS OBJECT 
(idEmployee INT,idOrganization INT,lastName varchar2(50),firstName VARCHAR2(50),salary NUMBER(10,2))
/ 

CREATE OR REPLACE TYPE EmployeeTblType IS TABLE OF EmployeeType
/ 
