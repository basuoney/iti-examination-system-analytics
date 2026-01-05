/*
Stored Procedure: SP_AssignInstructorToCourse
------------------------------------------------------------
Purpose:
    - Assigns an instructor to a specific course, track, branch, and intake.
    - Maintains consistency by inserting into all three related tables:
        1. Crs_Inst_Track_Branch_Intake
        2. Crs_Inst_Intake
        3. Intake_Inst_Branch

Key Validations:
    1. Ensures all provided IDs (intake_id, branch_id, track_id, crs_id, inst_id) exist in their respective tables.
    2. Confirms the provided intake_id equals the most recently opened intake (MAX(intake_id) from Intake).
    3. Verifies that the instructor’s department matches the track’s department — 
       ensuring the instructor only teaches within their department.
    4. Checks that the provided track, branch, and intake combination exists in Intake_Branch_Track table 
       (meaning this track is opened for this branch and intake).
    5. Prevents duplicate assignment entries across the target tables.

Behavior:
    - If all checks pass:
         → Inserts data into Crs_Inst_Track_Branch_Intake.
         → Inserts corresponding records into Crs_Inst_Intake and Intake_Inst_Branch.
    - If any validation fails:
         → Raises an appropriate error message and terminates execution.

Notes:
    - This procedure ensures referential and business rule integrity across all related entities.
    - Designed for use during new intake opening and instructor assignment operations.
*/

CREATE OR ALTER PROCEDURE SP_AssignInstructorToCourse
    @Intake_ID INT,
    @Branch_ID INT,
    @Track_ID INT,
    @Crs_ID INT,
    @Inst_ID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        ---------------------------------------------------------------------
        -- 1️⃣ Validate Intake Exists
        ---------------------------------------------------------------------
        IF NOT EXISTS (SELECT 1 FROM Intake WHERE Intake_ID = @Intake_ID)
        BEGIN
            RAISERROR('❌ Intake ID does not exist.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        ---------------------------------------------------------------------
        -- 2️⃣ Validate Intake is the Most Recent (MAX)
        ---------------------------------------------------------------------
        DECLARE @MaxIntakeID INT;
        SELECT @MaxIntakeID = MAX(Intake_ID) FROM Intake;

        IF @Intake_ID <> @MaxIntakeID
        BEGIN
            RAISERROR('⚠️ You can only assign instructors to the most recent intake.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        ---------------------------------------------------------------------
        -- 3️⃣ Validate Branch Exists
        ---------------------------------------------------------------------
        IF NOT EXISTS (SELECT 1 FROM Branch WHERE Bran_ID = @Branch_ID)
        BEGIN
            RAISERROR('❌ Branch ID does not exist.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        ---------------------------------------------------------------------
        -- 4️⃣ Validate Track Exists
        ---------------------------------------------------------------------
        IF NOT EXISTS (SELECT 1 FROM Track WHERE Track_ID = @Track_ID)
        BEGIN
            RAISERROR('❌ Track ID does not exist.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        ---------------------------------------------------------------------
        -- 5️⃣ Validate Course Exists
        ---------------------------------------------------------------------
        IF NOT EXISTS (SELECT 1 FROM Course WHERE Crs_ID = @Crs_ID)
        BEGIN
            RAISERROR('❌ Course ID does not exist.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        ---------------------------------------------------------------------
        -- 6️⃣ Validate Instructor Exists
        ---------------------------------------------------------------------
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE Inst_ID = @Inst_ID)
        BEGIN
            RAISERROR('❌ Instructor ID does not exist.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        ---------------------------------------------------------------------
        -- 7️⃣ Check Track-Course Relationship Exists
        ---------------------------------------------------------------------
        IF NOT EXISTS (
            SELECT 1 FROM Track_Crs WHERE Track_ID = @Track_ID AND Crs_ID = @Crs_ID
        )
        BEGIN
            RAISERROR('❌ This course is not part of the selected track.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        ---------------------------------------------------------------------
        -- 8️⃣ Check Instructor’s Department Matches Track Department
        ---------------------------------------------------------------------
        DECLARE @Inst_Dep INT, @Track_Dep INT;
        SELECT @Inst_Dep = Dep_ID FROM Instructor WHERE Inst_ID = @Inst_ID;
        SELECT @Track_Dep = Dep_ID FROM Track WHERE Track_ID = @Track_ID;

        IF @Inst_Dep <> @Track_Dep
        BEGIN
            RAISERROR('❌ Instructor''s department does not match the track''s department.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        ---------------------------------------------------------------------
        -- 9️⃣ Check Track is Opened for This Branch in This Intake
        ---------------------------------------------------------------------
        IF NOT EXISTS (
            SELECT 1 FROM Track_Branch_Intake
            WHERE Intake_ID = @Intake_ID
              AND Bran_ID = @Branch_ID
              AND Track_ID = @Track_ID
        )
        BEGIN
            RAISERROR('❌ This track is not opened for this branch in the current intake.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        ---------------------------------------------------------------------
        -- 🔟 Check for Duplicate Instructor-Course Assignment
        ---------------------------------------------------------------------
        IF EXISTS (
            SELECT 1 FROM Crs_Inst_Track_Branch_Intake
            WHERE Intake_ID = @Intake_ID
              AND Bran_ID = @Branch_ID
              AND Track_ID = @Track_ID
              AND Crs_ID = @Crs_ID
              AND Inst_ID = @Inst_ID
        )
        BEGIN
            RAISERROR('⚠️ Duplicate assignment: This instructor is already assigned to this course for this branch and track.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        ---------------------------------------------------------------------
        -- ✅ Insert Into Crs_Inst_Track_Branch_Intake (Detailed Granularity)
        ---------------------------------------------------------------------
        INSERT INTO Crs_Inst_Track_Branch_Intake (Intake_ID, Bran_ID, Track_ID, Dep_ID, Crs_ID, Inst_ID)
        VALUES (@Intake_ID, @Branch_ID, @Track_ID, @Track_Dep, @Crs_ID, @Inst_ID);

        ---------------------------------------------------------------------
        -- ✅ Insert Into Crs_Inst_Intake (Course-Level Relationship)
        ---------------------------------------------------------------------
        IF NOT EXISTS (
            SELECT 1 FROM Crs_Inst_Intake
            WHERE Crs_ID = @Crs_ID AND Inst_ID = @Inst_ID AND Intake_ID = @Intake_ID
        )
        INSERT INTO Crs_Inst_Intake (Crs_ID, Inst_ID, Intake_ID)
        VALUES (@Crs_ID, @Inst_ID, @Intake_ID);

        ---------------------------------------------------------------------
        -- ✅ Insert Into Intake_Inst_Branch (Instructor per Branch)
        ---------------------------------------------------------------------
        IF NOT EXISTS (
            SELECT 1 FROM Intake_Inst_Branch
            WHERE Intake_ID = @Intake_ID AND Inst_ID = @Inst_ID AND Bran_ID = @Branch_ID
        )
        INSERT INTO Intake_Inst_Branch (Intake_ID, Inst_ID, Bran_ID)
        VALUES (@Intake_ID, @Inst_ID, @Branch_ID);

        ---------------------------------------------------------------------
        -- ✅ Commit Transaction
        ---------------------------------------------------------------------
        COMMIT TRANSACTION;
        PRINT '✅ Instructor successfully assigned to course for this branch and track in the current intake.';

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO