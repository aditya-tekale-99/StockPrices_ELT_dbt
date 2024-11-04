select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select upper_band
from dev.analytics.bollinger
where upper_band is null



      
    ) dbt_internal_test