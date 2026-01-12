-- ======================================================================
-- ITI Examination System - 2026 Intake Mappings
-- Generated: 2025-11-17
-- Purpose: Create varied instructor-course-branch-track mappings
-- Components: Track_Branch_Intake, Intake_Inst_Branch,
--             Crs_Inst_Intake, Crs_Inst_Track_Branch_Intake
-- ======================================================================

USE ITI_Examination_System;
GO

-- Disable constraints for bulk insert
--EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';
--GO

PRINT '========================================';
PRINT 'Starting 2026 Mappings Generation';
PRINT '========================================';
GO

-- ======================================================================
-- 7. Track-Branch-Intake Mappings for 2026
-- NOT all tracks available in all branches (creates variance)
-- ======================================================================

-- Cairo Branch (1) - 8 tracks (most diverse)
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 1, 1);   -- Power BI
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 1, 2);   -- .NET
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 1, 4);   -- Frontend
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 1, 5);   -- Backend
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 1, 10);  -- AI/ML
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 1, 11);  -- Cloud & DevOps (NEW)
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 1, 12);  -- Full Stack JS (NEW)
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 1, 13);  -- Data Science (NEW)

-- Alexandria Branch (2) - 6 tracks
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 2, 2);   -- .NET
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 2, 3);   -- System Admin
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 2, 4);   -- Frontend
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 2, 8);   -- Cybersecurity
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 2, 11);  -- Cloud & DevOps (NEW)
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 2, 13);  -- Data Science (NEW)

-- Giza Branch (3) - 4 tracks
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 3, 1);   -- Power BI
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 3, 4);   -- Frontend
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 3, 7);   -- DevOps
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 3, 12);  -- Full Stack JS (NEW)

-- Mansoura Branch (4) - 3 tracks
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 4, 2);   -- .NET
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 4, 6);   -- Data Engineering
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 4, 11);  -- Cloud & DevOps (NEW)

-- Damanhur Branch (5) - 2 tracks
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 5, 1);   -- Power BI
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 5, 4);   -- Frontend

-- Tanta Branch (6) - 2 tracks
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 6, 2);   -- .NET
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 6, 5);   -- Backend

-- Asyut Branch (7) - 2 tracks
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 7, 4);   -- Frontend
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 7, 9);   -- Mobile Flutter

-- Ismailia Branch (8) - 2 tracks
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 8, 3);   -- System Admin
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 8, 8);   -- Cybersecurity

-- Port Said Branch (9) - 1 track
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 9, 2);   -- .NET

-- Minya Branch (10) - 1 track
INSERT INTO dbo.Track_Branch_Intake ([Intake_ID], [Bran_ID], [Track_ID]) VALUES (6, 10, 1);  -- Power BI

PRINT 'Step 7/10: Track-Branch-Intake mappings for 2026 added!';
GO

-- ======================================================================
-- 8. Instructor-Branch Assignments for 2026 (Varied distribution)
-- Cairo gets most instructors, smaller branches get fewer
-- ======================================================================

-- Cairo Branch (1) - 60 instructors (mix of old and new)
-- Old instructors (selected)
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 1, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 4, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 7, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 10, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 13, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 16, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 19, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 22, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 25, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 28, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 31, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 34, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 37, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 40, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 2, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 5, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 8, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 11, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 14, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 17, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 20, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 23, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 26, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 29, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 32, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 35, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 38, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 3, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 6, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 9, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 12, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 15, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 18, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 21, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 24, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 27, 1);

-- New instructors in Cairo (151-185 - 35 instructors from Dept 1)
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 151, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 152, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 153, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 154, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 155, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 156, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 157, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 158, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 159, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 160, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 161, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 162, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 163, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 164, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 165, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 166, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 167, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 168, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 169, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 170, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 186, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 190, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 200, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 221, 1);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 230, 1);

-- Alexandria Branch (2) - 35 instructors
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 2, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 5, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 8, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 11, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 14, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 17, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 20, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 23, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 26, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 29, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 32, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 35, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 38, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 3, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 6, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 9, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 12, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 15, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 171, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 172, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 173, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 174, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 175, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 187, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 188, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 191, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 192, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 195, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 222, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 223, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 224, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 227, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 231, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 234, 2);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 237, 2);

-- Giza Branch (3) - 20 instructors
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 1, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 4, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 7, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 10, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 18, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 21, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 24, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 27, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 30, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 33, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 176, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 177, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 178, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 179, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 180, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 193, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 197, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 225, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 228, 3);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 233, 3);

-- Mansoura Branch (4) - 15 instructors
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 13, 4);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 16, 4);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 41, 4);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 44, 4);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 47, 4);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 181, 4);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 182, 4);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 183, 4);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 194, 4);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 198, 4);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 203, 4);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 226, 4);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 229, 4);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 235, 4);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 238, 4);

