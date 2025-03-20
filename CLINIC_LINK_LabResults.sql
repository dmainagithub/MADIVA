--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--Name: Daniel Maina
--Date: 2025 March

DECLARE @SQL NVARCHAR(MAX) = ''

SELECT @SQL = @SQL + '
INSERT INTO madiva..LabResults
SELECT PatientId,HealthFacility,LabReportDate,LabTypeReport,NumericLabResults,NonNumericLabResults,LowerLimit,UpperLimit,LabResultsUnits,Note,DateEntered,EnteredBy,DateModified,ModifiedBy
 FROM [' + name + ']..LabResults 
WHERE PatientId IN (SELECT PatientId FROM [' + name + ']..Matches);'
FROM sys.databases
WHERE name IN ('LLHC', 'KHC', 'MHC', 'BabaDogo', 'KochHC')

PRINT @SQL  -- Debugging: View generated SQL
EXEC sp_executesql @SQL  -- Execute dynamically
