---
status: active
project: now
type: reference
author: junior
created: 2026-10-13
updated: 2026-10-13
---
# NOW Status

Research and design stage (checked 2026-10-13). There is no product code. The repo UndeifyIT/Now holds the research, three decision records and the Lekki/VI place data. All three decisions wait for [[Tolu]].

This note is a living snapshot. Overwrite it as things change; history goes in [[NOW Log]].

## Snapshot
- **Stage:** research and design. No code until the home screen is decided and the 2-week concierge test has a start date.
- **What exists in the repo** (latest commit b2a03d1, 2026-10-13):
  - `docs/research/2026-10-13-concept-research.md`
  - decisions 0001–0003 in `docs/decisions/`
  - the test plan in `docs/validation/test-plan.md`
  - the ChatGPT report in `docs/research/external/`
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

Evening of 2026-10-13: Tolu sent Isaac a "social discovery" product brief (9 docs, a zip and 5 screenshots), sitting untracked in the repo's `Now/` and `__MACOSX/` folders. Junior reviewed all of it. The screenshots Tolu's brief calls "Kona" are Corner's App Store screenshots (Corner, the closest live analog in our research). The brief is generic (no Lagos, trust rule, price, Nigerian constraints) and conflicts with 0003 (map and follow-feed home, voting only inside the app) and 0002's 24-hour friend delay. Worth adopting: per-item visibility and invite-link rules, lock-screen notification leaks, server-side access-control test cases, SSRF controls for link import, behaviour interviews before the test, empty states. Nothing applied; waiting for Isaac's OK on the adopt list and Tolu's answer on whether the brief is his 0003 position.

### Tolu
Sent the social discovery brief (2026-10-13), not yet in the repo. Waiting on Tolu: accept or challenge 0001 and 0002, and decide 0003 in the repo, saying whether the brief's map/feed/in-app plan is his answer.

## Next steps
1. Tolu decides 0003 and reviews 0001 and 0002.
2. Isaac sets the start date for the concierge test.
3. Before any code: choose the tech stack, price SMS codes, write the DPIA, and revisit open-sourcing.

## Related
- [[NOW Architecture]]
- [[NOW Log]]
- [[LIFE and NOW Concept Research]]
