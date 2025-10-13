USE [madiva];
GO

--------------------------------------------------------
-- 1️⃣  PREP — Ensure compatible structure
--------------------------------------------------------
IF EXISTS (
    SELECT 1 
    FROM sys.columns 
    WHERE object_id = OBJECT_ID('madiva_individual_events') 
      AND name = 'individual_id' 
      AND system_type_id <> 167
)
BEGIN
    PRINT 'Altering madiva_individual_events.individual_id to VARCHAR(50)...';
    ALTER TABLE madiva_individual_events ALTER COLUMN individual_id VARCHAR(50);
END
GO


--------------------------------------------------------
-- 2️⃣  DELETE existing rows in manageable chunks
--------------------------------------------------------
PRINT 'Deleting existing records from madiva_individual_events...';
SET NOCOUNT ON;

DECLARE @DeletedRows INT = 1;
WHILE @DeletedRows > 0
BEGIN
    DELETE TOP (20000) FROM madiva_individual_events;
    SET @DeletedRows = @@ROWCOUNT;
    PRINT CONCAT('Deleted ', @DeletedRows, ' rows...');
    CHECKPOINT;
END
GO

PRINT '✅ Deletion complete.';
GO


--------------------------------------------------------
-- 3️⃣  PREPARE TEMPORARY DATASET
--------------------------------------------------------
PRINT 'Creating temporary dataset for batched insert...';

IF OBJECT_ID('tempdb..#CombinedData') IS NOT NULL DROP TABLE #CombinedData;

SELECT 
    CAST(r.[PK] AS NVARCHAR(49)) + '1' AS record_id,
    'NAIROBI' AS hdss_name,
    ind.individual_guid AS individual_id,
    CASE 
        WHEN r.res_event = 2 THEN 'BTH'
        WHEN r.res_event = 1 THEN 'ENU'
        WHEN r.res_event = 3 THEN 'OMG'
        WHEN r.res_event = 4 THEN 'IMG'
        WHEN r.res_event = 5 THEN 'EXT'
        WHEN r.res_event = 6 THEN 'ENT'
        WHEN r.res_event = 7 THEN 'DTH'
        WHEN r.res_event = 9 THEN 'OBE'
        WHEN r.res_event = 10 THEN 'COV'
        WHEN r.res_event IN (-2, -1, 10) THEN 'OTH'
    END AS event_code,
    DATEADD(DAY, r.res_eventdate, '1960-01-01') AS event_date,
    CASE WHEN r.res_datebeg IS NOT NULL THEN '0' END AS event_date_estimated,
    DATEADD(DAY, r.res_datebeg, '1960-01-01') AS obs_date,
    r.res_locationid AS location_id,
    ROW_NUMBER() OVER (PARTITION BY r.res_individualid ORDER BY r.res_eventdate) AS rno
INTO #CombinedData
FROM madiva..allDSSpopulation_cal_age_cov_char r
LEFT JOIN [dbo].[individual_characteristics_anon_X_2018] ind 
    ON ind.indid = r.res_individualid
WHERE r.res_individualid <> '';

CREATE CLUSTERED INDEX IX_temp_combined ON #CombinedData(record_id);
PRINT '✅ Temporary dataset created.';
GO


--------------------------------------------------------
-- 4️⃣  BATCHED INSERT (Timeout-Resilient, Duplicate-Safe, Resumable)
--------------------------------------------------------
PRINT 'Starting batched insert into madiva_individual_events...';
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

DECLARE @BatchSize INT = 50000;   -- larger batch to improve throughput
DECLARE @Inserted INT = (SELECT COUNT(*) FROM madiva_individual_events);
DECLARE @Total INT = (SELECT COUNT(*) FROM #CombinedData);
DECLARE @BatchStartTime DATETIME;

PRINT CONCAT('Total records to insert: ', @Total);
PRINT CONCAT('Already inserted: ', @Inserted);
PRINT CONCAT('Batch size: ', @BatchSize);
PRINT '----------------------------------------------';

WHILE @Inserted < @Total
BEGIN
    SET @BatchStartTime = GETDATE();

    BEGIN TRY
        ;WITH Batch AS (
            SELECT TOP (@BatchSize) c.*
            FROM #CombinedData c
            LEFT JOIN madiva..madiva_individual_events t
                ON t.record_id = c.record_id
            WHERE t.record_id IS NULL
            ORDER BY c.record_id
        )
        INSERT INTO madiva..madiva_individual_events (
            record_id, hdss_name, individual_id, event_code, 
            event_date, event_date_estimated, event_nr, obs_date, location_id
        )
        SELECT record_id, hdss_name, individual_id, event_code, 
               event_date, event_date_estimated,
               ROW_NUMBER() OVER (PARTITION BY individual_id ORDER BY rno) AS event_nr,
               obs_date, location_id
        FROM Batch;

        SET @Inserted = (SELECT COUNT(*) FROM madiva_individual_events);

        PRINT CONCAT(
            '✅ Inserted so far: ', @Inserted, ' / ', @Total,
            ' (', CAST(@Inserted * 100.0 / @Total AS DECIMAL(5,2)), '%)... ',
            'Batch runtime: ', DATEDIFF(SECOND, @BatchStartTime, GETDATE()), ' sec'
        );

        -- Pause briefly to reduce log pressure
        WAITFOR DELAY '00:00:02';
    END TRY
    BEGIN CATCH
        PRINT CONCAT('⚠️ Error near offset ', @Inserted, ': ', ERROR_MESSAGE());
        WAITFOR DELAY '00:00:05';
    END CATCH
END
GO


--------------------------------------------------------
-- 5️⃣  CLEANUP
--------------------------------------------------------
PRINT '🔄 Performing final cleanup...';
DROP TABLE IF EXISTS #CombinedData;

PRINT '⚠️ Skipping automatic log shrink inside script.';
PRINT '➡️  To shrink manually, run:';
PRINT '    USE madiva; DBCC SHRINKFILE (madiva_log, 1000);';
PRINT '✅ Process completed successfully!';
GO
