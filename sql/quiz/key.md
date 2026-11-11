# Grade key

Author practice notes. The project and stack are in [README.md](../../README.md).

Open this file only after Daniel answers. Do not quote it in the question.

## island-filter

pass requires:
- `first_round` and `last_round` become the same round.
- That round is the start of the streak. The other three races are gone before the min and max.

repair:
- If he says the 4 races are still in the streak: ask `The running sum is in that same step as the filter. Which of the 4 rows does the filter still leave for min and max?`
- If he says the filter only changes sort order: ask `Does that WHERE remove rows, or only change their order?`

correction: The filter runs before the running sum can see the later races, so each streak collapses to its first round.

## dead-group-by

pass requires:
- The grouping does not change which rows come back.
- Those two columns already identify one row, so the `group by` is dead.

repair:
- If he says it sums points: ask `Points is in the select list with no aggregate. What is there to sum?`
- If he says it removes duplicates: ask `Before the GROUP BY, is there more than one row for the same driver and round?`

correction: `group by` changes the grain only when it collapses rows. Here each driver-round is already one row, so the clause does no work.

## missing-column

pass requires:
- No. The row count being right does not pass the question.
- A column the question asked for has to be in the result.

repair:
- If he says the count is enough: ask `Can the grader see qualifying position in the result without that column?`
- If he says the join implies the column: ask `A join can use a column without selecting it. Is qualifying position in the output?`

correction: A missing requested column fails the question even when the grain and the row count are right.

## push-names-the-branch

pass requires:
- The new commit does not go to GitHub `main`.
- `git push origin main` sends the laptop's `main`, and this commit is not on it.

repair:
- If he says the commit was rejected and is only on the laptop: ask `You had already run git push origin working. Where did that command send the commit?`

correction: The push names the branch it updates. The commit was on `working`, so only a push of `working` publishes it. `main` on GitHub changes when the pull request is merged.

## open-pr-follows-the-branch

pass requires:
- The same open pull request now includes the new commit.
- `main` stays unchanged until the pull request is merged.

repair:
- If he says GitHub opens a second pull request: ask `The pull request tracks the branch. Which branch did the new commit land on?`
- If he says `main` updates on the push: ask `What action puts the pull request's commits onto main?`

correction: An open pull request follows its branch. A new commit on that branch shows up in the same request. Merging the request is what updates `main`.

## checkout-does-not-fetch

pass requires:
- The files match `main` on the laptop.
- That copy can be behind the `main` on GitHub.

repair:
- If he says the files match GitHub: ask `Which command downloads the commits GitHub has that the laptop does not?`

correction: Checkout switches the folder to the laptop's `main`. `git pull` is what brings in the GitHub commits that laptop does not have yet.

## checkout-is-the-branch-this-folder-shows

pass requires:
- The new commit is on the laptop's `working`. GitHub does not have it yet.
- Checked out means this folder is showing that branch. A commit made here lands on the branch this folder has checked out.

repair:
- If he says checked out means the files were downloaded from GitHub: ask `Before any pull, which copy of working are these files: the laptop's, or GitHub's?`
- If he says the commit is already on origin: ask `Which command sends a commit to GitHub?`

correction: Checked out is the branch this folder is showing. A commit in the folder lands on that branch on the laptop. Pull and push are what talk to GitHub.

## pull-follows-the-checked-out-branch

pass requires:
- `git pull` with no arguments looks at `origin/working`, the remote of the branch that is checked out.
- The folder stays on `working`. A newer `main` on GitHub is not what this pull brings.

repair:
- If he says it pulls `main` because `main` is newer: ask `Which branch is checked out in this folder?`
- If he says the files now match GitHub `main`: ask `Which command switches this folder from working to main?`

correction: `git pull` with no arguments updates the branch this folder has checked out, from that branch's remote. It does not switch the folder, and it does not fetch `main` just because `main` moved.

## pull-brings-commits-not-untouched-files

pass requires:
- A pull brings commits that the remote of this branch has and the laptop's branch does not. It is not a file-by-file copy that skips edited files.
- Uncommitted edits stay when those commits leave those lines alone. If an incoming commit changes the same lines, Git stops and refuses.

repair:
- If he says pull replaces the folder with origin's copies: ask `When a pull is already up to date, do the uncommitted edits stay modified?`
- If he says Git always keeps your edits and takes theirs: ask `When a merge would overwrite a file you edited, did Git finish the merge or stop?`

correction: A pull brings commits for the checked-out branch. Uncommitted edits sit on top of the current commit and stay when the new commits leave those lines alone. Same lines, and Git refuses instead of overwriting.

## branch-is-a-label-on-a-commit

pass requires:
- `working` points at the new commit. That is the branch checked out in the folder where he committed.
- `feature` still points at the old commit. A branch is a label on a commit. A new commit moves only the label of the branch that is checked out.

repair:
- If he says both labels move because they shared a commit: ask `Which branch is checked out in the folder where you committed?`
- If he says `feature` keeps updating because it was created from `working`: ask `After the new commit, do the two labels still name the same commit?`

