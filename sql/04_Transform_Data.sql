USE PandemyResearch;
GO

-- ============================================================
-- 4.1 Transformation COVID19Cases_geoRegion -> Population
-- ============================================================

-- ------------------------------------------------------------
-- 4.1.1 Vorschau und Prüfung der Quelldaten
-- ------------------------------------------------------------

SELECT TOP 20
    TRY_CONVERT(date, datum) AS DATUM,
    geoRegion AS GeoRegion,
    TRY_CONVERT(int, pop) AS population,
    TRY_CONVERT(decimal(5,2), inz_entries) AS inzidents
FROM dbo.STAGE_COVID19Cases_geoRegion
WHERE
    datum IS NOT NULL
    AND datum <> 'NA'
    AND TRY_CONVERT(date, datum) IS NOT NULL
    AND geoRegion IS NOT NULL
    AND geoRegion <> 'NA';
GO


-- ------------------------------------------------------------
-- 4.1.2 Fehlende GeoRegionen ermitteln
-- ------------------------------------------------------------

SELECT DISTINCT s.geoRegion
FROM dbo.STAGE_COVID19Cases_geoRegion AS s
LEFT JOIN dbo.GeoUnit AS g
    ON s.geoRegion = g.NAME
WHERE
    s.geoRegion IS NOT NULL
    AND s.geoRegion <> 'NA'
    AND g.NAME IS NULL
ORDER BY s.geoRegion;
GO


-- ------------------------------------------------------------
-- 4.1.3 Fehlende GeoRegionen in GeoUnit ergänzen
-- ------------------------------------------------------------

INSERT INTO dbo.GeoUnit (NAME)
SELECT DISTINCT s.geoRegion
FROM dbo.STAGE_COVID19Cases_geoRegion AS s
WHERE
    s.geoRegion IS NOT NULL
    AND s.geoRegion <> 'NA'
    AND NOT EXISTS
    (
        SELECT 1
        FROM dbo.GeoUnit AS g
        WHERE g.NAME = s.geoRegion
    );
GO


-- Kontrolle der Referenztabelle
SELECT *
FROM dbo.GeoUnit
ORDER BY NAME;
GO


-- ------------------------------------------------------------
-- 4.1.4 Neue Falldaten in Population übernehmen
-- ------------------------------------------------------------

INSERT INTO dbo.Population
(
    DATUM,
    GeoRegion,
    population,
    inzidents
)
SELECT
    TRY_CONVERT(date, s.datum),
    s.geoRegion,
    TRY_CONVERT(int, s.pop),
    TRY_CONVERT(decimal(5,2), s.inz_entries)
FROM dbo.STAGE_COVID19Cases_geoRegion AS s
WHERE
    s.datum IS NOT NULL
    AND s.datum <> 'NA'
    AND TRY_CONVERT(date, s.datum) IS NOT NULL
    AND s.geoRegion IS NOT NULL
    AND s.geoRegion <> 'NA'
    AND NOT EXISTS
    (
        SELECT 1
        FROM dbo.Population AS p
        WHERE p.DATUM = TRY_CONVERT(date, s.datum)
          AND p.GeoRegion = s.geoRegion
    );
GO


-- ------------------------------------------------------------
-- 4.1.5 Vorhandene Population-/Inzidenzwerte aktualisieren
-- Dadurch ist die Transformation wiederholbar.
-- ------------------------------------------------------------

UPDATE p
SET
    p.population = TRY_CONVERT(int, s.pop),
    p.inzidents = TRY_CONVERT(decimal(5,2), s.inz_entries)
FROM dbo.Population AS p
INNER JOIN dbo.STAGE_COVID19Cases_geoRegion AS s
    ON p.DATUM = TRY_CONVERT(date, s.datum)
    AND p.GeoRegion = s.geoRegion
WHERE
    s.datum IS NOT NULL
    AND s.datum <> 'NA'
    AND TRY_CONVERT(date, s.datum) IS NOT NULL
    AND s.geoRegion IS NOT NULL
    AND s.geoRegion <> 'NA';
GO


-- ------------------------------------------------------------
-- 4.1.6 Kontrolle der Transformation
-- ------------------------------------------------------------

SELECT COUNT(*) AS Anzahl_Datensaetze
FROM dbo.Population;
GO

SELECT TOP 20
    DATUM,
    GeoRegion,
    population,
    inzidents,
    todesfaelle,
    tests
FROM dbo.Population
ORDER BY DATUM, GeoRegion;
GO


-- ============================================================
-- 4.2 Transformation COVID19Death_geoRegion
-- ============================================================

