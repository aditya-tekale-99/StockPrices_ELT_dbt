WITH stock_data AS (
    SELECT
        symbol,
        date,
        close,
        LAG(close) OVER (PARTITION BY symbol ORDER BY date) AS prev_close
    FROM {{ ref('stock_prices') }}
),

price_changes AS (
    SELECT
        symbol,
        date,
        close,
        CASE 
            WHEN close > prev_close THEN close - prev_close
            ELSE 0 
        END AS gain,
        CASE 
            WHEN close < prev_close THEN prev_close - close
            ELSE 0 
        END AS loss
    FROM stock_data
),

average_gains_losses AS (
    SELECT
        symbol,
        date,
        close,
        AVG(gain) OVER (
            PARTITION BY symbol 
            ORDER BY date 
            ROWS BETWEEN 13 PRECEDING AND CURRENT ROW
        ) AS avg_gain,
        AVG(loss) OVER (
            PARTITION BY symbol 
            ORDER BY date 
            ROWS BETWEEN 13 PRECEDING AND CURRENT ROW
        ) AS avg_loss
    FROM price_changes
)

SELECT
    symbol,
    date,
    close,
    avg_gain,
    avg_loss,
    COALESCE(100 - (100 / (1 + (NULLIF(avg_gain, 0) / NULLIF(avg_loss, 0)))), 0) AS rsi_14d
FROM average_gains_losses
ORDER BY symbol, date
