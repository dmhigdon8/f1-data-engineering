# F1 Project — Session Status

**Last session:** September 20, 2026
**Owner:** Daniel Higdon — now working across two machines:
  - **Mac:** macOS 26.6.2, Intel Mac (T2), path `~/Desktop/Projects/f1-data-engineering`
  - **Dell:** Dell XPS 14 (2026) Ubuntu Developer Edition, Core Ultra X7 358H, 64GB RAM, 1TB SSD, Ubuntu 24.04.5 LTS, path `~/f1-data-engineering`
**Repo:** https://github.com/dmhigdon8/f1-data-engineering (private)

---

## Learning plan

Sports-centered roadmap (SQL → dbt → AI → DSA → ingestion), with this F1 warehouse as the spine:

- Full plan: [`LEARNING_PLAN.md`](LEARNING_PLAN.md)
- Phase 1 SQL drills: [`sql/drills/`](sql/drills/) (see [`sql/drills/README.md`](sql/drills/README.md))

**In progress (Phase 1):** grain + gap-to-leader drills committed; singular dbt test `assert_no_duplicate_driver_race` added. Next: run the drills against a live warehouse on Mac or Dell, then keep the 3-drills/week cadence.

---

## Where we left off

The project is now fully working, independently, on **both** the Mac and the new Dell — same pipeline, same repo, verified with matching clean `dbt build` results on each. This session's news is the Dell coming online; the Mac was already rebuilt and verified in the prior session (Sept 10).

### The Dell has arrived and is set up (new this session)
Per the cross-platform hardware plan (see the personal context brief), the Dell XPS 14 Ubuntu Developer Edition arrived and is now fully set up and verified — the second of the three planned machines (Mac, Dell, Windows PC) to come online.

**Proposed going forward:** the Dell becomes the primary machine for raw datasets (matches the original cross-platform plan — a dedicated Linux box for this kind of work rather than the Mac). Not yet formally locked in with Daniel; flagging it here again as a decision to confirm, not confirmed.

### ✓ Done — Dell (this session, first full setup on this machine)
- apt-based toolchain: `git`, `gh` (browser-based auth via `gh auth login`, then `gh repo clone`), `python3.12`, `awscli`, `libpq-dev` **and** `postgresql-client` (the latter needed separately for the actual `psql` binary — `libpq-dev` alone only gives the client library)
- Docker Engine + `docker-compose-plugin` (native Linux Docker, not Docker Desktop) — `sudo systemctl enable --now docker` to get the daemon running and enabled at boot; `sudo usermod -aG docker $USER` + `newgrp docker` to pick up group membership in the current shell without a full logout
- Cloned the repo via `gh repo clone` to `~/f1-data-engineering` (note: **different path than the Mac** — no `Desktop/Projects` nesting)
- `dbt-core`/`dbt-postgres` installed via pipx, pinned to `"dbt-core==1.8.*"` / `"dbt-postgres==1.8.*"` (quoted, same reasoning as the Mac); `dbt` not found immediately after install — fixed with `pipx ensurepath` + a fresh terminal tab to pick up `~/.local/bin` on `PATH`
- `.env` and `~/.dbt/profiles.yml` set up the same way as the Mac (port `5433`); same AWS key reused from the password manager (still not rotated — see Still to do)
- Data extraction + load re-run for all seasons 2014–2025 — row counts matched the known-good baseline
- `dbt build`: **PASS=34, WARN=0, ERROR=0, SKIP=0, TOTAL=34** — identical clean result to the Mac

### ✓ Done — Mac (prior session, Sept 10 — unchanged, still the working state)
Homebrew, git, gh, python@3.12, awscli, libpq/psql, Docker Desktop, Postman all installed; repo cloned to `~/Desktop/Projects/f1-data-engineering`; dbt pinned to 1.8.x via pipx with `--python python3.12` explicit; full data reload verified; `dbt build` 34/34 passing. Full detail is in git history for this file (commit `72b27bd`) if needed.

### ⬜ Still to do
1. Rotate the `f1-pipeline` AWS IAM access key — still not done, now reused unchanged across **three** places (password manager, Mac `.env`, Dell `.env`), which raises the case for doing this soon rather than later
2. Formally decide/confirm: Dell as primary machine for raw datasets (proposed above, not yet locked in)
3. Windows PC — third and last machine in the cross-platform plan, not yet started: WSL2 + Docker Desktop (WSL2 backend), git/gh identity setup, confirm it can clone and run the pipeline
4. Broader cross-platform checklist, not yet started on any machine: `.gitattributes` (`* text=auto`) to normalize line endings across all three OSes; 1Password CLI (`op run`/`op inject`) for shared secrets instead of hand-copied `.env` files; a declarative env bootstrap (`requirements.txt`/`pyproject.toml` + a short setup script) so a new machine can get running with one command
5. Optional: scale further (more endpoints, incremental loads) now that AWS is in place on two machines

