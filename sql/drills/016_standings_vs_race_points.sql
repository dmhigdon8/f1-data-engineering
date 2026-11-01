select
	fds.driver_id
	, fds.points as championship_points
	, sum(frr.points) as race_points
	, fds.points - sum(frr.points) as sprint_points

from marts.fct_driver_standings fds
	inner join marts.fct_race_results as frr on fds.driver_id=frr.driver_id and fds.season=frr.season

where 
	fds.season = 2024

group by fds.driver_id, fds.points
order by championship_points desc;