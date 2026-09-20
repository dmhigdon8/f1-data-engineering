# Learning Plan — Sports Data Platform

**Owner:** Daniel Higdon  
**Primary machine:** Dell XPS 14 — Ubuntu 24.04 Developer Edition (`~/f1-data-engineering`)  
**Secondary:** Mac (convenience / travel); same repo, same pipeline  
**Primary repo:** [f1-data-engineering](https://github.com/dmhigdon8/f1-data-engineering) (grow this)  
**Supporting repos:** [LeetCode](https://github.com/dmhigdon8/LeetCode), [Coursera](https://github.com/dmhigdon8/Coursera) (DSA), [Space-Traders](https://github.com/dmhigdon8/Space-Traders) (optional ingestion sandbox)

**Goal order (confirmed stack — do not invert):**
1. **SQL problem-solving** — heaviest near-term investment  
2. **dbt** — real mileage (tests, models, incremental, CI) tied to the same warehouse  
3. **AI infrastructure** — verified AI craft *on top of* trustworthy SQL/dbt (gates, grounded generation, workflows) — not chat theater  
4. **Leverage → X / YouTube** — fact-gated sports analytics content as side-hustle / pivot proof (**last**; Phase 4b only)  
5. DSA in Python — weekend light / interview-driven, never ahead of 1–2  
6. Data ingestion — grows the warehouse when 1–2 are boring; not a distraction from drills  

**Cross-cutting (not a separate vanity track):** systems literacy — how machines actually work (processes, files, memory, networking, containers) so you stop missing implications when tools, AI, or cloud abstractions move. **Practice gym:** Dell terminal (fewer GUIs hiding the stack). **Target skill:** portable Unix / container / data-stack judgment that also holds on **Mac at work** (most employers). Linux-only details only when needed to run the Dell, or when the *idea* clearly carries over.

### Dual purpose (career first, public proof last)

**Primary:** professional skills that generalize — especially **SQL + dbt**, then solid **AI infrastructure** with verification. Your resume spine is airlines / data / tech; sports is the *domain gym* that sharpens the same muscles you’d use on any messy operational data.

**Secondary (sequenced last):** a public swing — X/Twitter and/or YouTube around **advanced sports analytics** — only after the warehouse numbers and AI gates are trustworthy. Motivation from sports/betting is fine; distribution is not allowed to jump the queue ahead of SQL/dbt/AI depth.

**How both stay aligned:** every “content” idea must be downstream of a real mart query you could defend. The interesting end-state sketch:

```text
ingest → warehouse (tested) → analytics artifact (SQL/dbt)
       → LLM draft (facts pinned from query output)
       → human gate → optional post to X / script for YouTube
```

That pipeline teaches the same job-relevant skills as airline/ops analytics (trustworthy numbers → narrative → distribution). It is **not** “LLM invents takes → auto-post.” Auto-posting without a fact gate trains the wrong muscle and can hurt a professional brand.

**Betting / odds:** fine as hobby context and as *event questions* (“was this line moved by injuries?”). Do **not** early-optimize for odds ingestion, tip bots, or “beat the book” products — weak skill ROI, noisy data, platform/ToS/career risk. If odds ever enter, treat them as another source with the same contracts as F1/MLB, after multi-sport marts already work.

Sports is the domain glue: **F1 first (already working), then MLB, then NFL**, same patterns each time.

---

## How learning works here (and what AI can / cannot do)

This is the honest contract — not a pep talk.

### Can an agent actually coach you dynamically?

**Yes, partially — if this section is in context and you hold the line too.**

| I *can* do | I *cannot* reliably do |
|------------|------------------------|
| Encode learning-science habits into this plan and follow them when you (or `STATUS.md`) point here | Guarantee every future chat/model remembers without you pasting / linking this |
| Spot *behavioral* lean-patterns in a thread (“describe outcome → demand exact steps → skip attempt”) and switch to teach/pair mode | Read your mind across sessions, or know you’re leaning if you hide that you’re copy-pasting |
| Force a **proof** (you attempt, you explain grain, you run a check) before dumping a full solution | Make struggle feel pleasant; desirable difficulty *feels* worse short-term (that’s the point) |
| Teach **AI skill** as a first-class craft (prompts, gates, when not to use me) | Replace deliberate practice — watching me code is performance theater, not storage strength |
| Adapt mode (teach / pair / ship) when you name the mode or when triggers fire | Be “dynamic” if you always ask for finished answers and never accept pushback |

**Bottom line:** Writing this into the plan is real leverage. “Dynamic forever by magic” is not. Your job: paste or link this section when starting learning sessions, and say “teach mode” or “I’m leaning — check me” when you notice it. My job: use the triggers below instead of being a polite autocomplete.

### Learning science we actually use (not vibes)

Drawn from robust findings (Ericsson deliberate practice; Bjork desirable difficulties / spacing / retrieval; generation effect; learning ≠ short-term fluency):

1. **Retrieval > re-reading** — cold explain grain / rewrite a drill from memory before opening the answer file.  
2. **Desirable difficulty** — effortful but solvable; if you can’t start, we scaffold one notch — we don’t hand the whole staircase.  
3. **Generation first** — you produce an attempt (even wrong) before AI’s solution; generation strengthens memory more than recognizing a right answer.  
4. **Spacing & interleaving** — revisit old drills days later; mix grain / window / anti-join rather than binge one pattern.  
5. **Feedback on the attempt** — compare your query to a reference; diagnose *why* it failed (strategy), not only fix the typo.  
6. **Learning vs performance** — feeling fluent after I explain something is cheap; delayed cold recall is the real test.  
7. **Deliberate practice** — specific goal, full attention, immediate feedback, slightly beyond current skill — not passive “exposure” to the repo.

### AI skills to build (goal #3 made concrete)

| Level | Skill | Looks like |
|-------|--------|------------|
| A | **Task framing** | You state goal, constraints, grain, and what “done” means before asking for code |
| B | **Context packing** | You paste error + relevant file + 3 sample rows — not “fix my dbt” |
| C | **Verification gates** | You refuse to merge/run anything you can’t restate; you demand a proof plan |
| D | **Mode control** | You choose teach / pair / ship; you accept pushback in teach/pair |
| E | **Anti-capture** | You notice when AI is doing the thinking; you stop and retrieve, or ask for a Socratic path |
| F | **Transfer** | You use the same gates at work on Mac without this repo’s babysitting |

### Modes (say which — or I infer from triggers)

| Mode | When | What I do | What you do |
|------|------|-----------|-------------|
| **Teach** | New concept, first time on a pattern | Questions, hints, partial scaffolds; withhold full answer until you’ve attempted | Struggle productively; write the attempt |
| **Pair** | You have a sketch / stuck mid-way | Alternate: you try → I critique → you revise; we build the proof together | Stay in the driver’s seat for the next edit |
| **Ship** | Ops chore, known pattern, time-box | Direct implementation with brief “why” | Still skim and can explain the change |

Default for learning blocks: **teach → pair**. **Ship** only when you explicitly want speed or the task is pure plumbing.

### Lean-too-hard triggers → what I should say

If you do something like:

- “I know what I want vaguely — just give me the exact steps/commands”  
- “Write the whole model/drill; I’ll learn by reading it”  
- Paste nothing / try nothing, ask for the finished artifact  
- Ask for the same explanation twice without attempting in between  
- Want auto-tweet / auto-pipeline before you can defend the numbers  

…I should **not** silently comply. Preferred pushback shape:

> “Easy description, missing attempt. Teach/pair mode: you draft the first version (or the proof query). I’ll critique and we’ll tighten until it runs. If you truly need ship mode for time, say so — but that won’t build the skill.”

Then we agree a **proof**: e.g. you write SQL that fails closed; or you explain grain in one sentence and predict row counts before running.

### How this stays “dynamic” week to week

- **In-session:** triggers + modes above.  
- **Across sessions:** `STATUS.md` notes “lean events” or “cold checks passed” so the next chat continues the arc.  
- **In drills:** answer files exist for feedback *after* attempt — not as the first open.  
- **Weekly:** one **cold retrieval** (no AI, no answer file): explain `fct_race_results` grain or rewrite last week’s drill header + approach from memory.

If this section and `STATUS.md` aren’t loaded, assume the contract is dormant — wake it by linking here.

---

## Holes in this approach (and how we tighten)

Honest critique of the plan you’re standing on — including ways *I* can fail you as a partner.

### Real holes

| Hole | Why it bites | Tighten |
|------|----------------|---------|
| **Planning > practicing** | You’ve already refined a strong map. More roadmap feels like progress; it isn’t storage strength. | Freeze plan edits unless a hole blocks next week’s work. Default next message = Dell proof, not another philosophy pass. |
| **Too many parallel tops** | SQL + dbt + AI + DSA + ingestion + systems + content = shallow on all. | **Near-term lane:** heavy **SQL + dbt** only (+ cold checks). AI infra next; X/YouTube last. DSA/ingest only if 1–2 are green. |
| **Assumed transfer to airline work** | Sports gym ≠ automatic on-the-job judgment unless you force the bridge. | Once/week: 5-line “work transfer” note — *where would this grain/test/window show up in ops/airline data?* |
| **Committed drills ≠ skill** | Files in git can be AI-authored or copy-run once. | Score **cold** recall (pass/fail) in `STATUS.md`. A drill “counts” only after a delayed redo without the answer file. |
| **Resume translation gap** | Hiring managers may see “F1 hobby” not “warehouse craft.” | Practice saying the project in **employer language**: sources, tests, incremental, CI, grain, idempotent loads — sports is the dataset, not the identity. |
| **Side-hustle gravity** | Betting love + X dopamine can yank you to NFL/odds/content before Phase 1 depth. | Content and odds stay gated behind Phase 4b rules. If excitement spikes, channel it into a sharper *SQL question*, not a new ingest. |
| **DSA may be the wrong near-term parallel** | DE/analytics roles often weight SQL/dbt/product sense over LeetCode; contest grind can steal hours from the warehouse. | Keep DSA as **weekend light** unless a specific interview loop demands it. Don’t let Coursera outrank drills. |
| **Partner continuity** | Agents forget; you start fresh chats. | Session open/close ritual below. No ritual → no training partner, just a chatbot. |

### What “good enough” looks like near-term (tighten the 90-day fog)

**Stack reminder:** SQL + dbt → AI infrastructure → X/YouTube. Do not invert.

For the next **2–4 weeks**, success is only:

1. Drills 001–002 run on Dell + singular test green  
2. ≥3 new drills **you** authored (attempt → answer), including one cold-redone later  
3. One meaningful dbt hardening (extra test or grain documentation)  
4. Weekly cold check logged in `STATUS.md`  
5. Zero AI infra builds beyond using teach/pair gates; **zero** X/YouTube / odds pipelines  

After that lane is boring: Phase 2 dbt depth → Phase 4 AI infrastructure → Phase 4b content leverage.

---

## Training partner protocol (near-term + long-term)

You asked for a partner, not a vending machine. Here’s the working agreement.

### Near-term (Phase 1 lane — weeks ahead)

| Cadence | What we do |
|---------|------------|
| **Session open** | You say: machine (Dell), mode (teach/pair/ship), and the **one** proof for this block. Link or mention “How learning works here.” |
| **During** | I default teach→pair. I call lean-triggers. We end with something *you* can re-run without me. |
| **Session close** | You (or I, if you ask ship-for-docs) update `STATUS.md`: what ran, cold check pass/fail, one under-the-hood or work-transfer line, next proof. |
| **Weekly review** (15 min) | Three questions only: (1) What can I explain cold? (2) Where did I lean on AI? (3) What’s the single next drill/dbt proof? |

**Near-term partner job:** keep you in the SQL/dbt gym, block scope creep, force retrieval.

### Long-term (after Phase 1 is boring)

| Horizon | Partner focus |
|---------|----------------|
| Phase 2 | dbt depth with proofs (tests that hurt, incremental, CI) — still generation-first |
| Phase 3 | Second sport **narrow** — one fact, three drills; kill architecture tourism |
| Phase 4 / 4b | AI craft + optional public artifact — fact gates before audience |
| Career | Mock “explain this PR to a hiring manager”; map sports work → airline/ops stories |
| Pivot evidence | Portfolio = warehouse you can defend live, not follower counts |

**Long-term partner job:** raise the bar on explanation quality, transfer, and public/professional brand safety — not cheerleading every new idea.

### How to summon this

Paste into a new chat:

> Dell · teach mode · training partner · next proof: [e.g. run 001–002 / author 003] · hold me to LEARNING_PLAN “How learning works here” + near-term lane.

If you don’t say that, I may still help — but I won’t assume coach mode.

---

## Design principle

One warehouse, many sports — not three disconnected toy projects.  
Dell for **depth of contact** with the stack; Mac stays fluent so work environments don’t feel foreign. Same mental model on both.

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
| 3 | AI infrastructure | Gates, grounded generation, `AI_WORKFLOW.md`, warehouse-tied tooling — **after** 1–2 | You steer AI; outputs are pinned to query results; lean-triggers respected |
| 4 | X / YouTube leverage | Phase 4b only — artifact → fact-gated draft → optional post | Public proof without outsourcing truth; never ahead of 1–3 |
| 5 | DSA | Coursera + LeetCode, light weekly | Patterns stick; doesn’t steal SQL/dbt hours |
| 6 | Ingestion | `ingest/` for F1, then MLB/NFL when 1–2 are boring | Idempotent loads, clear raw contracts |
| — | Systems (portable) | Terminal-first on Dell while doing 1–2 | Portable Unix/container judgment (Mac @ work too) |
| — | Learning hygiene | Retrieval, spacing, generation-first, cold checks | Delayed recall works; fluency-after-AI doesn’t fool you |

---

## Systems literacy — portable first, Dell as the gym

**Why this is here:** GUI-heavy workflows hide the stack. That feels fast until something breaks, scales, or an AI suggestion skips a layer you can’t see. The Dell + terminal is the **practice surface** (direct contact). The skill you keep is **portable** — same reasoning on a work Mac, a cloud VM, or CI.

**Rule:** every systems concept must earn its place by (a) showing up in *this* pipeline, and (b) **carrying to Mac/work** unless it’s a narrow Dell ops detail.

### Portable vs Linux-only (keep the ratio honest)

| Prefer learning (carries to Mac @ work) | Dell/Linux-only (ok when needed, don’t make it the goal) |
|----------------------------------------|----------------------------------------------------------|
| Shell, pipes, env/`PATH`, exit codes | `apt` package names, Ubuntu release quirks |
| Processes & ports (`ps`, who listens where) | Deep `systemd` unit authoring |
| Files, permissions, disk full (`df`, paths) | Desktop/ricing, kernel compiles |
| Docker concepts: image / container / volume / publish port | Docker Engine vs Docker Desktop *install* differences (know they exist; same compose mental model) |
| Client → server (e.g. `psql` → Postgres), connection strings | `usermod`/`newgrp` docker-group one-offs |
| What state survives reboot (volumes, S3, git) | Distro-specific service names beyond “how do I start Docker here?” |

When a Dell fix is Linux-specific, ask: **“What’s the Mac/work analogue of this idea?”** (e.g. `systemctl status docker` → “is the Docker daemon running?” — Desktop whale vs Engine service.)

### Habit (5–15 min, when something is already happening)

After a real step (compose up, dbt build, extract, slow query), ask once:

1. **What process owns this?** (`ps`, `docker compose ps`; on Dell also `systemctl status docker` if the daemon is the question)  
2. **Where does state live?** (named volume vs bind mount vs S3 vs `raw/` on disk)  
3. **What would fail if the machine rebooted / network dropped / disk filled?**  
4. **Would this explanation still work on a Mac at work?** If not, restate it in portable terms.

Optional: one short note in `STATUS.md` or a drill header — “implication I almost missed” / “Mac analogue: …”.

### Map systems → pipeline moments (do these when the work creates them)

| When you’re doing… | Look underneath (portable core) | Judgment you’re training |
|--------------------|---------------------------------|---------------------------|
| `docker compose up` / Postgres healthy | daemon vs container vs volume; host port **5433** vs container **5432**; restart policy | Where data survives; what “the DB is up” actually means (same on Mac Desktop or Linux Engine) |
| `psql` / SQL drills / `EXPLAIN ANALYZE` | client → TCP → server process; query plan vs “SQL looks fine” | Cost, indexes, when the machine (not the query text) is the bottleneck |
| `dbt build` | Python env (`pipx`/`PATH`), profiles, schemas (`staging_marts` quirk), materializations as tables/views | Abstractions compile to real objects; misconfig is a *machine* story on any OS |
| Extract → `raw/` → S3 → load | filesystem paths, credentials, network egress, idempotent writes | Durability and trust boundaries (local disk ≠ bucket ≠ warehouse) |
| Resource weirdness (slow, OOM, full disk) | `df -h`, memory pressure, `docker system df` | Capacity thinking before you buy more cloud or add Spark |

### What *not* to do with systems study

- Don’t pause SQL/dbt for a months-long OS curriculum.  
- Don’t dual-boot rabbit holes, kernel compiles, or ricing the desktop.  
- Don’t optimize for **Ubuntu trivia** that won’t help on a work Mac.  
- Don’t treat Mac GUI workflows as equivalent *practice* — use Mac when needed; **prefer Dell terminal for learning sessions** so you still get the direct contact.

**Exit (ongoing):** you can narrate the F1 path in portable systems language: *process → files/volumes → network → Postgres objects → query cost* — and reuse that narration on Mac at work when AI or docs feel thin.

---

## Phase 0 — Lock the F1 foundation (short)

You’re basically here already. Finish the operational debt so learning isn’t blocked by machine/secrets churn.

- [ ] Rotate `f1-pipeline` AWS key; stop sharing one key across machines forever  
- [x] Confirm Dell as primary raw-data **and** systems-practice machine (portable skills; Mac at work stays in scope)  
- [ ] Add `.gitattributes` (`* text=auto`)  
- [ ] One-command bootstrap notes kept truthful for Mac + Dell  
- [ ] Explain Docker + `pgdata` volume + host port 5433 in **portable** terms (daemon running? where does data live? which port on the host?) — works on Mac or Dell 

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
3. **NFL** — schedules + weekly results; **defer betting odds** until marts + a publishable analytics loop exist (see Dual purpose).

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
Skills A–F and teach/pair/ship modes live in **How learning works here** — this phase is where you practice them on purpose.

### Weekly AI practice (tied to this repo)

| Use | Do this | Verification gate |
|-----|---------|-------------------|
| Draft dbt models | “Here’s source YAML + 3 raw rows; draft `stg_…`” — **after** you state grain | You rewrite grain + tests before merge |
| Explain plans | Paste `EXPLAIN ANALYZE` + ask for indexed approach | Re-run explain; keep only measured wins |
| SQL drills | Attempt first; then ask for *alternate* solutions (window vs group) | You can teach both approaches cold later |
| Debugging | Paste dbt error + model + `_schema.yml`; your one-sentence hypothesis first | You can state root cause without the model rewriting itself |
| Docs | Generate model descriptions | You trim hallucinations; no invented columns |
| Systems check | “Explain what Docker/Postgres did here” | You reject answers you can’t restate with `ps`/`docker`/`df` evidence |
| Anti-capture drill | Once/week: ask AI for help, then close the chat and redo from memory | Cold redo works within ~10 minutes |

### Small applied AI projects (pick after Phase 2; order matters)

1. **Warehouse Q&A** — RAG over `dbt docs` / schema YAML so you can ask “grain of fct_race_results?”  
2. **Narrative generator (career + content bridge)** — given a **pinned** race/season fact row set from SQL, draft a short analysis post or voice-over outline; you score factual errors before anything public  
3. **Anomaly assistant** — flag odd pit/points outliers; you label true/false positives  

### Phase 4b — Publishable loop (optional side-hustle swing; after 4.2 works cold)

Only once you can produce a narrative that survives your own fact-check:

| Step | What | Career skill it proves |
|------|------|------------------------|
| 4b.1 | Recurring “artifact”: one SQL view or dbt exposure that answers a sharp sports question weekly | Productizing analytics, not one-off notebooks |
| 4b.2 | Script: pull artifact → LLM draft with **numbers injected as data**, not remembered | Grounded generation / anti-hallucination pattern (same idea as ops reporting) |
| 4b.3 | Human gate checklist (grain, sample rows, “would I bet my name on this number?”) | Stakeholder trust; brand safety |
| 4b.4 | Optional: post to X via API **after** gate passes; later: YouTube from the same artifact | Distribution automation — last mile, not the foundation |

**Reasonable?** Yes — as a late applied AI + ingestion story. **Consistent with core goals?** Yes — if X/YouTube never outranks SQL/dbt depth. Skipping to “ingest → LLM → tweet” first would optimize for content theater and under-train the skills that make a pivot credible.

Avoid jumping into “predict the championship” ML or tip-generation until SQL/dbt grain is boringly solid — otherwise you’ll debug features (and public takes) that were wrong upstream.

**Exit:** A short `AI_WORKFLOW.md` in this repo listing prompts you reuse + gates you refuse to skip. If 4b is active: one example weekly artifact + draft that you actually fact-checked (posted or not).

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
| Mon/Tue | 1.5h | SQL drill on warehouse (`psql` on Dell) — **attempt before opening answer** |
| Wed | 1.5h | dbt feature (test, incremental, macro, or CI) — teach/pair default |
| Thu | 1h | Ingestion ticket **or** systems hook (whichever the work surfaces) |
| Fri | 1h | AI-assisted review + **one anti-capture / cold retrieval** (no answer file) |
| Weekend | 1–1.5h | DSA (Coursera or LeetCode) — interleaved patterns when possible |

Protect SQL + dbt as first-class **in the near-term lane**; systems / AI craft / DSA only ride along if the primary lane is green that week. After Phase 1 is boring, reopen the fuller rhythm.

---

## 90-day milestone sketch (no calendar promises — capability targets)

**By ~30 days of steady work**
- `sql/drills/` has ≥12 F1 problems with answers  
- dbt: intermediate model + stronger tests + docs generated  
- AWS key rotated; Dell workflow boring  
- You can explain Docker volume vs `raw/` vs S3 without looking it up  
- At least 3 **cold retrievals** logged (grain or prior drill approach without AI)  

**By ~60 days**
- At least one incremental model in production path  
- CI runs `dbt build` on PRs (and you can say how CI’s Postgres differs from Dell’s)  
- Second sport skeleton (MLB recommended): extract + raw + 1 fact  
- You can name teach vs pair vs ship and have used lean-trigger pushback at least once on purpose  

**By ~90 days**
- Multi-sport mart you can query for “compare competitive balance” style SQL  
- `AI_WORKFLOW.md` + one small applied experiment (narrative-from-SQL preferred over tip bots)  
- DSA: Algorithmic Toolbox meaningfully advanced; LeetCode pattern coverage documented  
- Comfortable debugging a novel failure by *inspecting the machine* before asking AI  
- Optional: first **fact-gated** draft post from a warehouse artifact (public or private) — Phase 4b.1–4b.3, posting API still optional  
- AI skill: you catch yourself leaning and ask for proof-mode without being reminded every time  

---

## What not to do (keeps this learnable)

- Don’t stand up Kafka/Spark until Postgres + dbt + SQL drills feel easy.  
- Don’t add baseball *and* NFL in the same week.  
- Don’t let Space Traders or a new repo steal the dbt muscle — optional side quest only.  
- Don’t accept AI-generated models without stating grain + writing a test.  
- Don’t turn the Dell into a second curriculum that crowds out SQL/dbt — systems study is the *lens*, not the main event.  
- Don’t optimize for Linux-only trivia that won’t transfer to a work Mac.  
- Don’t hide from the terminal with GUIs when you’re on a learning block.  
- Don’t build “ingest → LLM → auto-tweet” before drills + tests make the numbers trustworthy.  
- Don’t let betting-tip / odds products hijack the roadmap — analytics credibility first; hobby betting stays personal.  
- Don’t prioritize audience metrics over skill depth; the pivot story is *the warehouse you can explain*, not follower count.  
- Don’t treat “AI explained it and I nodded” as learning — require retrieval or a proof.  
- Don’t punish agents for teach-mode pushback; if you want ship mode, say so explicitly.

---

## Immediate next actions (start here)

1. ~~Create `sql/drills/001_grain_fct_race_results.sql`~~ — done.  
2. ~~Create `sql/drills/002_gap_to_leader.sql`~~ — done.  
3. ~~Add singular dbt test for duplicate driver-race rows~~ — done (`assert_no_duplicate_driver_race`).  
4. **On the Dell:** run drills 001–002 with `psql`, run `dbt test --select assert_no_duplicate_driver_race`, and write one short “under the hood” note (process / state / failure mode).  
5. Add drill `003_…` from Phase 1 themes (windows / gaps / anti-joins) — **your attempt first**, then compare.  
6. When starting learning chats: link **How learning works here** (or say “teach mode”) so the lean-triggers are active.  
7. Schedule next sport only after (4–5) are done cold.

You’re on the **Dell XPS (Ubuntu)**. Prefer that machine for learning sessions; Mac remains the backup.
