# ETL Automation

## Overview

This directory contains the batch script used to automate the SQL ETL workflow.

The script executes the SQL files in sequence using `sqlcmd`.

## Automated Workflow

1. Create staging tables
2. Import CSV data
3. Validate imported data
4. Transform data
5. Test data quality
6. Complete the automated workflow

## Script

`PandemyResearch_ETL.bat`

The published version uses sanitized environment-specific configuration values.
