---
status: active
project: now
type: reference
author: junior
created: 2026-10-13
updated: 2026-10-14
---
# NOW Status

Design stage, moving to the build of a private beta (checked 2026-10-14). No product code. Decision 0006 (NOW as a social map), proposed by [[Tolu]] and accepted by Isaac on 2026-10-14, is the current definition of the product. Start with the repo's `docs/roadmap.md`.

This note is a living snapshot. Overwrite it as things change; history goes in [[NOW Log]].

## Snapshot
- **What NOW is:** a social map of places. Users post about places they've been (photos, their own words, Worth it / Mid / No, an optional price per head), follow each other by username, and open a map of public pins. Friends are two people who follow each other. Post audiences: Public, Friends, Selected friends, Only me. The team seeds one area; users build the rest; anyone can post anywhere.
- **Kept:** the trust rule (for when money starts), anti-gaming, one area first, adults only, no live location, posts appear 1 hour later by default and show the date never the time, new places private until checked.
- **In the first release:** map home with a "This weekend near you" strip, free-text reviews with guardrails, the cheap share-in from TikTok and Instagram, AI search (real posts only), Android and iOS, English.
- **Deferred:** live location, chat, groups and voting, events and bookings, money from venues (until users and interactions are proven).
- **The test:** a 4-week private beta of the real app (`docs/validation/beta-plan.md`), replacing the WhatsApp concierge test. Pass marks are still Junior's draft.
- **Repo** (latest commit c8fe2f0, 2026-10-14, checked against GitHub at 08:55): everything below is committed and pushed by Isaac (c9d319f, 10a6ef2, c286d84, c8fe2f0), including the project documents, decision 0007 and the Claude Code setup. Only `.claude/settings.local.json` (the ask-before-push rule) is gitignored, so each clone has to add it itself. Contents: decisions 0001–0007, roadmap v2, open questions, legal action list (34 items), the user walkthrough and following-and-friends rules in `docs/product/`, the beta plan, research and the Lekki/VI place data.
- **Requirements and risks** (2026-10-14): `docs/requirements/srs.md` (108 functional, 52 non-functional requirements, each with ID, priority, release, source and status) and `docs/requirements/risk-register.md` (33 NOW-only risks, 7 High: posting cold start, founder capacity, fake ratings, scope too big for the beta, access-control leaks, legal action over reviews, photo location metadata). Secret-scan hook installed on Isaac's clone; Tolu's clone still needs it. Markdown in the repo, chosen by Isaac.
- **Project documents** (2026-10-14, committed; Isaac commits and pushes project repos himself or on his explicit word): `docs/document-register.md` (every doc, owner, change control: only Isaac, Tolu or Junior; planned docs with triggers), threat model, data model and data map, `CONTRIBUTING.md` and `.github/CODEOWNERS` (Tolu's GitHub handle assumed Steezy7, to confirm), analytics plan, test strategy, moderation playbook, seeding guide, incident runbook, tester pack. SRS now 108 functional, 58 non-functional.
- **Planned documents and their triggers** (Junior reminds): technical design when Tolu picks the stack; privacy notice, terms and DPIA when hosting and vendors are chosen (tester version before the beta); app store checklist about 2 weeks before the first test build; beta cut line and cost model once there is a build estimate; device and account policy before the build starts.
- **Seeding (decision 0007, proposed by Isaac, waiting for Tolu):** option C plus past visits (last 3 months, shown "visited [month]"), 5–10 founding posters left out of the beta measures, one-drink visits, free spots, a smaller dense area: about 40–80 posts for roughly ₦30–80k (Junior's estimate). Open for Tolu: T16 (new-account half weight for founding posters).
- **Company priority (Isaac, 2026-10-14):** NOW goes first; Lingora on hold until further notice (see [[Lingora Status]]).
- **Known issues:** cold start and whether people post (the beta measures it); daily moderation load; Corner-clone risk (the Nigerian layer is the difference); the stack must be chosen before the beta; SMS code costs not priced; DPIA needed before public launch.

## Where we stopped
Each person keeps their own section current.

### Isaac
On 2026-10-14 Isaac accepted everything Tolu proposed (0006, the beta, NOW first, Lingora on hold) and asked Junior to lock it. Junior locked it in the repo (824fe1b), wrote the full user walkthrough and the following-and-friends rules, and marked its own new proposals for both founders to confirm (open question P13). Later on 2026-10-14 Isaac reviewed Junior's proposals: accepted the comment controls and the four visibility rules (selected friends from friends only; private accounts never public pins; anonymous totals from 3; "people you follow went" counts only visible posts); asked for Snapchat-style saved audience lists (a "private story" of pre-chosen friends); wants sign-in by email, Google and Apple, not only phone; questioned follow limits (Junior explained: they cap speed, not totals). Then: Worth it / Mid / No kept over stars (wording may change later); saved lists accepted with Junior's rules; sign-in by Google/Apple/email open until Tolu decides (E13). Written into the repo (Now 970c93c). Isaac then accepted all of Junior's remaining proposals except the welcome screen, which is Tolu's call (Now 92d8561).

Open for Isaac: capacity, area and seed budget (T1–T3), the beta pass marks with Tolu (T14), the start date once the build date is known.

History of 2026-10-13 (Isaac's concierge-test design, the seven gaps, the ChatGPT and Tolu brief reviews) is in [[NOW Log]] and the repo.

### Tolu
On 2026-10-13, on Isaac's laptop, Tolu reworked NOW into a social map (decision 0006), answered the open questions and agreed Junior's guards (1-hour delay, private-until-checked places, stack before the beta, price optional). Next for Tolu: the tech stack (open questions E1–E5, E9–E11), then the beta build.

## Next steps
1. Tolu chooses the tech stack.
2. Both founders lock the beta pass marks (T14); Tolu decides sign-in (E13) and the welcome screen (P13).
3. Isaac answers T1–T3; the start date follows the build date.
4. Junior drafts the participant notice, community rules and interview script.

## Related
- [[NOW Architecture]]
- [[NOW Log]]
- [[LIFE and NOW Concept Research]]
