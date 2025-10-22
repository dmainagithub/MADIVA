-- 0.1: List files & sizes (size is in MB)
USE [master];
GO
SELECT DB_NAME(database_id) AS dbname, name AS logical_name,
       physical_name,
       size/128.0 AS size_mb,
       type_desc
FROM sys.master_files
WHERE DB_NAME(database_id) = 'madiva';

-- 0.2: Recovery model
SELECT name, recovery_model_desc
FROM sys.databases
WHERE name = 'madiva';

-- 0.3: Database general usage
USE [madiva];
GO
EXEC sp_spaceused;        -- shows database size and unallocated space

-- 0.4: Log usage percent for all DBs
DBCC SQLPERF(LOGSPACE);
