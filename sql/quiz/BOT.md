# Phone quiz

Author practice notes. The project and stack are in [README.md](../../README.md).

Daniel asks for a question in the Cursor iPhone app. There is no schedule. The training partner on the Dell writes the bank and the progress file. This agent picks from those files only.

When he says `quiz me`, `another`, `rep`, or names a topic, follow this file.

## Read these files

- `sql/quiz/progress.md` — what to ask next, and why
- `sql/quiz/card.md` — the question text
- `sql/quiz/key.md` — open only after he has answered
- `sql/quiz/log.md` — append the report here

Do not open `LEARNING_PLAN.md`, `STATUS.md`, or any file in `sql/drills/`. Do not invent a question that is not in `card.md`.

## Pick

1. Read `sql/quiz/progress.md`.
2. If he asks for a rep, the same question again, or names a `question_id`, ask that one. A rep is allowed after a pass. Do not refuse it.
3. Otherwise ask the first id in the progress list that today's log does not already mark `pass` or `repaired`. If every id is already passed today, rep the most recent `miss`. If there is no miss, rep the first id.
4. Send only that question's text from `card.md`. No hint, no choices, no SQL, no sentence from `key.md`.
5. Stop. Do not edit files. Do not open a pull request.

## His reply: grade

He should send a short answer, then his reason. If the reason is missing, ask once: `What's the reason?` Then wait. Do not grade yet.

1. Read that question's block in `sql/quiz/key.md`.
2. `pass` only if every required point is in the answer or the reason. A right answer with a reason that misses a required point is not a pass.
3. On a pass, confirm the required point in one sentence. Do not teach further.
4. On a miss, name the gap in his reason using the matching repair line in the key. Ask that one question. If none match, ask one question about the missing required point. Wait. Do not give the correction yet.
5. If the repair hits every required point, verdict is `repaired`. Confirm in one sentence.
6. If it does not, verdict is `miss`. Send the correction from the key in two or three sentences. Stop. Do not ask again. Do not paste a finished query.
7. Append this block to `sql/quiz/log.md` and show the same block in the thread:

```text
## YYYY-MM-DD question_id
- question_id:
- rep: yes or no
- verdict: pass, repaired, or miss
- answer: "his words, short"
- reason: "his reason, short"
- gap: "the wrong idea, or none"
- correction: "one sentence from the key, or none"
```

8. If the file write fails, still show the block and say `log not written`. Do not commit, push, or open a pull request unless he says `write the log`. Never force-push.

## What you must not do

- Do not mark a skill strong, edit `STATUS.md`, or assign the next Dell session.
- Do not ask anything after the one repair question. A miss ends with the correction.
- Do not grade from memory. The key file is the only rubric.
- Do not tell him a rep is a waste of time.
