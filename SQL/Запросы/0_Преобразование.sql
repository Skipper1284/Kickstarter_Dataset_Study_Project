-- ============================================
-- ЗАДАЧА 0: Чистка и преобразование таблицы
-- Создаём очищенное представление (View)
-- Преобразуем формат Текста в формат Даты в столбцах "launched", "deadline'.
-- Удаляем записи с некорректными или неполными данными.
-- В результате для представления было отфильтровано 4 429 записи из 323 750
-- ============================================
DROP VIEW IF EXISTS "main"."KS_Projects_Modified";
CREATE VIEW KS_Projects_Modified AS
	SELECT "ID", "name", "category", "main_category", "currency", DATE("deadline") as "deadline", "goal", DATE("launched") as "launched", "pledged", "state", "backers", "country", "usd pledged"
	FROM KS_Projects
	WHERE DATE("launched") IS NOT NULL 
	AND DATE("launched") > "2008-01-01" 
	AND DATE("deadline") IS NOT NULL
	AND "backers" NOT IN ('failed', 'canceled')
	AND "country" != 'N,"0'