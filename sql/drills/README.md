# SQL drills

Interview-style / warehouse-native SQL practice against this project's Postgres + dbt marts.

Conventions:
- One file per drill: `NNN_short_slug.sql`
- Header comment: question, assumed grain, tables used
- Prefer querying `staging_marts.*` (see STATUS.md naming quirk) unless schemas are cleaned up
- Commit a working answer; optional `-- alternate:` solutions welcome
- **Learning rule:** attempt the question (or write your own draft in a scratch file) *before* reading the committed answer — then diff. Cold-redo a prior drill weekly without opening the file.

Start from [`LEARNING_PLAN.md`](../../LEARNING_PLAN.md) Phase 1 and “How learning works here.”
