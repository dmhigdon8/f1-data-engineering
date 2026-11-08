---
name: session-feedback-loop
description: >-
  At the end of a training session, review what Daniel struggled with, find
  underlying concepts missing from the learning plan and phone quiz, and add
  only those. Use when he says he is wrapping up, closing the session, done
  for the night, struggling and needs more, or asks what concepts he is missing.
---

# Session feedback loop

Run this when a training session is ending or he names a gap. The grade in the chat is not the record. A concept he cannot say is not "more practice of the same card" when the card never taught the idea underneath.

## Read first

- `STATUS.md` skill log and grade trail
- `LEARNING_PLAN.md` decisions and the parked list
- `sql/quiz/progress.md`, the headings in `sql/quiz/card.md`, and the latest entries in `sql/quiz/log.md`

## Classify each miss

Use his words from this session. For each struggle, pick one class:

- **Attention.** A typo, a missing `ORDER BY`, or another slip he can rebuild. Name it. Do not add a concept. Do not move a cold-correct pattern back to shaky.
- **Already covered.** The plan or the bank already asks it. Point at that id. Do not add a second card.
- **Missing concept.** He could not say the idea that would have made the miss impossible. One level under the task, not a new field.

## What may be added

A missing concept becomes a phone card: a question in `sql/quiz/card.md`, a key in `sql/quiz/key.md` with `pass requires`, `repair`, and `correction`, and an Ask-next line in `sql/quiz/progress.md` ahead of cards that use the word. Note the addition in one sentence in `LEARNING_PLAN.md` and in the `STATUS.md` path line.

Add a new proof or lane only when he cannot do the current one without it. Python, stats, DSA, a semantic layer, the sports product, pit stops, a new sport, herdr, reset, stash, and cherry-pick stay parked unless he asks for that lane.

Do not mark a skill strong. A phone pass does not move the skill log. Do not invent a quiz question outside `card.md` during a phone quiz. This skill is the Dell step that writes cards.

Check the repo before looking outside it. Search the web only when the missing concept is not already defined in the plan, the quiz key, or the code he uses. Do not survey a course.

## Close the session

Tell him, in this order:

1. What was weak, in his words.
2. The concept underneath, and whether it was already on the plan or just added. Name the file.
3. What you left off, and why.

If he is also committing or pushing, stop before the command. He says the branch, the exact push command, what GitHub updates, and the `gh pr create` command. Then one question that ties the step to a worktree. `git push origin working` is the push while the commit is on `working`. `git push origin main` from that branch does not get run until he corrects it. Leave a nested worktree folder out of `git add`.

## Example

He could not say what "checked out" means, and he described pull as downloading the files he had not edited.

- Attention: none.
- Already covered: `checkout-does-not-fetch` only says checkout skips the download. It does not define the word.
- Missing concept: the folder is showing one branch; a pull updates that branch from its remote and brings commits.

Add those cards. Do not add a Git course, rebase recipes, or reset.
