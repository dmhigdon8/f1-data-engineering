with base as (select
	round_num
	, driver_id
	, fastest_lap_rank
	, lag(fastest_lap_rank) over (partition by driver_id order by round_num) as last_race_flr

from marts.fct_race_results

where season = 2024)

, streak_start as (select
	*
	, case when fastest_lap_rank = 1 and (last_race_flr is null or last_race_flr > 1) then 1 else 0 end as streak_start_flag

	from base)

, islands as (select
	*
	, sum(streak_start_flag) over (partition by driver_id order by round_num) as streak_island

	from streak_start)

, streak_length as (select
	driver_id
	, streak_island
	, min(round_num) as first_round
	, max(round_num) as last_round
	, max(round_num) - min(round_num) + 1 as streak_length

	from islands

	where fastest_lap_rank = 1

	group by 1,2)



select 
	driver_id
	, first_round
	, last_round
	, streak_length 

from streak_length

where streak_length >= 2

order by streak_length desc, driver_id;