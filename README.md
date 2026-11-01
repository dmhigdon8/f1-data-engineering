# F1 data engineering

End-to-end Formula 1 warehouse. The Jolpica API is extracted to local JSON, landed in S3, loaded into Postgres, and modeled with dbt. Analytics SQL runs on the marts.

This is a personal project: one pipeline, one domain, the same shape as a small production analytics stack. Practice notes live in separate files and are not the project description.

## Stack

| Layer | Choice |
| --- | --- |
| Source | Jolpica F1 API (races, drivers, results, qualifying, sprint, driver standings) |
| Extract | Python 3.12, `requests`, `tenacity` retries, Click CLI, Docker image |
| Raw zone | Local JSON, then AWS S3 (`boto3`), least-privilege IAM on one bucket |
| Load | Python, `psycopg`, idempotent insert into `raw.jolpica_payloads` |
| Warehouse | PostgreSQL 16 in Docker Compose. Host port 5433. Schemas `raw`, `staging`, `marts` |
| Transform | dbt 1.8 / dbt-postgres. Staging views, mart tables. Custom schema macro uses the folder name as written |
| Tests | `unique`, `not_null`, and `relationships` on drivers, races, race results, and sprint results, plus a singular grain test on `fct_race_results` |
| API exploration | Postman collection in `postman/` |
| Version control | git |

Constructors are parsed from the nested constructor object on results. There is no separate constructors endpoint.

## Pipeline

```text
Jolpica API
  → ingest/extract.py          raw/<endpoint>_<season>.json
  → ingest/s3_client.py        s3://<bucket>/raw/jolpica/
  → ingest/load.py             raw.jolpica_payloads
  → dbt staging views          staging.stg_*
  → dbt marts                  marts.dim_*  marts.fct_*
```

## Warehouse

| Model | Grain |
| --- | --- |
| `staging.stg_races`, `stg_drivers`, `stg_results`, `stg_qualifying`, `stg_sprint`, `stg_standings`, `stg_constructors` | One row per source record, flattened from the raw JSON |
| `marts.dim_driver` | One row per driver |
| `marts.dim_race` | One row per season and round |
| `marts.dim_constructor` | One row per constructor |
| `marts.fct_race_results` | One row per driver per race |
| `marts.fct_qualifying_results` | One row per driver per qualifying session |
| `marts.fct_sprint_results` | One row per driver per sprint (2021 onward) |
| `marts.fct_driver_standings` | One championship snapshot per driver per season |

Schema tests cover `dim_driver`, `dim_race`, `fct_race_results`, and `fct_sprint_results`. Qualifying, standings, and constructors are modeled. Their schema tests are the next coverage to add.

Worked SQL against these marts is in `sql/drills/`: grain checks, window functions, anti-joins, streaks, season rank, and joins across facts and dimensions.

## Where to look

| Path | What it is |
| --- | --- |
| `ingest/` | Extract, S3 upload, Postgres load |
| `dbt_f1/` | Staging views, marts, tests, schema macro |
| `sql/init/` | Schemas and the raw-payload unique key |
| `sql/drills/` | Worked warehouse queries |
| `postman/` | Jolpica request collection |
| `STATUS.md`, `LEARNING_PLAN.md`, `LEARNING_LIBRARY.md`, `sql/quiz/` | Author practice notes |

---

## Local setup

`check_tools.sh` detects macOS or Linux and reports which tools are present. From the project folder:

```bash
bash check_tools.sh
```

What the script checks:

| Tool                        | Why you need it                                            |
|-----------------------------|-------------------------------------------------------------|
| Homebrew (macOS) / apt (Linux) | Package manager that installs everything else.           |
| git                         | Version control.                                             |
| Python 3.11+                | Runs the extractor and dbt.                                  |
| Docker Desktop (macOS) / Docker Engine (Linux) | Runs Postgres locally without installing it directly. |
| psql                        | CLI for inspecting Postgres. Bundled with Postgres tools.    |
| AWS CLI v2                  | Authenticates you to AWS and uploads to S3.                  |
| dbt-postgres                | Turns raw SQL into a tested, version-controlled warehouse.   |
| Postman                     | GUI for poking at the Jolpica API before you write code.     |

