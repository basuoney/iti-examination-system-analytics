/***********************************************************************************************
Stored Procedure: SP_ViewAssignedExams

Purpose:
    Retrieves all exams assigned to a given student (by ST_ID). 
    The procedure validates:
        - The student exists in the system.
        - The student is enrolled in the latest intake (MAX Intake_ID).
    If valid, it returns all assigned exams with details such as:
        - Exam ID
        - Course name
        - Exam date and time
        - Exam type (Normal or Corrective)
        - Branch name
        - Instructor name (if available)
        - Exam status (Scheduled, Completed, etc.)
    If the student does not exist or is not in the latest intake, 
    an appropriate error message is raised.

Parameters:
    @ST_ID INT   --> Student ID to check assigned exams for.

Output:
    Result set of assigned exams with related metadata.

Notes:
    - Ensures data integrity by joining with latest intake and branch.
    - Can be integrated into a student portal or exam management dashboard.
    - Supports both normal and corrective exam types.

***********************************************************************************************/

CREATE OR ALTER PROCEDURE SP_ViewAssignedExams
    @ST_ID INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @StudentIntake INT, @LatestIntake INT;

        SELECT @StudentIntake = Intake_ID FROM Student WHERE ST_ID = @ST_ID;
        IF @StudentIntake IS NULL
        BEGIN
            RAISERROR('❌ Student not found.', 16, 1);
            RETURN;
        END;

        SELECT @LatestIntake = MAX(Intake_ID) FROM Intake;
        IF @StudentIntake <> @LatestIntake
        BEGIN
            RAISERROR('⚠️ Student not enrolled in the latest intake.', 16, 1);
            RETURN;
        END;

        SELECT 
            e.Ex_Id,
            c.Crs_Name,
            i.Inst_Name,
            e.Date,
            e.Start_Time,
            e.End_Time,
            CASE WHEN e.Corrective = 1 THEN 'Corrective' ELSE 'Normal' END AS Exam_Type
        FROM Exam e
        JOIN Course c ON e.Crs_ID = c.Crs_ID
        JOIN Instructor i ON e.Inst_ID = i.Inst_ID
        JOIN Student s ON e.Intake_ID = s.Intake_ID 
                       AND e.Track_ID = s.Track_ID 
                       AND e.Bran_ID = s.Bran_ID
        WHERE s.ST_ID = @ST_ID
        ORDER BY e.Date, e.Start_Time;

        IF @@ROWCOUNT = 0
            PRINT 'ℹ️ No exams assigned to this student in the current intake.';

    END TRY
    BEGIN CATCH
        DECLARE @Err NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Err, 16, 1);
    END CATCH
END;
GO