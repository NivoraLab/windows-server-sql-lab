USE PandemyResearch;
GO

BULK INSERT dbo.STAGE_COVID19Cases_geoRegion
FROM 'C:\Data\Import\COVID19Cases_geoRegion.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO


-- ============================================================
-- Import: COVID19Death_geoRegion.csv
-- Zweck: Importiert die BAG-Todesfalldaten in die STAGE-Tabelle.
-- Die CSV-Kopfzeile wird mit FIRSTROW = 2 übersprungen.
-- ============================================================

BULK INSERT dbo.STAGE_COVID19Death_geoRegion
FROM 'C:\Data\Import\COVID19Death_geoRegion.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO



-- =========================================================
-- Import: COVID19Test_geoRegion_all
-- Importiert die BAG-Testdaten in die STAGE-Tabelle.
-- Die erste Zeile der CSV-Datei enthält die Spaltennamen
-- und wird deshalb übersprungen.
-- =========================================================

BULK INSERT dbo.STAGE_COVID19Test_geoRegion_all
FROM 'C:\Data\Import\COVID19Test_geoRegion_all.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO


-- ============================================================
-- Import: COVID19HospCapacity_geoRegion.csv
-- Die Kopfzeile der CSV-Datei wird übersprungen.
-- ============================================================

BULK INSERT dbo.STAGE_COVID19HospCapacity_geoRegion
FROM 'C:\Data\Import\COVID19HospCapacity_geoRegion.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO