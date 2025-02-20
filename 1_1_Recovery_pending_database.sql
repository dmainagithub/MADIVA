-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
--Solution Location: D:\APHRC\GoogleDrive_ii\data_science\madiva\DMAC\databases\tables\MADIVA

ALTER DATABASE madiva SET EMERGENCY
GO
ALTER DATABASE madiva SET single_user
GO
DBCC CHECKDB (madiva, REPAIR_ALLOW_DATA_LOSS) WITH ALL_ERRORMSGS
GO
ALTER DATABASE madiva SET multi_user
GO
--exec sp_who 
--KILL 55 
--drop database [madiva]

ALTER DATABASE ClinicLinkage SET EMERGENCY
GO
ALTER DATABASE ClinicLinkage SET single_user
GO
DBCC CHECKDB (ClinicLinkage, REPAIR_ALLOW_DATA_LOSS) WITH ALL_ERRORMSGS
GO
ALTER DATABASE ClinicLinkage SET multi_user
GO



--Other databases
ALTER DATABASE BabaDogo SET EMERGENCY
GO
ALTER DATABASE BabaDogo SET single_user
GO
DBCC CHECKDB (BabaDogo, REPAIR_ALLOW_DATA_LOSS) WITH ALL_ERRORMSGS
GO
ALTER DATABASE BabaDogo SET multi_user
GO
 
 
ALTER DATABASE KHC SET EMERGENCY
GO
ALTER DATABASE KHC SET single_user
GO
DBCC CHECKDB (KHC, REPAIR_ALLOW_DATA_LOSS) WITH ALL_ERRORMSGS
GO
ALTER DATABASE KHC SET multi_user
GO
 
ALTER DATABASE KochHC SET EMERGENCY
GO
ALTER DATABASE KochHC SET single_user
GO
DBCC CHECKDB (KochHC, REPAIR_ALLOW_DATA_LOSS) WITH ALL_ERRORMSGS
GO
ALTER DATABASE KochHC SET multi_user
GO
  
ALTER DATABASE LLHC SET EMERGENCY
GO
ALTER DATABASE LLHC SET single_user
GO
DBCC CHECKDB (LLHC, REPAIR_ALLOW_DATA_LOSS) WITH ALL_ERRORMSGS
GO
ALTER DATABASE LLHC SET multi_user
GO
 
  
ALTER DATABASE MHC SET EMERGENCY
GO
ALTER DATABASE MHC SET single_user
GO
DBCC CHECKDB (MHC, REPAIR_ALLOW_DATA_LOSS) WITH ALL_ERRORMSGS
GO
ALTER DATABASE MHC SET multi_user
GO


