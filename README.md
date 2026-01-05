# ITI Examination System - End-to-End Data Analytics Solution

![Project Banner](images/architecture_diagram.jpg)

A comprehensive examination management and analytics system built during my graduation from ITI's Data Analysis & Power BI track. This project demonstrates full-stack data engineering and analytics capabilities, from database design through cloud deployment to interactive dashboards.

## 🎯 Project Overview

The ITI Examination System enables educational institutions to manage exams, track student performance, and generate actionable insights across multiple branches, tracks, and intakes. The system serves three main user groups:

- **Instructors:** Create exams, review student performance, analyze teaching effectiveness
- **Students:** Take exams, track progress, view grades and certifications
- **Administrators:** Monitor branch performance, analyze trends, make data-driven decisions

## 📊 Key Achievements

- Designed and implemented a **normalized relational database** with 15+ tables
- Built **12 stored procedures** for complex business logic and exam processing
- Created **7 SSRS reports** for administrative and academic insights
- Deployed to **Microsoft Azure** for scalable cloud hosting
- Engineered **ETL pipelines** in Microsoft Fabric with PySpark
- Designed **Star Schema data warehouse** for optimized analytics
- Developed **14 interactive Power BI dashboards** with 50+ KPIs

## 🏗️ System Architecture

```
┌─────────────────┐
│   SQL Server    │  ← Transactional Database (OLTP)
│   Database      │     - 15+ normalized tables
└────────┬────────┘     - Stored procedures & triggers
         │
         ↓
┌─────────────────┐
│ Microsoft Azure │  ← Cloud Hosting
│   SQL Database  │     - Secure data storage
└────────┬────────┘     - Automated backups
         │
         ↓
┌─────────────────┐
│ Microsoft       │  ← Data Pipeline & Transformation
│   Fabric        │     - PySpark notebooks
└────────┬────────┘     - Data flows & orchestration
         │
         ↓
┌─────────────────┐
│  Data Warehouse │  ← Analytics Layer (OLAP)
│  (Star Schema)  │     - Fact tables: Exams, Enrollments
└────────┬────────┘     - Dimension tables: Students, Courses, Time
         │
         ↓
┌─────────────────┐
│    Power BI     │  ← Visualization & Insights
│   Dashboards    │     - 14 interactive dashboards
└─────────────────┘     - Role-based access
```

## 🛠️ Technologies Used

| Category | Technologies |
|----------|-------------|
| **Database** | SQL Server 2019, T-SQL, Stored Procedures |
| **Cloud Platform** | Microsoft Azure (SQL Database, Storage) |
| **ETL/Data Engineering** | Microsoft Fabric, PySpark, Data Pipelines |
| **Data Modeling** | Star Schema, Dimensional Modeling |
| **Reporting** | SQL Server Reporting Services (SSRS) |
| **Visualization** | Power BI Desktop, Power BI Service |
| **Design** | Draw.io (ERD & Process Mapping) |
| **AI-Assisted Development** | ChatGPT, Gemini (Data generation & optimization) |

## 📁 Repository Structure

```
iti-examination-system/
├── README.md                          # This file
├── docs/
│   ├── PROJECT_OVERVIEW.md           # Detailed project documentation
│   ├── DATABASE_DESIGN.md            # Database schema explanation
│   ├── ETL_PIPELINE.md               # Data pipeline documentation
│   └── DASHBOARD_GUIDE.md            # Power BI dashboard user guide
├── database/
│   ├── schema/
│   │   ├── 01_create_tables.sql     # Table creation scripts
│   │   ├── 02_relationships.sql      # Foreign keys & constraints
│   │   └── 03_indexes.sql           # Performance optimization
│   ├── stored_procedures/
│   │   ├── sp_open_intake.sql       # Open new academic intake
│   │   ├── sp_assign_instructor.sql  # Assign instructors to courses
│   │   ├── sp_create_exam.sql       # Exam creation (manual/random)
│   │   ├── sp_submit_answers.sql    # Process student submissions
│   │   └── ... (8 more procedures)
│   └── sample_data/
│       └── insert_dummy_data.sql     # Sample data for testing
├── erd/
│   ├── examination_system.drawio     # ERD source file
│   ├── examination_system_erd.png    # ERD diagram image
│   └── process_mapping.png           # Business process flow
├── fabric/
│   ├── notebooks/
│   │   └── etl_pipeline.ipynb       # PySpark data transformation
│   └── pipelines/
│       └── pipeline_config.json      # Data pipeline configuration
├── ssrs_reports/
│   ├── student_grades.rdl           # Student grade report
│   ├── department_roster.rdl        # Department student list
│   ├── track_branches.rdl           # Track-branch mapping
│   ├── instructor_courses.rdl       # Instructor course assignments
│   ├── student_certifications.rdl   # Student certifications
│   └── exam_questions.rdl           # Exam question details
├── powerbi/
│   ├── examination_system.pbix      # Main Power BI file
│   └── screenshots/                  # Dashboard screenshots
│       ├── 01_intake_overview.png
│       ├── 02_branch_performance.png
│       ├── 03_student_analytics.png
│       └── ... (11 more dashboards)
├── presentation/
│   └── graduation_presentation.pdf   # Final presentation slides
└── images/
    └── architecture_diagram.png      # System architecture
```

