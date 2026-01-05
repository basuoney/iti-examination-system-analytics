/*********************************************************************************************
    Stored Procedure: SP_ViewExamPaper

    📘 Purpose:
        Displays the full exam paper (questions + answers) 
        for a specific student, course, and exam.

    ✅ Logic Summary:
        1. Validate student existence.
        2. Validate that the student belongs to the latest intake.
        3. Validate course existence.
        4. Ensure the student takes this course (same intake, track, branch).
        5. Ensure the exam belongs to the same course.
        6. (Optional) Validate that the current date/time is within the exam window.
        7. Return 20 questions with their answers in the exam order.

    ⚙️ Parameters:
        @St_ID     INT   → Student ID
        @Crs_ID    INT   → Course ID
        @Ex_ID     INT   → Exam ID

    📤 Output:
        - Question_Order
        - Question_Body
        - Answer_ID
        - Answer_Body

*********************************************************************************************/
CREATE OR ALTER PROCEDURE SP_ViewExamPaper
    @St_ID INT,
    @Crs_ID INT,
    @Ex_ID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @LatestIntake INT;

        -- 1️⃣ Validate Student existence
        IF NOT EXISTS (SELECT 1 FROM Student WHERE ST_ID = @St_ID)
        BEGIN
            RAISERROR('❌ Student ID does not exist.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END

        -- 2️⃣ Get latest intake and validate student belongs to it
        SELECT @LatestIntake = MAX(Intake_ID) FROM Intake;

        IF NOT EXISTS (
            SELECT 1 FROM Student WHERE ST_ID = @St_ID AND Intake_ID = @LatestIntake
        )
        BEGIN
            RAISERROR('❌ Student is not registered in the latest intake.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END

        -- 3️⃣ Validate Course existence
        IF NOT EXISTS (SELECT 1 FROM Course WHERE Crs_ID = @Crs_ID)
        BEGIN
            RAISERROR('❌ Course ID does not exist.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END

        -- 4️⃣ Ensure student takes this course in this intake
        IF NOT EXISTS (
            SELECT 1
            FROM Student s
            JOIN Crs_Inst_Track_Branch_Intake c 
                ON s.Intake_ID = c.Intake_ID 
               AND s.Track_ID = c.Track_ID 
               AND s.Bran_ID = c.Bran_ID
            WHERE s.ST_ID = @St_ID AND c.Crs_ID = @Crs_ID AND s.Intake_ID = @LatestIntake
        )
        BEGIN
            RAISERROR('❌ Student is not enrolled in this course for the current intake.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END

        -- 5️⃣ Ensure exam belongs to the same course
        IF NOT EXISTS (SELECT 1 FROM Exam WHERE Ex_ID = @Ex_ID AND Crs_ID = @Crs_ID)
        BEGIN
            RAISERROR('❌ Exam ID does not belong to the specified course.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END

        -- 6️⃣ (Optional) Check exam is currently open
        /*
        IF NOT EXISTS (
            SELECT 1 
            FROM Exam 
            WHERE Ex_ID = @Ex_ID 
              AND GETDATE() BETWEEN 
                  DATEADD(SECOND, 0, CAST(Date AS DATETIME) + CAST(Start_Time AS DATETIME)) 
                  AND DATEADD(SECOND, 0, CAST(Date AS DATETIME) + CAST(End_Time AS DATETIME))
        )
        BEGIN
            RAISERROR('⏰ Exam is not currently open for viewing.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END
        */

        -- 7️⃣ Return the Exam Paper (20 questions + answers)
        SELECT 
            eq.Question_order,
			a.choice_letter,
            q.Body AS Question_Body,
            a.Body AS Answer_Body
        FROM Exam_Qup eq
        JOIN Qu_Pool q ON eq.Qu_ID = q.Qu_ID
        JOIN Choices a ON q.Qu_ID = a.Qu_ID
        WHERE eq.Ex_ID = @Ex_ID
        ORDER BY eq.Question_order, a.choice_letter;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error: %s', 16, 1, @ErrMsg);
    END CATCH
END
GO