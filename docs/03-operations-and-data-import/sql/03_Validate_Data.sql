USE PandemyResearch;
GO

-- ============================================================
-- Validierung: COVID19Cases_geoRegion
-- ============================================================

-- Anzahl der importierten Datensätze
SELECT COUNT(*) AS Anzahl_Datensaetze
FROM dbo.STAGE_COVID19Cases_geoRegion;
GO

-- Stichprobe relevanter Felder
SELECT TOP (10)
    geoRegion,
    datum,
    entries,
    pop,
    inz_entries
FROM dbo.STAGE_COVID19Cases_geoRegion
ORDER BY datum, geoRegion;
GO


-- Prüfung der STAGE-Spaltenstruktur
SELECT
    ORDINAL_POSITION,
    COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo'
  AND TABLE_NAME = 'STAGE_COVID19Cases_geoRegion'
ORDER BY ORDINAL_POSITION;
GO


-- Prüfung auf ungültige Datumswerte
SELECT COUNT(*) AS Ungueltige_Datumswerte
FROM dbo.STAGE_COVID19Cases_geoRegion
WHERE datum IS NOT NULL
  AND datum <> 'NA'
  AND TRY_CONVERT(date, datum) IS NULL;
GO


-- Prüfung auf ungültige Populationswerte
SELECT COUNT(*) AS Ungueltige_Populationswerte
FROM dbo.STAGE_COVID19Cases_geoRegion
WHERE pop IS NOT NULL
  AND pop <> 'NA'
  AND TRY_CONVERT(int, pop) IS NULL;
GO


-- Prüfung auf ungültige Inzidenzwerte
SELECT COUNT(*) AS Ungueltige_Inzidenzwerte
FROM dbo.STAGE_COVID19Cases_geoRegion
WHERE inz_entries IS NOT NULL
  AND inz_entries <> 'NA'
  AND TRY_CONVERT(decimal(18,2), inz_entries) IS NULL;
GO


-- Prüfung auf NA-Werte in den benötigten Spalten
SELECT
    SUM(CASE WHEN pop = 'NA' THEN 1 ELSE 0 END) AS NA_Population,
    SUM(CASE WHEN inz_entries = 'NA' THEN 1 ELSE 0 END) AS NA_Inzidenz,
    SUM(CASE WHEN entries = 'NA' THEN 1 ELSE 0 END) AS NA_Faelle
FROM dbo.STAGE_COVID19Cases_geoRegion;
GO


-- ============================================================
-- Validierung: COVID19Death_geoRegion
-- ============================================================

-- Anzahl der importierten Datensätze
SELECT COUNT(*) AS Anzahl_Datensaetze
FROM dbo.STAGE_COVID19Death_geoRegion;
GO

-- Stichprobe relevanter Felder
SELECT TOP (10)
    geoRegion,
    datum,
    entries,
    pop,
    inz_entries
FROM dbo.STAGE_COVID19Death_geoRegion
ORDER BY TRY_CONVERT(date, datum);
GO


-- Prüfung auf ungültige Datumswerte
SELECT COUNT(*) AS Ungueltige_Datumswerte
FROM dbo.STAGE_COVID19Death_geoRegion
WHERE datum IS NOT NULL
  AND datum <> 'NA'
  AND TRY_CONVERT(date, datum) IS NULL;
GO


-- Prüfung auf ungültige Todesfallzahlen
SELECT COUNT(*) AS Ungueltige_Todesfallwerte
FROM dbo.STAGE_COVID19Death_geoRegion
WHERE entries IS NOT NULL
  AND entries <> 'NA'
  AND TRY_CONVERT(int, entries) IS NULL;
GO


-- Prüfung auf NA-Werte
SELECT
    SUM(CASE WHEN datum = 'NA' THEN 1 ELSE 0 END) AS NA_Datum,
    SUM(CASE WHEN geoRegion = 'NA' THEN 1 ELSE 0 END) AS NA_GeoRegion,
    SUM(CASE WHEN entries = 'NA' THEN 1 ELSE 0 END) AS NA_Todesfaelle
FROM dbo.STAGE_COVID19Death_geoRegion;
GO


-- ============================================================
-- Validierung: COVID19Test_geoRegion_all
-- ============================================================

-- Anzahl der importierten Datensätze
SELECT COUNT(*) AS Anzahl_Datensaetze
FROM dbo.STAGE_COVID19Test_geoRegion_all;
GO

-- Stichprobe relevanter Felder
SELECT TOP (10)
    datum,
    geoRegion,
    entries,
    entries_pos,
    entries_neg,
    nachweismethode
FROM dbo.STAGE_COVID19Test_geoRegion_all;
GO


-- Prüfung auf ungültige Datumswerte
SELECT COUNT(*) AS Ungueltige_Datumswerte
FROM dbo.STAGE_COVID19Test_geoRegion_all
WHERE datum IS NOT NULL
  AND datum <> 'NA'
  AND TRY_CONVERT(date, datum) IS NULL;
GO


-- Prüfung auf ungültige Gesamtzahl der Tests
SELECT COUNT(*) AS Ungueltige_Testwerte
FROM dbo.STAGE_COVID19Test_geoRegion_all
WHERE entries IS NOT NULL
  AND entries <> 'NA'
  AND TRY_CONVERT(int, entries) IS NULL;