On Linux, the script also checks that your user is in the `docker` group, since running `docker` without `sudo` requires it.

---

## 1. Install what's missing

Pick the section for your OS.

### macOS

#### 1a. Homebrew (if the check says MISSING)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After it finishes, follow the printed instructions to add brew to your PATH (usually one `eval "$(/opt/homebrew/bin/brew shellenv)"` line added to `~/.zprofile`).

#### 1b. Everything else, one-shot

```bash
# Core CLIs
brew install git python@3.12 awscli libpq

# libpq is the Postgres client library; it gives us psql. Link it so it's on PATH:
brew link --force libpq

# GUI apps (Casks)
brew install --cask docker postman

# Python tooling used by this project
python3 -m pip install --upgrade pip
python3 -m pip install dbt-postgres==1.8.*
```

**After installing Docker Desktop:** open it once from Launchpad so the daemon starts. `docker info` should then work in your terminal.

#### 1c. Update what's already installed

```bash
brew update            # refresh Homebrew's package list
brew upgrade           # upgrade all brew formulas + casks
python3 -m pip install --upgrade dbt-postgres
```

#### 1d. Sign in to the tools

```bash
# Git — one-time config
git config --global user.name  "Your Name"
git config --global user.email "you@example.com"
git config --global init.defaultBranch main

# AWS — you'll need an IAM user with programmatic access
aws configure
# Paste: Access Key ID, Secret Access Key, region (us-east-1), output (json)
aws sts get-caller-identity   # proves the creds work
```

Don't have an AWS account yet? Sign up at aws.amazon.com — the Free plan (6 months / $200 credits) is enough for this project, since it only needs S3 + IAM, neither of which is restricted on that plan. In the AWS console, create an IAM user with **programmatic access only** (no console password), and attach a least-privilege customer-managed policy scoped to a single bucket instead of `AmazonS3FullAccess`:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "BucketLevel",
      "Effect": "Allow",
      "Action": ["s3:CreateBucket", "s3:ListBucket", "s3:GetBucketLocation"],
      "Resource": "arn:aws:s3:::YOUR_BUCKET_NAME"
    },
    {
      "Sid": "ObjectLevel",
      "Effect": "Allow",
      "Action": ["s3:PutObject", "s3:GetObject"],
      "Resource": "arn:aws:s3:::YOUR_BUCKET_NAME/*"
    }
  ]
}
```

This is what's actually attached to the `f1-pipeline` IAM user in this project. You don't strictly need `aws configure` either — `ingest/config.py` calls `load_dotenv()`, which pushes `.env` values into real env vars, and boto3 picks up `AWS_ACCESS_KEY_ID`/`AWS_SECRET_ACCESS_KEY` from there automatically. `aws configure` is still handy for using the `aws` CLI directly (e.g. `aws s3 ls`) as a sanity check.

---

### Linux (Ubuntu/Debian)

#### 1a. Core packages via apt

```bash
sudo apt update
sudo apt install -y git python3 python3-pip python3-venv pipx curl libpq-dev unzip
pipx ensurepath
```

#### 1b. Docker Engine (not Docker Desktop)

```bash
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER
```

Log all the way out and back in (or reboot) — group membership doesn't apply to your current session. Confirm with `docker info` (no `sudo` needed) and `docker compose version`.

#### 1c. AWS CLI v2

The `apt` version is often outdated, so use the official installer:

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws/
```

#### 1d. dbt

Pin the same dbt 1.8 line used with this project:

```bash
pipx install "dbt-core==1.8.*"
pipx inject dbt-core "dbt-postgres==1.8.*"
```

#### 1e. Postman (optional)

Only needed for manually poking at the Jolpica API — not required to run the pipeline. Download the `.deb`/AppImage from postman.com/downloads, or skip it and use `postman/F1_Jolpica.postman_collection.json` as reference only.

