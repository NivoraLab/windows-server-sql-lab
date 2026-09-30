# Project Screenshots

This section provides visual documentation of the Windows Server and Microsoft SQL Server lab environment.

The project covers the configuration of a virtualized Windows Server, network and firewall configuration, SQL Server administration, database security, testing, backup, and recovery.

## Project Context

This project was completed as part of my IT platform development training using a client-based project scenario with **DoubleCheck GmbH** as the defined client.

The scenario is based on **PandaResearch GmbH**, which requires a relational database environment for the **PandemyResearch** application used to analyse COVID-19 and other datasets.

My task was to prepare and configure the database server environment for operational use. This included:

- configuring a virtual machine and Windows Server
- implementing the network and firewall configuration
- installing and configuring Microsoft SQL Server
- creating the PandemyResearch database and physical database schema
- configuring database users, roles, permissions, and storage
- performing functional and database integrity tests
- creating a database backup
- testing database restore and recovery

The implementation and technical documentation were produced according to the **HERMES project management methodology**, including an integration and installation guide.

The screenshots below document the practical implementation and verification of the environment.

## Environment Setup

### Virtual Machine

![Virtual Machine Configuration](01-virtual-machine.png)

Windows Server virtual machine configured in VMware Workstation for the database environment.

### Windows Server

![Windows Server](02-windows-server.png)

Windows Server environment used to host and administer the Microsoft SQL Server database system.

## Network Configuration

### Network Configuration

![Network Configuration](03-network-configuration.png)

Network configuration of the Windows Server environment.

### Firewall Configuration

![Firewall Configuration](04-firewall-configuration.png)

Windows Defender Firewall configuration used to allow the required SQL Server network communication.

### SQL Server Network Configuration

![SQL Server Network Configuration](05-sql-server-network.png)

SQL Server TCP/IP network configuration for database connectivity.

## SQL Server and Database

### SQL Server Installation

![SQL Server Installation](06-sql-server-installation.png)

Successful installation of Microsoft SQL Server and the required database services.

### Database Structure

![Database Structure](07-database-structure.png)

Implementation of the relational database structure in Microsoft SQL Server Management Studio.

### Database Schema

![Database Schema](08-database-schema.png)

Verification of primary and foreign key constraints within the database schema.

### User Permissions

![User Permissions](09-user-permissions.png)

Database user configuration and role assignment demonstrating controlled access to the PandemyResearch database.

### Database Storage

![Database Storage](10-database-storage.png)

Configuration of the database data and transaction log storage.

## Testing and Validation

### Database Functionality Test

![Database Functionality Test](11-database-test.png)

Functional SQL test used to verify database access and data operations.

### Database Integrity Check

![Database Integrity Check](12-integrity-check.png)

Database integrity verification using SQL Server DBCC CHECKDB.

## Backup and Recovery

### Database Backup

![Database Backup](13-database-backup.png)

Successful backup of the PandemyResearch database.

### Database Restore

![Database Restore](14-database-restore.png)

Successful restoration of the database into a separate recovery test database.

### Recovery Test

![Recovery Test](15-recovery-test.png)

Verification of the restored `PandemyResearch_RestoreTest` database after the recovery procedure.

---

These screenshots document the practical implementation and testing of the Windows Server and SQL Server environment. Additional SQL scripts and technical documentation are available in the repository.
