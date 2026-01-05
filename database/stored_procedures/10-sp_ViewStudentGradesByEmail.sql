/*
=======================================================================
Procedure Name: sp_ViewStudentGradesByEmail
-----------------------------------------------------------------------
Description:
    Returns a detailed grade report for a student identified by their email.
    The report includes course, exam type (Normal/Corrective), pass status
    (Pass/Fail), grade score, and intake year. Works across all courses and
    exams the student has taken.

Parameters:
    @Email NVARCHAR(255) – The student’s registered email address.

Logic:
    1. Validate that the student exists.
    2. Fetch all graded exams for that student (from Student_Grades table).
    3. Join with Exam, Course, and Intake tables for full context.
    4. Return a detailed list of:
         - Course Name
         - Exam Type (Normal/Corrective)
         - Exam Date
         - Grade
         - Pass Status (Pass/Fail)
         - Intake Year
         - Track / Branch (optional, for reporting)

Notes:
    - Works for both normal and corrective exams.
    - If student not found, returns an informative message.
=======================================================================
*/
CREATE OR ALTER PROCEDURE sp_ViewStudentGradesByEmail
    @Email NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StudentID INT;

    -- 1. Validate that the student exists
    SELECT @StudentID = ST_ID
    FROM Student
    WHERE Email = @Email;

    IF @StudentID IS NULL
    BEGIN
        PRINT '❌ No student found with the provided email.';
        RETURN;
    END;

    -- 2. Fetch grade report
    SELECT 
        s.ST_Name AS Student_Name,
        c.Crs_Name,
        CASE 
            WHEN e.Corrective = 1 THEN 'Corrective'
            ELSE 'Normal'
        END AS Exam_Type,
        e.Date AS Exam_Date,
        g.Grade,
        CASE 
            WHEN g.Pass_Status = 1 THEN 'Pass'
            ELSE 'Fail'
        END AS Status,
        i.Intake_Year,
        t.Track_Name,
        b.Bran_Name
    FROM Student_Grades g
    INNER JOIN Exam e ON g.Ex_ID = e.Ex_ID
    INNER JOIN Course c ON e.Crs_ID = c.Crs_ID
    INNER JOIN Student s ON g.ST_ID = s.ST_ID
    INNER JOIN Intake i ON s.Intake_ID = i.Intake_ID
    LEFT JOIN Track t ON s.Track_ID = t.Track_ID
    LEFT JOIN Branch b ON s.Bran_ID = b.Bran_ID
    WHERE s.ST_ID = @StudentID
    ORDER BY i.Intake_Year DESC, e.Date DESC;

END;
GO

