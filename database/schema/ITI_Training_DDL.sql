/* ============================================================
   Build fresh database (optional)
   ============================================================ */

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

/* ============================================================
   1) Base lookup tables
   ============================================================ */

-- Branch
CREATE TABLE dbo.Branch
(
  Bran_ID    INT IDENTITY(1,1) NOT NULL,
  Bran_Name  NVARCHAR(100)     NOT NULL,
  [Location] NVARCHAR(100)     NULL,
  CONSTRAINT PK_Branch PRIMARY KEY CLUSTERED (Bran_ID)
);
GO

-- Department
CREATE TABLE dbo.Department
(
  Dep_ID   INT IDENTITY(1,1) NOT NULL,
  Dep_Name NVARCHAR(100)     NOT NULL,
  CONSTRAINT PK_Department PRIMARY KEY CLUSTERED (Dep_ID)
);
GO

-- Track
CREATE TABLE dbo.Track
(
  Track_ID   INT IDENTITY(1,1) NOT NULL,
  Track_Name NVARCHAR(100)     NOT NULL,
  No_Cources INT               NULL,
  Dep_ID     INT               NULL,
  CONSTRAINT PK_Track PRIMARY KEY CLUSTERED (Track_ID),
  CONSTRAINT FK_Track_Department
    FOREIGN KEY (Dep_ID) REFERENCES dbo.Department(Dep_ID)
);
GO

-- Intake
CREATE TABLE dbo.Intake
(
  Intake_ID   INT IDENTITY(1,1) NOT NULL,
  Intake_Year INT               NOT NULL,
  CONSTRAINT PK_Intake PRIMARY KEY CLUSTERED (Intake_ID)
);
GO

-- Course
CREATE TABLE dbo.Course
(
  Crs_ID          INT IDENTITY(1,1) NOT NULL,
  Crs_Name        NVARCHAR(200)     NOT NULL,
  Crs_Description NVARCHAR(500)     NULL,
  Min_Degree      DECIMAL(5,2)      NULL,
  Max_Degree      DECIMAL(5,2)      NULL,
  CONSTRAINT PK_Course PRIMARY KEY CLUSTERED (Crs_ID),
  CONSTRAINT CK_Course_MinLeMax CHECK (
      Min_Degree IS NULL OR Max_Degree IS NULL OR Min_Degree <= Max_Degree
  )
);
GO

/* ============================================================
   2) People
   ============================================================ */

-- Instructor
CREATE TABLE dbo.Instructor
(
  Inst_ID       INT IDENTITY(1,1) NOT NULL,
  Inst_Name     NVARCHAR(200)     NOT NULL,
  Email         NVARCHAR(200)     NULL,
  [Username]    NVARCHAR(100)     NULL,
  Date_of_Birth DATE              NULL,
  Gender        NVARCHAR(10)      NULL,
  Hire_Date     DATE              NULL,
  [Address]     NVARCHAR(500)     NULL,
  Academic_Rank NVARCHAR(100)     NULL,
  Dep_ID        INT               NULL,
  CONSTRAINT PK_Instructor PRIMARY KEY CLUSTERED (Inst_ID),
  CONSTRAINT FK_Instructor_Department
    FOREIGN KEY (Dep_ID) REFERENCES dbo.Department(Dep_ID)
);
GO

-- Student
CREATE TABLE dbo.Student
(
  ST_ID         INT IDENTITY(1,1) NOT NULL,
  ST_Name       NVARCHAR(200)     NOT NULL,
  Email         NVARCHAR(200)     NULL,
  user_Name     NVARCHAR(100)     NULL,
  Date_of_Birth DATE              NULL,
  Gender        NVARCHAR(10)      NULL,
  [Address]     NVARCHAR(500)     NULL,
  College       NVARCHAR(100)     NULL,
  University    NVARCHAR(200)     NULL,
  Intake_ID     INT               NULL,
  Track_id      INT               NULL,
  Bran_ID       INT               NULL,
  [Status]      NVARCHAR(50)      NULL,
  CONSTRAINT PK_Student PRIMARY KEY CLUSTERED (ST_ID),
  CONSTRAINT FK_Student_Intake FOREIGN KEY (Intake_ID) REFERENCES dbo.Intake(Intake_ID),
  CONSTRAINT FK_Student_Track  FOREIGN KEY (Track_id)  REFERENCES dbo.Track(Track_ID),
  CONSTRAINT FK_Student_Branch FOREIGN KEY (Bran_ID)   REFERENCES dbo.Branch(Bran_ID)
);
GO

