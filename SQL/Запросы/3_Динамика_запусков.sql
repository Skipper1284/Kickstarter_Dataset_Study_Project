-- ============================================
-- ЗАДАЧА 3: Динамика запусков
-- Количество проектов и процент успешности по годам и месяцам
-- ============================================

SELECT strftime('%Y', "launched") as Year, 
	strftime('%m', "launched") as Month, 
	COUNT("ID") as Projects_Launched,
	ROUND((AVG(CASE WHEN "state"='successful' THEN 1.0 ELSE 0.0 END)),2) as "Successful_Percentage"
FROM "KS_Projects_Modified"
WHERE state IN ('successful', 'failed', 'canceled')
GROUP BY Year, Month
ORDER BY Year asc, Month asc