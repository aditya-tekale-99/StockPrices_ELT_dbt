WITH averageTrueRanges AS (
    SELECT
        date,
        symbol,
        close,
        ABS(close - LAG(close) OVER (PARTITION BY symbol ORDER BY date)) AS true_range
    FROM dev.analytics.stock_prices
),
atr AS (
    SELECT
        date,
        symbol,
        AVG(true_range) OVER (PARTITION BY symbol ORDER BY date ROWS BETWEEN 13 PRECEDING AND CURRENT ROW) AS atr_14d
    FROM averageTrueRanges
)
SELECT 
    date, 
    symbol, 
    COALESCE(atr_14d, 0) AS atr_14d
FROM atr
ORDER BY date, symbol