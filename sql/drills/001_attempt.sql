select
	count(*) as row_count
	, count(distinct (season, round_num, driver_id)) as distinct_driver_races

from staging_marts.fct_race_results;


select
	season
	, round_num
	, driver_id
	, count(*) as n

from staging_marts.fct_race_results

group by 1,2,3
having count(*) > 1;