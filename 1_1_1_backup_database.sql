--Run this command on Command Prompt to backup the database
sqlcmd -S "APHRC-52-25\MSSQL_2022" -E -Q "BACKUP DATABASE [madiva] TO DISK='D:\DB_backups\madiva_22_oct_2025.bak' WITH COMPRESSION, INIT, STATS=10"



BACKUP DATABASE madiva
TO DISK = N'D:\DB_backups\madiva_22_oct_2025.bak'
WITH COMPRESSION, INIT, STATS = 10;
