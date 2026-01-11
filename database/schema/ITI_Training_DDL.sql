-- =====================================================
-- ITI Training Database - Complete DDL Script with IDENTITY
-- =====================================================

USE master;
GO

-- Drop database if exists
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'ITI_Training')
BEGIN
    ALTER DATABASE ITI_Training SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ITI_Training;
END
GO

CREATE DATABASE ITI_Training;
GO

USE ITI_Training;
GO

-- =====================================================
-- LOOKUP/DIMENSION TABLES
-- =====================================================

-- Department
CREATE TABLE Department (
    Dep_ID INT IDENTITY(1,1) PRIMARY KEY,
    Dep_Name NVARCHAR(100) NOT NULL
);

-- Branch
CREATE TABLE Branch (
    Bran_ID INT IDENTITY(1,1) PRIMARY KEY,
    Bran_Name NVARCHAR(100) NOT NULL,
    Location NVARCHAR(100)
);

-- Intake
CREATE TABLE Intake (
    Intake_ID INT IDENTITY(1,1) PRIMARY KEY,
    Intake_Year INT NOT NULL
);

-- Track
CREATE TABLE Track (
    Track_ID INT IDENTITY(1,1) PRIMARY KEY,
    Track_Name NVARCHAR(100) NOT NULL,
    No_Cources INT,
    Dep_ID INT,
    FOREIGN KEY (Dep_ID) REFERENCES Department(Dep_ID)
);

-- Course
CREATE TABLE Course (
    Crs_ID INT IDENTITY(1,1) PRIMARY KEY,
    Crs_Name NVARCHAR(200) NOT NULL,
    Crs_Description NVARCHAR(500),
    Min_Degree DECIMAL(5,2),
    Max_Degree DECIMAL(5,2)
);

-- Instructor
CREATE TABLE Instructor (
    Inst_ID INT IDENTITY(1,1) PRIMARY KEY,
    Inst_Name NVARCHAR(200) NOT NULL,
    Email NVARCHAR(200),
    Username NVARCHAR(100),
    Date_of_Birth DATE,
    Gender NVARCHAR(10),
    Hire_Date DATE,
    Address NVARCHAR(500),
    Academic_Rank NVARCHAR(100),
    Dep_ID INT,
    FOREIGN KEY (Dep_ID) REFERENCES Department(Dep_ID)
);

-- =====================================================
-- STUDENT TABLES
-- =====================================================

-- Student (Main table)
CREATE TABLE Student (
    ST_ID INT IDENTITY(1,1) PRIMARY KEY,
    ST_Name NVARCHAR(200) NOT NULL,
    Email NVARCHAR(200),
    user_Name NVARCHAR(100),
    Date_of_Birth DATE,
    Gender NVARCHAR(10),
    Address NVARCHAR(500),
    College NVARCHAR(100),
    University NVARCHAR(200),
    Intake_ID INT,
    Track_id INT,
    Bran_ID INT,
    Status NVARCHAR(50),
    FOREIGN KEY (Intake_ID) REFERENCES Intake(Intake_ID),
    FOREIGN KEY (Track_id) REFERENCES Track(Track_ID),
    FOREIGN KEY (Bran_ID) REFERENCES Branch(Bran_ID)
);

-- Student Career Profile
CREATE TABLE Student_Career_Profile (
    Career_Profile_ID INT IDENTITY(1,1) PRIMARY KEY,
    Company_Name NVARCHAR(200),
    Job_Title NVARCHAR(200),
    Employment_start_date DATE,
    Salary_Range NVARCHAR(50),
    ST_ID INT,
    FOREIGN KEY (ST_ID) REFERENCES Student(ST_ID)
);

-- Student Certifications
CREATE TABLE Student_Certifications (
    Stud_Cert_ID INT IDENTITY(1,1) PRIMARY KEY,
    Cert_Name NVARCHAR(200),
    Cert_Provider NVARCHAR(100),
    Cert_Category NVARCHAR(100),
    Cert_Level NVARCHAR(50),
    Date_obrained DATE,
    Expiry_Date DATE,
    Cost DECIMAL(10,2),
    ST_ID INT,
    FOREIGN KEY (ST_ID) REFERENCES Student(ST_ID)
);

