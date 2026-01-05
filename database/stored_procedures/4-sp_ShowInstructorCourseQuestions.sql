/*  
Stored Procedure: SP_ShowInstructorCourseQuestions
------------------------------------------------------------
Purpose:
    Displays all available questions for a specific course 
    to an instructor, only if the instructor is officially 
    assigned to that course in the current intake.

Parameters:
    @Inst_ID  - Instructor ID
    @Crs_ID   - Course ID

Logic:
    1. Validate instructor and course existence.
    2. Verify assignment via Crs_Inst_Track_Branch_Intake.
    3. If valid, return all questions for that course.
    4. Otherwise, raise an appropriate error.

Use Case:
    Used by instructors when selecting or composing their exams.
*/

CREATE OR ALTER PROCEDURE SP_ShowInstructorCourseQuestions
    @Inst_ID INT,
    @Crs_ID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Validate existence of Instructor and Course
    IF NOT EXISTS (SELECT 1 FROM Instructor WHERE Inst_ID = @Inst_ID)
    BEGIN
        RAISERROR('Instructor not found.', 16, 1);
        RETURN;
    END;

    IF NOT EXISTS (SELECT 1 FROM Course WHERE Crs_ID = @Crs_ID)
    BEGIN
        RAISERROR('Course not found.', 16, 1);
        RETURN;
    END;

    -- 2. Validate the instructor-course relationship
    IF NOT EXISTS (
        SELECT 1 
        FROM Crs_Inst_Track_Branch_Intake
        WHERE Inst_ID = @Inst_ID AND Crs_ID = @Crs_ID
    )
    BEGIN
        RAISERROR('Instructor is not assigned to this course in the current intake.', 16, 1);
        RETURN;
    END;

    -- 3. Show the questions for that course
    SELECT 
     *
    FROM Qu_Pool AS Q
    WHERE Q.Crs_ID = @Crs_ID;

END;
GO