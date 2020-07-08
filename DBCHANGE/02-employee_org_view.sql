CREATE OR REPLACE VIEW Employee_organization
AS SELECT 
emp.pk_id as employeeId,
emp.last_name as employeeLastName,
emp.first_name as employeeFirstName,
emp.salary as employeeSalary,
org.pk_id as orgId,
org.label as orgLabel
FROM Employee emp
INNER JOIN organization org on org.pk_id=emp.fk_id_organization;