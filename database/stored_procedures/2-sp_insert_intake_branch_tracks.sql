/*
==========================================
🧾 Stored Procedure: SP_insert_intake_branch_tracks
------------------------------------------
📌 Purpose:
    Inserts multiple tracks for a specific branch in the latest intake.

✅ Functionality:
    1. Takes @intake_id, @branch_id, and @track_ids (comma-separated).
    2. Validates that:
        - @intake_id exists and equals the latest intake (MAX(Intake_ID)).
        - @branch_id exists in the Branch table.
        - All provided @track_ids exist in the Track table.
    3. Prevents duplicate (Intake_ID, Branch_ID, Track_ID) combinations.
    4. Inserts valid records into Track_Branch_Intake.
    5. Rolls back and raises errors for invalid or duplicate entries.

🕓 Usage Example:
    EXEC sp_insert_intake_branch_tracks 
        @intake_id = 6, 
        @branch_id = 1, 
        @track_ids = '1,2,3';
==========================================
*/
CREATE OR ALTER PROCEDURE sp_insert_intake_branch_tracks
    @intake_id INT,
    @branch_id INT,
    @track_ids NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @max_intake_id INT;
        SELECT @max_intake_id = MAX(Intake_ID) FROM Intake;

        -- 1. ✅ Check Intake is the Latest
        IF @intake_id <> @max_intake_id
        BEGIN
            RAISERROR('❌ You can only insert data for the latest intake (max Intake_ID).', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- 2. ✅ Validate Intake Exists
        IF NOT EXISTS (SELECT 1 FROM Intake WHERE Intake_ID = @intake_id)
        BEGIN
            RAISERROR('❌ Intake ID does not exist in the Intake table.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- 3. ✅ Validate Branch Exists
        IF NOT EXISTS (SELECT 1 FROM Branch WHERE Bran_ID = @branch_id)
        BEGIN
            RAISERROR('❌ Branch ID does not exist in the Branch table.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- 4. ✅ Convert Track IDs String to Table
        DECLARE @TrackList TABLE (Track_ID INT);
        INSERT INTO @TrackList (Track_ID)
        SELECT TRY_CAST(value AS INT)
        FROM STRING_SPLIT(@track_ids, ',')
        WHERE TRY_CAST(value AS INT) IS NOT NULL;

        -- 5. ✅ Validate All Track IDs Exist
        IF EXISTS (
            SELECT t.Track_ID
            FROM @TrackList t
            LEFT JOIN Track tr ON t.Track_ID = tr.Track_ID
            WHERE tr.Track_ID IS NULL
        )
        BEGIN
            RAISERROR('❌ One or more Track IDs do not exist in the Track table.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- 6. ✅ Check for Duplicates Before Insert
        IF EXISTS (
            SELECT 1
            FROM @TrackList t
            JOIN Track_Branch_Intake itb
              ON itb.Intake_ID = @intake_id
             AND itb.Bran_ID = @branch_id
             AND itb.Track_ID = t.Track_ID
        )
        BEGIN
            RAISERROR('⚠️ Duplicate (Intake_ID, Branch_ID, Track_ID) combination already exists.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- 7. ✅ Insert Only if All Checks Pass
        INSERT INTO Track_Branch_Intake (Intake_ID, Bran_ID, Track_ID)
        SELECT @intake_id, @branch_id, t.Track_ID
        FROM @TrackList t;

        COMMIT TRANSACTION;
        PRINT '✅ Tracks inserted successfully for the latest intake.';

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO

