-- ============================================
-- ЗАДАЧА 1: Успешность проектов по категориям
-- Вычисляем отношение успешных проектов(набравших целевое кол-во пожертвований)
-- ============================================
WITH cte1 AS (
	SELECT "main_category", "state", count("state") as state_successful
	FROM "KS_Projects_Modified"
	WHERE state = 'successful'
	GROUP BY "main_category", "state"
)

SELECT k.main_category, ROUND(((c.state_successful*1.0) / (COUNT(k.state)*1.0)),3)*100 as "Successful_Ratio_%"
FROM KS_Projects_Modified k
JOIN cte1 c on k.main_category = c.main_category
GROUP BY k.main_category
ORDER BY "Successful_Ratio_%" DESC
