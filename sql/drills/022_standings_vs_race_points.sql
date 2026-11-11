select
	ds.driver_id
	, ds.points as championship_points
	, sum(rr.points) as race_points
	, ds.points - sum(rr.points) as sprint_points

from marts.fct_driver_standings ds
	join marts.fct_race_results rr on ds.season=rr.season and ds.driver_id=rr.driver_id

where 
	ds.season = 2024

group by ds.driver_id, ds.points
order by ds.points desc

