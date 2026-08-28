# F1 Data Engineering — Personal Learning Project

End-to-end pipeline: Jolpica F1 API → local raw JSON → AWS S3 (raw zone) → Postgres (Docker) → dbt models → analytics queries.

**Stack:** git · Python · Docker · Postgres · Postman · AWS S3 · dbt

---

## 0. Audit your machine first (macOS or Linux)

`check_tools.sh` detects your OS and checks for what it needs either way. Before installing anything, find out what you already have. From this project folder in Terminal:

```bash
cd ~/Downloads/f1-data-engineering   # or wherever you dropped it
bash check_tools.sh
```

Paste the output back and we'll fill in only the gaps. What the script checks:

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
git config --global user.name  "Daniel Higdon"
git config --global user.email "higdon.analytics@gmail.com"
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

Matches the pinned-Python approach this project already uses on macOS (see the "known quirks" note in `STATUS.md` about system Python drifting ahead of what dbt supports):

```bash
pipx install dbt-core
pipx inject dbt-core dbt-postgres
```

#### 1e. Postman (optional)

Only needed for manually poking at the Jolpica API — not required to run the pipeline. Download the `.deb`/AppImage from postman.com/downloads, or skip it and use `postman/F1_Jolpica.postman_collection.json` as reference only.

#### 1f. Sign in to the tools

Same as the macOS section above — `git config --global ...` and either fill in `.env` directly or run `aws configure`. Same least-privilege IAM policy JSON applies.

---

## 2. One-time project bootstrap

```bash
# 1. Start a git repo and make your first commit
cd ~/Downloads/f1-data-engineering
git init
git add .
git commit -m "scaffold f1 data engineering project"

# 2. (Optional) push to GitHub
#    - Create an empty repo on github.com first (no README, no .gitignore)
#    - Then:
# git remote add origin git@github.com:<you>/f1-data-engineering.git
# git push -u origin main

# 3. Create your .env from the template and edit it
cp .env.example .env
open -e .env     # edit AWS_S3_BUCKET to a globally-unique name

# 4. Point dbt at the profiles template shipped with the repo
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
dbt deps          # (no-op — we don't use packages yet, but habit-forming)
dbt build         # runs models, then runs tests
dbt docs generate && dbt docs serve   # opens a lineage graph in your browser
cd ..
```

If `dbt build` succeeds you'll have real tables — **note:** despite `dbt_project.yml` saying `+schema: marts`, dbt prefixes custom schemas with the profile's target schema (`staging`), so the models actually land in `staging_marts`, not `marts`. Same pattern gives `staging_staging` for the staging views. Query accordingly:
```bash
psql "postgresql://f1:f1pass@localhost:5433/f1" -c "\dt staging_marts.*"
```

### 3f. Try a real analysis query

```bash
psql "postgresql://f1:f1pass@localhost:5433/f1" <<'SQL'
select d.full_name,
       count(*) filter (where f.is_winner) as wins,
       count(*) filter (where f.is_podium) as podiums,
       sum(f.points) as total_points
from staging_marts.fct_race_results f
join staging_marts.dim_driver d using (driver_id)
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
│       ├── staging/              # views that flatten JSONB (lands in schema staging_staging)
│       └── marts/                # dim_driver, dim_race, fct_race_results (+ tests) (lands in schema staging_marts)
├── postman/F1_Jolpica.postman_collection.json
└── raw/                          # extractor drops JSON here (gitignored)
```

---

## 6. Learning path — what to tackle after it runs

You'll get the most out of this project if you extend it yourself. Suggested order:

1. **Incremental extracts** — change `ingest/extract.py` to only pull the latest round instead of whole seasons. Track "last pulled round" in a small Postgres table.
2. **Add pit stops and lap times** — new endpoints in `ENDPOINTS`, new staging + marts models.
3. **Constructor dimension** — add `dim_constructor`, join to `fct_race_results`.
4. **dbt tests that matter** — add `accepted_values` on `status`, a custom test that grid_position between 1 and 24.
5. **Orchestration** — schedule the extractor with a simple cron, or level up to Apache Airflow / Prefect / Dagster.
6. **Swap Postgres for Redshift or Snowflake** — only dbt `profiles.yml` changes; rest of the project is identical.
7. **CI** — GitHub Actions workflow that runs `dbt build --select state:modified+` on every PR.

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
- **`\dt marts.*` or `select ... from marts.foo` returns nothing** → the schema is actually `staging_marts` (and `staging_staging` for staging models), not `marts` — see the note in section 3e.
- **macOS: `docker: command not found`** → Docker Desktop isn't installed or hasn't been launched once. Open it from Launchpad, wait for the whale icon to stop animating.
- **Linux: `docker: command not found` or daemon unreachable** → make sure Docker Engine is installed and running (`sudo systemctl status docker`). If `docker info` fails with a permission error specifically, your user isn't in the `docker` group yet — `sudo usermod -aG docker $USER`, then fully log out and back in (not just a new terminal tab).
- **`pip install dbt-postgres` fails with a psycopg2 build error** → make sure the Postgres client headers are installed: `brew link --force libpq` on macOS, or `sudo apt install libpq-dev` on Linux. Or install into a venv/pipx instead of system Python.
- **S3 `AccessDenied`** → the IAM user attached to your AWS CLI creds/`.env` doesn't have S3 permissions, or the least-privilege policy's bucket ARN doesn't match `AWS_S3_BUCKET` exactly (typo, or you renamed the bucket). Compare the policy's `Resource` field against `.env`.
- **Jolpica rate-limit (HTTP 429)** → the extractor's `tenacity` retry handles it, but consider pulling fewer seasons at once.
