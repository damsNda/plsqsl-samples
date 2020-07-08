/**
* Organization management package
*/
CREATE OR REPLACE PACKAGE organizationPackage AUTHID DEFINER IS 
    /*
    * Retrieve the list of organizations
    **/
    FUNCTION findOrganizations RETURN orgaRecordTblType;
    /*
    * Create an organization
    */
    PROCEDURE createOrganization(orgaId IN INT, label IN VARCHAR2);
    /*
    *Update organization
    */
    PROCEDURE updateOrganization(orgaId IN INT,labelNewValue IN VARCHAR2);
    PROCEDURE deleteOrganization(orgaId IN INT) ;
END organizationPackage;
/

CREATE OR REPLACE PACKAGE BODY organizationPackage IS 
    
        FUNCTION findOrganizations RETURN orgaRecordTblType IS
            organizations orgaRecordTblType:=orgaRecordTblType();
            CURSOR organizations_cursors IS SELECT PK_ID, LABEL,payroll FROM ORGANIZATION;
            org_id ORGANIZATION.PK_ID%type; 
            label ORGANIZATION.LABEL%type; 
            payroll  ORGANIZATION.PAYROLL%type; 
            i INT:=1;
        BEGIN
            OPEN  organizations_cursors ;
            LOOP
              FETCH organizations_cursors into org_id, label, payroll; 
              EXIT WHEN organizations_cursors%notfound; 
                organizations.extend();
                organizations(i):=orgaRecordType(org_id,label,payroll);    
                i:=i+1;
            END LOOP; 
            CLOSE organizations_cursors;  
            RETURN organizations;
        END findOrganizations;
        
        PROCEDURE createOrganization(orgaId IN INT, label IN VARCHAR2) IS
        BEGIN
            INSERT INTO organization(PK_ID,label) VALUES(orgaId,label);
        END createOrganization;
        
        PROCEDURE updateOrganization(orgaId IN INT,labelNewValue IN VARCHAR2) IS
        BEGIN
            UPDATE organization SET label=labelNewValue where PK_ID=orgaId;
        END updateOrganization;
        
        PROCEDURE deleteOrganization(orgaId IN INT) IS
        BEGIN
            DELETE FROM organization where PK_ID=orgaId;
        END deleteOrganization;
        
END organizationPackage; 
/
commit;