/* ============================================================
   3) Questions & choices
   ============================================================ */

-- Question pool
CREATE TABLE dbo.Qu_Pool
(
  Qu_ID         INT IDENTITY(1,1) NOT NULL,
  Body          NVARCHAR(MAX)     NOT NULL,
  [Type]        NVARCHAR(50)      NULL,      -- 'MCQ'/'TF'/...
  Degree        INT               NULL,
  Crs_ID        INT               NULL,
  model_answer  NVARCHAR(MAX)     NULL,
  CONSTRAINT PK_Qu_Pool PRIMARY KEY CLUSTERED (Qu_ID),
  CONSTRAINT FK_Qu_Pool_Course FOREIGN KEY (Crs_ID) REFERENCES dbo.Course(Crs_ID)
);
GO

-- Choices (choice_letter is REQUIRED)
CREATE TABLE dbo.Choices
(
  Choice_ID     INT IDENTITY(1,1) NOT NULL,
  Body          NVARCHAR(MAX)     NULL,
  Is_Correct    BIT               NULL,
  Qu_ID			INT				  NOT NULL,
  choice_letter CHAR(1)           NOT NULL,
  CONSTRAINT PK_Choices PRIMARY KEY CLUSTERED (Choice_ID),
  CONSTRAINT FK_Choices_QuPool FOREIGN KEY (Qu_ID) REFERENCES dbo.Qu_Pool(Qu_ID),
  CONSTRAINT CK_Choices_Letter CHECK (choice_letter LIKE '[A-Z]')
);
GO

-- One letter per question (no duplicates)
CREATE UNIQUE INDEX UX_Choices_Qu_Letter
  ON dbo.Choices(Qu_ID, choice_letter);
GO


/* ============================================================
   4) Exams & mappings
   ============================================================ */

-- Exams (Corrective flag, optional parent, schedule)
CREATE TABLE dbo.Exam
(
  Ex_Id        INT IDENTITY(1,1) NOT NULL,
  [Date]       DATE              NULL,
  start_time   TIME              NULL,
  End_time     TIME              NULL,
  Corrective   BIT               NULL,
  Crs_ID       INT               NULL,
  Intake_ID    INT               NULL,
  Track_ID     INT               NULL,
  Bran_ID      INT               NULL,
  Inst_ID      INT               NULL,
  Parent_Ex_ID INT               NULL,
  CONSTRAINT PK_Exam PRIMARY KEY CLUSTERED (Ex_Id),
  CONSTRAINT FK_Exam_Parent     FOREIGN KEY (Parent_Ex_ID) REFERENCES dbo.Exam(Ex_Id),
  CONSTRAINT FK_Exam_Instructor FOREIGN KEY (Inst_ID)      REFERENCES dbo.Instructor(Inst_ID),
  -- extra FKs are useful in your workflows:
  CONSTRAINT FK_Exam_Course FOREIGN KEY (Crs_ID)   REFERENCES dbo.Course(Crs_ID),
  CONSTRAINT FK_Exam_Intake FOREIGN KEY (Intake_ID)REFERENCES dbo.Intake(Intake_ID),
  CONSTRAINT FK_Exam_Track  FOREIGN KEY (Track_ID) REFERENCES dbo.Track(Track_ID),
  CONSTRAINT FK_Exam_Branch FOREIGN KEY (Bran_ID)  REFERENCES dbo.Branch(Bran_ID)
);
GO
CREATE NONCLUSTERED INDEX IX_Exam_Lookup
ON dbo.Exam (Intake_ID, Track_ID, Bran_ID, Crs_ID);
CREATE NONCLUSTERED INDEX IX_Exam_Parent_Corrective
ON dbo.Exam (Parent_Ex_ID, Corrective);
CREATE NONCLUSTERED INDEX IX_Exam_Corrective
ON dbo.Exam (Corrective) INCLUDE (Parent_Ex_ID);
GO

