/****************************************************************************************************
Procedure:     sp_CreateExam

Description:
    This stored procedure is the central mechanism for creating exams in the Examination System.
    It supports both **manual** and **automatic (random)** exam generation modes while enforcing
    strict validation and referential integrity across multiple related tables.

Functionality:
    1️⃣  Input Parameters:
        • @Crs_ID         → Target course for the exam.
        • @Inst_ID        → Instructor creating the exam.
        • @Track_ID       → Track where the course is offered.
        • @Bran_ID        → Branch where the course is offered.
        • @QuestionList   → (Optional) Comma-separated list of 20 Question IDs.
                            If provided → Manual exam mode.
                            If NULL     → Randomly selects 20 questions from Qu_Pool.
        • @is_corrective  → Optional flag (1 = corrective exam, 0 = normal).

    2️⃣  Validations:
        • Ensures the provided Instructor, Course, Track, and Branch all exist.
        • Ensures the Instructor teaches the given Course for the given Track and Branch
          in the **latest (MAX) Intake** using Crs_Inst_Track_Branch_Intake.
        • For manual exams:
              - Requires exactly 20 valid Question IDs.
              - Validates that all questions belong to the specified Course.
        • For corrective exams:
              - Validates that a normal (non-corrective) exam for this Course and Instructor
                already exists in the latest intake.
              - Sets Parent_Ex_ID to the existing normal exam.
        • For random exams:
              - Randomly selects 20 questions using ORDER BY CHECKSUM(NEWID()).
        • Generates random start/end times between 9:00 AM and 3:00 PM
          (exam duration fixed at 2 hours).
        • Prevents duplicate exam creation for the same Instructor/Course/Intake.

    3️⃣  Actions:
        • Inserts new exam record into [Exam] with proper references and timing.
        • Inserts 20 question rows into [Exam_Qup] maintaining question order.
        • Handles both random and manual creation seamlessly.

    4️⃣  Error Handling:
        • All validation failures raise explicit user-friendly RAISERROR messages.
        • Uses TRY/CATCH with full transaction rollback for data integrity.

Outcome:
    - Ensures only authorized instructors can create exams.
    - Guarantees question integrity and course alignment.
    - Supports both automatic and manual workflows within a single SP.
    - Maintains complete consistency with the current academic intake.

Example:
    -- Manual Mode:
    EXEC sp_CreateExam
         @Crs_ID = 10,
         @Inst_ID = 5,
         @Track_ID = 3,
         @Bran_ID = 2,
         @QuestionList = '101,102,103,...,120',
         @is_corrective = 0;

    -- Random Mode:
    EXEC sp_CreateExam
         @Crs_ID = 10,
         @Inst_ID = 5,
         @Track_ID = 3,
         @Bran_ID = 2;

************************************************************************************************************/
CREATE OR ALTER PROCEDURE sp_CreateExam
    @Crs_ID INT,
    @Inst_ID INT,
    @Track_ID INT,
    @Bran_ID INT,
    @QuestionList NVARCHAR(MAX) = NULL,  -- optional manual mode (comma-separated)
    @Is_Corrective BIT = 0               -- 1 = corrective exam
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @MaxIntake INT,
        @Parent_Ex_ID INT = NULL,
        @StartTime TIME(0),
        @EndTime TIME(0),
        @Ex_ID INT,
        @QuestionCount INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        /* 1. Validate base objects exist */
        IF NOT EXISTS (SELECT 1 FROM dbo.Course WHERE Crs_ID = @Crs_ID)
        BEGIN RAISERROR('❌ Course ID not found.',16,1); ROLLBACK TRANSACTION; RETURN; END

        IF NOT EXISTS (SELECT 1 FROM dbo.Instructor WHERE Inst_ID = @Inst_ID)
        BEGIN RAISERROR('❌ Instructor ID not found.',16,1); ROLLBACK TRANSACTION; RETURN; END

        IF NOT EXISTS (SELECT 1 FROM dbo.Track WHERE Track_ID = @Track_ID)
        BEGIN RAISERROR('❌ Track ID not found.',16,1); ROLLBACK TRANSACTION; RETURN; END

        IF NOT EXISTS (SELECT 1 FROM dbo.Branch WHERE Bran_ID = @Bran_ID)
        BEGIN RAISERROR('❌ Branch ID not found.',16,1); ROLLBACK TRANSACTION; RETURN; END

        /* 2. Latest intake by ID */
        SELECT @MaxIntake = MAX(Intake_ID) FROM dbo.Intake;
        IF @MaxIntake IS NULL
        BEGIN RAISERROR('❌ No intake found in Intake table.',16,1); ROLLBACK TRANSACTION; RETURN; END

        /* 3. Ensure mapping exists for latest intake */
        IF NOT EXISTS (
            SELECT 1
            FROM dbo.Crs_Inst_Track_Branch_Intake cit
            WHERE cit.Crs_ID = @Crs_ID
              AND cit.Inst_ID = @Inst_ID
              AND cit.Track_ID = @Track_ID
              AND cit.Bran_ID = @Bran_ID
              AND cit.Intake_ID = @MaxIntake
        )
        BEGIN RAISERROR('❌ Instructor is not assigned to this Course/Track/Branch in the latest intake.',16,1);
              ROLLBACK TRANSACTION; RETURN; END

        /* 4. Duplicate prevention */
        IF @Is_Corrective = 0
        BEGIN
            IF EXISTS (
                SELECT 1 FROM dbo.Exam
                WHERE Crs_ID = @Crs_ID
                  AND Inst_ID = @Inst_ID
                  AND Track_ID = @Track_ID
                  AND Bran_ID = @Bran_ID
                  AND Intake_ID = @MaxIntake
                  AND ISNULL(Corrective, 0) = 0
            )
            BEGIN RAISERROR('⚠️ A normal exam already exists for this Course/Instructor/Track/Branch/Intake. Duplicate not allowed.',16,1);
                  ROLLBACK TRANSACTION; RETURN; END
        END
        ELSE
        BEGIN
            SELECT TOP 1 @Parent_Ex_ID = Ex_ID
            FROM dbo.Exam
            WHERE Crs_ID = @Crs_ID AND Inst_ID = @Inst_ID
              AND Track_ID = @Track_ID AND Bran_ID = @Bran_ID
              AND Intake_ID = @MaxIntake AND ISNULL(Corrective,0)=0
            ORDER BY Ex_ID DESC;

            IF @Parent_Ex_ID IS NULL
            BEGIN RAISERROR('❌ Cannot create corrective exam: no prior normal exam found for this combo in current intake.',16,1);
                  ROLLBACK TRANSACTION; RETURN; END

            IF EXISTS (SELECT 1 FROM dbo.Exam WHERE Parent_Ex_ID = @Parent_Ex_ID AND ISNULL(Corrective,0)=1)
            BEGIN RAISERROR('⚠️ A corrective exam already exists for parent exam (%d).',16,1,@Parent_Ex_ID);
                  ROLLBACK TRANSACTION; RETURN; END
        END

        /* 5. Validate questions input or pool availability
              *** TYPE FILTER: only TF / MCQ are allowed ***
        */
        IF @QuestionList IS NOT NULL
        BEGIN
            DECLARE @xml xml = CAST('<i>' + REPLACE(@QuestionList, ',', '</i><i>') + '</i>' AS xml);

            ;WITH Provided AS (
                SELECT TRY_CAST(x.i.value('.', 'nvarchar(50)') AS INT) AS Qu_ID
                FROM @xml.nodes('/i') x(i)
            )
            SELECT @QuestionCount = COUNT(*) FROM Provided WHERE Qu_ID IS NOT NULL;

            IF @QuestionCount <> 20
            BEGIN RAISERROR('❌ Manual mode requires exactly 20 question IDs in @QuestionList.',16,1);
                  ROLLBACK TRANSACTION; RETURN; END

            -- Duplicate IDs check (early)
            IF EXISTS (
                SELECT 1
                FROM (
                    SELECT Qu_ID, COUNT(*) cnt
                    FROM (
                        SELECT TRY_CAST(x.i.value('.', 'nvarchar(50)') AS INT) AS Qu_ID
                        FROM @xml.nodes('/i') x(i)
                    ) p
                    WHERE Qu_ID IS NOT NULL
                    GROUP BY Qu_ID
                ) d
                WHERE d.cnt > 1
            )
            BEGIN RAISERROR('❌ Duplicate question IDs detected in @QuestionList.',16,1);
                  ROLLBACK TRANSACTION; RETURN; END

            -- Ensure all provided questions belong to the course AND are TF/MCQ
            IF EXISTS (
                SELECT 1
                FROM (
                    SELECT TRY_CAST(x.i.value('.', 'nvarchar(50)') AS INT) AS Qu_ID
                    FROM @xml.nodes('/i') x(i)
                ) provided
                LEFT JOIN dbo.Qu_Pool q
                  ON provided.Qu_ID = q.Qu_ID
                 AND q.Crs_ID = @Crs_ID
                 AND q.[Type] IN (N'TF', N'MCQ')   -- <<< TYPE FILTER
                WHERE provided.Qu_ID IS NULL OR q.Qu_ID IS NULL
            )
            BEGIN RAISERROR('❌ One or more provided questions are invalid, not in the course, or not TF/MCQ.',16,1);
                  ROLLBACK TRANSACTION; RETURN; END
        END
        ELSE
        BEGIN
            -- Random mode: ensure enough TF/MCQ questions
            SELECT @QuestionCount = COUNT(*)
            FROM dbo.Qu_Pool
            WHERE Crs_ID = @Crs_ID
              AND [Type] IN (N'TF', N'MCQ');       -- <<< TYPE FILTER

            IF @QuestionCount < 20
            BEGIN RAISERROR('❌ Not enough TF/MCQ questions in pool for random generation (need ≥ 20).',16,1);
                  ROLLBACK TRANSACTION; RETURN; END
        END

        /* 6. Determine random start time between 09:00 and 13:00; end = start + 2h */
        DECLARE @RandomMinutes INT = ABS(CHECKSUM(NEWID())) % 241;  -- 0..240
        SET @StartTime = CONVERT(time(0), DATEADD(MINUTE, @RandomMinutes, CAST('1900-01-01 09:00:00' AS datetime)));
        SET @EndTime   = CONVERT(time(0), DATEADD(HOUR, 2, DATEADD(MINUTE, @RandomMinutes, CAST('1900-01-01 09:00:00' AS datetime))));

        /* 7. Create Exam row */
        INSERT INTO dbo.Exam ([Date], start_time, End_time, Corrective, Crs_ID, Intake_ID, Inst_ID, Track_ID, Bran_ID, Parent_Ex_ID)
        VALUES (CAST(GETDATE() AS DATE), @StartTime, @EndTime, @Is_Corrective, @Crs_ID, @MaxIntake, @Inst_ID, @Track_ID, @Bran_ID, @Parent_Ex_ID);

        SET @Ex_ID = CONVERT(INT, SCOPE_IDENTITY());

        /* 8. Insert questions into Exam_Qup */
        IF @QuestionList IS NULL
        BEGIN
            -- Random TF/MCQ only; unbiased randomization
            ;WITH R AS (
                SELECT Qu_ID,
                       ROW_NUMBER() OVER (ORDER BY NEWID()) AS rn
                FROM dbo.Qu_Pool
                WHERE Crs_ID = @Crs_ID
                  AND [Type] IN (N'TF', N'MCQ')     -- <<< TYPE FILTER
            )
            INSERT INTO dbo.Exam_Qup (Ex_Id, Qu_ID, Question_order)
            SELECT @Ex_ID, Qu_ID, rn
            FROM R
            WHERE rn <= 20
            ORDER BY rn;
        END
        ELSE
        BEGIN
            -- Manual mode: preserve provided order (already validated TF/MCQ)
            DECLARE @xml2 xml = CAST('<i>' + REPLACE(@QuestionList, ',', '</i><i>') + '</i>' AS xml);

            ;WITH Provided AS (
                SELECT 
                    TRY_CAST(x.i.value('.', 'nvarchar(50)') AS INT) AS Qu_ID,
                    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
                FROM @xml2.nodes('/i') x(i)
            )
            INSERT INTO dbo.Exam_Qup (Ex_Id, Qu_ID, Question_order)
            SELECT @Ex_ID, Qu_ID, rn
            FROM Provided
            ORDER BY rn;
        END

        COMMIT TRANSACTION;

        PRINT '✅ Exam created successfully.';
        SELECT @Ex_ID AS Created_Exam_ID, @MaxIntake AS Intake_ID, @StartTime AS Start_Time, @EndTime AS End_Time, @Is_Corrective AS Corrective;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        DECLARE @Err NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error creating exam: %s', 16, 1, @Err);
        RETURN;
    END CATCH
END;
GO
