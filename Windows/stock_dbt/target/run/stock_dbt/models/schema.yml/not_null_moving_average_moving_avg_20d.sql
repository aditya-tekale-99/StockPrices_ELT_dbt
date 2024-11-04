select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select moving_avg_20d
from dev.analytics.moving_average
where moving_avg_20d is null



      
    ) dbt_internal_test