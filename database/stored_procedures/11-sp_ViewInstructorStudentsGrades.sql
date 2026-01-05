/*
=======================================================================
Procedure Name: sp_ViewInstructorStudentsGrades
-----------------------------------------------------------------------
Description:
    Displays all students' grades for courses taught by a given instructor
    in the current (latest) intake. Supports optional filters by Course ID
    and Branch ID for more focused results.

Parameters:
    @Inst_ID INT              – Instructor ID (required)
    @Crs_ID INT = NULL        – Optional Course ID filter
    @Bran_ID INT = NULL       – Optional Branch ID filter

Logic:
    1. Validate that the instructor exists.
    2. Identify the latest intake ID (MAX(Intake_ID)) from the Intake table.
    3. Validate that the instructor is teaching in this latest intake
       (exists in Crs_Inst_Intake table with this Intake_ID).
    4. Ensure that graded exams exist for this instructor in this intake.
    5. Retrieve all student grades with optional filters for Course and Branch.
    6. Display:
         - Student Name
         - Course Name
         - Exam Type (Normal/Corrective)
         - Grade and Pass/Fail Status
         - Intake Year, Branch, Track

Notes:
    - Uses Student_Grades, Exam, Course, Student, Intake, Branch, Track.
    - Ensures instructor belongs to the current active intake only.
=======================================================================
*/
CREATE OR ALTER PROCEDURE sp_ViewInstructorStudentsGrades
    @Inst_ID INT,
    @Crs_ID INT = NULL,
    @Bran_ID INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @LatestIntakeID INT;

    -- 1. Validate instructor existence
    IF NOT EXISTS (SELECT 1 FROM Instructor WHERE Inst_ID = @Inst_ID)
    BEGIN
        PRINT '❌ Invalid Instructor ID.';
        RETURN;
    END;

    -- 2. Get the latest intake ID
    SELECT @LatestIntakeID = MAX(Intake_ID) FROM Intake;

    IF @LatestIntakeID IS NULL
    BEGIN
        PRINT '❌ No intake records found.';
        RETURN;
    END;

    -- 3. Validate that instructor teaches in this latest intake
    IF NOT EXISTS (
        SELECT 1
        FROM Crs_Inst_Intake
        WHERE Inst_ID = @Inst_ID
          AND Intake_ID = @LatestIntakeID
    )
    BEGIN
        PRINT '❌ Instructor is not assigned to any course in the latest intake.';
        RETURN;
    END;

    -- 4. Check if there are any graded exams for this instructor in this intake
    IF NOT EXISTS (
        SELECT 1
        FROM Exam e
        INNER JOIN Student_Grades g ON e.Ex_ID = g.Ex_ID
        WHERE e.Inst_ID = @Inst_ID
          AND e.Intake_ID = @LatestIntakeID
    )
    BEGIN
        PRINT '⚠️ No graded exams found for this instructor in the latest intake.';
        RETURN;
    END;

    -- 5. Retrieve student grades for instructor in latest intake
    SELECT 
        s.ST_Name AS Student_Name,
        c.Crs_Name,
        CASE WHEN e.Corrective = 1 THEN 'Corrective' ELSE 'Normal' END AS Exam_Type,
        e.Date AS Exam_Date,
        g.Grade,
        CASE WHEN g.Pass_Status = 1 THEN 'Pass' ELSE 'Fail' END AS Status,
        i.Intake_Year,
        b.Bran_Name,
        t.Track_Name
    FROM Student_Grades g
    INNER JOIN Exam e ON g.Ex_ID = e.Ex_ID
    INNER JOIN Course c ON e.Crs_ID = c.Crs_ID
    INNER JOIN Student s ON g.ST_ID = s.ST_ID
    INNER JOIN Intake i ON s.Intake_ID = i.Intake_ID
    LEFT JOIN Branch b ON s.Bran_ID = b.Bran_ID
    LEFT JOIN Track t ON s.Track_ID = t.Track_ID
    WHERE e.Inst_ID = @Inst_ID
      AND e.Intake_ID = @LatestIntakeID
      AND (@Crs_ID IS NULL OR e.Crs_ID = @Crs_ID)
      AND (@Bran_ID IS NULL OR e.Bran_ID = @Bran_ID)
    ORDER BY c.Crs_Name, s.ST_Name;

END;
GO