-- ------------------------------------------------------------
-- 4.2.1 Prüfung der Quelldaten
-- ------------------------------------------------------------

SELECT TOP 20
    datum,
    geoRegion,
    entries,
    type,
    type_variant
FROM dbo.STAGE_COVID19Death_geoRegion
WHERE
    datum IS NOT NULL
    AND datum <> 'NA'
    AND geoRegion IS NOT NULL
    AND geoRegion <> 'NA'
ORDER BY datum, geoRegion;
GO


-- ------------------------------------------------------------
-- 4.2.2 Transformation Death -> Population.todesfaelle
-- ------------------------------------------------------------

UPDATE p
SET p.todesfaelle = TRY_CONVERT(int, s.entries)
FROM dbo.Population AS p
INNER JOIN dbo.STAGE_COVID19Death_geoRegion AS s
    ON p.DATUM = TRY_CONVERT(date, s.datum)
    AND p.GeoRegion = s.geoRegion
WHERE
    s.datum IS NOT NULL
    AND s.datum <> 'NA'
    AND TRY_CONVERT(date, s.datum) IS NOT NULL
    AND s.geoRegion IS NOT NULL
    AND s.geoRegion <> 'NA'
    AND TRY_CONVERT(int, s.entries) IS NOT NULL;
GO


-- ------------------------------------------------------------
-- 4.2.3 Kontrolle der transformierten Todesfälle
-- ------------------------------------------------------------

SELECT TOP 20
    DATUM,
    GeoRegion,
    population,
    inzidents,
    todesfaelle
FROM dbo.Population
WHERE todesfaelle IS NOT NULL
ORDER BY DATUM, GeoRegion;
GO


-- ============================================================
-- 4.3 Transformation HospCapacity -> HospitalCapacity
-- ============================================================

-- ------------------------------------------------------------
-- 4.3.1 Neue HospitalCapacity-Datensätze einfügen
-- ------------------------------------------------------------

INSERT INTO dbo.HospitalCapacity
(
    DATUM,
    GeoRegion,
    total_capacity,
    ICU_capacity,
    total_all_patients,
    total_COVID19_patients,
    ICU_all_patients,
    ICU_COVID19_patients
)
SELECT
    TRY_CONVERT(date, s.date),
    s.geoRegion,
    TRY_CONVERT(int, s.Total_Capacity),
    TRY_CONVERT(int, s.ICU_Capacity),
    TRY_CONVERT(int, s.Total_AllPatients),
    TRY_CONVERT(int, s.Total_Covid19Patients),
    TRY_CONVERT(int, s.ICU_AllPatients),
    TRY_CONVERT(int, s.ICU_Covid19Patients)
FROM dbo.STAGE_COVID19HospCapacity_geoRegion AS s
WHERE
    s.type_variant = 'fp7d'
    AND s.date IS NOT NULL
    AND s.date <> 'NA'
    AND TRY_CONVERT(date, s.date) IS NOT NULL
    AND s.geoRegion IS NOT NULL
    AND s.geoRegion <> 'NA'
    AND NOT EXISTS
    (
        SELECT 1
        FROM dbo.HospitalCapacity AS h
        WHERE h.DATUM = TRY_CONVERT(date, s.date)
          AND h.GeoRegion = s.geoRegion
    );
GO


-- ------------------------------------------------------------
-- 4.3.2 Vorhandene HospitalCapacity-Datensätze aktualisieren
-- ------------------------------------------------------------

UPDATE h
SET
    h.total_capacity = TRY_CONVERT(int, s.Total_Capacity),
    h.ICU_capacity = TRY_CONVERT(int, s.ICU_Capacity),
    h.total_all_patients = TRY_CONVERT(int, s.Total_AllPatients),
    h.total_COVID19_patients = TRY_CONVERT(int, s.Total_Covid19Patients),
    h.ICU_all_patients = TRY_CONVERT(int, s.ICU_AllPatients),
    h.ICU_COVID19_patients = TRY_CONVERT(int, s.ICU_Covid19Patients)
FROM dbo.HospitalCapacity AS h
INNER JOIN dbo.STAGE_COVID19HospCapacity_geoRegion AS s
    ON h.DATUM = TRY_CONVERT(date, s.date)
    AND h.GeoRegion = s.geoRegion
WHERE
    s.type_variant = 'fp7d'
    AND s.date IS NOT NULL
    AND s.date <> 'NA'
    AND TRY_CONVERT(date, s.date) IS NOT NULL
    AND s.geoRegion IS NOT NULL
    AND s.geoRegion <> 'NA';
GO


