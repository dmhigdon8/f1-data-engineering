# Learning library

Topic map of books Daniel already owns, plus the few worth buying. Built 2026-10-30 from public titles, subtitles, and publisher descriptions. Not a substitute for the books, and not chapter text.

Use this with `LEARNING_PLAN.md` and the skill log in `STATUS.md`. The plan order is SQL screens, then one dbt grain test, then AI craft. A book does not jump that queue.

## Read this first

The shelf is large and almost none of it is the skill that is stuck. There is no SQL practice book. Islands, joins, and `GROUP BY` will not get better by opening linear algebra, Deep Learning, or an LLM handbook.

**This month:** coached islands on the warehouse. Do not start a reading program.

**The one book to buy now:** Anthony DeBarros, *Practical SQL*, 2nd edition (No Starch, 2022). Postgres. Read it only after the next coached islands rep, and only chapters 7 (joins), 9 (grouping), and 13 (subqueries and window functions). Redo each idea against `marts.fct_race_results`, not as a second project.

**When the dbt grain test starts:** read the grain chapters of Joe Reis, *Mixed Model Arts* (already owned). Buy Rui Machado and Hélder Russa, *Analytics Engineering with SQL and dbt* (O'Reilly, 2023). Do not also buy Kimball in the same month.

**Do not buy** another LLM build book, another linear algebra book, or a betting book. Those shelves are already full.

## Owned books, by when they help

### 1. SQL lane — nothing here is the textbook

| Book | What it actually covers | Use |
|------|-------------------------|-----|
| *Think Like a Programmer*, Spraul (2012) | Breaking a problem into pieces before coding. C++ flavored. | The habit, not the syntax. Useful beside a stuck query. Not a SQL book. |
| *Learn to Code by Solving Problems*, Zingaro (2021) | Programming-contest problems as the way to learn to code. | Weekend only, if a screen asks for algorithmic puzzles. |
| *Grokking Algorithms*, 2nd ed., Bhargava (2024) | Illustrated algorithms. The friendly DSA book. | The one DSA book if a loop requires it. Not this month. |
| *Problem Solving with Algorithms and Data Structures Using Python*, 2nd ed., Miller and Ranum | Course textbook: Python plus classic structures. | Heavier than Grokking. Park until DSA is the assigned track. |
| *The Bible of Algorithms and Data Structures*, Dedov (2020) | Short interview crib: Big O, sorts, graphs, trees, hashing. | Thin. Do not prefer it over Grokking. |
| *Data Structures the Fun Way*, Kubica (2022) | Intuition for structures, not interview drills. | Optional later. |
| *The Recursive Book of Recursion*, Sweigart (2022) | Recursion only. | Park. |
| *Critical Thinking, Logic & Problem Solving*, Neuronswaves (2023) | Generic self-published thinking guide, 154 pages. | Skip. *Think Like a Programmer* is the real book on this shelf. |

### 2. When the dbt test starts — modeling he already owns

| Book | What it actually covers | Use |
|------|-------------------------|-----|
| *Mixed Model Arts*, Joe Reis (2026) | Grain, identifiers, time, and modeling across relational, analytics, and AI shapes. Exercises at the end of chapters. Foreword by Bill Inmon. | **Read the grain chapters when the dbt test starts.** This is the owned book that names the thing the warehouse keeps tripping on. |
| *Essential Infrastructure as Code*, Rosemary Wang (2022) | IaC as a practice: environments, modules, testing infra changes. | After dbt CI exists. Not the test itself. |
| *Modern Data Architectures with Python*, Brian Lipp (2023) | Python pipelines, warehouses, and lakes. | Phase 3 ingestion, after SQL and dbt are boring. |
| *Hands-On APIs for AI and Data Science*, Ryan Day (2025) | Building and calling APIs with FastAPI. | When a model has to leave the warehouse. Not the SQL screen. |

He does **not** own a dbt book, Kimball's *Data Warehouse Toolkit*, *Designing Data-Intensive Applications*, or Reis and Housley's *Fundamentals of Data Engineering*.

### 3. Systems — one owned book is enough

| Book | What it actually covers | Use |
|------|-------------------------|-----|
| *The Linux Command Line*, 3rd ed., William Shotts (2026) | Shell, files, pipes, permissions, and shell scripts. The Dell book. | The systems book. Short sessions beside the warehouse, not instead of islands. |
| *Write Great Code, Vol. 1: Understanding the Machine*, Randall Hyde | How a machine represents data and executes instructions. | After Shotts. Deeper than the plan needs this month. |

### 4. AI directing — owned, and later

Read none of these until the dbt grain test exists. They overlap. Pick one build book, not three.

| Book | What it actually covers | Use |
|------|-------------------------|-----|
| *How AI Works*, Ronald T. Kneusel (2023) | Plain-language map of modern AI. Not a build manual. | First AI book, when Phase 4 opens. Short. |
| *Agentic Coding with Claude Code*, Eden Marco (2026) | Everyday agentic coding with Claude Code: tasks, tools, workflows. | Closest owned book to "direct the agent." Read after *How AI Works*, and only alongside the skill log. It is Claude Code, not this repo's teach mode. |
| *Claude Code + Obsidian: The AI Second Brain Playbook*, J. Cook (2026) | A vault, `CLAUDE.md`, hooks, skills, and subagents so a session stops forgetting. | A productized version of the skill-log idea. Mine it for patterns. Do not let it replace `STATUS.md`. |
| *LLM Engineer's Handbook*, Iusztin, Labonne, Vesa (2024) | End-to-end LLM app work: data, RAG, fine-tuning, evaluation, deployment. | The one build book if a later project needs it. |
| *Building LLMs for Production*, Bouchard and Peters (2024) | Prompting, fine-tuning, RAG, tool use. Same neighborhood as the handbook. | Overlaps the handbook. Do not read both. |
| *50 ML Projects to Understand LLMs*, Mike X Cohen (2026) | Fifty experiments on transformer behavior. | Research shelf. After the handbook, and only if the mechanism itself is the question. |
| *Ontology Pipeline*, Jessica Talisman (2026) | Vocabularies, taxonomies, ontologies, knowledge graphs, and why RAG needs governed meaning. | After a real LLM project exists. Not the first AI book. |
| *Deep Learning*, Goodfellow, Bengio, Courville (2016) | The graduate deep-learning textbook. | Park. This is not "get better at directing Cursor." |

### 5. Math and statistics — owned, parked until a number needs them

| Book | What it covers | When |
|------|----------------|------|
| *Modern Statistics: Intuition, Math, Python, R*, Mike X Cohen (2023) | Descriptive stats through tests, regression, power, and bias, with code. | The one stats book when a result needs an explanation beyond SQL. |
| *An Adventure in Statistics*, Andy Field (2022) | Stats as a story. Friendly, not a reference. | If Cohen feels cold. |
| *Active Statistics*, Gelman and Vehtari (2024) | Classroom activities for regression and causal inference. Companion to *Regression and Other Stories*, which is **not** owned. | Low value alone. |
| *Essential Math for Data Science*, Thomas Nield (2022) | The math tour for data science: probability, linear algebra, calculus sketches. | Park. Three deeper books already cover the pieces. |
| *Math for Programming*, Ronald T. Kneusel (2024) | Math a programmer uses. | Park beside Nield. |
| *The Elements of Statistical Learning*, Hastie, Tibshirani, Friedman | The graduate statistical-learning reference. | Park. |
| *The Dark Art of Linear Algebra*, Seth Braver (2023) | Geometric intro to linear algebra. | Park. |
| *Linear Algebra*, Mike X Cohen (2021) | A fuller linear algebra course. | Park. One linear algebra book is enough, later, and Braver is the readable one. |
| *Calculus Unraveled*, Mike X Cohen (2025) | Calculus with Python. | Park. |
| *Mathematica*, David Bessis (2024) | How mathematical intuition is learned. Not Wolfram. | Optional mindset. Not a skill drill. |
| *Statistical Consequences of Fat Tails*, Nassim Taleb (revised ed.) | Where ordinary statistics lies about extremes. | Later judgment. Not a screen. |
| *Keeping Up with the Quants*, Davenport and Kim (2013) | How a manager talks to analysts. | Light. After he can defend a query. |
| *Critical Thinking*, Jonathan Haber (MIT Press, 2020) | Short intro to the phrase "critical thinking." | Skip. |
| *Cut the Knot: Probability Riddles*, Alexander Bogomolny (2020) | Probability puzzles. | Play. Not the plan. |
| *Problem Solving Through Recreational Mathematics*, Averbach and Chein | Puzzles that teach mathematical thinking. | Play. |
| *Gödel, Escher, Bach*, Hofstadter | A long book about formal systems, meaning, and self-reference. | Not this plan. |

### 6. Python craft — supporting, not the path

He can already write the SQL and the dbt models. Do not clear this shelf.

| Book | Role |
|------|------|
| *Dead Simple Python*, Jason McDonald (2020) | Idiomatic Python when a script is the blocker. The one to open. |
| *Python Beyond the Basics*, Al Sweigart (2020) | Next Python book after Dead Simple, if needed. |
| *Object-Oriented Python*, Irv Kalb (2022) | Classes, pygame, GUIs. Owned twice (print path and Kindle `B0957SHYQL`). Skip unless a project needs objects. |
| *Python Illustrated*, van Putten and van Putten (2026) | Beginner Python. Skip. |
| *Invent Your Own Computer Games with Python*, 4th ed., Sweigart | Beginner Python via games. Skip. |
| *The Big Book of Small Python Projects*, Sweigart (2021) | Small practice programs. Skip as a plan. |

### 7. Sports and betting — hobby shelf

The plan keeps betting and a new sport behind SQL and dbt. Owning these is not a reason to open them.

| Book | What it is | When |
|------|------------|------|
| *Football Analytics with Python & R*, Eager and Erickson (2023) | NFL tracking-style analysis in code. | The one sports book when NFL ingestion starts. |
| *Sports Analytics and Data Science*, Thomas Miller (2016) | Survey of sports analytics work. | Background, with the NFL book. |
| *Mathletics*, 2nd ed., Winston, Nestler, Pelechrinis | Math of baseball, basketball, football, plus later chapters on soccer and Bayesian ideas. Owned as print `0691177627` and Kindle `B09KP3ZCVL`. | A night off. Not a skill block. |
| *Get in the Game*, Chartier and Earle (2022) | Sports math for a general reader. | Light. |
| *Bayesian Sports Models in R*, Andrew Mack (2024) | Bayesian models aimed at betting edges in NHL, NBA, NFL, MLB. | Hobby. The plan says not to optimize for beating the book. |
| *Monte Carlo or Bust*, Joseph Buchdahl (2021) | Simulation for sports bettors. | Hobby. |
| *Picking NFL Winners*, Masaru Kanemoto (2018) | Picking games. | Do not use for this plan. |

## Buy list

| When | Book | Why |
|------|------|-----|
| Now, read after the next coached islands rep | *Practical SQL*, 2nd ed., Anthony DeBarros | The missing SQL book. Postgres. Chapters 7, 9, and 13 match joins, grouping, and windows. |
| When the dbt grain test starts | *Analytics Engineering with SQL and dbt*, Rui Machado and Hélder Russa | He has no dbt book. Pair it with the grain chapters of *Mixed Model Arts*, which he already owns. |
| Only if screens keep failing on "what is wrong with this query" | *SQL Antipatterns*, Bill Karwin | Style and structure, which is the grading bar. Not the first buy. |
| Do not buy yet | Kimball, *The Data Warehouse Toolkit*; Kleppmann, *Designing Data-Intensive Applications*; Reis and Housley, *Fundamentals of Data Engineering* | Right books, wrong month. *Mixed Model Arts* covers grain sooner. |
| Do not buy | Another LLM handbook, another math textbook, a Snowflake tome, a betting book | The owned AI and math shelves already cover those. Snowflake dialect notes are smaller than the islands gap. |

## Duplicates on the list

- *Mathletics*, 2nd edition: print `0691177627` and Kindle `B09KP3ZCVL`.
- *Object-Oriented Python*: Kindle `B0957SHYQL` listed twice, same book.