correction: A branch is a label stuck to one commit. Two labels can share a commit. The next commit moves only the label of the branch checked out in that folder. The other label stays on the old commit.

## commit-records-what-was-staged

pass requires:
- The commit records nothing new. `STATUS.md` was not staged, so the edit stays uncommitted.
- `git add -A` stages every change, including the untracked `f1-feature/` folder. `git add STATUS.md` stages that file and leaves the folder out.

repair:
- If he says the commit includes every file he can see: ask `Which step puts a file into the commit: the edit, or git add?`
- If he says `git add -A` and `git add STATUS.md` stage the same set: ask `Is f1-feature/ a tracked edit to STATUS.md, or a new untracked path?`

correction: A commit records the staged snapshot. An edit stays out until it is added. `git add -A` also stages untracked paths, so a folder you did not mean, such as a worktree inside the repo, goes into the commit.

## fetch-updates-the-remote-bookmark

pass requires:
- The files in the folder do not change. Fetch does not merge and does not switch the checkout.
- `origin/working` is the laptop's bookmark for where GitHub's `working` was at this fetch. It is not the branch checked out in the folder, and it is not a live view of GitHub.

repair:
- If he says the files update to match GitHub: ask `Which command merges the fetched commits into the branch this folder has checked out?`
- If he says `origin/working` is GitHub itself: ask `After the laptop goes offline, can that name still point at a commit?`

correction: Fetch downloads new commits and moves the laptop's `origin/*` bookmarks. The folder keeps showing the branch that is checked out. Pull is fetch plus a merge of the checked-out branch.

## merge-joins-with-two-parents

pass requires:
- The new commit is on `working`. It has two parents, the `working` line and the `origin/main` line, and that is where the graph joins.
- GitHub `main` does not move. Merging the pull request is what moves `main`.

repair:
- If he says the merge switches this folder to `main`: ask `Which branch was checked out when you ran the merge?`
- If he says GitHub `main` now includes the working commits: ask `Which action on GitHub moves main: the local merge, or merging the pull request?`

correction: A merge commit joins two lines and sits on the branch that was checked out. `git merge origin/main` while on `working` updates `working`. GitHub `main` moves when the pull request is merged.

## conflict-stops-until-you-commit

pass requires:
- Both sides changed the same lines in that file, and Git will not choose for him.
- The merge is unfinished until the file is resolved and that resolution is committed.

repair:
- If he says the merge deleted his edits: ask `Did Git finish the merge, or did it stop and leave the file for you?`
- If he says keeping one side is the same as keeping both meanings: ask `What happens to the phone's lines if the committed file has only the Dell side?`

correction: A conflict means both sides touched the same lines, so Git stopped. The next commit on the checked-out branch is the resolution. Until that commit exists, the merge is not done.

## rebase-replays-your-commits

pass requires:
- Rebase takes the commits that are on `working` and not on `main` and replays them on top of `main` as new commits. The `working` label moves to those new commits.
- A merge keeps the old commits and adds one commit with two parents. That is what `git merge origin/main` did.

repair:
- If he says rebase and merge leave the same commits in place: ask `Do the replayed commits keep their old ids, or are they new commits?`
- If he says rebase deletes `main`: ask `Which branch's unique commits get replayed on top of the other?`

correction: Rebase copies this branch's unique commits onto the tip of the other branch as new commits, then points this branch at them. Merge adds one commit with two parents and leaves the old commits in place. Rebase of commits already on GitHub `main` rewrites history other people have.

## accept-merges-the-worktree-branch

pass requires:
- In the original folder, `git merge agent-check` brings the commit onto `working`.
- Copying the file by hand skips the branch. The commit has to be on `agent-check` before the merge.

repair:
- If he says `git push origin working` brings the file over: ask `The file was committed on agent-check. Which branch is the original folder filled from before the merge?`
- If he says copying the file is the same as the merge: ask `After a hand copy, which branch has the commit?`

correction: Accepting means the commit stays on the worktree branch. `git merge agent-check` in the folder filled from `working` moves that commit onto `working`. A hand copy never puts the commit on a branch.

## branch-is-not-a-folder

pass requires:
- No new directory appears. `working2` is a label, not a folder.
- The same project directory is rewritten with `working2`'s snapshot.

repair:
- If he says each branch is its own folder: ask `After you switch from working to working2, is STATUS.md in a new directory or in ~/f1-data-engineering?`
- If he says the files stay as they were: ask `Which snapshot does Git write into the project directory when you switch?`

correction: A branch is a label on a commit. Switching writes that commit's snapshot into the one project directory. A second directory exists only after `git worktree add`.

## origin-is-the-github-remote

pass requires:
- `origin` is the name of the remote, and that remote is GitHub. The laptop is local.
- `git pull origin working` updates the laptop's `working` from GitHub's `working`.

repair:
- If he says the laptop is the remote: ask `In git pull origin working, which copy is the source and which copy changes?`
- If he says the pull updates GitHub: ask `Which command sends the laptop's commits to GitHub?`

correction: `origin` names the GitHub remote. A pull copies that remote's branch onto the laptop. A push copies the laptop's branch onto GitHub.

