# Operations & Data Import

## Overview

This phase documents the operational use of the PandemyResearch database environment and the import of current pandemic data from official Swiss open-data sources.

The objective was to prepare source data for the PandemyResearch database, import it into Microsoft SQL Server and provide a repeatable process for ongoing data loading and validation.

## Data Import Process

The data import process follows a staged approach:

1. Analyse the available CSV source files
2. Select the data required by the PandemyResearch data model
3. Create staging tables for the source data
4. Load CSV data into the staging area using SQL Server `BULK INSERT`
5. Validate the imported values
6. Convert source values into the required database data types
7. Transfer the validated data into the PandemyResearch application tables
8. Perform functional checks after the import

## ETL Workflow

The project contains SQL scripts covering the main processing steps:

- creation of staging tables
- bulk import of CSV files
- validation of imported data
- transformation into the target schema
- data testing
- automation of the processing workflow

The scripts are available in the repository's `sql/` directory.

## Automation

The SQL processing workflow can be executed sequentially using a batch script.

The automation runs the required SQL scripts in the correct order and supports a repeatable data-import process.

The automation script is available in the repository's `automation/` directory.

## Operations Documentation

The operational documentation covers:

- hardware and software components
- database operation and administration
- database start, stop and restart procedures
- backup and recovery
- application data model
- data-import model
- data-import procedure and scripts

## Project Context

This phase builds on the database environment created during the previous implementation phase.

Together, the three project phases document the complete workflow:

1. **Planning & Design** – evaluation and project planning
2. **System Implementation** – server and database implementation
3. **Operations & Data Import** – operation, data loading, validation and automation
