-- ============================================
-- ЗАДАЧА 5: Корреляция между кол-вом пожертвователей и суммой пожертвований
-- Для расчёта корреляции был использован коэффициент Пирсона
-- Результаты вполне ожидаемы, коэффициенты корреляции лежат в районе 0.7-0.9 (сильная положительная связь)
-- Вывод: чем больше пожертвователей - тем больше удается собрать сумму пожертвований
-- ============================================
WITH cte1 as (
	SELECT
		"main_category",
		COUNT("main_category") as n,
		SUM("backers") as sum_x, 
		SUM("usd pledged") as sum_y,
		SUM("backers" * "backers") as sum_x2,
		SUM("usd pledged" * "usd pledged") as sum_y2,
		SUM("backers" * "usd pledged") as sum_xy
	FROM KS_Projects_Modified
	WHERE state = 'successful'
	GROUP BY "main_category"
)

SELECT 
	"main_category",
	(n * sum_xy - sum_x * sum_y) / sqrt((n * sum_x2 - sum_x * sum_x) * (n * sum_y2 - sum_y * sum_y)) as Corr_Pearson_Backers_To_Pledged
FROM cte1