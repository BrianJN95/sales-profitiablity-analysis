-- Profitability by region for the Tables sub-category
-- Source: superstore_sales_clean.csv
-- Note: Sales and Profit use a comma as decimal separator,
-- so they are converted from text to numeric values.

WITH tables_clean AS (
    SELECT
        Region,
        CAST(REPLACE(Sales, ',', '.') AS DOUBLE) AS sales,
        CAST(REPLACE(Profit, ',', '.') AS DOUBLE) AS profit
    FROM read_csv(
    'data/superstore_sales_clean.csv',
    header = true,
    all_varchar = true
)
    WHERE Category = 'Furniture'
      AND "Sub-Category" = 'Tables'
)

SELECT
    Region AS region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(sales - profit), 2) AS total_cost,
    ROUND(
        100.0 * SUM(profit) / NULLIF(SUM(sales), 0),
        2
    ) AS profit_margin_pct,
    COUNT(*) AS total_orders
FROM tables_clean
GROUP BY Region
ORDER BY total_sales DESC;
