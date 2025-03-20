--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--Name: Daniel Maina
--Date: 2025 March

DECLARE @SQL NVARCHAR(MAX) = ''

SELECT @SQL = @SQL + '
INSERT INTO madiva..clinic_link_individuals 
SELECT PatientId ,FileNO ,HealthFacility ,RegistrationDate ,Name ,OtherName ,Surname ,NationalID ,DoB ,YoB ,Age ,AgeUnits ,Sex ,PhoneNumber1 ,PhoneNumber2 ,HomeAddress ,MaritalStatus ,Occupation ,Employer ,WorkPhoneNumber ,NextOfKinName ,NextOfKinSurname ,NextOfKinRelationship ,NextOfKinPhoneNumber ,NextOfKinHomeAddress ,NotConsented ,CurrentVillageStartDate ,DateEntered ,EnteredBy ,DateModified ,ModifiedBy
 FROM [' + name + ']..Individuals 
WHERE PatientId IN (SELECT PatientId FROM [' + name + ']..Matches);'
FROM sys.databases
WHERE name IN ('LLHC', 'KHC', 'MHC', 'BabaDogo', 'KochHC')

PRINT @SQL  -- Debugging: View generated SQL
EXEC sp_executesql @SQL  -- Execute dynamically