-- Student Freelance Profile
CREATE TABLE Student_Freelance_Profile (
    Freelance_Id INT IDENTITY(1,1) PRIMARY KEY,
    Platform_Name NVARCHAR(100),
    Start_Date DATE,
    ST_ID INT,
    FOREIGN KEY (ST_ID) REFERENCES Student(ST_ID)
);

-- =====================================================
-- RELATIONSHIP/JUNCTION TABLES (No IDENTITY - composite PKs)
-- =====================================================

-- Track-Course Relationship
CREATE TABLE Track_Crs (
    Track_ID INT,
    Crs_ID INT,
    PRIMARY KEY (Track_ID, Crs_ID),
    FOREIGN KEY (Track_ID) REFERENCES Track(Track_ID),
    FOREIGN KEY (Crs_ID) REFERENCES Course(Crs_ID)
);

-- Track-Branch-Intake Relationship
CREATE TABLE Track_Branch_Intake (
    Track_ID INT,
	Bran_ID INT,
	Intake_ID INT,
    PRIMARY KEY (Intake_ID, Bran_ID, Track_ID),
    FOREIGN KEY (Intake_ID) REFERENCES Intake(Intake_ID),
    FOREIGN KEY (Bran_ID) REFERENCES Branch(Bran_ID),
    FOREIGN KEY (Track_ID) REFERENCES Track(Track_ID)
);

-- Course-Instructor-Intake Relationship
CREATE TABLE Crs_Inst_Intake (
    Crs_ID INT,
    Inst_ID INT,
    Intake_ID INT,
    PRIMARY KEY (Crs_ID, Inst_ID, Intake_ID),
    FOREIGN KEY (Crs_ID) REFERENCES Course(Crs_ID),
    FOREIGN KEY (Inst_ID) REFERENCES Instructor(Inst_ID),
    FOREIGN KEY (Intake_ID) REFERENCES Intake(Intake_ID)
);

-- Intake-Instructor-Branch Relationship
CREATE TABLE Intake_Inst_Branch (
    Intake_ID INT,
    Inst_ID INT,
    Bran_ID INT,
    PRIMARY KEY (Intake_ID, Inst_ID, Bran_ID),
    FOREIGN KEY (Intake_ID) REFERENCES Intake(Intake_ID),
    FOREIGN KEY (Inst_ID) REFERENCES Instructor(Inst_ID),
    FOREIGN KEY (Bran_ID) REFERENCES Branch(Bran_ID)
);

-- Course-Instructor-Track-Branch-Intake (Fact table)
CREATE TABLE Crs_Inst_Track_Branch_Intake (
    Intake_ID INT,
    Bran_ID INT,
    Track_ID INT,
    Dep_ID INT,
    Crs_ID INT,
    Inst_ID INT,
    PRIMARY KEY (Intake_ID, Bran_ID, Track_ID, Crs_ID),
    FOREIGN KEY (Intake_ID) REFERENCES Intake(Intake_ID),
    FOREIGN KEY (Bran_ID) REFERENCES Branch(Bran_ID),
    FOREIGN KEY (Track_ID) REFERENCES Track(Track_ID),
    FOREIGN KEY (Dep_ID) REFERENCES Department(Dep_ID),
    FOREIGN KEY (Crs_ID) REFERENCES Course(Crs_ID),
    FOREIGN KEY (Inst_ID) REFERENCES Instructor(Inst_ID)
);

-- =====================================================
-- EXAM/ASSESSMENT TABLES
-- =====================================================

-- Question Pool
CREATE TABLE Qu_Pool (
    Qu_ID INT IDENTITY(1,1) PRIMARY KEY,
    Body NVARCHAR(MAX) NOT NULL,
    Type NVARCHAR(50),
    Degree INT,
    Crs_ID INT,
    FOREIGN KEY (Crs_ID) REFERENCES Course(Crs_ID)
);

-- Choices
CREATE TABLE Choices (
    Choice_ID INT IDENTITY(1,1) PRIMARY KEY,
    Body NVARCHAR(MAX),
    Is_Correct BIT,
    Qu_ID INT,
    FOREIGN KEY (Qu_ID) REFERENCES Qu_Pool(Qu_ID)
);

-- Exam 
CREATE TABLE Exam (
    Ex_Id INT IDENTITY(1,1) PRIMARY KEY,
    Date DATE,
    start_time TIME,
    End_time TIME,
    Corrective BIT DEFAULT 0,
    Crs_ID INT,
    Intake_ID INT,
    Inst_ID INT,
    Track_ID INT,
    Bran_ID INT,
    Parent_Ex_ID INT NULL,
    FOREIGN KEY (Crs_ID) REFERENCES Course(Crs_ID),
    FOREIGN KEY (Intake_ID) REFERENCES Intake(Intake_ID),
    FOREIGN KEY (Inst_ID) REFERENCES Instructor(Inst_ID),
    FOREIGN KEY (Track_ID) REFERENCES Track(Track_ID),
    FOREIGN KEY (Bran_ID) REFERENCES Branch(Bran_ID),
    FOREIGN KEY (Parent_Ex_ID) REFERENCES Exam(Ex_Id)
);

-- Exam Question Pool (which questions in which exam)
CREATE TABLE Exam_Qup (
    Ex_Id INT,
    Qu_ID INT,
    Question_order INT,
    PRIMARY KEY (Ex_Id, Qu_ID),
    FOREIGN KEY (Ex_Id) REFERENCES Exam(Ex_Id),
    FOREIGN KEY (Qu_ID) REFERENCES Qu_Pool(Qu_ID)
);

-- Student Exam Question Pool (student answers)
CREATE TABLE Stu_Exam_Qup (
    ST_ID INT,
    Ex_Id INT,
    Qu_ID INT,
    Answer_Ch_ID INT,
    PRIMARY KEY (ST_ID, Ex_Id, Qu_ID),
    FOREIGN KEY (ST_ID) REFERENCES Student(ST_ID),
    FOREIGN KEY (Ex_Id) REFERENCES Exam(Ex_Id),
    FOREIGN KEY (Qu_ID) REFERENCES Qu_Pool(Qu_ID),
    FOREIGN KEY (Answer_Ch_ID) REFERENCES Choices(Choice_ID)
);

-- Student Grades (derived/calculated)
CREATE TABLE Student_Grades (
    ST_ID INT,
    Ex_Id INT,
    Percentage DECIMAL(5,2),
    Grade NVARCHAR(2),
    Pass_Status BIT,
	Total_Score DECIMAL(10,2),
    PRIMARY KEY (ST_ID, Ex_Id),
    FOREIGN KEY (ST_ID) REFERENCES Student(ST_ID),
    FOREIGN KEY (Ex_Id) REFERENCES Exam(Ex_Id)
);

GO

-- =====================================================
-- SUMMARY
-- =====================================================
PRINT '✅ Database schema created successfully!';
PRINT '';
PRINT '📊 Tables created: 21 tables total';
PRINT '';
PRINT '🔑 Tables WITH IDENTITY (auto-increment):';
PRINT '   - Department, Branch, Intake, Track, Course, Instructor';
PRINT '   - Student, Student_Career_Profile, Student_Certifications, Student_Freelance_Profile';
PRINT '   - Qu_Pool, Choices, Exam';
PRINT '';
PRINT '🔗 Tables WITHOUT IDENTITY (composite keys):';
PRINT '   - Track_Crs, Track_Branch_Intake, Crs_Inst_Intake';
PRINT '   - Intake_Inst_Branch, Crs_Inst_Track_Branch_Intake';
PRINT '   - Exam_Qup, Stu_Exam_Qup, Student_Grades';
PRINT '';
PRINT '📝 Notes:';
PRINT '   - Use SET IDENTITY_INSERT ON/OFF for bulk loading existing IDs';
PRINT '   - Future inserts will auto-generate IDs';
PRINT '   - Exam table includes Dep_ID column';
PRINT '';
PRINT '✅ Ready for bulk insert!';
