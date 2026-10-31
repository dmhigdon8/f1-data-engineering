select
	r.round_num
	, r.driver_id
	, r.finish_position
	, q.qualifying_position - r.finish_position as positions_gained

from marts.fct_race_results r
	inner join marts.fct_qualifying_results q on r.season=q.season and r.round_num=q.round_num and r.driver_id=q.driver_id

where r.season = 2024

group by 1,2,3,4
order by r.round_num, positions_gained desc;