-- Profitability by region
SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(cost) AS total_cost,
    SUM(profit) AS total_profit,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS profit_margin_pct,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN returned = 1 THEN 1 ELSE 0 END) AS returned_orders,
    ROUND(100.0 * SUM(CASE WHEN returned = 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) AS return_rate_pct
FROM tables_clean
GROUP BY region
ORDER BY total_sales DESC;
