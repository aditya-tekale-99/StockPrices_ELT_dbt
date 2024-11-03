SELECT
    symbol,
    date,
    open,
    high,
    low,
    close,
    volume
FROM {{ source('raw_data', 'stock_prices') }}
