select 
		count(*) as rows
		, count(distinct (season, round_num, driver_id)) as d_rows

from staging_marts.fct_race_results