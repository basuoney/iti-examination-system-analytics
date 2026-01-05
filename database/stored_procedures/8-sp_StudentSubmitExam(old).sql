/*
==========================================
🧾 Stored Procedure: sp_StudentSubmitExam
------------------------------------------
📌 Purpose:
    Allows a student to submit answers for a specific exam.

✅ Functionality:
    1. Takes parameters:
         - @St_ID (Student ID)
         - @Crs_ID (Course ID)
         - @Ex_ID (Exam ID)
         - @AnswerList (Comma-separated list of 20 Choice_IDs ordered by question)
    2. Validates:
         - Student exists in the latest intake.
         - Exam and course match the student’s track, branch, and intake.
         - Student has not already submitted this exam.
         - Exactly 20 answers are provided.
    3. Inserts answers by matching Exam_QUP.Question_Order (1–20)
       to the position of each provided answer.
    4. Optionally checks exam time window (commented for flexibility).
    5. Rolls back transaction if any validation fails.

🕓 Usage Example:
    EXEC sp_StudentSubmitExam
        @St_ID = 101,
        @Crs_ID = 3,
        @Ex_ID = 7729,
        @AnswerList = '12,24,31,45,50,63,78,88,92,99,101,112,120,130,145,152,160,170,181,190';
==========================================
*/
CREATE OR ALTER PROCEDURE sp_StudentSubmitExam
    @St_ID INT,
    @Crs_ID INT,
    @Ex_ID INT,
    @AnswerList NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @MaxIntake INT, @StuIntake INT, @StuTrack INT, @StuBranch INT;
        DECLARE @ExamIntake INT, @ExamTrack INT, @ExamBranch INT, @ExamCourse INT;
        DECLARE @AnswerCount INT;

        -- 1️⃣ Validate Student Exists
        IF NOT EXISTS (SELECT 1 FROM Student WHERE ST_ID = @St_ID)
        BEGIN
            RAISERROR('❌ Student ID not found.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END

        -- 2️⃣ Validate Exam Exists
        IF NOT EXISTS (SELECT 1 FROM Exam WHERE Ex_ID = @Ex_ID)
        BEGIN
            RAISERROR('❌ Exam ID not found.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END

        -- 3️⃣ Get Exam Details
        SELECT 
            @ExamIntake = Intake_ID,
            @ExamTrack  = Track_ID,
            @ExamBranch = Bran_ID,
            @ExamCourse = Crs_ID
        FROM Exam
        WHERE Ex_ID = @Ex_ID;

        -- 4️⃣ Get Student Details
        SELECT 
            @StuIntake = Intake_ID,
            @StuTrack  = Track_ID,
            @StuBranch = Bran_ID
        FROM Student
        WHERE ST_ID = @St_ID;

        -- 5️⃣ Validate Intake and Course
        SELECT @MaxIntake = MAX(Intake_ID) FROM Intake;

        IF @StuIntake <> @ExamIntake OR @StuIntake <> @MaxIntake
        BEGIN
            RAISERROR('❌ Student not enrolled in the active intake for this exam.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END

        IF @ExamCourse <> @Crs_ID
        BEGIN
            RAISERROR('❌ Exam does not belong to the specified course.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END

        IF @StuTrack <> @ExamTrack OR @StuBranch <> @ExamBranch
        BEGIN
            RAISERROR('❌ Student not assigned to this exam’s track or branch.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END

        -- 6️⃣ Prevent Duplicate Submission
        IF EXISTS (SELECT 1 FROM Stu_Exam_Qup WHERE ST_ID = @St_ID AND Ex_ID = @Ex_ID)
        BEGIN
            RAISERROR('⚠️ Student has already submitted this exam.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END

        -- 7️⃣ Parse Answers
        DECLARE @Answers TABLE (Choice_ID INT, RowNum INT IDENTITY(1,1));
        INSERT INTO @Answers (Choice_ID)
        SELECT TRY_CAST(value AS INT)
        FROM STRING_SPLIT(@AnswerList, ',')
        WHERE TRY_CAST(value AS INT) IS NOT NULL;

        SELECT @AnswerCount = COUNT(*) FROM @Answers;

        IF @AnswerCount <> 20
        BEGIN
            RAISERROR('❌ You must provide exactly 20 ordered answers.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END

        -- 8️⃣ Validate Exam has 20 questions
        DECLARE @QuestionCount INT;
        SELECT @QuestionCount = COUNT(*) FROM Exam_QUP WHERE Ex_ID = @Ex_ID;

        IF @QuestionCount <> 20
        BEGIN
            RAISERROR('❌ Exam invalid: must contain exactly 20 questions.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END

        -- 9️⃣ (Optional) Time validation
        /*
        IF NOT EXISTS (
            SELECT 1
            FROM Exam
            WHERE Ex_ID = @Ex_ID
              AND GETDATE() BETWEEN [Date] + CAST(Start_Time AS DATETIME) AND [Date] + CAST(End_Time AS DATETIME)
        )
        BEGIN
            RAISERROR('⏰ Exam can only be submitted during the scheduled time.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END
        */

        -- 🔟 Insert Each Answer in the Same Question Order
        INSERT INTO Stu_Exam_QUP (ST_ID, Ex_ID, Qu_ID, Answer_Ch_ID)
        SELECT 
            @St_ID,
            e.Ex_ID,
            e.Qu_ID,
            a.Choice_ID
        FROM Exam_QUP e
        JOIN @Answers a ON e.Question_Order = a.RowNum
        WHERE e.Ex_ID = @Ex_ID
        ORDER BY e.Question_Order;

        COMMIT TRANSACTION;
        PRINT '✅ Exam answers submitted successfully.';

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO
