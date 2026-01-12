-- ======================================================================
-- ITI Examination System - 2026 Intake Data with Variations
-- ======================================================================

USE ITI_Examination_System;
GO

-- Disable constraints for bulk insert
--EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';
--GO

PRINT '========================================';
PRINT 'Starting 2026 Intake Data Generation';
PRINT '========================================';
GO

-- ======================================================================
-- 1. Add 2026 Intake
-- ======================================================================

SET IDENTITY_INSERT dbo.Intake ON;
GO

INSERT INTO dbo.Intake ([Intake_ID], [Intake_Year])
VALUES (6, 2026);

SET IDENTITY_INSERT dbo.Intake OFF;
GO

PRINT 'Step 1/10: 2026 Intake added successfully!';
GO

-- ======================================================================
-- 2. Add New Tracks for 2026
-- ======================================================================

SET IDENTITY_INSERT dbo.Track ON;
GO

-- New Track 11: Cloud Computing & DevOps (Hybrid - Dept 3)
INSERT INTO dbo.Track ([Track_ID], [Track_Name], [No_Cources], [Dep_ID])
VALUES (11, N'Cloud Computing & DevOps', 12, 3);

-- New Track 12: Full Stack JavaScript (Dept 1)
INSERT INTO dbo.Track ([Track_ID], [Track_Name], [No_Cources], [Dep_ID])
VALUES (12, N'Full Stack JavaScript', 10, 1);

-- New Track 13: Data Science & Analytics (Dept 2)
INSERT INTO dbo.Track ([Track_ID], [Track_Name], [No_Cources], [Dep_ID])
VALUES (13, N'Data Science & Analytics', 11, 2);

SET IDENTITY_INSERT dbo.Track OFF;
GO

PRINT 'Step 2/10: 3 New tracks added successfully!';
GO

-- ======================================================================
-- 3. Add New Courses for 2026 (33 courses: 101-133)
-- ======================================================================

SET IDENTITY_INSERT dbo.Course ON;
GO

