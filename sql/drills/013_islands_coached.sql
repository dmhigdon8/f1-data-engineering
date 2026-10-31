with base as (
	select
		driver_id
		, round_num
		, case when is_podium then 1 else 0 end as is_podium

	from marts.fct_race_results

	where
		season = 2023
)

, streak_start as (
	select
		*
		, case when is_podium = 1 and 
			   (lag(is_podium) over (partition by driver_id order by round_num) is null OR 
			   lag(is_podium) over (partition by driver_id order by round_num) = 0) then 1 else 0 end as streak_start

	from base) 

, streak_island as (
	select
		*
		, sum(streak_start) over (partition by driver_id order by round_num) as streak_island

	from streak_start)

, streak_params as (
	select
		driver_id
		, streak_island
		, min(round_num) as first_round
		, max(round_num) as last_round
		, count(*) as streak_length 

	from streak_island

	where
		is_podium = 1

	group by driver_id, streak_island)

select
	driver_id
	, first_round
	, last_round
	, streak_length

from streak_params

where
	streak_length >= 2

order by streak_length desc, driver_id;