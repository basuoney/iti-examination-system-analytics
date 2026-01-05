/*
============================================================
Stored Procedure : sp_Grade_Unprocessed_Exams
Created On       : 2025-10-31
============================================================
📌 Purpose:
Grades all unprocessed (ungraded) exams for students who 
have completed all their exam answers in the latest intake.

============================================================
⚙️ Logic Summary:
✅ Finds all (ST_ID, Ex_ID) in Stu_Exam_Qup not in Student_Grades.
✅ Checks that the student belongs to the latest intake.
✅ Ensures all exam questions are answered.
✅ Calculates score, percentage, grade, and pass/fail status.
✅ Inserts results into Student_Grades.

🕓 Usage Example:
    EXEC sp_Grade_Unprocessed_Exams;
============================================================
*/

CREATE OR ALTER PROCEDURE sp_Grade_Unprocessed_Exams
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ST_ID INT, @Ex_ID INT, @Intake_ID INT, @MaxIntake INT, @Crs_ID INT;
    DECLARE @TotalQuestions INT, @AnsweredQuestions INT, @CorrectAnswers INT;
    DECLARE @Percentage DECIMAL(5,2), @TotalScore DECIMAL(9,2),
            @MinDegree DECIMAL(5,2), @MaxDegree DECIMAL(5,2),
            @PassStatus BIT, @Grade NVARCHAR(4);

    BEGIN TRY
        BEGIN TRANSACTION;

        SELECT @MaxIntake = MAX(Intake_ID) FROM Intake;

        DECLARE cur CURSOR LOCAL FAST_FORWARD FOR
        SELECT DISTINCT s.ST_ID, s.Ex_Id
        FROM Stu_Exam_Qup s
        LEFT JOIN Student_Grades g ON s.ST_ID = g.ST_ID AND s.Ex_Id = g.Ex_Id
        JOIN Student st ON s.ST_ID = st.ST_ID
        WHERE g.ST_ID IS NULL
          AND st.Intake_ID = @MaxIntake;

        OPEN cur;
        FETCH NEXT FROM cur INTO @ST_ID, @Ex_ID;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- 1️⃣ Get course id
            SELECT @Crs_ID = Crs_ID FROM Exam WHERE Ex_Id = @Ex_ID;

            -- 2️⃣ Validate completeness
            SELECT @TotalQuestions = COUNT(*) FROM Exam_Qup WHERE Ex_Id = @Ex_ID;
            SELECT @AnsweredQuestions = COUNT(*) 
            FROM Stu_Exam_Qup 
            WHERE ST_ID = @ST_ID AND Ex_Id = @Ex_ID;

            IF @AnsweredQuestions = @TotalQuestions
            BEGIN
                -- 3️⃣ Get grading scale
                SELECT @MinDegree = Min_Degree, @MaxDegree = Max_Degree
                FROM Course WHERE Crs_ID = @Crs_ID;

                -- 4️⃣ Count correct answers
                SELECT 
                    @CorrectAnswers = SUM(CASE WHEN c.Is_Correct = 1 THEN 1 ELSE 0 END)
                FROM Stu_Exam_Qup s
                JOIN Exam_Qup eq ON s.Ex_Id = eq.Ex_Id AND s.Qu_ID = eq.Qu_ID
                JOIN Choices c ON s.Answer_Ch_ID = c.Choice_ID
                WHERE s.ST_ID = @ST_ID AND s.Ex_Id = @Ex_ID;

                -- 5️⃣ Compute grade and pass status
                SET @Percentage = CASE WHEN @TotalQuestions > 0 THEN (@CorrectAnswers * 100.0 / @TotalQuestions) ELSE 0 END;
                SET @TotalScore = @MaxDegree * (@Percentage / 100);
                SET @PassStatus = CASE WHEN @TotalScore >= @MinDegree THEN 1 ELSE 0 END;
                SET @Grade = CASE 
                                WHEN @Percentage >= 90 THEN 'A'
                                WHEN @Percentage >= 80 THEN 'B'
                                WHEN @Percentage >= 70 THEN 'C'
                                WHEN @Percentage >= 60 THEN 'D'
                                ELSE 'F'
                             END;

                -- 6️⃣ Insert result
                INSERT INTO Student_Grades (ST_ID, Ex_Id, Percentage, Grade, Pass_Status, Total_Score)
                VALUES (@ST_ID, @Ex_ID, @Percentage, @Grade, @PassStatus, @TotalScore);

                PRINT CONCAT('✅ Graded Exam ', @Ex_ID, ' for Student ', @ST_ID);
            END
            ELSE
            BEGIN
                PRINT CONCAT('⚠️ Exam ', @Ex_ID, ' for Student ', @ST_ID, ' not fully answered — skipped.');
            END

            FETCH NEXT FROM cur INTO @ST_ID, @Ex_ID;
        END

        CLOSE cur;
        DEALLOCATE cur;

        COMMIT TRANSACTION;
        PRINT '✅ All ungraded exams processed successfully.';

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        DECLARE @Error NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Error, 16, 1);
    END CATCH
END;
GO


