--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--Name: Daniel Maina
--Date: 2025 March

DECLARE @SQL NVARCHAR(MAX) = ''

SELECT @SQL = @SQL + '
INSERT INTO madiva..DataProfile
SELECT HealthFacility ,PatientId ,RegistrationDate ,DOB ,YoB ,Sex ,NationalId ,PhoneNumber1 ,PhoneNumber2 ,ADSSID ,MatchCriteria ,Score ,Village ,NameComplete ,SurnameComplete ,DoBComplete   ,GenderComplete ,PhoneNumber1Complete ,PhoneNumber2Complete ,NationalIDComplete   ,HomeAddressComplete ,NextOfKinNameComplete ,NextOfKinSurnameComplete ,Consented ,Refused ,NotAsked ,MissingConsentInfo ,HasClinicalVisits ,MatchFound ,NoOfVisits ,FirstVisitDate ,LastVisitDate FROM [' + name + ']..DataProfile 
WHERE PatientId IN (SELECT PatientId FROM [' + name + ']..Matches);'
FROM sys.databases
WHERE name IN ('LLHC', 'KHC', 'MHC', 'BabaDogo', 'KochHC')

PRINT @SQL  -- Debugging: View generated SQL
EXEC sp_executesql @SQL  -- Execute dynamically
