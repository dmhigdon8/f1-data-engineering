# F1 Project — Session Status

**Last session:** July 13, 2026
**Owner:** Daniel Higdon (macOS 26.4.1, Intel Mac)
**Repo:** https://github.com/dmhigdon8/f1-data-engineering (private)

---

## Where we left off

Full local pipeline is working end to end for all 12 seasons (2014–2025), and AWS bootstrap is now complete — all 65 raw JSON files are in S3. The project is in a stable, working state; what's left is optional scaling.

### ✓ Done
- Xcode CLT, Homebrew 5.1.6, `python@3.12`, `awscli`, `libpq`, Docker Desktop, Postman
- `dbt-core` + `dbt-postgres` via pipx (pinned to Python 3.12)
- Project folder: `~/Desktop/Projects/f1-data-engineering`
- Docker Postgres 16 running on **host port 5433** (remapped from 5432)
- Schemas created (`raw`, `staging`, `marts`) + landing table `raw.jolpica_payloads`
- Extraction: all 65 raw JSON files for seasons 2014–2025 pulled (races, drivers, results, qualifying, standings for all 12 seasons; sprint for 2021–2025 only, correctly — sprints didn't exist before then)
- Load: `raw.jolpica_payloads` truncated and reloaded from all 65 files. Verified row counts — drivers/qualifying/races/results/standings = 12 each, sprint = 5.
- dbt build: all 4 table models + 4 view models built clean, 34/34 tests passed, on the full dataset
- Sanity-checked `fct_race_results` — top career wins (Hamilton 83, Verstappen 71, Rosberg 20...) look correct
- Git initialized, first commit made, pushed to GitHub (`main` branch, using a PAT over HTTPS — Keychain should now have it saved)
- Installed the Claude Code extension in Cursor and used it to fix a real bug: `ingest/load.py` had no dedup/upsert logic. Added `sql/init/02_raw_payloads_unique.sql` (unique constraint on `(endpoint, season)`) and changed the loader's INSERT to `ON CONFLICT (endpoint, season) DO UPDATE`. Migration applied to the existing Postgres volume by hand (`psql ... -f sql/init/02_raw_payloads_unique.sql`), since `01_schemas.sql`-style init scripts only run on first container creation. Verified idempotency by running `ingest.load` twice in a row — counts stayed at 12/12/12/12/12/5, no duplication. Re-ran `dbt build` after — still 34/34 tests passing.
- **AWS bootstrap (complete):**
  - AWS account created on the Free plan (6 months / $200 credits) — sufficient for this project since it only needs S3 + IAM, neither of which is restricted on the free tier.
  - IAM user `f1-pipeline` created, programmatic access only (no console access).
  - Least-privilege customer-managed policy `F1PipelineS3Access` created and attached directly to the user, scoped to a single bucket: `s3:CreateBucket`/`s3:ListBucket`/`s3:GetBucketLocation` on the bucket ARN, `s3:PutObject`/`s3:GetObject` on `<bucket>/*`.
  - Access key created and stored in `.env` (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_S3_BUCKET`, `AWS_REGION=us-east-1`). `.env` is gitignored — confirmed via `.gitignore` (`.env`, `.env.local`, `*.env`).
  - No `aws configure` needed — `ingest/config.py` calls `load_dotenv()`, which pushes `.env` values into real process env vars, and `boto3.client("s3", ...)` in `ingest/s3_client.py` picks up `AWS_ACCESS_KEY_ID`/`AWS_SECRET_ACCESS_KEY` from the environment automatically via its default credential chain.
  - Bucket `dmhigdon8-f1-data-raw` created in `us-east-1` via `docker compose run --rm extractor python -m ingest.s3_client ensure-bucket`.
  - All 65 raw JSON files uploaded via `docker compose run --rm extractor python -m ingest.s3_client upload`, landing at `s3://dmhigdon8-f1-data-raw/raw/jolpica/<endpoint>/season=<YYYY>/<endpoint>_<YYYY>.json`. Log confirmed "Done. 65 files uploaded." with no failures.

### ⬜ Still to do
1. Optional: scale further (more endpoints, incremental loads) now that AWS is in place
2. Optional: rotate the `f1-pipeline` IAM access key, since the secret value was visible in on-screen screenshots during setup (low risk given the policy is scoped to one bucket, but easy to tidy up — create a new key, update `.env`, deactivate the old one in IAM)

### Known quirks / gotchas
- System `python3` is 3.14.4, but dbt runs inside its own pipx venv pinned to 3.12 — don't "fix" this.
- Host port is **5433** (not the default 5432). Every host-side connection string uses `:5433`. Inside Docker, the extractor still uses `:5432`.
- `ingest/load.py` is now idempotent (see above) — reloading no longer duplicates rows. If the schema changes again, remember new files in `sql/init/` only auto-apply to a *fresh* Postgres volume; apply them manually to an existing one with `psql ... -f sql/init/<file>.sql`.
- Docker occasionally pulls a newer `postgres:16` image and recreates the container on `docker compose up`. This is harmless — the data lives in the named `pgdata` volume, which persists across container recreation (would only be lost via `docker compose down -v` or an explicit volume removal).
- The dbt marts schema is **not** literally named `marts` in Postgres — due to `dbt_project.yml`'s schema config, models land in `staging_marts` (and staging models in `staging_staging`). Query `staging_marts.dim_driver`, `staging_marts.fct_race_results`, etc., not `marts.*`.
- No `gh` CLI on this machine — GitHub pushes use HTTPS + a Personal Access Token (password auth is disabled). Token should be cached in Keychain after the first push.
- Finder silently drops dotfiles when copying folders — use `cp -a` or zip first. Also, Finder hides dotfiles like `.env` by default; toggle visibility with **Cmd+Shift+.**, and open them in a code editor (Cursor/VS Code), not double-clicked into TextEdit, to avoid rich-text mangling.
- pipx + dbt: `dbt-postgres` alone is not a CLI app. Install `dbt-core` first, then `pipx inject dbt-core dbt-postgres`.
- The `extractor` Docker image already has `boto3`/`click`/etc. from `requirements.txt`, so ad hoc S3 commands run via `docker compose run --rm extractor python -m ingest.s3_client <cmd>` — no separate local Python env needed for AWS work.

---

## To resume next time

1. Open Docker Desktop (wait for whale icon to settle).
2. Open Terminal, `cd ~/Desktop/Projects/f1-data-engineering`.
3. Start the db:
   ```bash
   docker compose up -d postgres
   docker compose ps     # want Up (healthy)
   ```
4. Paste this file's contents into the new chat with Claude. Then say what you want to work on next — e.g. "let's talk about scaling to more endpoints" or "help me rotate the AWS access key."

---

## Before logging off for the night

1. Stop the Postgres container (data persists in the `pgdata` volume either way):
   ```bash
   cd ~/Desktop/Projects/f1-data-engineering
   docker compose down
   ```
2. Quit Docker Desktop to free up RAM/CPU.
   - Note: `postgres` has `restart: unless-stopped`, so if you quit Docker Desktop *without* running `docker compose down` first, it'll auto-restart the container next time Docker Desktop launches.
3. Nothing else in this project runs in the background — `extractor` only runs on-demand, dbt runs and exits, and the only cloud resource now is the S3 bucket (`dmhigdon8-f1-data-raw`), which costs nothing to leave sitting idle at this file count/size.
