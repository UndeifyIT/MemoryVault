---
status: active
project: linhora
type: reference
author: junior
created: 2026-09-26
updated: 2026-10-10
---
# Linhora Status

Planning stage for the Lingora app (repo UndeifyIT/Lingora); no production code. Unverified assumption: "Linhora" in this vault is the Lingora project (Isaac has not corrected it).

This note is a living snapshot. Overwrite it as things change; history goes in [[Linhora Log]].

## Snapshot
- **Stage:** Not recorded yet.
- **What works:** Not recorded yet.
- **Known issues:** Not recorded yet.

## Where we stopped
Each person keeps their own section current. Say what is half-done, the branch, the files touched, the next command to run, and how to test it.

### Isaac
The live tracker is in the repo: `docs/roadmap.md`, "Start here". As of 2026-10-10 (night) **Isaac handed the decisions to Tolu** and went offline. Pushed to GitHub (Isaac's commit e764c9c): decisions 0028 (culture ownership), 0029 (school-standard Yorùbá), 0031 (diaspora families stay the main buyer; sprint measures every group), 0032 (one scripted market scene in the MVP), plus the parallel session's 0030 (concept video). **Not yet pushed** (on Isaac's machine, waiting for his OK to commit): 0033 (Proposed: a short Unit 1 market scene in the sprint build; Isaac chose A; passes done; six fixes listed in the record), the decisions index row and the roadmap "Start here" handoff line.
**Tolu, pick up here, in order:** (1) decide 0033: approve or change fixes 1–6 (legal item 36 to V; stylised banknotes only; new legal item 57 for test-build privacy, Spitch agreement and tester-data deletion; test-build security baseline; culture reviewer hired before sprint week 6; cut of 2–3 minutes), then "lock it". If 0033 is not on GitHub yet, its full text is in Isaac's local repo; ask Isaac to push. (2) Lock 0029 and 0032, and accept or object to the rules Isaac added to 0028 (tie-break, 24-hour silence rule, experts never overruled). (3) Review the three stage 5 journeys (learner, family, internal). (4) Continue the vision summary reconciliation: next, what the sprint measures for each of its three assumptions (culture depth, interactive scenarios, immersion cost); then the core feel (3D adventure vs guided tour); then the learning cycle. (5) Then culture proposal item 3 (Unit 1 deadline: Junior recommends keeping "before sprint week 6") and the remaining items, the outside brief's ideas, stage 6, the accounts spec review from section 2 plus S1. Every decision runs the review loop with at least three passes (docs/review-loop.md). Legal list at 56 items (57 proposed in 0033).

Side task, concept video for Isaac's mentor (repo `design/video/`, decision 0030 amended, proposed): version 2 rendered 2026-10-11 to `out/lingora-landscape.mp4` and `out/lingora-vertical.mp4` (4:28, 720p, Ezinne voice, Pixabay music, Pexels stock). Before showing: Isaac or Tolu checks every string in `src/yoruba.ts`, then re-render. Words live in `src/narration.json` (rerun `python -I scripts/voice.py`). Repo changes since 044e552 uncommitted.

### Tolu
As of 2026-10-11 (with Junior, on Tolu's machine): locked 0033 (short market scene in the sprint build) with fixes 1–6, changing fix 1 so art may start AI-made (tool licence recorded per image, culture reviewer checks every frame, voices human or linguist-checked; contracts when humans are hired). Agreed 0029 (school-standard Yorùbá) and the teen completion-card default (name hidden; nickname optional, never the account ID). Reopened 0028's tie-break: Tolu wants culture decisions unanimous (talk within 48 hours, else the current plan stands); waiting for Isaac. Held, not written: the age lock on the phone (Tolu wants a way to fix a wrong age; settle later). 0032 (market scene in the MVP) locked by Tolu later the same day. Stage 5 journeys: Tolu reviewed and agreed all three (learner, family, internal) on 2026-10-11. Internal journey fixes: step 2 matched to 0029 (regional forms become notes, never accepted answers); staff sign-in uses passkeys or security keys, never SMS, also for GitHub, email and store developer accounts (spec section 2); every email from our domain uses SPF, DKIM and DMARC (spec section 8). Held by Tolu for later: who builds the internal tools (Junior suggests an off-the-shelf content system and help desk, decided with the tech stack), and cover when both founders are away. Culture pipeline: Tolu agreed four checkpoints, added to the internal journey step 1 (ef0159a): culture reviewer checks the brief first, signs off storyboard and full animation, expensive work last, a change reopens a sign-off. Held for Isaac (noted in PR #2): labelling AI-drafted items, and a free tracking spreadsheet. PR #2 (1f28702, ef0159a) merged by Isaac. Culture proposal: edge-case passes on items 3–11, categories, Unit 1 items, stories and style guide; Tolu answered all six questions (one maturity ceiling for everyone, 12+ / Teen store rating; weekly culture streak; card shows app name and plain store link, no tracking code, no card for guests; AI art allowed in the MVP, replaced with human art when there is money, main characters first; narrator AI only in the sprint if the linguist passes it, human in the MVP, warm adult with a Nigerian accent; Unit 1 culture before sprint week 6), plus the jùjú wording and stored chapter progress. All waiting for Isaac's sign-off: Lingora PR #3 (846c31b, branch `tolu-culture-2026-10-11`). Still held by Tolu: the age lock, who builds the internal tools, founder cover. Open: both UndeifyIT/Lingora and UndeifyIT/MemoryVault are public (checked signed out, 2026-10-11); making them private needs Tolu or Isaac.

## Next steps
1. Not recorded yet.

## Related
- [[Linhora Architecture]]
- [[Linhora Log]]