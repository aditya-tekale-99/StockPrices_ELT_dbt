select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select lower_band
from dev.analytics.bollinger
where lower_band is null



      
    ) dbt_internal_test