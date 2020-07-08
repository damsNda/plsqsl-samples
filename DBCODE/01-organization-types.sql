CREATE OR REPLACE TYPE orgaRecordType AS OBJECT 
(idOrganization INT,label varchar2(50),payroll NUMBER(10,2))
/ 

CREATE OR REPLACE TYPE orgaRecordTblType IS TABLE OF orgaRecordType
/ 
