# Phone quiz log

Author practice notes. The project and stack are in [README.md](../../README.md).

The bot appends one block per answer. A `pass` here does not change the skill log in `STATUS.md`. The Dell session decides that.

## 2026-11-01 dead-group-by
- question_id: dead-group-by
- rep: no
- verdict: pass
- answer: "Nothing"
- reason: "Group by collapses the rows for aggregation, but the rows are already at a collapsed grain"
- gap: "none"
- correction: "none"
## 2026-11-02 dead-group-by
- question_id: dead-group-by
- rep: no
- verdict: pass
- answer: "Nothing"
- reason: "it's already at the grain you're grouping by"
- gap: "none"
- correction: "none"
## 2026-11-03 leader-max-needs-over
- question_id: leader-max-needs-over
- rep: no
- verdict: pass
- answer: "It just sees that driver_id sum points"
- reason: "the max is for only one number, the sum of points but grouped by that driver. You need the over () so that the window it's calculating the max from is all the drivers"
- gap: "none"
- correction: "none"
## 2026-11-04 rank-takes-no-argument
- question_id: rank-takes-no-argument
- rep: no
- verdict: pass
- answer: "The call should be rank() over (order by sum(points) desc)"
- reason: "rank() with the ordering inside over"
- gap: "none"
- correction: "none"
## 2026-11-04 island-filter
- question_id: island-filter
- rep: no
- verdict: pass
- answer: "The first and last round will both show the round the streak started"
- reason: "in the where you've filtered for only that row"
- gap: "none"
- correction: "none"
## 2026-11-05 missing-column
- question_id: missing-column
- rep: no
- verdict: pass
- answer: "No"
- reason: "you're not providing what was asked for in the results (qualifying_position)"
- gap: "none"
- correction: "none"
## 2026-11-06 push-names-the-branch
- question_id: push-names-the-branch
- rep: no
- verdict: miss
- answer: "Nowhere, it's on the working branch"
- reason: "git push origin main moves this to origin/main (production)"
- gap: "thought the push sent the current branch's commit; it sends laptop main"
- correction: "The push names the branch it updates. The commit was on working, so only a push of working publishes it."
## 2026-11-07 push-names-the-branch
- question_id: push-names-the-branch
- rep: yes
- verdict: pass
- answer: "Nowhere"
- reason: "you pushed the main branch on your local"
- gap: "none"
- correction: "none"
## 2026-11-08 open-pr-follows-the-branch
- question_id: open-pr-follows-the-branch
- rep: no
- verdict: pass
- answer: "Nothing happens to main until the pull request is merged"
- reason: "The pull request from working is updated with the new commit changes"
- gap: "none"
- correction: "none"
## 2026-11-10 branch-is-not-a-folder
- question_id: branch-is-not-a-folder
- rep: no
- verdict: pass
- answer: "No, a new directory doesn't appear"
- reason: "same directory but the files are repointed to the versions with the label working2"
- gap: "none"
- correction: "none"
## 2026-11-10 origin-is-the-github-remote
- question_id: origin-is-the-github-remote
- rep: no
- verdict: repaired
- answer: "GitHub is origin, local machine is remote"
- reason: "Origin is the source, local copy is what changes"
- gap: "called the laptop the remote"
- correction: "none"
## 2026-11-10 pull-main-merges-into-working
- question_id: pull-main-merges-into-working
- rep: no
- verdict: pass
- answer: "GitHub main does not change"
- reason: "dimensions.py updates from origin main; features.py stays his local working version"
- gap: "none"
- correction: "none"
## 2026-11-10 worktree-is-a-second-folder
- question_id: worktree-is-a-second-folder
- rep: no
- verdict: repaired
- answer: "It is a branch of working, with its own file directory"
- reason: "No, it has its own label, feature"
- gap: "called feature a branch of working"
- correction: "none"
## 2026-11-10 worktree-keeps-uncommitted-work
- question_id: worktree-keeps-uncommitted-work
- rep: no
- verdict: pass
- answer: "In one folder commit or stash before switch"
- reason: "A worktree is its own folder so you don't have to"
- gap: "none"
- correction: "none"
## 2026-11-10 feature-reaches-main-without-working
- question_id: feature-reaches-main-without-working
- rep: no
- verdict: repaired
- answer: "No working stop; git push origin main from f1-feature"
- reason: "has to be origin feature, then PR to main"
- gap: "named push origin main from the feature folder"
- correction: "none"
## 2026-11-11 accept-merges-the-worktree-branch
- question_id: accept-merges-the-worktree-branch
- rep: no
- verdict: repaired
- answer: "git merge agent-check working"
- reason: "Copying by hand skips the commit; it stays on agent-check"
- gap: "unsure what a hand copy skips"
- correction: "none"
## 2026-11-11 checkout-is-the-branch-this-folder-shows
- question_id: checkout-is-the-branch-this-folder-shows
- rep: no
- verdict: miss
- answer: "Working has the commit"
- reason: "checked out means files from when the branch was created"
- gap: "checked out is the branch the folder is showing now, not the create-time snapshot"
- correction: "Checked out is the branch this folder is showing. A commit in the folder lands on that branch on the laptop."
## 2026-11-12 checkout-is-the-branch-this-folder-shows
- question_id: checkout-is-the-branch-this-folder-shows
- rep: yes
- verdict: pass
- answer: "Working has the commit"
- reason: "checked out means the directory's files match the current branch"
- gap: "none"
- correction: "none"
## 2026-11-12 branch-is-a-label-on-a-commit
- question_id: branch-is-a-label-on-a-commit
- rep: no
- verdict: pass
- answer: "Working points at the new commit"
- reason: "feature doesn't change"
- gap: "none"
- correction: "none"
## 2026-11-13 commit-records-what-was-staged
- question_id: commit-records-what-was-staged
- rep: no
- verdict: pass
- answer: "That commit records nothing"
- reason: "git add -A stages all untracked; git add STATUS.md only that file"
- gap: "none"
- correction: "none"
## 2026-11-14 pull-follows-the-checked-out-branch
- question_id: pull-follows-the-checked-out-branch
- rep: no
- verdict: pass
- answer: "It looks at working"
- reason: "that's what's checked out; it does not switch to main"
- gap: "none"
- correction: "none"
## 2026-11-16 fetch-updates-the-remote-bookmark
- question_id: fetch-updates-the-remote-bookmark
- rep: no
- verdict: miss
- answer: "files show proposed pull changes but aren't changed; origin/working is latest pushed"
- reason: "diff is remote versus local; did not know if origin/working survives offline"
- gap: "origin/working treated as GitHub itself, not a laptop bookmark from the last fetch"
- correction: "Fetch downloads new commits and moves the laptop's origin/* bookmarks. The folder keeps showing the branch that is checked out."
## 2026-11-16 fetch-updates-the-remote-bookmark
- question_id: fetch-updates-the-remote-bookmark
- rep: yes
- verdict: pass
- answer: "files don't change; bookmarks update to latest from origin/working"
- reason: "not a live GitHub connection; it's a snapshot"
- gap: "none"
- correction: "none"
## 2026-11-16 pull-brings-commits-not-untouched-files
- question_id: pull-brings-commits-not-untouched-files
- rep: no
- verdict: miss
- answer: "pull brings latest origin files; conflict means pick a version"
- reason: "same-line differences need a declared version; repair guessed only unedited origin files"
- gap: "pull framed as a file-by-file copy of untouched origin files, not commits for the branch"
- correction: "A pull brings commits for the checked-out branch. Same lines, and Git refuses instead of overwriting."
## 2026-11-16 pull-brings-commits-not-untouched-files
- question_id: pull-brings-commits-not-untouched-files
- rep: yes
- verdict: pass
- answer: "pull downloads latest commits of the branch on origin and merges; same lines and Git stops"
- reason: "a commit is a snapshot; uncommitted changes sit on top of the local commit"
- gap: "none"
- correction: "none"
## 2026-11-16 fetch-vs-pull
- question_id: fetch-vs-pull
- rep: no
- verdict: repaired
- answer: "fetch updates local snapshot of origin; pull merges origin commits into local; origin/* bookmarks update"
- reason: "fetch is a snapshot not live; pull updates files to latest commits; repair: fetch alone does not rewrite folder files"
- gap: "first answer omitted that fetch leaves folder files alone"
- correction: "none"
## 2026-11-16 checkout-vs-pull
- question_id: checkout-vs-pull
- rep: no
- verdict: pass
- answer: "pull on working fetches/merges origin/working; checkout main switches to local main"
- reason: "checkout retargets which local versions the folder shows, not GitHub; pull updates that branch from origin's latest commits"
- gap: "none"
- correction: "none"
## 2026-11-17 singular-test-select-is-the-failure-report
- question_id: singular-test-select-is-the-failure-report
- rep: no
- verdict: repaired
- answer: "prints result_key and points; hash not readable; season, round, driver name where it failed"
- reason: "a row coming back decides fail; select list is the failure report"
- gap: "first answer omitted that pass/fail is whether any row comes back"
- correction: "none"
## 2026-11-17 yaml-indent-is-the-tree
- question_id: yaml-indent-is-the-tree
- rep: no
- verdict: repaired
- answer: "freshness belongs to columns from indent; same indent as loaded_at_field makes it a table property"
- reason: "indent is the tree; same level as loaded_at_field is a sibling on the table"
- gap: "first answer did not say same indent as loaded_at_field"
- correction: "none"
## 2026-11-17 push-names-the-branch
- question_id: push-names-the-branch
- rep: no
- verdict: pass
- answer: "Nowhere"
- reason: "commit is on local working; push origin main sends laptop main, not working"
- gap: "none"
- correction: "none"
## 2026-11-17 singular-test-returns-bad-rows
- question_id: singular-test-returns-bad-rows
- rep: no
- verdict: pass
- answer: "test does not fail; it's testing duplicates not negatives; should return points < 0"
- reason: ">= 1 would include the -1 row but still tests group counts, not negatives; he overrode the miss — concept held, detail bar was too picky"
- gap: "none"
- correction: "none"
## 2026-11-18 origin-is-the-github-remote
- question_id: origin-is-the-github-remote
- rep: no
- verdict: pass
- answer: "Origin is the remote (GitHub); laptop is local. Pull brings origin working commits and merges with local."
- reason: "origin is GitHub; git pull origin working updates laptop working from GitHub working"
- gap: "none"
- correction: "none"
## 2026-11-18 merge-joins-with-two-parents
- question_id: merge-joins-with-two-parents
- rep: no
- verdict: miss
- answer: "combine origin/main with local working; then I don't know on parents / GitHub main"
- reason: "on working so the merge lands on working; could not say two parents or that GitHub main stays put"
- gap: "missed two-parent join and that GitHub main does not move"
- correction: "A merge commit joins two lines and sits on the branch that was checked out. git merge origin/main while on working updates working. GitHub main moves when the pull request is merged."
## 2026-11-18 dead-group-by
- question_id: dead-group-by
- rep: no
- verdict: pass
- answer: "Nothing"
- reason: "grain is already at the group-by level so no change to results"
- gap: "none"
- correction: "none"
## 2026-11-18 checkout-does-not-fetch
- question_id: checkout-does-not-fetch
- rep: no
- verdict: pass
- answer: "Your local main, not origin main"
- reason: "checkout changes which files you see; it does not pull new commits"
- gap: "none"
- correction: "none"
## 2026-11-18 merge-joins-with-two-parents
- question_id: merge-joins-with-two-parents
- rep: yes
- verdict: pass
- answer: "GitHub main doesn't move; merge combines local working with origin/main commits; two parents: previous working commit and origin/main"
- reason: "two parents join the working line and origin/main; GitHub main stays put"
- gap: "none"
- correction: "none"
## 2026-11-18 fetch-vs-pull
- question_id: fetch-vs-pull
- rep: no
- verdict: repaired
- answer: "fetch updates local bookmarks for working; pull merges origin/working into local working"
- reason: "fetch updates bookmarks of changes; pull brings new file state and merges on top of local; after fetch alone files do not rewrite"
- gap: "first answer did not say fetch leaves folder files alone"
- correction: "none"
## 2026-11-19 leader-max-needs-over
- question_id: leader-max-needs-over
- rep: no
- verdict: repaired
- answer: "max at driver grain equals sum so gap is 0; need max of whole result; over attaches to max"
- reason: "without over, max only sees that driver; sum stays at driver grain, max needs the whole window"
- gap: "first answer put over on the sum: max(sum(points) over ())"
- correction: "none"
## 2026-11-19 pull-brings-commits-not-untouched-files
- question_id: pull-brings-commits-not-untouched-files
- rep: no
- verdict: pass
- answer: "pull brings latest origin commit for the checked-out branch; same-line edits and Git stops"
- reason: "commits for the branch you have checked out; Git will not pick a version for you on the same lines"
- gap: "none"
- correction: "none"
## 2026-11-19 singular-test-select-is-the-failure-report
- question_id: singular-test-select-is-the-failure-report
- rep: no
- verdict: pass
- answer: "prints result_key and -1; season/round/driver are human-readable; result_key is a hash"
- reason: "season round driver name where to look; he overrode repaired — card asked the printout, not what decides fail"
- gap: "none"
- correction: "none"
## 2026-11-20 fetch-updates-the-remote-bookmark
- question_id: fetch-updates-the-remote-bookmark
- rep: no
- verdict: pass
- answer: "bookmarks update to latest on origin; files unchanged"
- reason: "fetch moves bookmarks; folder files stay put"
- gap: "none"
- correction: "none"
## 2026-11-20 yaml-indent-is-the-tree
- question_id: yaml-indent-is-the-tree
- rep: no
- verdict: miss
- answer: "property of columns because nested under it"
- reason: "table property = indented more than the table name"
- gap: "more-than-table-name also fits under columns; need same indent as loaded_at_field"
- correction: "Further indent belongs to the key above. Same indent is a sibling. freshness beside loaded_at_field is a table property."
## 2026-11-20 rank-takes-no-argument
- question_id: rank-takes-no-argument
- rep: no
- verdict: pass
- answer: "rank() over (order by sum(points) desc)"
- reason: "window fn; rank takes no arg; order in over ranks the whole result when no partition"
- gap: "none"
- correction: "none"
## 2026-11-20 yaml-indent-is-the-tree
- question_id: yaml-indent-is-the-tree
- rep: yes
- verdict: repaired
- answer: "table property: child of table, sibling of loaded_at_field"
- reason: "repair: more indent than columns = child of columns"
- gap: "first answer skipped what under-columns means"
- correction: "none"
