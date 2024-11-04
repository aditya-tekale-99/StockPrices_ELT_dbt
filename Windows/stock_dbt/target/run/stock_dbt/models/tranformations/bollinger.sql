
  
    

        create or replace transient table dev.analytics.bollinger
         as
        (WITH bollinger AS (
    SELECT
        symbol,
        date,
        close,
        AVG(close) OVER (
            PARTITION BY symbol 
            ORDER BY date 
            ROWS BETWEEN 19 PRECEDING AND CURRENT ROW
        ) AS sma_20d,
        STDDEV(close) OVER (
            PARTITION BY symbol 
            ORDER BY date 
            ROWS BETWEEN 19 PRECEDING AND CURRENT ROW
        ) AS stddev_20d
    FROM dev.analytics.stock_prices
)

SELECT
    symbol,
    date,
    close,
    COALESCE(sma_20d, 0) AS sma_20d,
    COALESCE(sma_20d + (2 * stddev_20d), 0) AS upper_band,
    COALESCE(sma_20d - (2 * stddev_20d), 0) AS lower_band
FROM bollinger
ORDER BY symbol, date
        );
      
  