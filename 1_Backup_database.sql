-- ==========================================================
-- FULL BACKUP OF madiva DATABASE
-- ==========================================================

DECLARE @BackupPath NVARCHAR(500) = N'D:\DB_backups\';   -- Change this path
DECLARE @DatabaseName NVARCHAR(100) = N'madiva';
DECLARE @BackupFile NVARCHAR(500);

-- Create filename with timestamp
SET @BackupFile = @BackupPath + @DatabaseName + '_FULL_' 
    + REPLACE(CONVERT(VARCHAR(19), GETDATE(), 120), ':', '-') + '.bak';

PRINT 'Starting FULL backup of ' + @DatabaseName + ' to: ' + @BackupFile;

BACKUP DATABASE [madiva]
TO DISK = @BackupFile
WITH 
    FORMAT,                    -- Overwrite existing media header
    INIT,                      -- Overwrite the file if exists
    NAME = N'Madiva-Full Backup',
    COMPRESSION,               -- Compress the backup
    STATS = 10;                -- Report every 10% progress

PRINT 'FULL backup completed successfully at ' + CONVERT(VARCHAR, GETDATE(), 120);
GO
