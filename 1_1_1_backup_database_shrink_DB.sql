SELECT name, recovery_model_desc 
FROM sys.databases 
WHERE name = 'madiva';

ALTER DATABASE madiva SET RECOVERY SIMPLE;

DBCC SHRINKFILE (madiva_Log, 1024);  -- target size in MB


