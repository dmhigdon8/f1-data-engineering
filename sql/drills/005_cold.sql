select
	count(*) as c_count
	, count(distinct (season, round_num, driver_id)) as d_count

from staging_marts.fct_sprint_results;


select
	season
	, round_num
	, driver_id
	, count(*) as c_count

from staging_marts.fct_sprint_results

group by 1,2,3
having count(*) > 1
order by c_count desc;
