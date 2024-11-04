WITH stock_data AS (
    SELECT
        symbol,
        date,
        close
    FROM dev.analytics.stock_prices -- assuming 'stock_prices' is the name of the raw table model in dbt
)

SELECT
    symbol,
    date,
    close,
    AVG(close) OVER (
        PARTITION BY symbol 
        ORDER BY date 
        ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
    ) AS moving_avg_5d,
    AVG(close) OVER (
        PARTITION BY symbol 
        ORDER BY date 
        ROWS BETWEEN 19 PRECEDING AND CURRENT ROW
    ) AS moving_avg_20d
FROM stock_data
ORDER BY symbol, date