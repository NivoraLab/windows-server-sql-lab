# Windows Server & SQL Server Lab

## Overview

This project documents the setup and administration of a virtualized Windows Server environment with Microsoft SQL Server.

The project combines server administration, database management, an ETL workflow, automation, backup and recovery procedures.

## Technologies

- Windows Server
- VMware Workstation
- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- SQL
- sqlcmd
- Windows Batch

## What I Implemented

- Created and configured a Windows Server virtual machine
- Installed and configured Microsoft SQL Server and SSMS
- Created and administered a SQL Server database
- Configured users, roles and permissions
- Created staging tables for data imports
- Imported CSV data using SQL scripts
- Validated and transformed imported data
- Created SQL-based data quality tests
- Automated the ETL workflow using a Windows batch script and sqlcmd
- Performed database backup and restore
- Tested database recovery procedures

## ETL Workflow

The data processing workflow consists of six SQL steps:

1. Create staging tables
2. Import CSV data
3. Validate imported data
4. Transform data
5. Test data quality
6. Complete the automated workflow

The SQL scripts are executed sequentially through the batch automation script.

## Project Structure

```text
windows-server-sql-lab/
├── automation/
│   ├── PandemyResearch_ETL.bat
│   └── README.md
├── docs/
│   ├── architecture.md
│   └── backup-recovery.md
├── sql/
│   ├── 01_Create_Stage_Tables.sql
│   ├── 02_BulkImport.sql
│   ├── 03_Validate_Data.sql
│   ├── 04_Transform_Data.sql
│   ├── 05_Test_Data.sql
│   ├── 06_Automation.sql
│   └── README.md
└── README.md
