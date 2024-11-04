select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select avg_gain
from dev.analytics.rsi_calculation
where avg_gain is null



      
    ) dbt_internal_test