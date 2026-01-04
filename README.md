# 🎓 Examination System & Data Warehouse (End-to-End Project)
**ITI Graduation Project | Data Analysis Track**

![Power BI Badge](https://img.shields.io/badge/Power%20BI-Desktop-yellow)
![Fabric Badge](https://img.shields.io/badge/Microsoft-Fabric-blue)
![SQL Badge](https://img.shields.io/badge/SQL-Server-red)
![SSRS Badge](https://img.shields.io/badge/SSRS-Reporting-orange)

## 📌 Project Overview
This project represents a full-cycle data engineering and analytics solution for an educational institution. [cite_start]It starts with building a robust **Transactional Database (OLTP)** to manage the examination process (students, exams, questions, grading) and ends with a **Modern Data Warehouse** on **Microsoft Fabric** to analyze student performance and freelance market impact[cite: 26, 718, 727].

[cite_start]The system allows instructors to generate random exams, grade them automatically via Stored Procedures, and enables management to visualize success rates and student career outcomes via Power BI[cite: 27, 28].

---

## 🏗️ High-Level Architecture
The project follows a modern data pipeline flow:
1.  **OLTP:** SQL Server for transaction handling.
2.  **Reporting:** SSRS for operational documents (Grades, Certificates).
3.  **Cloud Storage:** Azure SQL Database & OneLake.
4.  **ETL:** Microsoft Fabric Dataflow Gen2.
5.  **Analytics:** Power BI connected to a Star Schema Semantic Model.

*(Insert your Architecture Diagram here - from PDF Page 24)*
![Architecture](./03-Cloud-Data-Warehouse-Fabric/Architecture_Diagram.png)

---

## 🛠️ Technical Implementation

### Phase 1: SQL Server OLTP & Advanced Logic
[cite_start]Designed a normalized database (`Examination_System`) to handle complex many-to-many relationships between Students, Courses, and Exams[cite: 2, 99].
* [cite_start]**Schema:** Modeled entities including `Student`, `Instructor`, `Course`, `Question_Pool`, and `Exam_Qup` (Question mapping)[cite: 63, 70, 73].
* **Stored Procedures:** Implemented complex business logic using T-SQL:
    * [cite_start]`sp_CreateExam`: Automates exam generation (Random or Manual selection of questions)[cite: 168, 185].
    * [cite_start]`sp_StudentSubmitExam`: Handles student answer submission and calculates initial scores[cite: 222].
    * [cite_start]`sp_OpenNewIntake`: Automates the administrative setup for new academic years[cite: 138].

### Phase 2: Operational Reporting (SSRS)
Developed reports using Visual Studio for immediate administrative use:
* [cite_start]**Student Grades Report:** parameterized by Student ID to show transcripts[cite: 269].
* [cite_start]**Instructor Course Report:** Analyzes teaching loads and student counts per course[cite: 499].

### Phase 3: Microsoft Fabric & ETL
[cite_start]Migrated data to the cloud using **Microsoft Azure** and **Fabric Dataflow Gen2** to transition from a normalized schema (3NF) to a denormalized schema for analytics[cite: 646, 744, 1083].
* [cite_start]**Transformation:** Used Power Query in Fabric to clean data and select relevant columns[cite: 912].
* **Data Modeling (Star Schema):** Created a Data Warehouse with:
    * [cite_start]**Fact Table:** `FactStudentGrades`[cite: 1134].
    * [cite_start]**Dimension Tables:** `DimStudent`, `DimBranch`, `DimCourse`, `DimInstructor`, `DimDate`[cite: 917, 919, 1040].

### Phase 4: Power BI Analytics
Built comprehensive dashboards to track KPIs across Intakes, Branches, and Tracks.

#### 📊 Dashboard Highlights:
1.  [cite_start]**Intake & Branch Performance:** Visualizes the Pass/Fail rate (Current Rate: **93.06%**) and student distribution across branches like Cairo and Alexandria[cite: 1608, 1613].
2.  **Student Freelancing Insights:** A unique module analyzing student income from platforms like *Upwork* and *Freelancer*.
    * [cite_start]*Insight:* **TopTal** and **Mostaql** generated the highest revenue for students[cite: 2284].
3.  [cite_start]**Instructor Analysis:** Monitors active instructors and student-to-instructor ratios across departments[cite: 1748, 1871].

*(Insert Power BI Screenshot here)*
![Dashboard](./04-PowerBI-Dashboards/Dashboard_Intake_Overview.png)

---

## 📈 Key Insights & Results
* [cite_start]**High Success Rate:** The system recorded a 93.06% pass rate across 10,082 total success cases[cite: 1470, 1608].
* [cite_start]**Freelance Impact:** Tracked over **$882k** in student freelance revenue, proving the curriculum's market relevance[cite: 2281].
* [cite_start]**Scalability:** The move to a Star Schema in Fabric improved query performance for historical data analysis[cite: 1083].

---

## 💻 How to Run
1.  Execute the scripts in `/01-OLTP-Database-Design` to set up the SQL DB.
2.  Review the `Fabric` documentation in `/03-Cloud-Data-Warehouse-Fabric` to understand the ETL flow.
3.  Open the `.pbix` file in Power BI Desktop to interact with the dashboards.

---
*Created by [Your Name] - ITI Data Analysis Track 2025*
