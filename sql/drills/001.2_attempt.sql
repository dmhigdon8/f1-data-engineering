 with step1 as (
	select 
		count(*) as rows
		, count(distinct (season, round_num, driver_id)) as d_rows

from staging_marts.fct_race_results)


 , step2 as (select
 	season
 	, round_num
 	, driver_id
 	, count(*) as n

 from staging_marts.fct_race_results

 group by season, round_num, driver_id
 having count(*) > 1)

 select
 	'Step 1' as Step
 	, rows as row_count
 	, d_rows as distinct_rows
 	, null as season
 	, null as round_num
 	, null as driver_id
 	, null as n

 from step1

 union

 select
 	'Step 2' as Step
 	, null as row_count
 	, null as distinct_rows
 	, case when season is null then 'None' else season::text end as season
 	, case when round_num is null then 'None' else round_num::text end as round_num
 	, case when driver_id is null then 'None' else driver_id end as driver_id
 	, case when n is null then 0 else n end as n

 from step2;