---
status: active
project: now
type: reference
author: junior
created: 2026-10-13
updated: 2026-10-13
---
# NOW Status

Research and design stage (checked 2026-10-13). There is no product code. The repo UndeifyIT/Now holds the research, five decision records, a Lingora-style roadmap, open questions, a legal action list and the Lekki/VI place data. Start with the repo's `docs/roadmap.md`. All five decisions wait for [[Tolu]].

This note is a living snapshot. Overwrite it as things change; history goes in [[NOW Log]].

## Snapshot
- **Stage:** research and design. No code until the home screen is decided and the 2-week concierge test has a start date.
- **What exists in the repo** (latest commit 9942ce6, 2026-10-13):
  - `docs/research/2026-10-13-concept-research.md`
  - decisions 0001–0005 in `docs/decisions/`
  - `docs/roadmap.md`, `docs/open-questions.md` and `docs/legal/legal-action-list.md`
  - the test plan in `docs/validation/test-plan.md`
  - the ChatGPT report and Tolu's social discovery brief in `docs/research/external/`, and Junior's review of the brief
  - an Overture Maps extract for VI and Lekki in `data/`, plus `scripts/overture_places.py` to rebuild it
- **Known issues:**
  - The cold start is the main risk.
  - Overture data misses most new openings (2 of 14 present).
  - Location safety needs a DPIA (data protection impact assessment) before launch.
  - The open-source plan is parked because of the AI-cloning concern.
  - Phone sign-in codes (OTP by SMS) cost money per message; not yet priced.

## Where we stopped
Each person keeps their own section current.

### Isaac
On 2026-10-13 Isaac dropped LIFE to focus on NOW (decision 0001). With Junior he chose:
- content seeded by the team first, then by users
- the trust rule: vendors pay for visibility, never for the verdict
- open across Lagos, with effort focused on Lekki Phase 1 and VI (decision 0002)

He asked Tolu to decide the home screen (0003). Later on 2026-10-13 Isaac brought a ChatGPT market analysis. Junior reviewed it and Isaac adopted six points (commit 867e69e):
- the WhatsApp-vs-prototype test with six measures, now in `docs/validation/test-plan.md`, pass marks to lock before starting
- practical tags on places (dress code, transport, noise, group fit)
- outing spots plus a "free or cheap" chip in v1
- a "Your city life" profile
- pasting a Reel into the group shortlist
- choosing the first zone by who we can recruit

Isaac locked the test plan's pass marks on 2026-10-13 (b2a03d1). Tolu may challenge them until day 1. Isaac will give the start date on 2026-10-14.

New local competitor: Niibow, a Lagos restaurant finder by mood (self-reported 1,000+ venues; no social features on its website). Junior recommends option D, the "Tonight / This weekend" deck with "Send to the group". Open for Isaac: the start date for the concierge test. Junior recommends after the DPCO gate on 30 Nov.

Evening of 2026-10-13: Tolu sent Isaac a "social discovery" product brief (9 docs, a zip and 5 screenshots), sitting untracked in the repo's `Now/` and `__MACOSX/` folders. Junior reviewed all of it. The screenshots Tolu's brief calls "Kona" are Corner's App Store screenshots (Corner, the closest live analog in our research). The brief is generic (no Lagos, trust rule, price, Nigerian constraints) and conflicts with 0003 (map and follow-feed home, voting only inside the app) and 0002's 24-hour friend delay. Worth adopting: per-item visibility and invite-link rules, lock-screen notification leaks, server-side access-control test cases, SSRF controls for link import, behaviour interviews before the test, empty states. Isaac approved the adopt list, and Junior applied it (Now dc899c5): the brief and screenshots (renamed `corner-*.png`) are filed in `docs/research/external/`, the review is in `docs/research/2026-10-13-tolu-brief-review.md`, 0002 gained section 6 (privacy and access-control requirements, proposed), the test plan gained 20–30 behaviour interviews before day 1 (pass marks unchanged), and 0003 asks Tolu whether the brief is his answer.

