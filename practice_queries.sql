-- SFM PRACTICE QUERIES
-- Run these inside sqlite3 after the pipeline builds sfm.db:
--     sqlite3 sfm.db
-- Type them BY HAND (no copy-paste) — retyping is where syntax sticks.

-- ============ WARM-UPS ============

-- 1. Look around first (SQLite meta-commands, day-one analyst moves)
.tables
.schema sessions

-- 2. See a few rows
SELECT * FROM sessions LIMIT 5;

-- 3. How many sessions total?
SELECT COUNT(*) FROM sessions;

-- ============ THE PIVOT TABLE, REBUILT IN SQL ============

-- 4. Participants per site (your old pivot table, query form)
SELECT site_name, SUM(num_participants) AS total_participants
FROM sessions
GROUP BY site_name
ORDER BY total_participants DESC;

-- 5. Per site PER MONTH (the full Market Reach pivot)
SELECT site_name, month, SUM(num_participants) AS participants
FROM sessions
GROUP BY site_name, month
ORDER BY site_name, month;

-- 6. In-person only (the is_virtual filter from your Bureau doc)
SELECT site_name, month, SUM(num_participants) AS participants
FROM sessions
WHERE is_virtual = 0
GROUP BY site_name, month;

-- ============ ANALYST QUESTIONS ============

-- 7. Survey language breakdown (your old language pivot)
SELECT survey_language, COUNT(*) AS sessions, SUM(num_surveys) AS surveys
FROM sessions
GROUP BY survey_language
ORDER BY surveys DESC;

-- 8. EBT/WIC usage by site (NULLs excluded — note the IS NOT NULL)
SELECT site_name, ebt_wic_usage, COUNT(*) AS times_reported
FROM sessions
WHERE ebt_wic_usage IS NOT NULL
GROUP BY site_name, ebt_wic_usage;

-- 9. Average participants: virtual vs in-person (CASE statement intro)
SELECT
  CASE is_virtual WHEN 1 THEN 'Virtual' ELSE 'In-Person' END AS session_type,
  ROUND(AVG(num_participants), 1) AS avg_participants,
  COUNT(*) AS sessions
FROM sessions
GROUP BY session_type;

-- 10. Which borough reaches the most people? (uses the joined column)
SELECT borough, SUM(num_participants) AS total
FROM sessions
GROUP BY borough
ORDER BY total DESC;

-- ============ STRETCH (interview-level) ============

-- 11. Top site per month (subquery practice)
SELECT month, site_name, participants FROM (
  SELECT month, site_name, SUM(num_participants) AS participants
  FROM sessions
  GROUP BY month, site_name
)
GROUP BY month
HAVING participants = MAX(participants);

-- 12. Sites above the average site total (subquery in WHERE/HAVING)
SELECT site_name, SUM(num_participants) AS total
FROM sessions
GROUP BY site_name
HAVING total > (
  SELECT AVG(site_total) FROM (
    SELECT SUM(num_participants) AS site_total
    FROM sessions GROUP BY site_name
  )
);

-- When query 5 returns and you recognize your old Excel pivot —
-- that's the analyst-to-engineer bridge, crossed.
