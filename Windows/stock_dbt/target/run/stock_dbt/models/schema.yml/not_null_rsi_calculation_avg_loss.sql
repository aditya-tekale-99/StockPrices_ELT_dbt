select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select avg_loss
from dev.analytics.rsi_calculation
where avg_loss is null



      
    ) dbt_internal_test