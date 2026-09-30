USE PandemyResearch;
GO

-- ============================================================
-- 05 FUNKTIONS- UND QUALITÄTSTEST DER TRANSFORMIERTEN DATEN
-- ============================================================


-- ------------------------------------------------------------
-- 5.1 Kontrolle der Datensatzanzahl
-- ------------------------------------------------------------

SELECT 'Population' AS Tabelle, COUNT(*) AS Anzahl_Datensaetze
FROM dbo.Population

UNION ALL

SELECT 'HospitalCapacity', COUNT(*)
FROM dbo.HospitalCapacity

UNION ALL

SELECT 'Tests', COUNT(*)
FROM dbo.Tests;
GO


-- ------------------------------------------------------------
-- 5.2 Prüfung der Pflichtfelder auf NULL
-- ------------------------------------------------------------

SELECT 'Population' AS Tabelle, COUNT(*) AS Fehlerhafte_Datensaetze
FROM dbo.Population
WHERE DATUM IS NULL
   OR GeoRegion IS NULL
   OR population IS NULL
   OR inzidents IS NULL

UNION ALL

SELECT 'HospitalCapacity', COUNT(*)
FROM dbo.HospitalCapacity
WHERE DATUM IS NULL
   OR GeoRegion IS NULL

UNION ALL

SELECT 'Tests', COUNT(*)
FROM dbo.Tests
WHERE DATUM IS NULL
   OR GeoRegion IS NULL;
GO


-- ------------------------------------------------------------
-- 5.3 Prüfung auf negative Werte
-- ------------------------------------------------------------

SELECT 'Population' AS Tabelle, COUNT(*) AS Negative_Werte
FROM dbo.Population
WHERE population < 0
   OR inzidents < 0
   OR todesfaelle < 0

UNION ALL

SELECT 'HospitalCapacity', COUNT(*)
FROM dbo.HospitalCapacity
WHERE total_capacity < 0
   OR ICU_capacity < 0
   OR total_all_patients < 0
   OR total_COVID19_patients < 0
   OR ICU_all_patients < 0
   OR ICU_COVID19_patients < 0

UNION ALL

SELECT 'Tests', COUNT(*)
FROM dbo.Tests
WHERE tests < 0
   OR positive < 0;
GO


-- ------------------------------------------------------------
-- 5.4 Prüfung auf Duplikate
-- ------------------------------------------------------------

-- Population:
-- Datum und Region müssen eindeutig sein.
SELECT 'Population' AS Tabelle, COUNT(*) AS Anzahl_Duplikatgruppen
FROM
(
    SELECT DATUM, GeoRegion
    FROM dbo.Population
    GROUP BY DATUM, GeoRegion
    HAVING COUNT(*) > 1
) AS P

UNION ALL

-- HospitalCapacity:
-- Datum und Region müssen eindeutig sein.
SELECT 'HospitalCapacity', COUNT(*)
FROM
(
    SELECT DATUM, GeoRegion
    FROM dbo.HospitalCapacity
    GROUP BY DATUM, GeoRegion
    HAVING COUNT(*) > 1
) AS H

UNION ALL

-- Tests:
-- Für dieselbe Region und dasselbe Datum können unterschiedliche
-- Nachweismethoden vorhanden sein. Deshalb wird die Nachweismethode
-- in die Duplikatprüfung einbezogen.
SELECT 'Tests', COUNT(*)
FROM
(
    SELECT
        DATUM,
        GeoRegion,
        ISNULL(tests_nachweismethode, '') AS tests_nachweismethode
    FROM dbo.Tests
    GROUP BY
        DATUM,
        GeoRegion,
        ISNULL(tests_nachweismethode, '')
    HAVING COUNT(*) > 1
) AS T;
GO


-- ------------------------------------------------------------
-- 5.5 Fachliche Plausibilitätsprüfung
-- ------------------------------------------------------------

-- Positive Tests dürfen nicht grösser als alle Tests sein.
SELECT COUNT(*) AS Unplausible_Testdaten
FROM dbo.Tests
WHERE positive > tests;
GO


-- COVID-19-Patienten dürfen nicht grösser
-- als die Gesamtzahl aller Patienten sein.
SELECT COUNT(*) AS Unplausible_Hospitaldaten
FROM dbo.HospitalCapacity
WHERE total_COVID19_patients > total_all_patients
   OR ICU_COVID19_patients > ICU_all_patients;
GO


-- ------------------------------------------------------------
-- 5.6 Abschlusskontrolle Population
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS Gesamt,
    COUNT(population) AS Population_befuellt,
    COUNT(inzidents) AS Inzidents_befuellt,
    COUNT(todesfaelle) AS Todesfaelle_befuellt
FROM dbo.Population;
GO