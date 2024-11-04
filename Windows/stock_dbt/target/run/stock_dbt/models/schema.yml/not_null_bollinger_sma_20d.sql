select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select sma_20d
from dev.analytics.bollinger
where sma_20d is null



      
    ) dbt_internal_test