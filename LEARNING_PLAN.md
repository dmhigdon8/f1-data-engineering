# Learning Plan — Sports Data Platform

**Owner:** Daniel Higdon  
**Primary machine:** Dell XPS 14 — Ubuntu 24.04 Developer Edition (`~/f1-data-engineering`)  
**Secondary:** Mac (convenience / travel); same repo, same pipeline  
**Primary repo:** [f1-data-engineering](https://github.com/dmhigdon8/f1-data-engineering) (grow this)  
**Supporting repos:** [LeetCode](https://github.com/dmhigdon8/LeetCode), [Coursera](https://github.com/dmhigdon8/Coursera) (DSA), [Space-Traders](https://github.com/dmhigdon8/Space-Traders) (optional ingestion sandbox)

**Goal order (your tops):**
1. SQL problem-solving  
2. dbt — understand and get real mileage  
3. AI — understand and get real mileage  
4. DSA in Python  
5. Data ingestion  

**Cross-cutting (not a separate vanity track):** systems literacy on the Dell — how the machine actually works (processes, files, memory, networking, containers) so you stop missing implications when tools, AI, or cloud abstractions move. The Dell exists so the **terminal forces direct contact** with that layer. Learn it *in service of* better judgment on this stack and whatever comes next — not Linux for its own sake.

Sports is the domain glue: **F1 first (already working), then MLB, then NFL**, same patterns each time.

---

## Design principle

One warehouse, many sports — not three disconnected toy projects.  
One primary machine (Dell/Linux) for depth — not three half-understood environments.

```text
APIs / files
   → ingest (Python)
   → raw landing (local JSON + S3)
   → Postgres raw schemas
   → dbt staging → intermediate → marts
   → SQL drills + AI-assisted analysis on marts
```

F1 already proves the path (Jolpica → S3 → Postgres → dbt, `dbt build` 34/34). Everything below **extends that spine** instead of replacing it.

Space Traders stays optional: great for API polling / rate limits / game-state facts, but **not** the main SQL/dbt gym. Sports data has richer join/window/grain problems.

---

## How the skills map to work

| Priority | Skill | Where you practice it | “Done looks like” |
|----------|--------|------------------------|-------------------|
| 1 | SQL | `sql/drills/`, ad-hoc on `staging_marts.*`, interview-style prompts on your own tables | You can answer grain, window, and gap questions without guessing |
| 2 | dbt | `dbt_f1/` → later `dbt_sports/` or multi-project | Incremental models, tests that catch real bugs, docs people could trust |
| 3 | AI | Workflow on this repo + small applied experiments | You use AI to accelerate, verify, and document — not to skip understanding |
| 4 | DSA | Coursera Algorithmic Toolbox + LeetCode, 3–5 problems/week | Patterns stick; you can explain Big-O and map patterns to pipeline code |
| 5 | Ingestion | `ingest/` for F1, then MLB/NFL extractors | Idempotent loads, clear raw contracts, incremental / season-partitioned pulls |
| — | Systems (Dell) | Terminal-first on Ubuntu while doing 1–5; short “what just happened under the hood?” notes | You can explain *why* a command/failure/slowdown happened, not only *what* to type next |

---

## Systems literacy — attached to real work (Dell default)

**Why this is here:** GUI-heavy machines hide the stack. That feels fast until something breaks, scales, or an AI suggestion skips a layer you can’t see. The Dell + terminal is the gym for that missing layer — so you reason better about Postgres, Docker, dbt, AWS, and future tools.

**Rule:** every systems concept must earn its place by showing up in *this* pipeline. No “learn systemd because textbooks say so.”

### Habit (5–15 min, when something is already happening)

After a real step (compose up, dbt build, extract, slow query), ask once:

1. **What process owns this?** (`ps`, `docker compose ps`, `systemctl status docker`)  
2. **Where does state live?** (named volume vs bind mount vs S3 vs `raw/` on disk)  
3. **What would fail if the machine rebooted / network dropped / disk filled?**  

Optional: one short note in `STATUS.md` or a drill header — “implication I almost missed.”

### Map systems → pipeline moments (do these when the work creates them)

| When you’re doing… | Look underneath | Judgment you’re training |
|--------------------|-----------------|---------------------------|
| `docker compose up` / Postgres healthy | daemon vs container vs volume; host port **5433** vs container **5432**; `restart: unless-stopped` | Where data survives; what “the DB is up” actually means |
| `psql` / SQL drills / `EXPLAIN ANALYZE` | client → TCP → server process; query plan vs “SQL looks fine” | Cost, indexes, when the machine (not the query text) is the bottleneck |
| `dbt build` | Python env (`pipx`/`PATH`), profiles, schemas (`staging_marts` quirk), materializations as tables/views in Postgres | Abstractions compile to real objects; misconfig is a *machine* story |
| Extract → `raw/` → S3 → load | filesystem paths, credentials, network egress, idempotent writes | Durability and trust boundaries (local disk ≠ bucket ≠ warehouse) |
| Resource weirdness (slow, OOM, full disk) | `df -h`, `free -h`, `docker system df`, which cgroup/container is fat | Capacity thinking before you buy more cloud or add Spark |

### What *not* to do with systems study

- Don’t pause SQL/dbt for a months-long OS curriculum.  
- Don’t dual-boot rabbit holes, kernel compiles, or ricing the desktop.  
- Don’t treat Mac GUI workflows as equivalent practice — use Mac when needed; **prefer Dell terminal for learning sessions.**

**Exit (ongoing):** you can narrate the F1 path in systems language: *process → files/volumes → network → Postgres objects → query cost* — and use that narration when AI or docs feel thin.

---

## Phase 0 — Lock the F1 foundation (short)

You’re basically here already. Finish the operational debt so learning isn’t blocked by machine/secrets churn.

- [ ] Rotate `f1-pipeline` AWS key; stop sharing one key across machines forever  
- [x] Confirm Dell as primary raw-data **and** systems-learning machine  
- [ ] Add `.gitattributes` (`* text=auto`)  
- [ ] One-command bootstrap notes kept truthful for Mac + Dell  
- [ ] On Dell: be able to explain Docker Engine + `pgdata` volume + host port 5433 without notes  

**Exit:** Fresh clone on Dell → extract → load → `dbt build` green without tribal knowledge — and you can say where each layer’s state lives.

---

## Phase 1 — SQL gym on F1 marts (highest leverage next)

Build a `sql/drills/` folder of **problems against your own warehouse**, not only generic LeetCode SQL.

### Drill themes (write the question + a reference answer)

1. **Grain checks** — “One row per driver-race?” Prove with `COUNT(*)` vs `COUNT(DISTINCT …)`.  
2. **Windows** — season points running total; rank within race; gap to leader.  
3. **Gaps / islands** — streak of podium finishes; races since last DNF.  
4. **Slowly changing truth** — constructor changes; who drove for whom when.  
5. **Anti-joins** — drivers who entered a season but have zero sprint results.  
6. **Performance reading** — `EXPLAIN ANALYZE` on a heavy drill; add an index only if earned.

### Cadence

- **3 SQL drills / week** (45–60 min), committed as `sql/drills/001_….sql` with a short header comment: question, assumed grain, answer query.  
- After each dbt model you add, write **one drill that would have failed** if the model grain were wrong.  
- **On Dell:** run drills via `psql` in the terminal (not a GUI client) so client/server and connection strings stay real.

### Stretch

- Recreate 5 classic interview problems (second highest salary style, sessionization, retention) **using race/driver tables** so muscle memory stays in-domain.  
- Pair drill 6 (performance) with `EXPLAIN ANALYZE` + a one-paragraph note: *was the cost in scan, join, sort, or disk?*

**Exit:** 12+ drills in repo; you can explain grain of `fct_race_results` cold.

---

## Phase 2 — Make dbt do real work (not just `SELECT *` staging)

Current shape: staging (`stg_drivers/races/results/sprint_results`) + marts (`dim_*`, `fct_*`). Next skills, in order:

| Step | dbt skill | Concrete F1 task |
|------|-----------|------------------|
| 2a | Sources & freshness | Declare Jolpica-loaded raw tables; freshness warn on stale seasons |
| 2b | Tests that hurt | `unique`, `not_null`, accepted ranges; **relationships** race→driver; custom singular test: points ≥ 0 |
| 2c | Intermediate models | `int_results_with_standings` (windows live here, not in marts) |
| 2d | Incremental | `fct_race_results` incremental on `season` or `race_id` after full refresh baseline |
| 2e | Macros | `finish_position_surrogate`, season filter macro — one macro used in 3+ models |
| 2f | Docs & exposures | `dbt docs generate`; exposure “Driver season dashboard” |
| 2g | Packages | `dbt_utils` (`surrogate_key`, `deduplicate`) — use deliberately, don’t carpet-import |
| 2h | CI | GitHub Action: `dbt parse` + `dbt build` against Docker Postgres on PR |

Also fix/document the schema naming quirk (`staging_marts` vs `marts`) so future-you queries the right place — or set `+schema` cleanly so marts land in `marts`.

**Systems hook (Phase 2):** when you add CI and incremental models, explicitly contrast *local Dell Docker Postgres* vs *ephemeral CI Postgres* — same dbt project, different lifetime of state. That’s the abstraction worth owning.

**Exit:** Incremental path works; CI runs dbt on PR; at least one singular test has caught a bad load in practice (force a bad row once on purpose).

---

## Phase 3 — Grow into multi-sport (ingestion + dbt at once)

Same contracts every time. Do **not** invent a new architecture for baseball.

### Suggested order

1. **F1 deepen** — more Jolpica endpoints you don’t have yet (qualifying, pit stops, lap times if available / licensed). Prefer endpoints that create interesting grains.  
2. **MLB** — start narrow: schedules + game results for one season (e.g. Stats API or a stable open source).  
3. **NFL** — schedules + weekly results; avoid betting odds rabbit holes early.

### Repo layout target (evolve toward)

```text
ingest/
  f1/
  mlb/
  nfl/
raw/                    # or sport-prefixed S3 keys
sql/init/               # raw schemas: raw_f1, raw_mlb, raw_nfl
dbt_sports/             # or keep dbt_f1 and add dbt_mlb — decide in 3a
  models/staging/...
  models/marts/...
sql/drills/
```

**Decision 3a (pick once):**
- **A (recommended):** one dbt project `dbt_sports` with `f1__`, `mlb__`, `nfl__` model prefixes and shared macros  
- **B:** separate dbt projects per sport (simpler isolation, more profile/CI duplication)

### Ingestion checklist per new sport

- [ ] Postman (or httpx scratch) understands auth, pagination, rate limits  
- [ ] Extract writes **immutable raw JSON** (date-partitioned keys on S3)  
- [ ] Load is **idempotent** (you already do this for F1)  
- [ ] One dbt source + two staging models + one fact before expanding  

**Exit:** MLB (or NFL) has extract → raw → staging → one fact, plus 3 SQL drills on that fact.

---

## Phase 4 — AI: get mileage without outsourcing thinking

Treat AI as a **force multiplier with verification gates**, not as the source of truth.

### Weekly AI practice (tied to this repo)

| Use | Do this | Verification gate |
|-----|---------|-------------------|
| Draft dbt models | “Here’s source YAML + 3 raw rows; draft `stg_…`” | You rewrite grain + tests before merge |
| Explain plans | Paste `EXPLAIN ANALYZE` + ask for indexed approach | Re-run explain; keep only measured wins |
| SQL drills | Ask for *alternate* solutions (window vs group) | You can teach both approaches |
| Debugging | Paste dbt error + model + `_schema.yml` | You can state root cause in one sentence |
| Docs | Generate model descriptions | You trim hallucinations; no invented columns |
| Systems check | “Explain what Docker/Postgres did here” | You reject answers you can’t restate with `ps`/`docker`/`df` evidence |

### Small applied AI projects (pick one after Phase 2)

1. **Warehouse Q&A** — RAG over `dbt docs` / schema YAML so you can ask “grain of fct_race_results?”  
2. **Narrative generator** — given a race fact row set, draft a race report; evaluate factual errors  
3. **Anomaly assistant** — flag odd pit/points outliers; you label true/false positives  

Avoid jumping into “predict the championship” ML until SQL/dbt grain is boringly solid — otherwise you’ll debug features that were wrong upstream.

**Exit:** A short `AI_WORKFLOW.md` in this repo listing prompts you reuse + gates you refuse to skip.

---

## Phase 5 — DSA in Python (parallel track, lighter weekly load)

Keep this **separate from the warehouse** so you don’t muddy “pipeline code” with contest patterns — then deliberately reconnect.

### Cadence

- **Coursera Algorithmic Toolbox** — finish modules in order (already started in Coursera repo).  
- **LeetCode** — 3 problems/week, tag by pattern (two pointers, sliding window, hash map, stack, BFS/DFS, heap, binary search).  
- **Bridge note** (5 lines in the LeetCode README): where this pattern appears in data eng (e.g. sliding window → time-series features; heap → top-k lap times; graph BFS → team influence / schedule graphs).

### Sports-flavored applied DSA (optional monthly)

- Parse a season schedule into a graph; shortest path between venues (NFL travel toy).  
- Streaming median of lap times (two heaps).  
- Compress race event sequences (run-length / stack).

**Exit:** Consistent weekly streak; you can explain 8 core patterns without looking them up.

---

## Suggested weekly rhythm (sustainable)

Assuming ~6–8 focused hours/week, **default on the Dell terminal:**

| Block | Time | Focus |
|-------|------|--------|
| Mon/Tue | 1.5h | SQL drill on warehouse (`psql` on Dell) |
| Wed | 1.5h | dbt feature (test, incremental, macro, or CI) |
| Thu | 1h | Ingestion ticket **or** systems hook from the table above (whichever the work surfaces) |
| Fri | 1h | AI-assisted review of the week’s PR + update docs (+ one under-the-hood verification) |
| Weekend | 1–1.5h | DSA (Coursera or LeetCode) |

Protect SQL + dbt as first-class; systems literacy tags along when the pipeline creates the question; ingestion and AI support them; DSA stays a steady parallel.

---

## 90-day milestone sketch (no calendar promises — capability targets)

**By ~30 days of steady work**
- `sql/drills/` has ≥12 F1 problems with answers  
- dbt: intermediate model + stronger tests + docs generated  
- AWS key rotated; Dell workflow boring  
- You can explain Docker volume vs `raw/` vs S3 without looking it up  

**By ~60 days**
- At least one incremental model in production path  
- CI runs `dbt build` on PRs (and you can say how CI’s Postgres differs from Dell’s)  
- Second sport skeleton (MLB recommended): extract + raw + 1 fact  

**By ~90 days**
- Multi-sport mart you can query for “compare competitive balance” style SQL  
- AI workflow doc + one small applied experiment  
- DSA: Algorithmic Toolbox meaningfully advanced; LeetCode pattern coverage documented  
- Comfortable debugging a novel failure by *inspecting the machine* before asking AI  

---

## What not to do (keeps this learnable)

- Don’t stand up Kafka/Spark until Postgres + dbt + SQL drills feel easy.  
- Don’t add baseball *and* NFL in the same week.  
- Don’t let Space Traders or a new repo steal the dbt muscle — optional side quest only.  
- Don’t accept AI-generated models without stating grain + writing a test.  
- Don’t turn the Dell into a second curriculum that crowds out SQL/dbt — systems study is the *lens*, not the main event.  
- Don’t hide from the terminal with GUIs when you’re on a learning block.

---

## Immediate next actions (start here)

1. ~~Create `sql/drills/001_grain_fct_race_results.sql`~~ — done.  
2. ~~Create `sql/drills/002_gap_to_leader.sql`~~ — done.  
3. ~~Add singular dbt test for duplicate driver-race rows~~ — done (`assert_no_duplicate_driver_race`).  
4. **On the Dell:** run drills 001–002 with `psql`, run `dbt test --select assert_no_duplicate_driver_race`, and write one short “under the hood” note (process / state / failure mode).  
5. Add drill `003_…` from Phase 1 themes (windows / gaps / anti-joins).  
6. Schedule next sport only after (4–5) are done cold.

You’re on the **Dell XPS (Ubuntu)**. Prefer that machine for learning sessions; Mac remains the backup.
