with gp as (select distinct
	driver_id
	
from staging_marts.fct_race_results

where season = 2024)

, sprints as (select distinct driver_id from staging_marts.fct_sprint_results where season = 2024)


select
	gp.*

from gp
	left join sprints on gp.driver_id = sprints.driver_id

where 
	sprints.driver_id is null

order by driver_id;