-- Cloud Computing & DevOps Track Courses (101-112)
INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (101, N'AWS Fundamentals', N'Introduction to Amazon Web Services cloud platform', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (102, N'Azure Cloud Services', N'Microsoft Azure cloud computing services', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (103, N'Google Cloud Platform', N'GCP services and architecture', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (104, N'Cloud Architecture', N'Design patterns for cloud solutions', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (105, N'Serverless Computing', N'AWS Lambda, Azure Functions, Cloud Functions', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (106, N'Cloud Security', N'Security best practices in cloud environments', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (107, N'GitOps', N'Git-based operations and deployment', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (108, N'Service Mesh', N'Istio, Linkerd service mesh technologies', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (109, N'Cloud Cost Optimization', N'Managing and optimizing cloud costs', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (110, N'Multi-Cloud Strategy', N'Managing multiple cloud providers', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (111, N'Cloud Native Applications', N'Building cloud-native apps', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (112, N'Site Reliability Engineering', N'SRE principles and practices', 60, 100);

-- Full Stack JavaScript Track Courses (113-122)
INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (113, N'Modern JavaScript', N'ES2023+ features and best practices', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (114, N'Next.js', N'React framework for production', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (115, N'Express.js Advanced', N'Building robust Node.js APIs', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (116, N'NestJS', N'Progressive Node.js framework', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (117, N'MongoDB & Mongoose', N'NoSQL database with Node.js', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (118, N'React Native', N'Mobile development with React', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (119, N'WebSocket & Real-time', N'Real-time communication in web apps', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (120, N'Jest & Testing', N'Testing JavaScript applications', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (121, N'Webpack & Build Tools', N'Module bundlers and optimization', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (122, N'JavaScript Performance', N'Optimization techniques', 60, 100);

-- Data Science & Analytics Track Courses (123-133)
INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (123, N'Statistics for Data Science', N'Statistical analysis fundamentals', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (124, N'Pandas & NumPy', N'Data manipulation with Python', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (125, N'Data Visualization', N'Matplotlib, Seaborn, Plotly', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (126, N'Scikit-Learn', N'Machine learning library for Python', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (127, N'Time Series Analysis', N'Analyzing temporal data', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (128, N'Feature Engineering', N'Creating effective features for ML', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (129, N'A/B Testing', N'Experimentation and hypothesis testing', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (130, N'SQL for Analytics', N'Advanced SQL queries for data analysis', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (131, N'Tableau Advanced', N'Advanced data visualization with Tableau', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (132, N'R Programming', N'Statistical computing with R', 60, 100);

INSERT INTO dbo.Course ([Crs_ID], [Crs_Name], [Crs_Description], [Min_Degree], [Max_Degree])
VALUES (133, N'Big Data Analytics', N'Analytics at scale', 60, 100);

SET IDENTITY_INSERT dbo.Course OFF;
GO

PRINT 'Step 3/10: 33 New courses added successfully!';
GO

-- ======================================================================
-- 4. Map New Courses to New Tracks
-- ======================================================================

-- Cloud Computing & DevOps Track (11) -> Courses 101-112
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (11, 101);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (11, 102);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (11, 103);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (11, 104);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (11, 105);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (11, 106);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (11, 107);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (11, 108);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (11, 109);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (11, 110);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (11, 111);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (11, 112);

-- Full Stack JavaScript Track (12) -> Courses 113-122
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (12, 113);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (12, 114);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (12, 115);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (12, 116);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (12, 117);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (12, 118);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (12, 119);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (12, 120);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (12, 121);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (12, 122);

-- Data Science & Analytics Track (13) -> Courses 123-133
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (13, 123);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (13, 124);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (13, 125);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (13, 126);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (13, 127);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (13, 128);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (13, 129);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (13, 130);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (13, 131);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (13, 132);
INSERT INTO dbo.Track_Crs ([Track_ID], [Crs_ID]) VALUES (13, 133);

PRINT 'Step 4/10: Track-Course mappings added successfully!';
GO

-- ======================================================================
-- 5. Add 100 New Instructors for 2026 (IDs: 151-250)
-- ======================================================================

SET IDENTITY_INSERT dbo.Instructor ON;
GO

-- Department 1 (IT) - 35 instructors
INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (151, N'Ahmed Khaled', N'ahmed.khaled@iti.gov.eg', N'ahmedkhaled151', '1985-03-15', N'Male', '2025-09-01', N'12 Cairo Street', N'Senior Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (152, N'Fatma Mansour', N'fatma.mansour@iti.gov.eg', N'fatmamansour152', '1988-07-22', N'Female', '2025-09-01', N'45 Alexandria Street', N'Principal Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (153, N'Karim Adel', N'karim.adel@iti.gov.eg', N'karimadel153', '1986-11-10', N'Male', '2025-09-01', N'23 Giza Street', N'Lead Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (154, N'Nada Samy', N'nada.samy@iti.gov.eg', N'nadasamy154', '1990-01-18', N'Female', '2025-10-01', N'67 Cairo Street', N'Senior Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (155, N'Omar Tamer', N'omar.tamer@iti.gov.eg', N'omartamer155', '1987-05-25', N'Male', '2025-10-01', N'89 Alexandria Street', N'Lead Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (156, N'Salma Walid', N'salma.walid@iti.gov.eg', N'salmawalid156', '1989-09-12', N'Female', '2025-10-01', N'34 Giza Street', N'Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (157, N'Hassan Sherif', N'hassan.sherif@iti.gov.eg', N'hassansherif157', '1984-12-05', N'Male', '2025-11-01', N'56 Cairo Street', N'Principal Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (158, N'Hoda Ramadan', N'hoda.ramadan@iti.gov.eg', N'hodaramadan158', '1986-04-20', N'Female', '2025-11-01', N'78 Alexandria Street', N'Senior Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (159, N'Yasser Fouad', N'yasser.fouad@iti.gov.eg', N'yasserfouad159', '1985-08-30', N'Male', '2025-11-01', N'90 Giza Street', N'Lead Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (160, N'Dina Refaat', N'dina.refaat@iti.gov.eg', N'dinarefaat160', '1983-02-14', N'Female', '2025-08-15', N'12 Mansoura Street', N'Senior Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (161, N'Tarek Gamal', N'tarek.gamal@iti.gov.eg', N'tarekgamal161', '1982-06-18', N'Male', '2025-09-10', N'45 Tanta Street', N'Lead Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (162, N'Mona Essam', N'mona.essam@iti.gov.eg', N'monaessam162', '1991-03-27', N'Female', '2025-09-15', N'78 Damanhur Street', N'Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (163, N'Khaled Osama', N'khaled.osama@iti.gov.eg', N'khaledosama163', '1987-11-05', N'Male', '2025-10-20', N'23 Asyut Street', N'Senior Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (164, N'Noha Ashraf', N'noha.ashraf@iti.gov.eg', N'nohaashraf164', '1989-08-14', N'Female', '2025-10-25', N'56 Ismailia Street', N'Lead Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (165, N'Ibrahim Magdy', N'ibrahim.magdy@iti.gov.eg', N'ibrahimmagdy165', '1984-01-22', N'Male', '2025-11-05', N'89 Port Said Street', N'Principal Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (166, N'Sara Hani', N'sara.hani@iti.gov.eg', N'sarahani166', '1986-09-30', N'Female', '2025-11-10', N'34 Minya Street', N'Senior Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (167, N'Mohamed Hazem', N'mohamed.hazem@iti.gov.eg', N'mohamedhazem167', '1983-05-16', N'Male', '2025-09-20', N'67 Cairo Street', N'Lead Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (168, N'Rana Amgad', N'rana.amgad@iti.gov.eg', N'ranaamgad168', '1990-12-08', N'Female', '2025-09-25', N'12 Alexandria Street', N'Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (169, N'Ali Hossam', N'ali.hossam@iti.gov.eg', N'alihossam169', '1988-07-19', N'Male', '2025-10-30', N'45 Giza Street', N'Senior Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (170, N'Laila Mazen', N'laila.mazen@iti.gov.eg', N'lailamazen170', '1985-04-11', N'Female', '2025-11-15', N'78 Mansoura Street', N'Lead Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (171, N'Amr Seif', N'amr.seif@iti.gov.eg', N'amrseif171', '1982-10-23', N'Male', '2025-09-05', N'23 Cairo Street', N'Principal Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (172, N'Mariam Badr', N'mariam.badr@iti.gov.eg', N'mariambadr172', '1991-02-15', N'Female', '2025-10-10', N'56 Alexandria Street', N'Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (173, N'Youssef Medhat', N'youssef.medhat@iti.gov.eg', N'youssefmedhat173', '1987-06-07', N'Male', '2025-10-15', N'89 Giza Street', N'Senior Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (174, N'Heba Nabil', N'heba.nabil@iti.gov.eg', N'hebanabil174', '1989-01-29', N'Female', '2025-11-20', N'34 Damanhur Street', N'Lead Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (175, N'Omar Wael', N'omar.wael@iti.gov.eg', N'omarwael175', '1984-08-12', N'Male', '2025-09-12', N'67 Tanta Street', N'Senior Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (176, N'Yasmin Hesham', N'yasmin.hesham@iti.gov.eg', N'yasminhesham176', '1986-03-24', N'Female', '2025-10-05', N'12 Asyut Street', N'Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (177, N'Ahmed Reda', N'ahmed.reda@iti.gov.eg', N'ahmedreda177', '1983-11-17', N'Male', '2025-11-08', N'45 Ismailia Street', N'Lead Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (178, N'Nour Taha', N'nour.taha@iti.gov.eg', N'nourtaha178', '1990-05-09', N'Female', '2025-09-18', N'78 Port Said Street', N'Senior Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (179, N'Mahmoud Samir', N'mahmoud.samir@iti.gov.eg', N'mahmoudsamir179', '1988-12-21', N'Male', '2025-10-22', N'23 Minya Street', N'Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (180, N'Mai Yasser', N'mai.yasser@iti.gov.eg', N'maiyasser180', '1985-07-03', N'Female', '2025-11-12', N'56 Cairo Street', N'Lead Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (181, N'Sherif Karim', N'sherif.karim@iti.gov.eg', N'sherifkarim181', '1982-04-26', N'Male', '2025-09-08', N'89 Alexandria Street', N'Principal Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (182, N'Aya Mostafa', N'aya.mostafa@iti.gov.eg', N'ayamostafa182', '1991-09-14', N'Female', '2025-10-28', N'34 Giza Street', N'Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (183, N'Hossam Adham', N'hossam.adham@iti.gov.eg', N'hossamadham183', '1987-02-06', N'Male', '2025-11-03', N'67 Mansoura Street', N'Senior Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (184, N'Nesma Fady', N'nesma.fady@iti.gov.eg', N'nesmafady184', '1989-10-18', N'Female', '2025-09-22', N'12 Damanhur Street', N'Lead Instructor', 1);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (185, N'Mostafa Ramy', N'mostafa.ramy@iti.gov.eg', N'mostafaramy185', '1984-06-30', N'Male', '2025-10-12', N'45 Tanta Street', N'Senior Instructor', 1);

-- Department 2 (BI) - 35 instructors
INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (186, N'Rania Khaled', N'rania.khaled@iti.gov.eg', N'raniakhaled186', '1986-01-12', N'Female', '2025-09-03', N'78 Asyut Street', N'Principal Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (187, N'Tamer Waleed', N'tamer.waleed@iti.gov.eg', N'tamerwaleed187', '1983-08-24', N'Male', '2025-09-07', N'23 Ismailia Street', N'Lead Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (188, N'Dalia Hassan', N'dalia.hassan@iti.gov.eg', N'daliahassan188', '1990-03-16', N'Female', '2025-10-11', N'56 Port Said Street', N'Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (189, N'Wael Sami', N'wael.sami@iti.gov.eg', N'waelsami189', '1988-11-08', N'Male', '2025-10-16', N'89 Minya Street', N'Senior Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (190, N'Eman Tarek', N'eman.tarek@iti.gov.eg', N'emantarek190', '1985-05-21', N'Female', '2025-11-21', N'34 Cairo Street', N'Lead Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (191, N'Hazem Fathy', N'hazem.fathy@iti.gov.eg', N'hazemfathy191', '1982-12-03', N'Male', '2025-09-14', N'67 Alexandria Street', N'Principal Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (192, N'Shaimaa Maged', N'shaimaa.maged@iti.gov.eg', N'shaimaamaged192', '1991-07-25', N'Female', '2025-10-19', N'12 Giza Street', N'Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (193, N'Seif Alaa', N'seif.alaa@iti.gov.eg', N'seifalaa193', '1987-04-17', N'Male', '2025-11-06', N'45 Mansoura Street', N'Senior Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (194, N'Nada Hamdi', N'nada.hamdi@iti.gov.eg', N'nadahamdi194', '1989-09-09', N'Female', '2025-09-26', N'78 Damanhur Street', N'Lead Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (195, N'Adel Ashraf', N'adel.ashraf@iti.gov.eg', N'adelashraf195', '1984-02-01', N'Male', '2025-10-08', N'23 Tanta Street', N'Senior Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (196, N'Salwa Hany', N'salwa.hany@iti.gov.eg', N'salwahany196', '1986-10-13', N'Female', '2025-11-18', N'56 Asyut Street', N'Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (197, N'Magdy Emad', N'magdy.emad@iti.gov.eg', N'magdyemad197', '1983-06-25', N'Male', '2025-09-11', N'89 Ismailia Street', N'Lead Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (198, N'Reem Ayman', N'reem.ayman@iti.gov.eg', N'reemayman198', '1990-01-07', N'Female', '2025-10-24', N'34 Port Said Street', N'Senior Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (199, N'Badr Nader', N'badr.nader@iti.gov.eg', N'badrnader199', '1988-08-19', N'Male', '2025-11-09', N'67 Minya Street', N'Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (200, N'Lamia Sayed', N'lamia.sayed@iti.gov.eg', N'lamiasayed200', '1985-03-31', N'Female', '2025-09-19', N'12 Cairo Street', N'Lead Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (201, N'Hamdy Ragab', N'hamdy.ragab@iti.gov.eg', N'hamdyragab201', '1982-11-23', N'Male', '2025-10-14', N'45 Alexandria Street', N'Principal Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (202, N'Soha Gamal', N'soha.gamal@iti.gov.eg', N'sohagamal202', '1991-05-15', N'Female', '2025-11-01', N'78 Giza Street', N'Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (203, N'Fadi Taher', N'fadi.taher@iti.gov.eg', N'faditaher203', '1987-12-07', N'Male', '2025-09-23', N'23 Mansoura Street', N'Senior Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (204, N'Hala Zaki', N'hala.zaki@iti.gov.eg', N'halazaki204', '1989-07-29', N'Female', '2025-10-18', N'56 Damanhur Street', N'Lead Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (205, N'Nabil Lotfy', N'nabil.lotfy@iti.gov.eg', N'nabillotfy205', '1984-04-21', N'Male', '2025-11-13', N'89 Tanta Street', N'Senior Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (206, N'Ghada Sherif', N'ghada.sherif@iti.gov.eg', N'ghadasherif206', '1986-09-13', N'Female', '2025-09-27', N'34 Asyut Street', N'Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (207, N'Reda Bassem', N'reda.bassem@iti.gov.eg', N'redabassem207', '1983-02-05', N'Male', '2025-10-21', N'67 Ismailia Street', N'Lead Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (208, N'Safaa Adly', N'safaa.adly@iti.gov.eg', N'safaaadly208', '1990-10-27', N'Female', '2025-11-16', N'12 Port Said Street', N'Senior Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (209, N'Essam Helmy', N'essam.helmy@iti.gov.eg', N'essamhelmy209', '1988-06-19', N'Male', '2025-09-29', N'45 Minya Street', N'Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (210, N'Naglaa Saad', N'naglaa.saad@iti.gov.eg', N'naglaasaad210', '1985-01-11', N'Female', '2025-10-26', N'78 Cairo Street', N'Lead Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (211, N'Medhat Kamal', N'medhat.kamal@iti.gov.eg', N'medhatkamal211', '1982-08-03', N'Male', '2025-11-11', N'23 Alexandria Street', N'Principal Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (212, N'Nadia Samy', N'nadia.samy@iti.gov.eg', N'nadiasamy212', '1991-03-25', N'Female', '2025-09-30', N'56 Giza Street', N'Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (213, N'Hany Maher', N'hany.maher@iti.gov.eg', N'hanymaher213', '1987-11-17', N'Male', '2025-10-17', N'89 Mansoura Street', N'Senior Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (214, N'Samar Hatem', N'samar.hatem@iti.gov.eg', N'samarhatem214', '1989-05-09', N'Female', '2025-11-22', N'34 Damanhur Street', N'Lead Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (215, N'Alaa Fahmy', N'alaa.fahmy@iti.gov.eg', N'alaafahmy215', '1984-12-31', N'Male', '2025-09-16', N'67 Tanta Street', N'Senior Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (216, N'Mervat Nasr', N'mervat.nasr@iti.gov.eg', N'mervatnasr216', '1986-07-23', N'Female', '2025-10-23', N'12 Asyut Street', N'Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (217, N'Farouk Naguib', N'farouk.naguib@iti.gov.eg', N'farouknaguib217', '1983-04-15', N'Male', '2025-11-07', N'45 Ismailia Street', N'Lead Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (218, N'Amal Wagdy', N'amal.wagdy@iti.gov.eg', N'amalwagdy218', '1990-09-07', N'Female', '2025-09-24', N'78 Port Said Street', N'Senior Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (219, N'Sami Fouad', N'sami.fouad@iti.gov.eg', N'samifouad219', '1988-02-29', N'Male', '2025-10-29', N'23 Minya Street', N'Instructor', 2);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (220, N'Injy Amr', N'injy.amr@iti.gov.eg', N'injyamr220', '1985-10-21', N'Female', '2025-11-14', N'56 Cairo Street', N'Lead Instructor', 2);

-- Department 3 (Networks & Security) - 30 instructors
INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (221, N'Waleed Samir', N'waleed.samir@iti.gov.eg', N'waleedsamir221', '1982-05-13', N'Male', '2025-09-04', N'89 Alexandria Street', N'Principal Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (222, N'Abeer Tawfik', N'abeer.tawfik@iti.gov.eg', N'abeertawfik222', '1991-12-05', N'Female', '2025-10-09', N'34 Giza Street', N'Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (223, N'Rafat Essam', N'rafat.essam@iti.gov.eg', N'rafatessam223', '1987-08-27', N'Male', '2025-11-02', N'67 Mansoura Street', N'Senior Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (224, N'Manal Fawzy', N'manal.fawzy@iti.gov.eg', N'manalfawzy224', '1989-04-19', N'Female', '2025-09-21', N'12 Damanhur Street', N'Lead Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (225, N'Samy Ramzy', N'samy.ramzy@iti.gov.eg', N'samyramzy225', '1984-11-11', N'Male', '2025-10-13', N'45 Tanta Street', N'Senior Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (226, N'Hend Soliman', N'hend.soliman@iti.gov.eg', N'hendsoliman226', '1986-06-03', N'Female', '2025-11-17', N'78 Asyut Street', N'Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (227, N'Ashraf Nour', N'ashraf.nour@iti.gov.eg', N'ashrafnour227', '1983-01-25', N'Male', '2025-09-13', N'23 Ismailia Street', N'Lead Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (228, N'Neveen Yousry', N'neveen.yousry@iti.gov.eg', N'neveenyousry228', '1990-08-17', N'Female', '2025-10-27', N'56 Port Said Street', N'Senior Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (229, N'Ayman Sobhy', N'ayman.sobhy@iti.gov.eg', N'aymansobhy229', '1988-03-09', N'Male', '2025-11-19', N'89 Minya Street', N'Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (230, N'Azza Mahmoud', N'azza.mahmoud@iti.gov.eg', N'azzamahmoud230', '1985-09-01', N'Female', '2025-09-28', N'34 Cairo Street', N'Lead Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (231, N'Ehab Fekry', N'ehab.fekry@iti.gov.eg', N'ehabfekry231', '1982-12-23', N'Male', '2025-10-15', N'67 Alexandria Street', N'Principal Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (232, N'Engy Kamel', N'engy.kamel@iti.gov.eg', N'engykamel232', '1991-06-15', N'Female', '2025-11-23', N'12 Giza Street', N'Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (233, N'Gamal Saeed', N'gamal.saeed@iti.gov.eg', N'gamalsaeed233', '1987-02-07', N'Male', '2025-09-17', N'45 Mansoura Street', N'Senior Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (234, N'Faten Shalaby', N'faten.shalaby@iti.gov.eg', N'fatenshalaby234', '1989-10-29', N'Female', '2025-10-31', N'78 Damanhur Street', N'Lead Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (235, N'Hamdy Ghoneim', N'hamdy.ghoneim@iti.gov.eg', N'hamdyghoneim235', '1984-07-21', N'Male', '2025-11-15', N'23 Tanta Street', N'Senior Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (236, N'Hanaa Morsy', N'hanaa.morsy@iti.gov.eg', N'hanaamorsy236', '1986-03-13', N'Female', '2025-09-25', N'56 Asyut Street', N'Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (237, N'Ismail Selim', N'ismail.selim@iti.gov.eg', N'ismailselim237', '1983-11-05', N'Male', '2025-10-20', N'89 Ismailia Street', N'Lead Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (238, N'Karima Adel', N'karima.adel@iti.gov.eg', N'karimaadel238', '1990-05-27', N'Female', '2025-11-25', N'34 Port Said Street', N'Senior Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (239, N'Lotfy Ibrahim', N'lotfy.ibrahim@iti.gov.eg', N'lotfyibrahim239', '1988-01-19', N'Male', '2025-09-31', N'67 Minya Street', N'Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (240, N'Maha Nabil', N'maha.nabil@iti.gov.eg', N'mahanabil240', '1985-08-11', N'Female', '2025-10-25', N'12 Cairo Street', N'Lead Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (241, N'Nasser Hamed', N'nasser.hamed@iti.gov.eg', N'nasserhamed241', '1982-04-03', N'Male', '2025-11-10', N'45 Alexandria Street', N'Principal Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (242, N'Olfat Hassan', N'olfat.hassan@iti.gov.eg', N'olfathassan242', '1991-11-25', N'Female', '2025-09-20', N'78 Giza Street', N'Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (243, N'Raafat Moussa', N'raafat.moussa@iti.gov.eg', N'raafatmoussa243', '1987-07-17', N'Male', '2025-10-18', N'23 Mansoura Street', N'Senior Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (244, N'Samia Labib', N'samia.labib@iti.gov.eg', N'samialabib244', '1989-02-09', N'Female', '2025-11-24', N'56 Damanhur Street', N'Lead Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (245, N'Tariq Anwar', N'tariq.anwar@iti.gov.eg', N'tariqanwar245', '1984-09-01', N'Male', '2025-09-15', N'89 Tanta Street', N'Senior Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (246, N'Wafaa Zayed', N'wafaa.zayed@iti.gov.eg', N'wafaazayed246', '1986-04-23', N'Female', '2025-10-30', N'34 Asyut Street', N'Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (247, N'Yehia Hosny', N'yehia.hosny@iti.gov.eg', N'yehiahosny247', '1983-12-15', N'Male', '2025-11-20', N'67 Ismailia Street', N'Lead Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (248, N'Zeinab Atef', N'zeinab.atef@iti.gov.eg', N'zeinabatef248', '1990-06-07', N'Female', '2025-09-26', N'12 Port Said Street', N'Senior Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (249, N'Bassem Salah', N'bassem.salah@iti.gov.eg', N'bassemsalah249', '1988-10-29', N'Male', '2025-10-21', N'45 Minya Street', N'Instructor', 3);

INSERT INTO dbo.Instructor ([Inst_ID], [Inst_Name], [Email], [Username], [Date_of_Birth], [Gender], [Hire_Date], [Address], [Academic_Rank], [Dep_ID])
VALUES (250, N'Zaki Fahim', N'zaki.fahim@iti.gov.eg', N'zakifahim250', '1985-02-21', N'Male', '2025-11-26', N'78 Cairo Street', N'Lead Instructor', 3);

SET IDENTITY_INSERT dbo.Instructor OFF;
GO

PRINT 'Step 5/10: 100 New instructors added successfully! (IDs: 151-250)';
GO