-- Exam → Questions
CREATE TABLE dbo.Exam_Qup
(
  Ex_ID          INT      NOT NULL,
  Qu_ID          INT      NOT NULL,
  Question_Order TINYINT  NOT NULL,
  CONSTRAINT PK_Exam_Qup PRIMARY KEY CLUSTERED (Ex_ID, Question_Order),
  CONSTRAINT UQ_Exam_Qup UNIQUE (Ex_ID, Qu_ID),
  CONSTRAINT CK_Exam_Qup_Order CHECK (Question_Order BETWEEN 1 AND 20),
  CONSTRAINT FK_Exam_Qup_Exam   FOREIGN KEY (Ex_ID) REFERENCES dbo.Exam(Ex_Id),
  CONSTRAINT FK_Exam_Qup_QuPool FOREIGN KEY (Qu_ID) REFERENCES dbo.Qu_Pool(Qu_ID)
);
GO
CREATE NONCLUSTERED INDEX IX_Exam_Qup_Ex ON dbo.Exam_Qup(Ex_ID) INCLUDE (Qu_ID, Question_Order);
CREATE NONCLUSTERED INDEX IX_Exam_Qup_Qu ON dbo.Exam_Qup(Qu_ID);
GO

-- Student answers per exam question
CREATE TABLE dbo.Stu_Exam_Qup
(
  ST_ID         INT          NOT NULL,
  Ex_Id         INT          NOT NULL,
  Qu_ID         INT          NOT NULL,
  Answer_Ch_ID  INT          NULL,
  txt_answer    VARCHAR(255) NULL,
  Choice_Letter CHAR(1)      NULL,
  CONSTRAINT PK_Stu_Exam_Qup PRIMARY KEY CLUSTERED (ST_ID, Ex_Id, Qu_ID),

  -- FKs
  CONSTRAINT FK_SEQ_Student FOREIGN KEY (ST_ID) REFERENCES dbo.Student(ST_ID),
  CONSTRAINT FK_SEQ_Exam    FOREIGN KEY (Ex_Id) REFERENCES dbo.Exam(Ex_Id),

  -- *** Strong membership check: the Qu_ID must belong to the same exam ***
  CONSTRAINT FK_SEQ_ExamQup FOREIGN KEY (Ex_Id, Qu_ID) REFERENCES dbo.Exam_Qup(Ex_ID, Qu_ID),

  -- Keep this if you want a direct FK to choice row (optional but handy)
  CONSTRAINT FK_SEQ_Choices  FOREIGN KEY (Answer_Ch_ID) REFERENCES dbo.Choices(Choice_ID),

  CONSTRAINT CK_SEQ_Letter CHECK (Choice_Letter IS NULL OR Choice_Letter LIKE '[A-Z]')
);
GO

-- Guard: chosen Answer_Ch_ID must belong to the same Qu_ID
CREATE OR ALTER TRIGGER dbo.trg_SEQ_ChoiceGuard
ON dbo.Stu_Exam_Qup
AFTER INSERT, UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  IF EXISTS (
     SELECT 1
     FROM inserted i
     JOIN dbo.Choices c ON c.Choice_ID = i.Answer_Ch_ID
     WHERE i.Answer_Ch_ID IS NOT NULL
       AND c.Qu_ID <> i.Qu_ID
  )
  BEGIN
     RAISERROR('Answer_Ch_ID must belong to the same Qu_ID.',16,1);
     ROLLBACK TRANSACTION;
     RETURN;
  END
