USE PandemyResearch;
GO

-- ============================================================
-- 06 ABSCHLUSSKONTROLLE DES AUTOMATISIERTEN ETL-ABLAUFS
-- ============================================================

PRINT '==============================================';
PRINT 'PandemyResearch - ETL-Ablauf abgeschlossen';
PRINT '==============================================';
PRINT 'Abschlusszeit: ' + CONVERT(varchar(30), SYSDATETIME(), 126);
GO

-- Kontrolle der produktiven Zieltabellen
SELECT 'Population' AS Tabelle, COUNT(*) AS Anzahl_Datensaetze
FROM dbo.Population

UNION ALL

SELECT 'HospitalCapacity', COUNT(*)
FROM dbo.HospitalCapacity

UNION ALL

SELECT 'Tests', COUNT(*)
FROM dbo.Tests;
GO