with winner as (
	select
		round_num
		, season
		, points
		, finish_position

	from marts.fct_race_results

	where
		season = 2024
		and race_name = 'Abu Dhabi Grand Prix'
		and is_winner)

select
	rr.driver_id
	, rr.finish_position
	, rr.points
	, rr.finish_position - w.finish_position as position_gap
	, w.points - rr.points as points_gap

from marts.fct_race_results rr
	join winner w on rr.round_num=w.round_num and rr.season=w.season

where
	rr.season = 2024
	and rr.race_name = 'Abu Dhabi Grand Prix';