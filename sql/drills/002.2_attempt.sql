select
	season
	, round_num
	, race_name
	, driver_id
	, finish_position
	, points
	, finish_time
	, is_finisher
	, case when is_finisher
		   then rank() over(order by finish_position) end as finisher_rank
    , first_value(points) over (order by points desc) - points as pts_gap_to_leader
    , finish_position - first_value(finish_position) over (order by finish_position asc) as position_gap_to_leader

from staging_marts.fct_race_results

where
	season = 2024
	and round_num = 1