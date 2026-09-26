with winner as (select season, race_name, is_winner, driver_id, points, finish_time, finish_position from staging_marts.fct_race_results where season = 2024 and round_num = 1 and is_winner)


select
	a.season
	, a.race_name
	, a.driver_id
	, a.is_finisher
	, a.finish_position
	, lag(a.driver_id) over (partition by a.season, a.race_name order by a.finish_position) as driver_ahead
	, rank() over (partition by a.season, a.race_name order by a.finish_position asc) as driver_finish_rank
	, a.points
	, a.finish_time
	, w.points - a.points as pts_gap_to_leader
	, a.finish_position - w.finish_position as driver_finish_position_gap_to_winner


from staging_marts.fct_race_results a
	left join winner w on a.season=w.season and a.race_name=w.race_name

where
	a.season = 2024
	and a.round_num = 1

order by finish_position;