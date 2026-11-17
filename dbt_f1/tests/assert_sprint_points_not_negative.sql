-- Singular test: fail if any driver in a given sprint has negative points value.
-- Returns violating (season, round_num, driver_id, points); 0 rows = pass.
-- Complements the not_null test on points.

select
	season,
	round_num,
	driver_id,
	points
from {{ ref('fct_sprint_results') }}
where points < 0
