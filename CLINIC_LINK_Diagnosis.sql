--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--Name: Daniel Maina
--Date: 2025 March

DECLARE @SQL NVARCHAR(MAX) = ''

SELECT @SQL = @SQL + '
INSERT INTO madiva..Diagnoses
SELECT PatientId ,HealthFacility ,VisitDate ,Diagnoses ,DateEntered ,EnteredBy ,DateModified ,ModifiedBy
 FROM [' + name + ']..Diagnoses 
WHERE PatientId IN (SELECT PatientId FROM [' + name + ']..Matches);'
FROM sys.databases
WHERE name IN ('LLHC', 'KHC', 'MHC', 'BabaDogo', 'KochHC')

PRINT @SQL  -- Debugging: View generated SQL
EXEC sp_executesql @SQL  -- Execute dynamically
