USE MediaProduction;
GO

--- Try Database
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

SELECT 
    TABLE_NAME,
    COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
ORDER BY TABLE_NAME, ORDINAL_POSITION;

/* =========================================================
   Inquiry 1
========================================================= */


SELECT TOP 1
    S.TECH_SKILL, COUNT(*) AS NumberOfAssignments
FROM SKILLS S
JOIN PROFESSIONAL P ON S.SKILL_ID = P.SKILL_ID
JOIN WORK_ON W ON P.PROFESSIONAL_ID = W.PROFESSIONAL_ID
JOIN SESSION SE ON W.SESS_ID = SE.SESS_ID
WHERE DATEDIFF(month, SESS_DATE, GETDATE()) = 1
AND YEAR(SE.SESS_DATE) = YEAR(GETDATE())
GROUP BY S.TECH_SKILL
ORDER BY NumberOfAssignments DESC;

PRINT '==============================';


/* =========================================================
   Inquiry 2
========================================================= */

SELECT
    P.ID, P.TITLE
FROM PROJECT P
LEFT JOIN SESSION S ON P.ID = S.ID
  AND MONTH(S.SESS_DATE) = MONTH(GETDATE()) - 1
   AND YEAR(S.SESS_DATE) = YEAR(GETDATE())
WHERE S.SESS_ID IS NULL;

PRINT '==============================';


/* =========================================================
   Inquiry 3
========================================================= */

SELECT TOP 1
    P.PROFESSIONAL_ID, P.PRO_NAME,
    COUNT(DISTINCT SE.EQ_ID) AS EquipmentCount
FROM PROFESSIONAL P
JOIN SESSION_EQUIP SE
    ON P.PROFESSIONAL_ID = SE.PROFESSIONAL_ID
JOIN SESSION S ON SE.SESS_ID = S.SESS_ID
WHERE MONTH(S.SESS_DATE) = MONTH(GETDATE()) - 1
AND YEAR(S.SESS_DATE) = YEAR(GETDATE())
GROUP BY
    P.PROFESSIONAL_ID, P.PRO_NAME
ORDER BY EquipmentCount DESC;

PRINT '==============================';


/* =========================================================
   Inquiry 4
========================================================= */

SELECT
    ST.ID_STUDIO, ST.NAME
FROM STUDIO ST
LEFT JOIN SESSION S ON ST.ID_STUDIO = S.ID_STUDIO
 AND MONTH(S.SESS_DATE) = MONTH(GETDATE()) - 1
    AND YEAR(S.SESS_DATE) = YEAR(GETDATE())
WHERE S.SESS_ID IS NULL;

PRINT '==============================';


/* =========================================================
   Inquiry 5
========================================================= */

SELECT
    P.TITLE AS ProjectTitle, E.EQ_ID, E.EQ_TYPE, E.SERIAL_NUM
FROM PROJECT P
JOIN SESSION S ON P.ID = S.ID
JOIN SESSION_EQUIP SE ON S.SESS_ID = SE.SESS_ID
JOIN EQUIPMENT E ON SE.EQ_ID = E.EQ_ID
WHERE MONTH(S.SESS_DATE) = MONTH(GETDATE()) - 1
AND YEAR(S.SESS_DATE) = YEAR(GETDATE())
ORDER BY P.TITLE;

PRINT '==============================';


/* =========================================================
   Inquiry 6
========================================================= */
SELECT P.PROFESSIONAL_ID, P.PRO_NAME, P.ROLE, S.TECH_SKILL, COUNT(DISTINCT PR.ID) AS TotalProjects
FROM PROFESSIONAL P
JOIN SKILLS S ON P.SKILL_ID = S.SKILL_ID
LEFT JOIN WORK_ON W ON P.PROFESSIONAL_ID = W.PROFESSIONAL_ID
LEFT JOIN SESSION SE ON W.SESS_ID = SE.SESS_ID
 AND MONTH(SE.SESS_DATE) = MONTH(GETDATE()) - 1
    AND YEAR(SE.SESS_DATE) = YEAR(GETDATE())
LEFT JOIN PROJECT PR
    ON SE.ID = PR.ID
GROUP BY P.PROFESSIONAL_ID, P.PRO_NAME, P.ROLE, S.TECH_SKILL
ORDER BY TotalProjects DESC;

PRINT '==============================';