## 🚀 Key Features

### 1. Database Management
- **Normalized design** (3NF) with proper relationships and constraints
- **Stored procedures** for all business logic (no business logic in application layer)
- **Automated exam grading** with configurable question types
- **Audit trails** for all critical operations

### 2. Cloud Infrastructure
- **Azure SQL Database** for high availability and automatic backups
- **Scalable architecture** supporting multiple branches and thousands of students
- **Security** with role-based access control

### 3. Data Pipeline (Microsoft Fabric)
- **Incremental loading** from transactional database
- **PySpark transformations** for data quality and enrichment
- **Automated scheduling** with pipeline orchestration
- **Star schema generation** for optimized analytics

### 4. Analytics & Reporting

**SSRS Reports (7 reports):**
- Student grade reports with filtering by intake/branch
- Department rosters with enrollment details
- Instructor teaching assignments
- Exam question pools
- Student certification tracking

**Power BI Dashboards (14 dashboards):**
- **Intake Level:** Overall performance, enrollment trends
- **Branch Level:** Branch comparison, regional insights
- **Department Level:** Department performance metrics
- **Track Level:** Track-specific analytics
- **Instructor Level:** Teaching effectiveness, student outcomes
- **Course Level:** Course difficulty analysis, pass rates
- **Student Level:** Individual progress tracking, freelancing readiness
- **Exam Level:** Exam difficulty, question analysis

## 📈 Sample Insights Generated

From the Power BI dashboards, stakeholders can answer questions like:

- Which branches have the highest student performance?
- What is the average exam score trend across intakes?
- Which instructors have the highest student satisfaction?
- Which courses have the highest failure rates?
- How do students in different tracks compare?
- What percentage of students are freelancing-ready?
- Which exam questions are too easy or too hard?

## 🎓 Business Impact

- **Improved exam efficiency:** Automated grading reduces manual work by 80%
- **Better decision-making:** Real-time dashboards enable data-driven decisions
- **Enhanced transparency:** Students can track their progress instantly
- **Quality assurance:** Identify struggling students early for intervention
- **Resource optimization:** Data-driven instructor and course assignments

## 🔧 Setup & Installation

### Prerequisites
- SQL Server 2019 or later
- Microsoft Fabric workspace
- Power BI Desktop
- Azure subscription (optional, for cloud deployment)

### Quick Start

1. **Set up the database:**
```sql
-- Run scripts in order
USE master;
GO
CREATE DATABASE ITI_Examination_System;
GO
USE ITI_Examination_System;
GO

-- Execute table creation scripts
:r database/schema/01_create_tables.sql
:r database/schema/02_relationships.sql
:r database/schema/03_indexes.sql

-- Load sample data
:r database/sample_data/insert_dummy_data.sql

-- Create stored procedures
:r database/stored_procedures/*.sql
```

2. **Deploy to Azure (Optional):**
- See `docs/AZURE_DEPLOYMENT.md` for step-by-step guide

3. **Configure Fabric Pipeline:**
- Import `fabric/notebooks/etl_pipeline.ipynb`
- Update connection strings in pipeline config
- Schedule pipeline execution

4. **Open Power BI:**
- Open `powerbi/examination_system.pbix`
- Update data source connections
- Refresh data

## 📚 Documentation

- [Complete Project Documentation](docs/PROJECT_OVERVIEW.md)
- [Database Design Details](docs/DATABASE_DESIGN.md)
- [ETL Pipeline Guide](docs/ETL_PIPELINE.md)
- [Dashboard User Guide](docs/DASHBOARD_GUIDE.md)

## 🎯 Skills Demonstrated

This project showcases proficiency in:

✅ **SQL & Database Design**
- Complex schema design with normalization
- Advanced T-SQL (CTEs, window functions, recursive queries)
- Stored procedure development
- Performance optimization (indexing, query tuning)

✅ **Cloud Computing**
- Azure SQL Database deployment
- Cloud resource management
- Security and access control

✅ **Data Engineering**
- ETL pipeline design and implementation
- PySpark for large-scale data processing
- Data quality and validation
- Incremental data loading

✅ **Data Modeling**
- Dimensional modeling (Star Schema)
- Fact and dimension table design
- Slowly changing dimensions (SCD)

✅ **Business Intelligence**
- Interactive dashboard development
- DAX calculations and measures
- Report design and optimization
- Storytelling with data

✅ **Project Management**
- End-to-end system design
- Documentation and knowledge transfer
- Stakeholder communication

## 🔮 Future Enhancements

- [ ] Machine learning model to predict student performance
- [ ] Real-time exam monitoring dashboard
- [ ] Mobile app integration
- [ ] Question recommendation system using NLP
- [ ] Automated anomaly detection for cheating prevention
- [ ] Integration with Learning Management Systems (LMS)



---

## 🙏 Acknowledgments

- **ChatGPT & Gemini** for AI-assisted data generation
- **Microsoft Azure & Fabric** for cloud platform and tools

---

**⭐ If you find this project helpful, please star this repository!**

*This project uses dummy data for demonstration purposes. No real student information is included.*
