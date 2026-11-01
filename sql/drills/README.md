# SQL examples

Warehouse queries against the dbt marts in this project. Each numbered file is one question: grain, windows, anti-joins, streaks, season rank, or a join across facts and dimensions.

Conventions:

- One file per example: `NNN_short_slug.sql`
- Header comment states the question, the grain, and the tables
- Query `marts.*` for facts and dimensions, and `staging.*` for the flattened views
- Files named `attempt` are drafts beside the finished example
