select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select atr_14d
from dev.analytics.avg_true_range
where atr_14d is null



      
    ) dbt_internal_test