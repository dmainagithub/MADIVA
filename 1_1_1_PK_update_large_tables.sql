-- =========================================
-- 1️⃣ Ensure the column exists (add if missing)
-- =========================================
IF COL_LENGTH('madiva..allDSSpopulation_cal_age_cov_char', 'PK') IS NULL
BEGIN
    ALTER TABLE madiva..allDSSpopulation_cal_age_cov_char 
    ADD [PK] UNIQUEIDENTIFIER NULL;
    PRINT 'Column [PK] added.';
END
ELSE
    PRINT 'Column [PK] already exists.';
GO


-- =========================================
-- 1️⃣ Initialize
-- =========================================
DECLARE @BatchSize INT = 70000;     -- Smaller batch size (~50k rows)
DECLARE @Processed BIGINT = 0;
DECLARE @Total BIGINT;
DECLARE @Remaining BIGINT;

-- Count total rows
SELECT @Total = COUNT(*) 
FROM madiva..allDSSpopulation_cal_age_cov_char;

PRINT CONCAT('Total rows to process: ', @Total);

-- =========================================
-- 2️⃣ Loop through missing PKs
-- =========================================
WHILE 1 = 1
BEGIN
    BEGIN TRY
        BEGIN TRAN;

        SET ROWCOUNT @BatchSize;

        UPDATE madiva..allDSSpopulation_cal_age_cov_char
        SET [PK] = NEWID()
        WHERE [PK] IS NULL;

        SET ROWCOUNT 0;

        DECLARE @Rows INT = @@ROWCOUNT;
        COMMIT TRAN;

        SET @Processed += @Rows;

        SELECT @Remaining = COUNT(*) 
        FROM madiva..allDSSpopulation_cal_age_cov_char
        WHERE [PK] IS NULL;

        PRINT CONCAT(
            'Processed: ', @Processed, 
            ' / ', @Total,
            ' (', CAST(100.0 * @Processed / @Total AS DECIMAL(5,2)), '%)',
            ' - Remaining: ', @Remaining
        );

        IF @Remaining = 0 BREAK;

        WAITFOR DELAY '00:00:05';  -- brief pause between batches
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRAN;
        PRINT CONCAT('⚠️ Error: ', ERROR_MESSAGE());
        WAITFOR DELAY '00:00:05';
    END CATCH
END
GO

-- =========================================
-- 4️⃣ Verify completion
-- =========================================
SELECT COUNT(*) AS Missing_GUIDs
FROM madiva..allDSSpopulation_cal_age_cov_char
WHERE [PK] IS NULL;
GO

-- =========================================
-- 5️⃣ Make column NOT NULL and add Primary Key (if all done)
-- =========================================
IF NOT EXISTS (
    SELECT 1 
    FROM madiva..allDSSpopulation_cal_age_cov_char 
    WHERE [PK] IS NULL
)
BEGIN
    ALTER TABLE madiva..allDSSpopulation_cal_age_cov_char
    ALTER COLUMN [PK] UNIQUEIDENTIFIER NOT NULL;

    ALTER TABLE madiva..allDSSpopulation_cal_age_cov_char
    ADD CONSTRAINT PK_allDSSpopulation_cal_age_cov_char PRIMARY KEY ([PK]);

    PRINT 'Primary key successfully added.';
END
ELSE
    PRINT 'Some rows are still missing PK values — rerun the update script.';
GO
