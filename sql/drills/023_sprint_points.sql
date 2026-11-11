/*
  Drill 023 — Sprint points, 2024

  Question:
    Total sprint points for each driver in 2024.

  Assumed grain:
    One row per driver_id for season 2024.

  Tables used:
    marts.fct_sprint_results
*/

select
	driver_id
	, sum(points) as sprint_points

from marts.fct_sprint_results

where
	season = 2024

group by driver_id
order by sprint_points desc, driver_id;
