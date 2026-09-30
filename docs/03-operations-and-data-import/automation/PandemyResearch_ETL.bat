@echo off
title PandemyResearch - Automatisierter ETL-Ablauf

echo ================================================
echo PandemyResearch - ETL-Automatisierung
echo ================================================
echo.

pushd "%~dp0"

echo [1/6] STAGE-Tabellen erstellen...
sqlcmd -C -S YOUR_SQL_SERVER,1433 -d PandemyResearch -E -i "..\sql\01_Create_Stage_Tables.sql"
if errorlevel 1 goto ERROR

echo.
echo [2/6] CSV-Daten importieren...
sqlcmd -C -S YOUR_SQL_SERVER,1433 -d PandemyResearch -E -i "..\sql\02_BulkImport.sql"
if errorlevel 1 goto ERROR

echo.
echo [3/6] Quelldaten validieren...
sqlcmd -C -S YOUR_SQL_SERVER,1433 -d PandemyResearch -E -i "..\sql\03_Validate_Data.sql"
if errorlevel 1 goto ERROR

echo.
echo [4/6] Daten transformieren...
sqlcmd -C -S YOUR_SQL_SERVER,1433 -d PandemyResearch -E -i "..\sql\04_Transform_Data.sql"
if errorlevel 1 goto ERROR

echo.
echo [5/6] Transformierte Daten testen...
sqlcmd -C -S YOUR_SQL_SERVER,1433 -d PandemyResearch -E -i "..\sql\05_Test_Data.sql"
if errorlevel 1 goto ERROR

echo.
echo [6/6] Abschlusskontrolle...
sqlcmd -C -S YOUR_SQL_SERVER,1433 -d PandemyResearch -E -i "..\sql\06_Automation.sql"
if errorlevel 1 goto ERROR

echo.
echo ================================================
echo ETL-ABLAUF ERFOLGREICH ABGESCHLOSSEN
echo ================================================
echo.

pause
exit /b 0

:ERROR
echo.
echo ================================================
echo FEHLER: ETL-ABLAUF WURDE ABGEBROCHEN
echo ================================================
echo.

pause
exit /b 1