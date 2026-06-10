-- ============================================
-- ЗАДАЧА 4: Связь длительности кампании и успеха
--  Вычисление процента успешности проектов по интервалам длительности сбора средств
-- ============================================

WITH cte1 as (
	SELECT "state", JULIANDAY("deadline") - JULIANDAY("launched") as duration_days
	FROM KS_Projects_Modified
	WHERE state IN ('successful', 'failed', 'canceled')
)

SELECT 
	CASE
        WHEN duration_days <= 20 THEN '1-20 days'
        WHEN duration_days <= 40 THEN '21-40 days'
        WHEN duration_days <= 60 THEN '41-60 days'
        WHEN duration_days <= 80 THEN '61-80 days'
        WHEN duration_days <= 100 THEN '81-100 days'
	END as "Duration",
	COUNT(*) as "Total_Projects",
	SUM(CASE WHEN state = 'successful' THEN 1 ELSE 0 END) as Successful_Count,
	ROUND(AVG(CASE WHEN state = 'successful' THEN 1.0 ELSE 0.0 END),2) as Successful_Percentage
FROM cte1
GROUP BY "Duration"