## pull-main-merges-into-working

pass requires:
- `dimensions.py` becomes the version from `main`. The committed `features.py` stays his version. The result is both.
- GitHub `main` does not change. The pull merged `main` into the laptop's `working`.

repair:
- If he says `features.py` is replaced by `main`: ask `Who changed features.py, and who changed dimensions.py?`
- If he says GitHub `main` now has his commit: ask `What puts commits onto GitHub main: this pull, or merging the pull request?`

correction: `git pull origin main` while the folder is filled from `working` merges GitHub `main` into `working`. His committed file stays. Their file comes in. GitHub `main` moves when the pull request is merged.

## worktree-is-a-second-folder

pass requires:
- `feature` is a new label that starts on the same commit as `working`. It is its own branch after that.
- The new thing on disk is a second folder, filled with that commit's files. The history is shared.

repair:
- If he says `feature` is a branch of `working` that keeps copying it: ask `After you commit in the feature folder, does the working label move?`
- If he says only a new branch is created and the project folder switches: ask `What does git worktree add create that git checkout -b does not?`

correction: A worktree is the second folder. The new branch is a new label on the commit you started from. A later commit moves only the label written into the folder where you committed.

## worktree-keeps-uncommitted-work

pass requires:
- In one folder, he commits or stashes before the switch, or Git refuses when the files differ.
- A worktree leaves those uncommitted edits in branch 1's folder while branch 2's folder is open.

repair:
- If he says a worktree means he never has to commit: ask `What saves the work once you are ready to push it?`
- If he says both setups require a commit before he can look at branch 2: ask `Which setup leaves branch 1's files on disk while he opens branch 2?`

correction: Switching branches rewrites the one folder, so uncommitted work has to be committed or stashed first. A worktree keeps that folder intact. He still commits when the work is ready to push.

## feature-reaches-main-without-working

pass requires:
- He does not commit the change to `working` first. The commit in the feature folder is already on `feature`.
- `git push origin feature` publishes it. A pull request from `feature` into `main`, then the merge, updates GitHub `main`.

repair:
- If he says the commit has to land on `working` before it can be pushed: ask `Which branch is written into the f1-feature folder?`
- If he says `git push origin main` publishes the feature commit: ask `Which branch does that command name?`

correction: Commit in the feature folder, then `git push origin feature`. The pull request from `feature` into `main` is the review. Merging it updates GitHub `main`. `working` is not a stop on the way.

## leader-max-needs-over

pass requires:
- After `group by driver_id`, a plain `max(sum(points))` is not the leader's total. It does not see the other drivers.
- The gap needs `max(sum(points)) over ()`, an empty window over every grouped row.

repair:
- If he says the max already looks across every driver: ask `After GROUP BY driver_id, which rows can an aggregate with no OVER see?`
- If he says it just errors: ask `The nested max needs a window to be legal. What goes in the empty OVER so the max can see every driver's total?`

correction: `over ()` is the whole grouped result. That is how the max becomes the leader's points. Without it, the nested max is not a window, and Postgres rejects the nested aggregate.

## rank-takes-no-argument

pass requires:
- `rank()` takes no argument.
- The ordering goes inside the window: `rank() over (order by sum(points) desc)`.

repair:
- If he says `rank(sum(points))` is legal when the sum is already grouped: ask `Does rank accept a value argument at all, or does the sort live somewhere else?`
- If he says the final `order by` sets the rank: ask `Does that final ORDER BY change the rank number, or only the order the rows are displayed?`

correction: `rank`, `dense_rank`, and `row_number` take no argument. The order lives in `over`. `lag`, `lead`, and `ntile` do take an argument.

## worktree-commit-stays-in-its-folder

pass requires:
- The original folder is unchanged. It still has `working` checked out.
- The new commit is on `feature`, the branch checked out in the new folder.

repair:
- If he says both folders show the commit: ask `Which branch is checked out in the original folder?`
- If he says the commit landed on `working`: ask `Which branch did the new folder get when it was created?`

correction: A worktree is another folder with its own branch. The commit lands on the branch that folder has checked out. The original folder stays on `working`.

## worktree-push-names-its-branch

pass requires:
- `git push origin main` does not publish the feature commit. It sends the laptop's `main`.
- From that folder, `git push origin HEAD` or `git push origin feature` publishes `feature`.

repair:
- If he says the worktree folder makes the push send `feature`: ask `The command says origin main. Which branch does that word name?`
- If he says the commit can only be pushed from the original folder: ask `HEAD in the feature folder is feature. What does git push origin HEAD send?`

correction: The folder does not choose the remote branch. The push command does. From the worktree, name `feature` or `HEAD` to publish the commit that folder just made.

## worktree-one-branch-one-checkout

pass requires:
- Git refuses. `working` is already checked out in the original folder.
- The new folder needs its own branch. The original folder stays on `working`.

repair:
- If he says both folders now show `working`: ask `What would break if two folders committed to working at the same time?`
- If he says the original folder switches off `working`: ask `Does git worktree add change the folder you were already in?`

correction: One branch can be checked out in only one worktree. The new folder needs a new branch. The original folder stays put.