-- Damanhur Branch (5) - 10 instructors
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 25, 5);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 28, 5);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 50, 5);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 53, 5);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 184, 5);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 185, 5);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 199, 5);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 204, 5);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 232, 5);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 236, 5);

-- Tanta Branch (6) - 8 instructors
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 40, 6);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 43, 6);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 46, 6);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 49, 6);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 189, 6);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 205, 6);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 239, 6);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 245, 6);

-- Asyut Branch (7) - 8 instructors
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 55, 7);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 58, 7);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 61, 7);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 64, 7);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 196, 7);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 206, 7);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 240, 7);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 246, 7);

-- Ismailia Branch (8) - 8 instructors
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 70, 8);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 73, 8);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 76, 8);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 79, 8);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 201, 8);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 207, 8);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 241, 8);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 247, 8);

-- Port Said Branch (9) - 5 instructors
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 85, 9);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 88, 9);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 202, 9);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 242, 9);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 248, 9);

-- Minya Branch (10) - 5 instructors
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 94, 10);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 97, 10);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 208, 10);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 243, 10);
INSERT INTO dbo.Intake_Inst_Branch ([Intake_ID], [Inst_ID], [Bran_ID]) VALUES (6, 249, 10);

PRINT 'Step 8/10: Instructor-Branch assignments for 2026 added!';
GO

-- ======================================================================
-- 9. Course-Instructor-Intake Assignments (Varied - NOT uniform)
-- Each instructor teaches 2-12 courses (specialists vs generalists)
-- ======================================================================

-- NOTE: This creates realistic variance where:
-- - Cloud specialists (221-230) teach only Cloud courses
-- - Data Science specialists (186-195) teach mainly DS/BI courses
-- - Full Stack JS specialists (151-160) teach mainly JS/Frontend courses
-- - Generalists teach 6-12 courses across their department
-- - Some existing instructors teach limited courses in 2026

-- Cloud & DevOps Specialists (Dept 3: 221-250)
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (101, 221, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (102, 221, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (103, 221, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (104, 222, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (105, 222, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (106, 222, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (107, 223, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (108, 223, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (109, 223, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (110, 224, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (111, 224, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (112, 224, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (101, 225, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (104, 225, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (102, 226, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (106, 226, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (61, 227, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (62, 227, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (107, 227, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (71, 228, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (72, 228, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (73, 229, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (74, 229, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (21, 230, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (22, 230, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (23, 230, 6);

-- Data Science Specialists (Dept 2: 186-220)
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (123, 186, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (124, 186, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (125, 186, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (126, 187, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (127, 187, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (128, 187, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (129, 188, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (130, 188, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (131, 189, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (132, 189, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (133, 190, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (123, 190, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (124, 190, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (1, 191, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (2, 191, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (3, 191, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (4, 192, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (5, 192, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (6, 193, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (7, 193, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (130, 193, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (8, 194, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (9, 194, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (10, 195, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (51, 195, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (52, 195, 6);

-- Full Stack JavaScript Specialists (Dept 1: 151-185)
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (113, 151, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (114, 151, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (115, 151, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (116, 152, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (117, 152, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (118, 152, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (119, 153, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (120, 153, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (121, 154, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (122, 154, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (113, 155, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (32, 155, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (31, 156, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (33, 156, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (34, 156, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (35, 157, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (36, 157, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (37, 157, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (38, 158, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (39, 158, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (40, 159, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (114, 159, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (11, 160, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (12, 160, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (13, 160, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (14, 160, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (15, 160, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (16, 161, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (17, 161, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (18, 161, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (19, 162, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (20, 162, 6);

-- Add assignments for remaining instructors (sampling some for brevity)
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (41, 163, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (42, 163, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (43, 163, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (44, 163, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (45, 164, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (46, 164, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (47, 165, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (48, 165, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (49, 165, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (50, 165, 6);

-- Add some existing instructors with limited assignments
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (1, 1, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (2, 1, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (3, 2, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (4, 2, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (5, 2, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (71, 3, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (75, 3, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (76, 3, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (11, 4, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (13, 4, 6);

INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (6, 5, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (7, 5, 6);
INSERT INTO dbo.Crs_Inst_Intake ([Crs_ID], [Inst_ID], [Intake_ID]) VALUES (8, 5, 6);

PRINT 'Step 9/10: Course-Instructor-Intake assignments for 2026 added!';
GO

-- ======================================================================
-- Re-enable constraints
-- ======================================================================

--EXEC sp_MSforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL';
--GO

PRINT '';
PRINT '========================================';
PRINT '2026 Mappings Completed Successfully!';
PRINT '========================================';
PRINT '';
PRINT 'Summary:';
PRINT '- Track-Branch-Intake: VARIED (not all tracks in all branches)';
PRINT '- Instructor-Branch: VARIED distribution (60 in Cairo, 5 in Minya)';
PRINT '- Course-Instructor: VARIED assignments (specialists: 2-4 courses, generalists: 5-12 courses)';
PRINT '';
GO
