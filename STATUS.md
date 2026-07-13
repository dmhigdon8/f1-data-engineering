# F1 Project — Session Status

**Last session:** May 17, 2026 (early hours)
**Owner:** Daniel Higdon (macOS 26.4.1, Intel Mac)

---

## Where we left off

Pipeline is verified end-to-end for the 2024-only single-season scope. Then expanded scope to **2014-2025 (hybrid era)** and added a parallel **sprint race** fact table. Extract + load are complete for the new scope; **dbt build for the expanded data hasn't been run yet**.

### ✓ Done since last STATUS

Single-season verification (April-era work):
- Built and ran the 2024 pipeline end-to-end (`docker compose build extractor`, extract, load, `dbt build`)
- 25 dbt nodes built clean (3 view + 3 table models + 19 tests), all PASS
- Verified `staging_marts.fct_race_results` against real-world 2024 final standings — ordering matched exactly (VER → NOR → LEC → PIA → SAI → RUS → HAM → PER → ALO → GAS); totals were ~5-10% low because sprint points weren't being ingested

Expansion to multi-season + sprints:
- `.env`: `SEASON_START=2014`, `SEASON_END=2025`
- `ingest/extract.py`: added `sprint` endpoint to `ENDPOINTS` dict; added `HISTORICALLY_PARTIAL = {"sprint": 2021}` and a guard in `extract_season()` so pre-2021 seasons skip sprint cleanly with an INFO log line (no API call wasted)
- `dbt_f1/models/staging/stg_sprint_results.sql`: new view — mirror of `stg_results.sql` but filters `endpoint = 'sprint'` and unnests `race->'SprintResults'` instead of `race->'Results'`
- `dbt_f1/models/marts/fct_sprint_results.sql`: new table — mirror of `fct_race_results.sql`; **`result_key` is prefixed with `'sprint-'`** so it never collides with a regular race result for the same driver+season+round
- `dbt_f1/models/marts/_schema.yml`: added unique/not_null/relationships tests for `fct_sprint_results` (mirroring `fct_race_results`)
- `ingest/load.py`: **no changes needed** — already endpoint-agnostic (globs `raw/*.json`, regex matches `sprint_YYYY.json` cleanly)
- Truncated `raw.jolpica_payloads`, cleared `raw/*.json`, re-extracted all 12 seasons
- Loaded **65 JSON files** into `raw.jolpica_payloads`:
  - 12 seasons × 5 endpoints (drivers, qualifying, races, results, standings) = 60
  - 5 seasons of sprint (2021-2025) = 5

### ⬜ Still to do, in order

1. From inside `dbt_f1/`, run `dbt build` to rebuild all models against the expanded raw data and create `fct_sprint_results`. Expect roughly: dim_driver ~200 rows, dim_race ~280 rows, fct_race_results ~9-10k rows, fct_sprint_results ~500 rows.
2. Sanity-check 2024 totals — should now match real-world final standings exactly:
   - Verstappen 437 / 9 wins
   - Norris 374 / 4 wins
   - Leclerc 356 / 3 wins
3. Sample sprint-only query (most sprint wins, sprint points leaders by season, etc.)
4. Optional: revisit `fct_sprint_results.is_points_finish` — currently uses `finish_position <= 8` (2022+ convention). 2021 only paid top 3. If precision matters for 2021 analyses, make this season-aware.
5. **Step 9 (deferred)**: AWS bootstrap — IAM user, `aws configure`, set `AWS_S3_BUCKET` in `.env`, run `s3_client.py ensure-bucket` then `upload`.
6. **Step 10 (deferred)**: `git init`, first commit, push to GitHub.

### Known quirks / gotchas (carry forward + new)

Original quirks (still apply):
- System `python3` is 3.14.4, but dbt runs inside its own pipx venv pinned to 3.12 — don't "fix" this.
- Host Postgres port is **5433** (not 5432). Host-side connection strings use `:5433`. Inside Docker, the extractor uses `:5432` (set by `POSTGRES_PORT=5432` in `docker-compose.yml` for the extractor service).
- Finder silently drops dotfiles when copying folders — use `cp -a` or zip first.
- `dbt-postgres` is not standalone — install `dbt-core` via pipx first, then `pipx inject dbt-core dbt-postgres`.

New quirks discovered this session:
- **`~/.dbt/profiles.yml` is env-var-driven, not hardcoded** (despite what the old STATUS doc claimed). It uses Jinja `env_var()` with fallback defaults. The pipx-installed `dbt` binary does NOT auto-load the project `.env`, so the **fallback defaults are what dbt actually uses**. The fallback for `POSTGRES_PORT` has been updated to `'5433'` so dbt works without sourcing `.env`.
- **zsh interactive shells don't honor `#` comments by default.** Paste command blocks without comment lines, or run `setopt INTERACTIVE_COMMENTS` first.
- **`cd dbt_f1 && dbt build && cd ..` fails if you're already inside `dbt_f1/`.** From inside, just run `dbt build`.
- **`raw.jolpica_payloads` has no unique constraint on `(endpoint, season)`.** Re-running `ingest.load` will create duplicate rows for previously loaded files. Always `truncate raw.jolpica_payloads restart identity cascade;` before a re-load, or build a real upsert into the loader.
- **Sprint pre-2021**: extract.py skips with `HISTORICALLY_PARTIAL` guard — no `sprint_2014.json` through `sprint_2020.json` files exist. This is by design, not a missing-data bug.
- **Sprint points scoring varies by era**: 2021 = top 3 (3/2/1). 2022+ = top 8 (8/7/6/5/4/3/2/1). `fct_sprint_results.is_points_finish` currently uses top-8 — fine for most analyses but biases 2021 high.
- **Marts schema is `staging_marts`, not `marts`.** dbt concatenates the profile's default schema (`staging`) with the marts-models `+schema: marts` override. So queries reference `staging_marts.fct_race_results`, `staging_marts.fct_sprint_results`, etc.

---

## To resume tomorrow

1. Open Docker Desktop (wait for whale icon to settle).
2. Open Terminal, `cd` to the project folder.
3. Start the db (if not already running):
   ```bash
   docker compose up -d postgres
   docker compose ps     # want Up (healthy)
   ```
4. Run the dbt build (from inside the `dbt_f1` directory):
   ```bash
   cd dbt_f1
   dbt build
   ```
5. Once green, run the validation query:
   ```bash
   psql "postgresql://f1:f1pass@localhost:5433/f1" -c "
   select
     d.full_name,
     sum(r.points) + coalesce(sum(s.points), 0) as total_points,
     count(*) filter (where r.is_winner) as race_wins,
     count(distinct s.race_key) filter (where s.is_winner) as sprint_wins
   from staging_marts.fct_race_results r
   left join staging_marts.fct_sprint_results s
     on r.season = s.season and r.round_num = s.round_num and r.driver_id = s.driver_id
   join staging_marts.dim_driver d using (driver_id)
   where r.season = 2024
   group by d.full_name
   order by total_points desc
   limit 10;
   "
   ```
   Expect Verstappen 437, Norris 374, Leclerc 356.
6. Paste this file's contents into the new chat with Claude. Then say: "Pick up at step 1 of 'Still to do'."
