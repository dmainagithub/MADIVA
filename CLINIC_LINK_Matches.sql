--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--Name: Daniel Maina
--Date: 2025 March

DECLARE @SQL NVARCHAR(MAX) = ''
DECLARE @DBName NVARCHAR(128)
DECLARE @TargetDB NVARCHAR(128) = 'madiva' -- Change this to your destination database

-- List of source databases
DECLARE SourceDBs CURSOR FOR
SELECT name FROM sys.databases 
WHERE name IN ('LLHC', 'KHC', 'MHC', 'KochHC', 'BabaDogo') -- Add your source database names here

OPEN SourceDBs
FETCH NEXT FROM SourceDBs INTO @DBName

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Construct dynamic SQL for each database
    SET @SQL = '
    WITH RankedMatches AS (
        SELECT *, 
               ROW_NUMBER() OVER (PARTITION BY ADSSID ORDER BY MatchedDate DESC) AS rn
        FROM [' + @DBName + ']..Matches
    )
    INSERT INTO [' + @TargetDB + ']..Matches -- Adjust table name in the destination DB
    SELECT HealthFacility, 
           PatientId, 
           ADSSID, 
           MatchCriteria, 
           Score, 
           MatchOnRealTime, 
           MatchedDate, 
           MatchedBy, 
           DateModified, 
           ModifiedBy
    FROM RankedMatches
    WHERE rn = 1;'

    PRINT @SQL -- Debugging: View the generated SQL before execution
    EXEC sp_executesql @SQL -- Execute the dynamic SQL

    FETCH NEXT FROM SourceDBs INTO @DBName
END

-- Cleanup cursor
CLOSE SourceDBs
DEALLOCATE SourceDBs
