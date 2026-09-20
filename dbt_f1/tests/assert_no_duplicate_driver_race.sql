-- Singular test: fail if any driver appears more than once in a race.
-- Returns violating (season, round_num, driver_id) groups; 0 rows = pass.
-- Complements the unique test on result_key by checking the natural grain.

select
    season,
    round_num,
    driver_id,
    count(*) as row_count
from {{ ref('fct_race_results') }}
group by season, round_num, driver_id
having count(*) > 1