#### 1f. Sign in to the tools

Same as the macOS section above — `git config --global ...` and either fill in `.env` directly or run `aws configure`. Same least-privilege IAM policy JSON applies.

---

## 2. One-time project bootstrap

```bash
git clone git@github.com:dmhigdon8/f1-data-engineering.git
cd f1-data-engineering

cp .env.example .env
# Set AWS_S3_BUCKET to a globally unique name, plus the AWS keys.

mkdir -p ~/.dbt
cp dbt_f1/profiles.template.yml ~/.dbt/profiles.yml
```

**Gotcha:** `docker-compose.yml` maps the container's Postgres port 5432 to **host port 5433** (`"5433:5432"`), to avoid clashing with any Postgres already on your machine. `profiles.template.yml` defaults `POSTGRES_PORT` to `5432` if the env var isn't set. Either export `POSTGRES_PORT=5433` in your shell before running `dbt`, or just hardcode `port: 5433` directly in `~/.dbt/profiles.yml` after copying it — the latter is simpler and is what this project actually runs with. Every host-side `psql`/`dbt` connection uses `:5433`; only *inside* the Docker network (container-to-container) does it stay `:5432`.

---

## 3. Run the pipeline

Everything below assumes your Docker daemon is running (Docker Desktop on macOS, `dockerd` on Linux).

### 3a. Start Postgres in Docker

```bash
docker compose up -d postgres
docker compose logs -f postgres   # Ctrl-C once you see "database system is ready"
```

That spun up a Postgres 16 container, reachable from the host at `localhost:5433` (see the port gotcha above), and ran `sql/init/01_schemas.sql` to create the `raw`, `staging`, and `marts` schemas.

Verify:
```bash
psql "postgresql://f1:f1pass@localhost:5433/f1" -c "\dn"
```

### 3b. Build the extractor image and pull data

```bash
docker compose build extractor
docker compose run --rm extractor python -m ingest.extract --seasons 2023 --seasons 2024
ls raw/
```

You should now have `races_2023.json`, `results_2024.json`, etc.

### 3c. Upload the raw files to S3

```bash
docker compose run --rm extractor python -m ingest.s3_client ensure-bucket
docker compose run --rm extractor python -m ingest.s3_client upload
aws s3 ls "s3://$(grep AWS_S3_BUCKET .env | cut -d= -f2)/raw/jolpica/" --recursive
```

### 3d. Load raw JSON into Postgres

```bash
docker compose run --rm extractor python -m ingest.load
psql "postgresql://f1:f1pass@localhost:5433/f1" \
  -c "select endpoint, season, count(*) from raw.jolpica_payloads group by 1,2 order by 1,2;"
```

### 3e. Transform with dbt

```bash
cd dbt_f1
dbt debug         # checks that dbt can connect to Postgres
dbt deps          # no packages yet; keeps the project ready for one
dbt build         # runs models, then runs tests
dbt docs generate && dbt docs serve   # opens a lineage graph in your browser
cd ..
```

If `dbt build` succeeds you'll have real tables in `marts` and views in `staging`. `macros/generate_schema_name.sql` tells dbt to use those folder schema names as written.
```bash
psql "postgresql://f1:f1pass@localhost:5433/f1" -c "\dt marts.*"
```

### 3f. Try a real analysis query

```bash
psql "postgresql://f1:f1pass@localhost:5433/f1" <<'SQL'
select d.full_name,
       count(*) filter (where f.is_winner) as wins,
       count(*) filter (where f.is_podium) as podiums,
       sum(f.points) as total_points
from marts.fct_race_results f
join marts.dim_driver d using (driver_id)
where f.season = 2024
group by d.full_name
order by total_points desc
limit 10;
SQL
```

---

## 4. Explore the API in Postman

1. Open Postman.
2. `File → Import` → pick `postman/F1_Jolpica.postman_collection.json`.
3. The `base_url`, `season`, `round`, `driver` values are on the collection's **Variables** tab — edit them once, not per request.
4. Hit `Send` on each request to see the raw JSON the extractor parses.

