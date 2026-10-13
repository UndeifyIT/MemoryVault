---
status: idea
project: now
type: plan
author: junior
created: 2026-10-13
updated: 2026-10-13
---
# LIFE and NOW Concept Research

Summary of the 2026-10-13 background check on Isaac's two consumer ideas. LIFE was dropped and NOW is the focus. The full report, the decision records and the data live in the repo https://github.com/UndeifyIT/Now, which is the source of truth. This note only summarises it.

> Draft, not confirmed. Decisions 0001 (drop LIFE) and 0002 (content model, trust rule, launch zone) are proposed by Isaac and waiting for [[Tolu]]. Decision 0003 (home screen) is open for Tolu to decide.

## Where the detail is (repo `main`, commit facdd69)
- `docs/research/2026-10-13-concept-research.md`: the full report. It covers competitors, demand, Nigeria, failed products, open source, security and law, scores, the 2-week tests, and what we didn't verify.
- `docs/decisions/0001-drop-life-focus-on-now.md`
- `docs/decisions/0002-content-trust-rule-and-launch-zone.md`
- `docs/decisions/0003-home-screen.md`: options A–D and the Lagos Gen Z brainstorm.
- `data/` and `scripts/overture_places.py`: the Overture Maps extract for VI and Lekki.

## Key findings to remember
- **LIFE was dropped.**
  - Apple, Google and Nothing already ship its core loop.
  - Transsion (Tecno, Infinix, itel), about 51% of Nigerian phones, is testing an assistant with memory.
  - Meta has banned AI-first bots on the WhatsApp Business API since 15 Jan 2026. There is no exemption for Nigeria.
- **NOW: the map-first social category has failed repeatedly outside China.** Gowalla's 2023 relaunch, Facebook Places and Foursquare's consumer app all died. Beli is the one clear winner: one category, a ranking ritual you do alone, and taste comparison with friends.
- **Nigeria:**
  - Every standalone discovery or directory app has stalled.
  - The survivors are tied to a transaction: Chowdeck (food delivery) and Tix (ticketing).
  - There is a public trust gap with paid influencers (BusinessDay, Jul 2026).
- **Overture data for Lekki and VI** (release 2026-09-23.1):
  - 8,679 places, about 691 of them food and drink.
  - About 97% of the records come from Meta.
  - It has 16 of 18 established venues, but only 2 of 14 new openings.
  - So it solves the empty map but not freshness, and freshness is NOW's pitch.
- **Home screen (recommended, not decided):** option D, a "Tonight / This weekend" deck.
  - Swipeable photo cards from real visitors, each with a price per head and a "worth it" verdict.
  - "Send to the group" creates a WhatsApp vote link.
  - One labelled Promoted card that still shows its real verdict.
  - "New this week" and "Your people" sections.

## Change log
- 2026-10-13, Junior for Isaac: first version, from five research agents.
- 2026-10-13, Junior for Isaac: added the draft decision and the Overture coverage check.
- 2026-10-13, Junior for Isaac: moved from the Inbox to `09 - NOW`. Cut down to a summary once the full report went into the repo (one source of truth).