END;
GO

/* ============================================================
   5) Student outcomes and profiles
   ============================================================ */

-- Grades
CREATE TABLE dbo.Student_Grades
(
  ST_ID       INT            NOT NULL,
  Ex_Id       INT            NOT NULL,
  Percentage  DECIMAL(5,2)   NULL,
  Grade       NVARCHAR(2)    NULL,
  Pass_Status BIT            NULL,
  Total_Score DECIMAL(10,2)  NULL,
  CONSTRAINT PK_Student_Grades PRIMARY KEY CLUSTERED (ST_ID, Ex_Id),
  CONSTRAINT FK_Student_Grades_Student FOREIGN KEY (ST_ID) REFERENCES dbo.Student(ST_ID),
  CONSTRAINT FK_Student_Grades_Exam    FOREIGN KEY (Ex_Id) REFERENCES dbo.Exam(Ex_Id),
  CONSTRAINT CK_Student_Grades_Pct   CHECK (Percentage BETWEEN 0 AND 100),
  CONSTRAINT CK_Student_Grades_Score CHECK (Total_Score BETWEEN 0 AND 100),
  CONSTRAINT CK_Student_Grades_Grade CHECK (Grade IN (N'A',N'B',N'C',N'D',N'F'))
);
GO

-- Career profile
CREATE TABLE dbo.Student_Career_Profile
(
  Career_Profile_ID     INT IDENTITY(1,1) NOT NULL,
  Company_Name          NVARCHAR(200)     NULL,
  Job_Title             NVARCHAR(200)     NULL,
  Employment_start_date DATE              NULL,
  Salary_Range          NVARCHAR(50)      NULL,
  ST_ID                 INT               NULL,
  CONSTRAINT PK_Student_Career_Profile PRIMARY KEY CLUSTERED (Career_Profile_ID),
  CONSTRAINT FK_Student_Career_Profile_Student FOREIGN KEY (ST_ID) REFERENCES dbo.Student(ST_ID)
);
GO

-- Certifications
CREATE TABLE dbo.Student_Certifications
(
  Stud_Cert_ID   INT IDENTITY(1,1) NOT NULL,
  Cert_Name      NVARCHAR(200)     NULL,
  Cert_Provider  NVARCHAR(100)     NULL,
  Cert_Category  NVARCHAR(100)     NULL,
  Cert_Level     NVARCHAR(50)      NULL,
  Date_obrained  DATE              NULL,
  Expiry_Date    DATE              NULL,
  Cost           DECIMAL(10,2)     NULL,
  ST_ID          INT               NULL,
  CONSTRAINT PK_Student_Certifications PRIMARY KEY CLUSTERED (Stud_Cert_ID),
  CONSTRAINT FK_Student_Certifications_Student FOREIGN KEY (ST_ID) REFERENCES dbo.Student(ST_ID)
);
GO

-- Freelance profile
CREATE TABLE dbo.Student_Freelance_Profile
(
  Freelance_Id  INT IDENTITY(1,1) NOT NULL,
  Platform_Name NVARCHAR(100)     NULL,
  Start_Date    DATE              NULL,
  ST_ID         INT               NULL,
  CONSTRAINT PK_Student_Freelance_Profile PRIMARY KEY CLUSTERED (Freelance_Id),
  CONSTRAINT FK_Student_Freelance_Profile_Student FOREIGN KEY (ST_ID) REFERENCES dbo.Student(ST_ID)
);
GO

/* ============================================================
   6) Track/course relations & intake/instructor/branch maps
   ============================================================ */

-- Track_Crs
CREATE TABLE dbo.Track_Crs
(
  Track_ID INT NOT NULL,
  Crs_ID   INT NOT NULL,
  CONSTRAINT PK_Track_Crs PRIMARY KEY CLUSTERED (Track_ID, Crs_ID),
  CONSTRAINT FK_Track_Crs_Track  FOREIGN KEY (Track_ID) REFERENCES dbo.Track(Track_ID),
  CONSTRAINT FK_Track_Crs_Course FOREIGN KEY (Crs_ID)   REFERENCES dbo.Course(Crs_ID)
);
GO