Postman is useful for *understanding* an API before automating it. When you find a new endpoint worth ingesting, add it to `ENDPOINTS` in `ingest/extract.py`.

---

## 5. Project structure

```
f1-data-engineering/
├── check_tools.sh                # macOS/Linux toolchain audit
├── docker-compose.yml            # Postgres + extractor services
├── Dockerfile                    # Python 3.12 image for the extractor
├── requirements.txt              # Python deps
├── .env.example / .env           # secrets (real .env is gitignored)
├── sql/init/
│   ├── 01_schemas.sql            # runs on first Postgres boot (fresh volume only)
│   └── 02_raw_payloads_unique.sql # unique constraint; apply by hand to an existing volume
├── ingest/
│   ├── config.py                 # env-driven Settings
│   ├── extract.py                # Jolpica API -> raw/*.json
│   ├── s3_client.py              # raw/*.json -> S3
│   └── load.py                   # raw/*.json -> raw.jolpica_payloads
├── dbt_f1/
│   ├── dbt_project.yml
│   ├── profiles.template.yml     # copy to ~/.dbt/profiles.yml
│   └── models/
│       ├── staging/              # stg_<endpoint> views (schema staging)
│       └── marts/                # dim_<singular>, fct_<event> tables (schema marts)
├── sql/drills/                   # worked queries against the marts
├── postman/F1_Jolpica.postman_collection.json
└── raw/                          # extractor drops JSON here (gitignored)
```

---

## 6. Next on the warehouse

1. **Incremental extracts** — pull the latest round instead of a full season, and record the last pulled round.
2. **Schema tests** for qualifying, driver standings, and constructors. `fct_race_results` already carries `constructor_id`, and `dim_constructor` is the matching dimension.
3. **Pit stops and lap times** — both are per round, so the extractor has to loop rounds before those models exist.
4. **More result tests** — `accepted_values` on status, and grid position between 1 and 24.
5. **Orchestration** — cron, or Airflow / Prefect / Dagster, once the batch is worth scheduling.
6. **Another warehouse** — a dbt profile change is the adapter swap (Redshift or Snowflake). The extract and S3 landing stay put.
7. **CI** — GitHub Actions running `dbt build` on pull requests.

---

## 7. Stop / clean up

```bash
docker compose down          # stop containers, keep data volume
docker compose down -v       # ALSO delete the Postgres volume (start fresh)
docker image prune           # reclaim disk
```

---

## 8. Troubleshooting

- **`dbt debug` says connection refused** → the Postgres container hasn't finished booting, or you're on the wrong port. Re-run `docker compose up -d postgres`, watch logs, and confirm you're connecting to `5433` (host) not `5432` (that's only the in-container port — see the gotcha in section 2).
- **macOS: `docker: command not found`** → Docker Desktop isn't installed or hasn't been launched once. Open it from Launchpad, wait for the whale icon to stop animating.
- **Linux: `docker: command not found` or daemon unreachable** → make sure Docker Engine is installed and running (`sudo systemctl status docker`). If `docker info` fails with a permission error specifically, your user isn't in the `docker` group yet — `sudo usermod -aG docker $USER`, then fully log out and back in (not just a new terminal tab).
- **`pip install dbt-postgres` fails with a psycopg2 build error** → make sure the Postgres client headers are installed: `brew link --force libpq` on macOS, or `sudo apt install libpq-dev` on Linux. Or install into a venv/pipx instead of system Python.
- **S3 `AccessDenied`** → the IAM user attached to your AWS CLI creds/`.env` doesn't have S3 permissions, or the least-privilege policy's bucket ARN doesn't match `AWS_S3_BUCKET` exactly (typo, or you renamed the bucket). Compare the policy's `Resource` field against `.env`.
- **Jolpica rate-limit (HTTP 429)** → the extractor's `tenacity` retry handles it, but consider pulling fewer seasons at once.