GO


-- Prüfung auf ungültige positive Testergebnisse
SELECT COUNT(*) AS Ungueltige_Positive_Testwerte
FROM dbo.STAGE_COVID19Test_geoRegion_all
WHERE entries_pos IS NOT NULL
  AND entries_pos <> 'NA'
  AND TRY_CONVERT(int, entries_pos) IS NULL;
GO


-- Prüfung auf ungültige negative Testergebnisse
SELECT COUNT(*) AS Ungueltige_Negative_Testwerte
FROM dbo.STAGE_COVID19Test_geoRegion_all
WHERE entries_neg IS NOT NULL
  AND entries_neg <> 'NA'
  AND TRY_CONVERT(int, entries_neg) IS NULL;
GO


-- Prüfung auf NA-Werte
SELECT
    SUM(CASE WHEN datum = 'NA' THEN 1 ELSE 0 END) AS NA_Datum,
    SUM(CASE WHEN geoRegion = 'NA' THEN 1 ELSE 0 END) AS NA_GeoRegion,
    SUM(CASE WHEN entries = 'NA' THEN 1 ELSE 0 END) AS NA_Tests,
    SUM(CASE WHEN entries_pos = 'NA' THEN 1 ELSE 0 END) AS NA_Positive,
    SUM(CASE WHEN entries_neg = 'NA' THEN 1 ELSE 0 END) AS NA_Negative
FROM dbo.STAGE_COVID19Test_geoRegion_all;
GO


-- ============================================================
-- Validierung: COVID19HospCapacity_geoRegion
-- ============================================================

-- Anzahl der importierten Datensätze
SELECT COUNT(*) AS Anzahl_Datensaetze
FROM dbo.STAGE_COVID19HospCapacity_geoRegion;
GO

-- Stichprobe relevanter Felder
SELECT TOP (10)
    date,
    geoRegion,
    Total_Capacity,
    ICU_Capacity,
    Total_AllPatients,
    Total_Covid19Patients,
    ICU_AllPatients,
    ICU_Covid19Patients
FROM dbo.STAGE_COVID19HospCapacity_geoRegion;
GO


-- Prüfung auf ungültige Datumswerte
SELECT COUNT(*) AS Ungueltige_Datumswerte
FROM dbo.STAGE_COVID19HospCapacity_geoRegion
WHERE date IS NOT NULL
  AND date <> 'NA'
  AND TRY_CONVERT(date, date) IS NULL;
GO


-- Prüfung auf ungültige Zahlenwerte
SELECT COUNT(*) AS Ungueltige_Zahlenwerte
FROM dbo.STAGE_COVID19HospCapacity_geoRegion
WHERE
       (Total_Capacity IS NOT NULL
        AND Total_Capacity <> 'NA'
        AND TRY_CONVERT(int, Total_Capacity) IS NULL)

    OR (ICU_Capacity IS NOT NULL
        AND ICU_Capacity <> 'NA'
        AND TRY_CONVERT(int, ICU_Capacity) IS NULL)

    OR (Total_AllPatients IS NOT NULL
        AND Total_AllPatients <> 'NA'
        AND TRY_CONVERT(int, Total_AllPatients) IS NULL)

    OR (Total_Covid19Patients IS NOT NULL
        AND Total_Covid19Patients <> 'NA'
        AND TRY_CONVERT(int, Total_Covid19Patients) IS NULL)

    OR (ICU_AllPatients IS NOT NULL
        AND ICU_AllPatients <> 'NA'
        AND TRY_CONVERT(int, ICU_AllPatients) IS NULL)

    OR (ICU_Covid19Patients IS NOT NULL
        AND ICU_Covid19Patients <> 'NA'
        AND TRY_CONVERT(int, ICU_Covid19Patients) IS NULL);
GO


-- Prüfung auf NA-Werte
SELECT
    SUM(CASE WHEN date = 'NA' THEN 1 ELSE 0 END) AS NA_Datum,
    SUM(CASE WHEN geoRegion = 'NA' THEN 1 ELSE 0 END) AS NA_GeoRegion,
    SUM(CASE WHEN Total_Capacity = 'NA' THEN 1 ELSE 0 END) AS NA_TotalCapacity,
    SUM(CASE WHEN ICU_Capacity = 'NA' THEN 1 ELSE 0 END) AS NA_ICUCapacity,
    SUM(CASE WHEN Total_AllPatients = 'NA' THEN 1 ELSE 0 END) AS NA_TotalAllPatients,
    SUM(CASE WHEN Total_Covid19Patients = 'NA' THEN 1 ELSE 0 END) AS NA_TotalCovid19Patients,
    SUM(CASE WHEN ICU_AllPatients = 'NA' THEN 1 ELSE 0 END) AS NA_ICUAllPatients,
    SUM(CASE WHEN ICU_Covid19Patients = 'NA' THEN 1 ELSE 0 END) AS NA_ICUCovid19Patients
FROM dbo.STAGE_COVID19HospCapacity_geoRegion;
GO