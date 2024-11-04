
  create or replace   view dev.analytics.stock_prices
  
   as (
    SELECT
    symbol,
    date,
    open,
    high,
    low,
    close,
    volume
FROM dev.raw_data.stock_prices
  );