-- Track_Branch_Intake (composite PK + FKs)
CREATE TABLE dbo.Track_Branch_Intake
(
  Intake_ID INT NOT NULL,
  Bran_ID   INT NOT NULL,
  Track_ID  INT NOT NULL,
  CONSTRAINT PK_TBI PRIMARY KEY CLUSTERED (Intake_ID, Bran_ID, Track_ID),
  CONSTRAINT FK_TBI_Intake FOREIGN KEY (Intake_ID) REFERENCES dbo.Intake(Intake_ID),
  CONSTRAINT FK_TBI_Branch FOREIGN KEY (Bran_ID)   REFERENCES dbo.Branch(Bran_ID),
  CONSTRAINT FK_TBI_Track  FOREIGN KEY (Track_ID)  REFERENCES dbo.Track(Track_ID)
);
GO


-- Intake_Inst_Branch
CREATE TABLE dbo.Intake_Inst_Branch
(
  Intake_ID INT NOT NULL,
  Inst_ID   INT NOT NULL,
  Bran_ID   INT NOT NULL,
  CONSTRAINT PK_Intake_Inst_Branch
    PRIMARY KEY CLUSTERED (Intake_ID, Inst_ID, Bran_ID),
  CONSTRAINT FK_IIB_Intake     FOREIGN KEY (Intake_ID) REFERENCES dbo.Intake(Intake_ID),
  CONSTRAINT FK_IIB_Instructor FOREIGN KEY (Inst_ID)   REFERENCES dbo.Instructor(Inst_ID),
  CONSTRAINT FK_IIB_Branch     FOREIGN KEY (Bran_ID)   REFERENCES dbo.Branch(Bran_ID)
);
GO
-- Helpful reverse lookup (find all branches/intakes for an instructor)
CREATE NONCLUSTERED INDEX IX_IIB_Inst
  ON dbo.Intake_Inst_Branch (Inst_ID, Intake_ID)
  INCLUDE (Bran_ID);
GO


-- Crs_Inst_Intake
CREATE TABLE dbo.Crs_Inst_Intake
(
  Crs_ID    INT NOT NULL,
  Inst_ID   INT NOT NULL,
  Intake_ID INT NOT NULL,
  CONSTRAINT PK_Crs_Inst_Intake
    PRIMARY KEY CLUSTERED (Crs_ID, Inst_ID, Intake_ID),
  CONSTRAINT FK_CII_Course     FOREIGN KEY (Crs_ID)    REFERENCES dbo.Course(Crs_ID),
  CONSTRAINT FK_CII_Instructor FOREIGN KEY (Inst_ID)   REFERENCES dbo.Instructor(Inst_ID),
  CONSTRAINT FK_CII_Intake     FOREIGN KEY (Intake_ID) REFERENCES dbo.Intake(Intake_ID)
);
GO
-- Common lookups
CREATE NONCLUSTERED INDEX IX_CII_Inst
  ON dbo.Crs_Inst_Intake (Inst_ID, Intake_ID) INCLUDE (Crs_ID);
CREATE NONCLUSTERED INDEX IX_CII_Course
  ON dbo.Crs_Inst_Intake (Crs_ID, Intake_ID)  INCLUDE (Inst_ID);
GO


