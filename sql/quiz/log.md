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
