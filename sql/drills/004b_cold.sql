with base as (select 
	driver_id
	, round_num
	, is_points_finish
	, lag(is_points_finish) over (partition by driver_id order by round_num) as prev_points_finish

from marts.fct_race_results

where 
	season = 2024)

, streaks as (
	select 
		*
		, sum(case when is_points_finish and coalesce(prev_points_finish, false) = false then 1 else 0 end) over (partition by driver_id order by round_num) as driver_streak_ind
	
	from base

	where is_points_finish)


, penultimate as (select distinct
	driver_id 
	, min(round_num) over (partition by driver_id, driver_streak_ind) as streak_round_start
	, max(round_num) over (partition by driver_id, driver_streak_ind) as streak_round_end
	, count(*) over (partition by driver_id, driver_streak_ind) as streak_length
	

 from streaks)

select distinct * from penultimate

where streak_length >=2
order by streak_length desc;