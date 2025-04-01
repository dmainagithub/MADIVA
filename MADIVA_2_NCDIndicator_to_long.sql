--D:\DBs_Raw\madiva_with_long_tables.bak

DECLARE @sql NVARCHAR(MAX);
DECLARE @columns_casted NVARCHAR(MAX);
DECLARE @columns_unpivot NVARCHAR(MAX);

-- Generate column list for SELECT (with CAST)
SET @columns_casted = STUFF((  
    SELECT ', CAST(' + QUOTENAME(COLUMN_NAME) + ' AS NVARCHAR(MAX)) AS ' + QUOTENAME(COLUMN_NAME)  
    FROM INFORMATION_SCHEMA.COLUMNS  
    WHERE TABLE_NAME = 'madiva_NCDIndicators'  
    AND COLUMN_NAME NOT IN ('individual_id', 'obs_date', 'source')  
    FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, '');

-- Generate column list for UNPIVOT (without CAST)
SET @columns_unpivot = STUFF((  
    SELECT ', ' + QUOTENAME(COLUMN_NAME)  
    FROM INFORMATION_SCHEMA.COLUMNS  
    WHERE TABLE_NAME = 'madiva_NCDIndicators'  
    AND COLUMN_NAME NOT IN ('individual_id', 'obs_date', 'source')  
    FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, '');

-- Construct the dynamic SQL
SET @sql = '
SELECT individual_id, obs_date, source, Variable, Value
INTO madiva_NCDIndicators_long
FROM 
(
    SELECT individual_id, obs_date, source, ' + @columns_casted + '
    FROM madiva_NCDIndicators
) src
UNPIVOT (
    Value FOR Variable IN (' + @columns_unpivot + ')
) unpvt;';

-- Execute the dynamic SQL
EXEC sp_executesql @sql;
