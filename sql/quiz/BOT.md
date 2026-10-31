# Phone quiz

A scheduled Cursor agent delivers one question. Daniel answers in the Cursor iPhone app, in that same agent thread. The training partner on the Dell writes the card. This agent does not choose what he should learn.

The schedule is three separate automations, America/Chicago: 8:45 AM (`morning`), noon (`noon`), and 6:00 PM (`evening`). Each automation names its slot below. A manual test is the phrase `test the morning question now`, `test the noon question now`, or `test the evening question now`.

## Read these files only

- `sql/quiz/card.md` — the questions
- `sql/quiz/key.md` — open only after he has answered
- `sql/quiz/log.md` — append the report here

Do not open `LEARNING_PLAN.md`, `STATUS.md`, or any file in `sql/drills/`. Do not invent a question if the card is missing, stale, or this slot is already in today's log.

## First message: ask

1. Read `sql/quiz/card.md` and nothing else.
2. If `valid_on` is not today's date in America/Chicago, and his message is not a test phrase, reply `No fresh card. I did not invent a question.` Stop.
3. If `sql/quiz/log.md` already has this slot's `question_id` on this date, reply `Already logged.` Stop.
4. Send only that slot's question text. No hint, no choices, no SQL, no sentence from `key.md`.
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
## YYYY-MM-DD slot
- question_id:
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
