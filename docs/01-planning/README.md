# Project Planning & Design

## Overview

This phase documents the planning and evaluation work completed before the technical implementation of the PandemyResearch database environment.

The project scenario was based on **PandaResearch GmbH**, which required a relational database system for the PandemyResearch application. Current pandemic data should be obtained from official sources, processed, stored in the database and later imported automatically.

The project was carried out within a client-based scenario defined by **DoubleCheck GmbH**.

## Objectives

The planning phase focused on:

- analysing the client and system requirements
- defining hardware and software requirements
- evaluating database availability and scalability
- comparing licensing, support and operating costs
- considering existing technical knowledge
- identifying project and operational risks
- defining project phases and milestones
- preparing a documented solution proposal

## Database Evaluation

Five relational database solutions were evaluated:

1. Microsoft SQL Server 2025 Express
2. Oracle Database 19c SE2 on Windows
3. Oracle Database 19c SE2 on Linux
4. MySQL 8.4 LTS Community Edition
5. MariaDB 11.8 LTS Community Server

The solutions were compared using common technical and operational criteria such as functionality, availability, scalability, administration, costs, support and required know-how.

## Evaluation Result

The qualitative evaluation showed that all five database systems could fulfil the fundamental requirements of PandemyResearch, but with different trade-offs.

The utility analysis resulted in:

- MySQL 8.4 LTS – 84%
- MariaDB 11.8 LTS – 84%
- Microsoft SQL Server – 82%
- Oracle Database on Windows – 76%
- Oracle Database on Linux – 76%

The evaluation also included cost and benefit considerations, infrastructure sizing and project risks.

## Project Methodology

The planning and documentation were structured according to the **HERMES project management methodology**.

The work included:

- system context and boundaries
- requirements analysis
- solution variants
- utility analysis
- cost and risk assessment
- project milestones
- target/actual comparison

## Relation to the Implementation

This planning phase represents the evaluation and design stage of the overall PandemyResearch project.

The subsequent sections of this repository document the practical implementation of a Windows Server and Microsoft SQL Server environment, followed by database operations, data processing and automation.

The evaluation results are retained here as the documented outcome of the planning phase, while the later technical implementation is documented separately.
