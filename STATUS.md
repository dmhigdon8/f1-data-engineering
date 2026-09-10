# F1 Project — Session Status

**Last session:** September 10, 2026
**Owner:** Daniel Higdon (macOS 26.6.2, Intel Mac — same physical machine as before, freshly reinstalled)
**Repo:** https://github.com/dmhigdon8/f1-data-engineering (private)

---

## Where we left off

Full local pipeline is working end to end again for all 12 seasons (2014–2025). The project is in a stable, working state — this session was a full rebuild after a clean macOS reinstall, not new feature work.

### Why the machine got wiped (Sept 2026 context)
This Mac was temporarily converted to a dedicated Ubuntu box (see the Build Sheet artifact) as an experiment in reclaiming hands-on Linux/dev skills. Linux-on-this-hardware proved troublesome (an unresolved Firefox "already running" bug, general dated-hardware friction), so the decision was made to revert it to macOS via Internet Recovery and instead order a **Dell XPS 14 (2026) Ubuntu Developer Edition** (Core Ultra X7 358H, 64GB RAM, 1TB SSD, factory Ubuntu 24.04 LTS) as the dedicated Linux dev machine — arriving mid-to-late Sept 2026. This Mac is the interim/backup machine until the Dell arrives, and stays in the mix afterward alongside the Dell and a Windows PC.

### ✓ Done (this session — full rebuild from a blank macOS install)
- Homebrew 6.0.22 (fresh install), `git` 2.55.0, `gh` 2.100.0 (new on this machine — wasn't installed before), `python@3.12`, `awscli` 2.36.42, `libpq`/`psql` 18.6, Docker Desktop 29.7.2, Postman
- Cloned the repo fresh via `gh repo clone` to the same path as before: `~/Desktop/Projects/f1-data-engineering`
- `dbt-core`/`dbt-postgres` reinstalled via pipx, explicitly pinned to `"dbt-core==1.8.*"` / `"dbt-postgres==1.8.*"` **and** explicitly pointed at Python 3.12 with `--python python3.12` — see Known quirks below, this step changed from last time
- `.env` recreated from `.env.example`; reused the existing AWS access key/secret from the password manager (not rotated — see Still to do)
- `~/.dbt/profiles.yml` recreated from `dbt_f1/profiles.template.yml`, with `port` hardcoded to `5433`
- Docker Postgres 16 brought back up on host port **5433**; `sql/init/02_raw_payloads_unique.sql` re-applied by hand (only auto-applies on a truly fresh volume)
- Extraction re-run for all seasons 2014–2025; load re-run — row counts verified back to the known-good state: drivers/qualifying/races/results/standings = 12 each, sprint = 5 (2021–2025 only)
- `dbt build`: all 4 table models + 4 view models built clean, **34/34 tests passed** (26 data tests + the view/table builds) — full parity with the July 13 session

### ⬜ Still to do
1. Optional: scale further (more endpoints, incremental loads) now that AWS is in place
2. Rotate the `f1-pipeline` IAM access key — still not done. The secret was visible in on-screen screenshots back in July, and this session reused the same key from the password manager rather than rotating (low risk given the policy is scoped to one bucket, but still worth doing when convenient: create a new key, update `.env`, deactivate the old one in IAM)
3. Once the Dell XPS 14 (Ubuntu) arrives, decide its role vs. this Mac vs. the Windows PC — see the cross-platform setup checklist in the personal context brief (`.gitattributes`, WSL2+Docker Desktop on Windows, 1Password CLI for shared secrets, declarative env bootstrap) — not yet started on any machine

### Known quirks / gotchas
- **New this session:** a fresh macOS install's default `python3` may not be the Homebrew 3.12 you just installed — this time it resolved to Python 3.14, which broke `pipx install dbt-core` (a `dbt-common`/`mashumaro` incompatibility with 3.14, tracked upstream at dbt-labs/dbt-core#12098). Fix: always install with `pipx install "dbt-core==1.8.*" --python python3.12` explicitly — don't rely on pipx picking the right interpreter on its own.
- **New this session:** zsh treats an unquoted `*` in a version pin as a glob and fails with "no matches found" if nothing in the current directory matches. Always quote version specs: `pipx install "dbt-core==1.8.*"`, not `pipx install dbt-core==1.8.*`.
- Host port is **5433** (not the default 5432). Every host-side connection string uses `:5433`. Inside Docker, the extractor still uses `:5432`.
- `ingest/load.py` is idempotent — reloading doesn't duplicate rows. If the schema changes again, remember new files in `sql/init/` only auto-apply to a *fresh* Postgres volume; apply them manually to an existing one with `psql ... -f sql/init/<file>.sql`.
- Docker occasionally pulls a newer `postgres:16` image and recreates the container on `docker compose up`. Harmless — data lives in the named `pgdata` volume, which persists across container recreation (only lost via `docker compose down -v` or explicit volume removal).
- The dbt marts schema is **not** literally named `marts` in Postgres — due to `dbt_project.yml`'s schema config, models land in `staging_marts` (and staging models in `staging_staging`). Query `staging_marts.dim_driver`, `staging_marts.fct_race_results`, etc., not `marts.*`.
- `gh` CLI is now installed on this machine (it wasn't before) — GitHub auth goes through `gh auth login` (browser-based), not a manually-managed PAT.
- Finder silently drops dotfiles when copying folders — use `cp -a` or zip first. Also, Finder hides dotfiles like `.env` by default; toggle visibility with **Cmd+Shift+.**, and edit them in a code editor or `nano`, not by double-clicking into TextEdit, to avoid rich-text mangling.
- pipx + dbt: `dbt-postgres` alone is not a CLI app. Install `dbt-core` first, then `pipx inject dbt-core dbt-postgres` (both version-pinned and quoted, per above).
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