### Known quirks / gotchas
- **Dell/Linux-specific:** `libpq-dev` does **not** include the `psql` binary — install `postgresql-client` explicitly for that.
- **Dell/Linux-specific:** after a fresh Docker Engine install, the daemon isn't running/enabled by default — `sudo systemctl enable --now docker`. And `usermod -aG docker $USER` doesn't take effect in your *current* shell — either `newgrp docker` or fully log out/in.
- **Dell/Linux-specific:** if `dbt` isn't found right after a successful `pipx install`, it's almost always a stale `PATH` in that terminal tab — `pipx ensurepath` then open a new tab.
- **Both machines:** `check_tools.sh` reports `compose` (and, on Mac, `postman`) as missing even when everything works — it's checking for the old standalone `docker-compose` binary instead of the modern `docker compose` subcommand, and Postman has no CLI binary to detect. Confirmed false positive via `docker compose version` / `docker info` directly — not worth chasing.
- **Both machines:** dbt/pipx needs the version pin quoted and the Python interpreter explicit to avoid resolution problems — `pipx install "dbt-core==1.8.*" --python python3.12` (or `python3.12` however it's invoked on that OS), then `pipx inject dbt-core "dbt-postgres==1.8.*"`.
- **Clone paths differ by machine** — Mac: `~/Desktop/Projects/f1-data-engineering`; Dell: `~/f1-data-engineering`. Worth remembering when following any instructions written for "the other" machine.
- Host port is **5433** (not the default 5432) on every machine. Every host-side connection string uses `:5433`. Inside Docker, the extractor still uses `:5432`.
- `ingest/load.py` is idempotent — reloading doesn't duplicate rows. If the schema changes again, new files in `sql/init/` only auto-apply to a *fresh* Postgres volume; apply manually to an existing one with `psql ... -f sql/init/<file>.sql`.
- Docker occasionally pulls a newer `postgres:16` image and recreates the container on `docker compose up`. Harmless — data lives in the named `pgdata` volume, which persists across container recreation (only lost via `docker compose down -v` or explicit volume removal).
- The dbt marts schema is **not** literally named `marts` in Postgres — due to `dbt_project.yml`'s schema config, models land in `staging_marts` (and staging models in `staging_staging`). Query `staging_marts.dim_driver`, `staging_marts.fct_race_results`, etc., not `marts.*`.
- Mac only: Finder silently drops dotfiles when copying folders — use `cp -a` or zip first. Finder also hides dotfiles like `.env` by default; toggle visibility with **Cmd+Shift+.**, and edit in a code editor or `nano`, not TextEdit (rich-text mangling).
- pipx + dbt: `dbt-postgres` alone is not a CLI app. Install `dbt-core` first, then `pipx inject dbt-core dbt-postgres` (both version-pinned and quoted, per above).
- The `extractor` Docker image already has `boto3`/`click`/etc. from `requirements.txt`, so ad hoc S3 commands run via `docker compose run --rm extractor python -m ingest.s3_client <cmd>` — no separate local Python env needed for AWS work.

---

## To resume next time

**On the Mac:**
1. Open Docker Desktop (wait for whale icon to settle).
2. Terminal → `cd ~/Desktop/Projects/f1-data-engineering`.
3. `docker compose up -d postgres` then `docker compose ps` (want `Up (healthy)`).

**On the Dell:**
1. Docker Engine should already be running (`systemctl enable --now docker` was used, so it starts on boot) — confirm with `docker info`.
2. Terminal → `cd ~/f1-data-engineering`.
3. `docker compose up -d postgres` then `docker compose ps` (want `Up (healthy)`).

Either way: paste this file's contents into a new chat with Claude, say which machine you're on, then say what you want to work on next.

**Learning track (Phase 1):** with Postgres up and `dbt build` green, run the SQL drills:

```bash
psql "postgresql://f1:f1pass@localhost:5433/f1" -f sql/drills/001_grain_fct_race_results.sql
psql "postgresql://f1:f1pass@localhost:5433/f1" -f sql/drills/002_gap_to_leader.sql
cd dbt_f1 && dbt test --select assert_no_duplicate_driver_race
```

Then add drill `003_…` from [`LEARNING_PLAN.md`](LEARNING_PLAN.md) Phase 1 themes (windows / gaps / anti-joins).

---

## Before logging off for the night

**Mac:**
```bash
cd ~/Desktop/Projects/f1-data-engineering
docker compose down
```
Then quit Docker Desktop to free RAM/CPU. Note: `postgres` has `restart: unless-stopped`, so if you quit Docker Desktop *without* running `docker compose down` first, it'll auto-restart the container next time Docker Desktop launches.

**Dell:**
```bash
cd ~/f1-data-engineering
docker compose down
```
Docker Engine itself can stay running in the background (it's a lightweight native daemon, not a full VM like Docker Desktop) — no need to stop the service, just the containers.

**Both:** nothing else in this project runs in the background — `extractor` only runs on-demand, dbt runs and exits, and the only cloud resource is the S3 bucket (`dmhigdon8-f1-data-raw`), which costs nothing to leave sitting idle at this file count/size.
