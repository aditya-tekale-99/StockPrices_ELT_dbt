select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select open
from dev.analytics.stock_prices
where open is null



      
    ) dbt_internal_test