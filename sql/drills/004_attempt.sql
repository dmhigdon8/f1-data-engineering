select 
	season
	, round_num
	, race_name
	, race_date
	, driver_id
	, is_podium
	, finish_position
	, lag(is_podium) over (partition by driver_id order by race_date) as previous_podium_flag


 from staging_marts.fct_race_results

 order by 1,2,3,4;