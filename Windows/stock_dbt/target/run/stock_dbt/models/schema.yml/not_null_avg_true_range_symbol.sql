select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select symbol
from dev.analytics.avg_true_range
where symbol is null



      
    ) dbt_internal_test