-- Crs_Inst_Track_Branch_Intake (one instructor per combo)
CREATE TABLE dbo.Crs_Inst_Track_Branch_Intake
(
  Intake_ID INT NOT NULL,
  Bran_ID   INT NOT NULL,
  Track_ID  INT NOT NULL,
  Crs_ID    INT NOT NULL,
  Dep_ID    INT NULL,
  Inst_ID   INT NULL,
  CONSTRAINT PK_CITBI
    PRIMARY KEY (Intake_ID, Bran_ID, Track_ID, Crs_ID),
  CONSTRAINT FK_CITBI_Intake     FOREIGN KEY (Intake_ID) REFERENCES dbo.Intake(Intake_ID),
  CONSTRAINT FK_CITBI_Branch     FOREIGN KEY (Bran_ID)   REFERENCES dbo.Branch(Bran_ID),
  CONSTRAINT FK_CITBI_Track      FOREIGN KEY (Track_ID)  REFERENCES dbo.Track(Track_ID),
  CONSTRAINT FK_CITBI_Course     FOREIGN KEY (Crs_ID)    REFERENCES dbo.Course(Crs_ID),
  CONSTRAINT FK_CITBI_Department FOREIGN KEY (Dep_ID)    REFERENCES dbo.Department(Dep_ID),
  CONSTRAINT FK_CITBI_Instructor FOREIGN KEY (Inst_ID)   REFERENCES dbo.Instructor(Inst_ID)
);
GO
-- Useful lookups
CREATE NONCLUSTERED INDEX IX_CITBI_ByInstructor
  ON dbo.Crs_Inst_Track_Branch_Intake (Inst_ID)
  INCLUDE (Intake_ID, Bran_ID, Track_ID, Crs_ID, Dep_ID);
CREATE NONCLUSTERED INDEX IX_CITBI_ByTrackCourse
  ON dbo.Crs_Inst_Track_Branch_Intake (Track_ID, Crs_ID)
  INCLUDE (Intake_ID, Bran_ID, Inst_ID);
GO


/* ============================================================
   7) ML queue
   ============================================================ */

CREATE TABLE dbo.ML_GradeQueue
(
  Queue_ID        INT IDENTITY(1,1) NOT NULL,
  ST_ID           INT               NULL,
  Ex_ID           INT               NULL,
  Qu_ID           INT               NULL,
  Answer_Text     NVARCHAR(MAX)     NULL,
  Predicted_Score FLOAT             NULL,
  [Status]        NVARCHAR(50)      NULL CONSTRAINT DF_ML_GradeQueue_Status  DEFAULT (N'Pending'),
  CreatedAt       DATETIME          NULL CONSTRAINT DF_ML_GradeQueue_Created DEFAULT (GETDATE()),
  ProcessedAt     DATETIME          NULL,
  ErrorMessage    NVARCHAR(4000)    NULL,
  CONSTRAINT PK_ML_GradeQueue PRIMARY KEY CLUSTERED (Queue_ID),
  CONSTRAINT FK_MLGQ_Student FOREIGN KEY (ST_ID) REFERENCES dbo.Student(ST_ID),
  CONSTRAINT FK_MLGQ_Exam    FOREIGN KEY (Ex_ID) REFERENCES dbo.Exam(Ex_Id),
  CONSTRAINT FK_MLGQ_QuPool  FOREIGN KEY (Qu_ID) REFERENCES dbo.Qu_Pool(Qu_ID)
);
GO

/* ============================================================
   8) Secondary indexes for performance (non-unique)
   ============================================================ */
CREATE NONCLUSTERED INDEX IX_Student_Lookup
  ON dbo.Student (Intake_ID, Track_id, Bran_ID, ST_ID);

-- Stu_Exam_Qup is large (>1M): add these two for common lookups
CREATE NONCLUSTERED INDEX IX_SEQ_ExamQuestion
  ON dbo.Stu_Exam_Qup (Ex_Id, Qu_ID)
  INCLUDE (Answer_Ch_ID, Choice_Letter, txt_answer);

CREATE NONCLUSTERED INDEX IX_SEQ_StudentExam
  ON dbo.Stu_Exam_Qup (ST_ID, Ex_Id)
  INCLUDE (Qu_ID, Answer_Ch_ID, Choice_Letter, txt_answer);
GO

-- Prevent duplicates at the DB level
CREATE UNIQUE INDEX UX_Intake_Year ON dbo.Intake(Intake_Year);
