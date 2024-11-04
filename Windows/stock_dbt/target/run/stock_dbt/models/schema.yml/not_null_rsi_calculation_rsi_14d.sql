select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select rsi_14d
from dev.analytics.rsi_calculation
where rsi_14d is null



      
    ) dbt_internal_test