-- ------------------------------------------------------------
-- 4.3.3 Kontrolle der Transformation HospitalCapacity
-- ------------------------------------------------------------

SELECT COUNT(*) AS Anzahl_Datensaetze
FROM dbo.HospitalCapacity;
GO

SELECT TOP 20
    DATUM,
    GeoRegion,
    total_capacity,
    ICU_capacity,
    total_all_patients,
    total_COVID19_patients,
    ICU_all_patients,
    ICU_COVID19_patients
FROM dbo.HospitalCapacity
ORDER BY DATUM, GeoRegion;
GO


-- ============================================================
-- 4.4 Transformation COVID19Test_geoRegion_all -> Tests
-- ============================================================

-- ------------------------------------------------------------
-- 4.4.1 Struktur der Testdaten prüfen
-- ------------------------------------------------------------

SELECT TOP 30
    datum,
    geoRegion,
    entries,
    entries_pos,
    entries_neg,
    nachweismethode,
    type
FROM dbo.STAGE_COVID19Test_geoRegion_all
WHERE
    datum IS NOT NULL
    AND datum <> 'NA'
    AND geoRegion IS NOT NULL
    AND geoRegion <> 'NA'
ORDER BY datum, geoRegion, nachweismethode;
GO


-- ------------------------------------------------------------
-- 4.4.2 Prüfung auf doppelte Datum-/Regionskombinationen
-- ------------------------------------------------------------

SELECT
    TRY_CONVERT(date, datum) AS DATUM,
    geoRegion AS GeoRegion,
    COUNT(*) AS Anzahl
FROM dbo.STAGE_COVID19Test_geoRegion_all
WHERE
    datum IS NOT NULL
    AND datum <> 'NA'
    AND TRY_CONVERT(date, datum) IS NOT NULL
    AND geoRegion IS NOT NULL
    AND geoRegion <> 'NA'
GROUP BY
    TRY_CONVERT(date, datum),
    geoRegion
HAVING COUNT(*) > 1
ORDER BY DATUM, GeoRegion;
GO


-- ------------------------------------------------------------
-- 4.4.3 Neue Testdaten übernehmen
-- ------------------------------------------------------------

INSERT INTO dbo.Tests
(
    DATUM,
    GeoRegion,
    tests,
    tests_nachweismethode,
    positive
)
SELECT
    TRY_CONVERT(date, s.datum),
    s.geoRegion,
    TRY_CONVERT(int, s.entries),
    NULLIF(s.nachweismethode, 'NA'),
    TRY_CONVERT(int, s.entries_pos)
FROM dbo.STAGE_COVID19Test_geoRegion_all AS s
WHERE
    s.datum IS NOT NULL
    AND s.datum <> 'NA'
    AND TRY_CONVERT(date, s.datum) IS NOT NULL
    AND s.geoRegion IS NOT NULL
    AND s.geoRegion <> 'NA'
    AND NOT EXISTS
    (
        SELECT 1
        FROM dbo.Tests AS t
        WHERE t.DATUM = TRY_CONVERT(date, s.datum)
          AND t.GeoRegion = s.geoRegion
          AND ISNULL(t.tests_nachweismethode, '') =
              ISNULL(NULLIF(s.nachweismethode, 'NA'), '')
    );
GO


-- ------------------------------------------------------------
-- 4.4.4 Vorhandene Testdaten aktualisieren
-- ------------------------------------------------------------

UPDATE t
SET
    t.tests = TRY_CONVERT(int, s.entries),
    t.positive = TRY_CONVERT(int, s.entries_pos)
FROM dbo.Tests AS t
INNER JOIN dbo.STAGE_COVID19Test_geoRegion_all AS s
    ON t.DATUM = TRY_CONVERT(date, s.datum)
    AND t.GeoRegion = s.geoRegion
    AND ISNULL(t.tests_nachweismethode, '') =
        ISNULL(NULLIF(s.nachweismethode, 'NA'), '')
WHERE
    s.datum IS NOT NULL
    AND s.datum <> 'NA'
    AND TRY_CONVERT(date, s.datum) IS NOT NULL
    AND s.geoRegion IS NOT NULL
    AND s.geoRegion <> 'NA';
GO


-- ------------------------------------------------------------
-- 4.4.5 Kontrolle der Transformation Tests
-- ------------------------------------------------------------

SELECT COUNT(*) AS Anzahl_Datensaetze
FROM dbo.Tests;
GO

SELECT TOP 20
    DATUM,
    GeoRegion,
    tests,
    tests_nachweismethode,
    positive
FROM dbo.Tests
ORDER BY DATUM, GeoRegion, tests_nachweismethode;
GO