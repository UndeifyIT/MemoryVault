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
- **Repo** (latest commit 8ac1e5e on main, 2026-10-14, pushed on Isaac's word): Tolu's 2026-10-14 decisions (b616bbd) and Isaac's review fixes (4c6471c) merged into main; everything is committed and pushed, including the project documents, decisions 0007 and 0008 (0008 still proposed) and the Claude Code setup. Only `.claude/settings.local.json` (the ask-before-push rule) is gitignored, so each clone has to add it itself. Contents: decisions 0001–0008, roadmap v2, open questions, legal action list (34 items), the user walkthrough and following-and-friends rules in `docs/product/`, the beta plan, research and the Lekki/VI place data.
- **Requirements and risks** (2026-10-14): `docs/requirements/srs.md` (117 functional, 64 non-functional requirements, each with ID, priority, release, source and status) and `docs/requirements/risk-register.md` (33 NOW-only risks, 7 High: posting cold start, founder capacity, fake ratings, scope too big for the beta, access-control leaks, legal action over reviews, photo location metadata). Secret-scan hook installed on Isaac's clone and the DELL laptop clone (2026-10-14); Tolu's own machine unverified. Markdown in the repo, chosen by Isaac.
- **Project documents** (2026-10-14, committed; Isaac commits and pushes project repos himself or on his explicit word): `docs/document-register.md` (every doc, owner, change control: only Isaac, Tolu or Junior; planned docs with triggers), threat model, data model and data map, `CONTRIBUTING.md` and `.github/CODEOWNERS` (Tolu's GitHub handle assumed Steezy7, to confirm), analytics plan, test strategy, moderation playbook, seeding guide, incident runbook, tester pack. SRS now 108 functional, 58 non-functional.
- **Planned documents and their triggers** (Junior reminds): technical design when Tolu picks the stack; privacy notice, terms and DPIA when hosting and vendors are chosen (tester version before the beta); app store checklist about 2 weeks before the first test build; beta cut line and cost model once there is a build estimate; device and account policy before the build starts.
- **Seeding (decision 0007, accepted by Tolu 2026-10-14):** option C plus past visits (last 3 months, shown "visited [month]"), 5–10 founding posters left out of the beta measures and recruited **at least 14 days before the beta** so they pass the new-account half weight with no exemption in the code (T16), one-drink visits, free spots, a smaller dense area: about 40–80 posts for roughly ₦30–80k (Junior's estimate).
- **Sign-in (E13, decided by Tolu 2026-10-14):** Google, Apple or email one-time code, phone optional, as Isaac proposed. Rating integrity without a required phone: FR-POST-16 to 18, FR-MAP-12, FR-MOD-08 and NFR-PRIV-09 added (held ratings out of totals, multi-signal burst detection, no verdict under 3 ratings, extra checks for suspicious accounts, abuse signals in the data map). Retention for abuse signals still to be set by both founders.
- **Company priority (Isaac, 2026-10-14):** NOW goes first; Lingora on hold until further notice (see [[Lingora Status]]).
- **Known issues:** cold start and whether people post (the beta measures it); daily moderation load; Corner-clone risk (the Nigerian layer is the difference); the stack must be chosen before the beta; SMS code costs not priced; DPIA needed before public launch.

## Where we stopped
Each person keeps their own section current.

### Isaac
On 2026-10-14 Isaac accepted everything Tolu proposed (0006, the beta, NOW first, Lingora on hold) and asked Junior to lock it. Junior locked it in the repo (824fe1b), wrote the full user walkthrough and the following-and-friends rules, and marked its own new proposals for both founders to confirm (open question P13). Later on 2026-10-14 Isaac reviewed Junior's proposals: accepted the comment controls and the four visibility rules (selected friends from friends only; private accounts never public pins; anonymous totals from 3; "people you follow went" counts only visible posts); asked for Snapchat-style saved audience lists (a "private story" of pre-chosen friends); wants sign-in by email, Google and Apple, not only phone; questioned follow limits (Junior explained: they cap speed, not totals). Then: Worth it / Mid / No kept over stars (wording may change later); saved lists accepted with Junior's rules; sign-in by Google/Apple/email open until Tolu decides (E13). Written into the repo (Now 970c93c). Isaac then accepted all of Junior's remaining proposals except the welcome screen, which is Tolu's call (Now 92d8561).

Later on 2026-10-14 Isaac reviewed Tolu's branch `tolu/2026-10-14-decisions`. Junior's fixes: FR-VEN-06 (venue-linked accounts can't rate their venue, replacing 0003's phone rule; later), Resend in the data map, TikTok short links rejected rather than resolved. The docs-consistency-reviewer then found 12 issues; fixed: FR-MAP-12 counts people not ratings, FR-AUTH-11 proposed (recovery without a phone), legal items 12, 24 and 26 moved before the beta, participant notice covers abuse signals and vendors, email-code abuse in NFR-SEC-14 and the threat model, stale statements; new open question T17 (founding posters and friend groups vs the fake-rating checks). Merged into main and pushed (Now 8ac1e5e). Not fixed: test-strategy still requires the AI test set before the beta (NFR-AI-05 in 0008 would launch without AI search instead; settles when 0008 is accepted); FR-AUTH-03 and the tester pack still offer phone, which 0008 drops for the beta. Isaac asked about Jev (TypeSafe AI) or Microsoft's Phi instead of Haiku 5.5 for AI search: Junior recommends a bake-off on the NFR-AI-01 test set (Haiku 5.5 vs Jev as a filter picker), not a swap now. Isaac then brought ChatGPT's design (database retrieves permitted posts, Jev ranks them). Junior's proposed search backend (not decided): the AI only turns the question into filters from a fixed menu (area, category, price bucket, tags, verdict) and never sees post text; Postgres does retrieval under RLS as the asking member (never the service-role key), with PostGIS, tag and full-text indexes; place totals precomputed when the 1-hour delay publishes a post; parsed questions cached; pgvector inside Supabase only if the test set shows keyword misses. Reason: no post text to a US early-access vendor, no prompt injection from venue-written posts, cost per question a few hundredths of a cent. Questions for Jev before the bake-off: schema-per-call structured output, data retention and DPA, SLA, latency from London.

Open for Isaac: accept or challenge 0008 (and whether the AI provider is chosen by bake-off); capacity and area (T1, T2); the beta pass marks with Tolu (T14); the start date once the build date is known.

History of 2026-10-13 (Isaac's concierge-test design, the seven gaps, the ChatGPT and Tolu brief reviews) is in [[NOW Log]] and the repo.

### Tolu
On 2026-10-13, on Isaac's laptop, Tolu reworked NOW into a social map (decision 0006), answered the open questions and agreed Junior's guards (1-hour delay, private-until-checked places, stack before the beta, price optional). On 2026-10-14, on the DELL laptop, Tolu caught up on Isaac's night session, decided sign-in (E13), accepted 0007 and answered T16 (founding posters 14 days early). Written in the Now repo working tree across 13 files, trace check clean (115 FR, 59 NFR); **not committed**, waiting for Isaac. Then Tolu proposed the tech stack as decision 0008 (Expo, Supabase London, MapLibre + OpenFreeMap, no SMS, Claude Haiku 5.5 AI search behind a test-set gate), after Junior's research and two outside reviews; written in the repo with NFR-REL-06, NFR-SEC-20, NFR-AI-03 to 05, data map and legal updates; trace check clean (115 FR, 64 NFR); **not committed**. Tolu also accepted 0001 (drop LIFE) and 0005 (working name and public copy, both parts); 0001's revisit trigger now points at the beta pass marks. All of it is on branch `tolu/2026-10-14-decisions` (b616bbd), pushed with Isaac's OK as Mednova-lifesciences (Tolu's account), in **pull request #1** for Isaac to review and merge; `main` unchanged. Next for Tolu: once Isaac accepts 0008, the week-1 spike (low-end phone, tile failure, share-in), then the welcome screen (P13) and the beta build.

Latest (2026-10-14, DELL laptop): Tolu answered T17. FR-POST-12 clarified (earlier half-weight ratings count in full once the account passes); FR-POST-17 amended (flag mode in the private beta, reviewed within 24 hours, hold mode before public launch; one global founder-only setting, logged); FR-TEAM-04 added (invite group for moderators only). Committed straight to `main` and pushed (Now 33e63e0), because Isaac told Tolu to stop creating branches. Then Tolu decided the welcome screen (P13: one screen, no slideshow, line without unprovable claims; FR-AUTH-12), pushed to `main` (Now b73a21a). Next for Tolu: the week-1 spike once Isaac accepts 0008.

## Next steps
1. Isaac reviews decision 0008 (tech stack, proposed by Tolu) and accepts or challenges it.
2. Tolu runs the week-1 spike (0008 conditions 1, 4, 9).
3. Both founders lock the beta pass marks (T14) and set the abuse-signal retention (NFR-PRIV-09).
4. Isaac answers T1 and T2 and recruits founding posters at least 14 days before the beta; the start date follows the build date.
5. Junior drafts the participant notice, community rules and interview script.

## Related
- [[NOW Architecture]]
- [[NOW Log]]
- [[LIFE and NOW Concept Research]]
