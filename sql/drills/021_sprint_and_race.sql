select
	r.round_num
	, r.race_name
	, r.driver_id
	, s.finish_position as sprint_finish
	, r.finish_position as race_finish
	, s.points as sprint_points

from marts.fct_race_results r
	join marts.fct_sprint_results s on r.round_num=s.round_num and r.season=s.season and r.driver_id=s.driver_id

where 
	r.season = 2024

order by r.round_num, sprint_finish;