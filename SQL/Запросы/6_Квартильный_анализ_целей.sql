-- ============================================
-- ЗАДАЧА 6: Анализ категорий по квартилям целей
-- В данной задаче проводится квартильный анализ целей сборов средств.
-- Сравнив среднюю цель и среднее кол-во привлеченных средств по диапазонам можно предположить какая цель по сбору наиболее целесообразна в каждой категории.
-- Для более наглядного сравнения введён коэффициент "Return on goal" (Pledged / Goal) или "окупаемость" цели.  
-- Так в категориях "Игры", "Дизайн" и "Технологии" большие цели приводят к пропорционально большому сбору средств.
-- В остальных категориях проекты с целями выше ~$20тыс. собирают менее 20% от запрошенной суммы.
-- ============================================
WITH cte1 AS (
	SELECT 
		"main_category",
		"goal",
		"usd pledged",
		NTILE(4) OVER (PARTITION BY main_category ORDER BY goal) as quart
	FROM KS_Projects_Modified
)

SELECT 
	main_category, 
	quart, 
	(min("goal")|| " - " || max("goal") || " $") as "Goal Range",
	ROUND(avg("goal"),1) as "Avg Goal",
	ROUND(avg("usd pledged"),1) as "Avg Pledged",
	ROUND((ROUND(avg("usd pledged"),1) / ROUND(avg("goal"),1)*100),1) || "%" as "Return On Goal"
FROM cte1
GROUP BY main_category, quart
