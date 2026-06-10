-- ============================================
-- ЗАДАЧА 2: Топ-10 стран по сумме привлеченного финансирования
-- Группируя проекты по странам вычисляем топ-10 стран по сумме привлеченного финансирования
-- ============================================

SELECT "country", CAST(SUM("usd pledged") AS INTEGER) as "USD Pledged Total"
FROM "KS_Projects_Modified"
GROUP BY "country"
ORDER BY SUM("usd pledged") DESC
LIMIT 10