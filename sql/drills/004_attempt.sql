with base as (select 
	season
	, round_num
	, race_name
	, race_date
	, driver_id
	, is_podium
	, finish_position
	, lag(is_podium) over (partition by driver_id order by race_date) as previous_podium_flag
	, lead(is_podium) over (partition by driver_id order by race_date) as next_podium_flag
	, case when is_podium then 1
		   when is_podium and lag(is_podium) over (partition by driver_id order by race_date) then 1 else 0 end as streak_flag


 from staging_marts.fct_race_results


 order by 1,2,3,4)

select
	base.*
	, case when is_podium and race_date = (select min(race_date) from staging_marts.fct_race_results) then 'streak_start'
		   when is_podium and previous_podium_flag is false then 'streak_start'
		   when is_podium and next_podium_flag is false then 'streak_end'
		   when is_podium and next_podium_flag and previous_podium_flag then 'streak_continue'
		   else null end as stread_indicator
/*	, sum(streak_flag) over (partition by driver_id, streak_flag order by driver_id, streak_flag) as podium_streak_length
	, first_value(season) over (partition by driver_id, streak_flag order by season, round_num) as streak_start_season
	, last_value(season) over (partition by driver_id, streak_flag order by season, round_num) as streak_end_season
	, first_value(round_num) over (partition by driver_id, streak_flag order by season, round_num) as streak_start_round
	, last_value(round_num) over (partition by driver_id, streak_flag order by season, round_num) as streak_end_round*/

from base

order by season, round_num, race_date, finish_position, driver_id