Later on 2026-10-13 Isaac asked for NOW to be mapped out the way Lingora is. Junior wrote `docs/roadmap.md` (start here, progress tracker, 17 stages in tracks A–G), `docs/open-questions.md` and `docs/legal/legal-action-list.md` (34 items; 5 before the test). Isaac then worked through seven gaps with Junior and pushed back on three. Settled and committed (Now 9942ce6):
- **MVP cuts (0003, "Isaac's changes"):** no groups, voting or link pasting; a plain share link to a public place page stays; rating in two steps (Worth it / Mid / No, then an optional "better or worse than" comparison); no free text from users.
- **Test plan:** share rate and visit rate replace group conversion and plan completion (changed before day 1); picks go one-to-one; weeks 3–4 everyone on the prototype; 10 venue interviews, gate 3 of 10 would pay.
- **0004 (proposed):** rating rules R1–R9: raters invisible to venues, no opt-out for public venues, home vendors opt-in only, complaint path, evidence, extortion bans. Prompted by the Chioma Okoli case.
- **0005 (proposed):** "NOW" is a working name; the tagline stays internal; draft public line "Venues can pay to be seen. They can't pay to be liked."

Most urgent for Isaac before day 1: T1 capacity, T2 zone and T3 seed budget (estimated ₦600k–1M for 40 visits).

### Tolu
**Needs decision (both founders).** On 2026-10-13 at about 11 PM Tolu, on Isaac's laptop, got a full briefing from Junior and pushed back. His positions, not yet in the repo:
- NOW is a social app first: users post, follow each other and are found by username (real names optional), TikTok-style. The team only seeds a few places so the map isn't empty.
- No launch zone: anyone posts anywhere, including outside Lagos (conflicts with 0002's Lekki/VI focus).
- Users must be able to write their own reviews and comments (conflicts with 0004 R2 and 0003 change 4).
- AI search should not be ruled out.
- Share from TikTok or Instagram into NOW should work, with the app saying when no place was found (conflicts with Isaac's deferral of link pasting, 0003 change 2).
- Live location as an on/off setting, as on Snapchat (conflicts with 0002 section 5).
- Agrees to defer events, ticketing, bookings, groups and voting; chat deferred for now, though he thinks it matters. Keep the map.
Junior's view was given in the chat; neither version is settled until Isaac and Tolu agree.
- Later the same night Tolu agreed with Junior's full app walkthrough (social map, public pins for everyone without an account, "Been here" tap, posts with Worth it / Mid / No and price per head, date never time, "after I leave" default, 18+, venue side), with two changes: mutual follows are **not** friends (instead suggest people followed by people you follow), and places show how many people saved them ("80 people saved this"). He asked why sharing from TikTok/Instagram is deferred; after Junior's answer he chose to include the cheap version (share into NOW, TikTok's official lookup only, "Which place is this?", saved privately with the link; Isaac deferred link pasting, so this needs Isaac). Clarified: friends = two people who follow each other; "followed by people you follow" is only a suggestion. Post audiences: Public, Friends, selected friends (pick names), plus Junior's suggested Only me.

Earlier: sent the social discovery brief (2026-10-13), now filed in the repo. Waiting on Tolu: accept or challenge 0001, 0002 (including section 6), 0004, 0005 and the changed pass marks, and decide 0003 in the repo, saying whether a map or follow-feed home is still his answer.

## Next steps
1. Tolu decides 0003 and reviews 0001, 0002, 0004, 0005 and the pass marks.
2. Isaac answers T1–T3, then sets the start date for the concierge test.
3. Junior drafts the participant notice, the Monday check-in script and the venue interview script.
4. Before any code: the test must say continue; then the tech stack, SMS costs, the DPIA and open-sourcing.

## Related
- [[NOW Architecture]]
- [[NOW Log]]
- [[LIFE and NOW Concept Research]]
