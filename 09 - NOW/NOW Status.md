---
status: active
project: now
type: reference
author: junior
created: 2026-10-13
updated: 2026-10-22
---
# NOW Status

Building the private beta (milestone M0, foundations); no product code on `main` beyond the app skeleton, the data layer and the first database tables (checked against the repo 2026-10-22). Decision 0006 (NOW as a social map, proposed by [[Tolu]], accepted by Isaac 2026-10-14) defines the product. Start with the repo's `docs/roadmap.md`: its "Start here" and "Waiting on Isaac" sections are the source of truth for what is next.

This note is a living snapshot. Overwrite it as things change; one-line history goes in [[NOW Log]], and older long-form entries are in [[NOW Status History 20261022]].

## Snapshot
- **What NOW is:** a social map of places. Users post about places they've been (photos, their own words, Worth it / Mid / No, an optional price per head), follow each other by username, and open a map of public pins. Friends are two people who follow each other. Post audiences: Public, Friends, Selected friends, Only me. The team seeds an area; users build the rest; anyone can post anywhere.
- **Kept:** the trust rule (for when money starts), anti-gaming, adults only, no live location, posts appear after a member-set delay and show the date never the time, new places private until checked.
- **In the first release:** map home with a "This weekend near you" strip, free-text reviews with guardrails, the cheap share-in from TikTok and Instagram, AI search (real posts only), Android and iOS, English.
- **Deferred:** live location, chat, groups and voting, events and bookings, money from venues (until users and interactions are proven).
- **The test:** a 4-week private beta of the real app (`docs/validation/beta-plan.md`); pass marks locked 2026-10-15 (0010).
- **Company priority (Isaac, 2026-10-14):** NOW goes first; Lingora on hold (see [[Lingora Status]]).
- **Decisions in force (repo `docs/decisions/`, status checked 2026-10-22):** 0001 to 0012 accepted (0008 tech stack, 0009 phone sign-in and 0011 adding places with conditions; 0012 VerifyNow beta codes amends 0009). **Proposed, not in force:** 0013 (beta cut line and measure-first, Isaac, waiting for Tolu) and 0014 (base map from OpenFreeMap, Isaac, waiting for Tolu).
- **Requirements** (trace check 2026-10-22): 145 functional, 78 non-functional; risks in `docs/requirements/risk-register.md`. Planned documents wait for their triggers in `docs/document-register.md`.
- **Hosting:** all on AWS (Isaac, 2026-10-15), with Supabase (London) for the database; Cloudflare Access and Turnstile kept. Backups in a separate AWS account is still open (E16).
- **Known issues:** cold start and whether people post (the beta measures it); founder capacity (Isaac's 10-hour days no longer end in November per the roadmap, 2026-10-22; he still has to give the real end date; decision 0013); daily moderation load; Corner-clone risk; the base map host (0014); SMS costs and the E15 country allowlist; DPIA and lawyer review before real tester data.

## Where we stopped
Each person keeps their own section current.

### Isaac
**Latest (2026-10-22, DB-21 part 1, Now 94f8cb8 pushed to `feature/db-21-visibility`, off `main` 16a7442, not merged):** Isaac said go on DB-21 in this session, so the part that needs no posts table was built: `private.is_follower`, `is_friend`, `is_blocked`, `is_muted`, `followers_of` (active followers only, proposed for Tolu to confirm) and `place_visible` (with a block backstop, NOW-SF-019). Built in a second worktree (machine-specific: `Now-db21` beside Isaac's clone) because another session was using the shared clone for DB-18. Two independent security reviews: no Critical/High/Medium; NOW-SF-019 to 024 drafted and fixed. 33/33 on PGlite, real CI not run (CI runs on pull requests; no PR yet, Junior's token can't open one). **Next:** Isaac opens the PR; lock-it on SF-019 to 024; part 2 (`can_view`, `post_audience`, public projection) once Tolu's DB-31 lands. Q1 (banned adder's pending place) left as is on Junior's recommendation; Q2 (mutes at inbox write or read) is DB-34's call.

**Latest (2026-10-22, later):** DB-51 and DB-20 are on `main` (#49, 16a7442, checked 2026-10-22). Isaac locked NOW-SF-007 to 017, accepting SF-008 (the soft cap). DB-21 is held for Tolu's DB-31 (posts table), on Isaac's call. DB-18 (Isaac's contract stubs) built on `feature/db-18-isaac-stubs` with a contract test and a stub register that the SEC-33 sign-off must find empty; committed b387f8c and pushed on Isaac's word; the PR isn't open because the GitHub connector's token gets 403 on creating PRs, so Isaac opens it from the compare page. Next: DB-62, the real risky-word check (FR-POST-06 is a beta Must).

**Earlier (2026-10-22, DB-51 review and fixes, Now af78cfe):** DB-51 and DB-20 committed (bbf3939). `now-security-reviewer` on bbf3939: no Critical/High; NOW-SF-010 to 018 drafted. Fixed in af78cfe: SF-010 (SCP denies IAM users/access keys), SF-012 (IAM alert on every write, new Identity Center rule), SF-013 (receipt expiry ceiling), SF-014 (rotation order), SF-016 (`posting_paused` status); DB-51 tests 44/44 on PGlite (Docker isn't installed; pgcrypto shimmed), infra 5/5, real CI not run. Still open after the lock: SF-011 (deploy role effectively admin; the earlier FND-09 review rated it High), SF-015 (FND-11 no-echo key copy), SF-017 (alert emails in cdk.json). Open question E17 (does a block survive account deletion) blocks DB-23 and DB-65. **Next:** Isaac opens the PR so CI runs, Tolu reviews, lock-it on the remaining findings, decide E17, then DB-21 (the visibility rule).

**Latest (2026-10-22, AWS, separate session):** FND-09 started. The account is empty (no stacks, buckets or Organization) and becomes the management account; creating the Organization moves it to AWS's Paid plan (the Free plan closes accounts after 6 months). Junior wrote `aws/infra` (not deployed; README has the first-deploy runbook); security review: 1 High (deploy role reaches AdministratorAccess through the CDK bootstrap) and 4 Medium. The infra files were swept into the DB-51 commit bbf3939 (pushed) and need splitting onto `feature/fnd-09-aws-org`. Isaac's console steps not started.

**Earlier (2026-10-22):** Isaac reopened the base map after researching a free Snap-Map-style stack: decision 0014 proposed (OpenFreeMap tiles through our own style file; Protomaps on AWS kept as a measured fallback with an exit drill and switch triggers; R-35). Isaac pushed 0014 and its wiring to `main` (b5bd424, 60cca05); the docs-consistency fixes (8 findings) appear to be committed in b3cb719 (commit message checked, diff not). Waiting for Tolu. On 2026-10-15 the move off OpenFreeMap was driven by "no SLA", which is unchanged. APP-04 done: merged in #46 and #47 (c6d71cd) after Junior's security review (5 findings in [[NOW Security Findings]], locked by Isaac; NOW-SF-003 and 004 wait in APP-10, NOW-SF-002 in APP-27 and MAP-11).

**Decisions that shaped the build (2026-10-15):** 0008 tech stack accepted with conditions (AWS, AI filter picker); 0009 phone and SMS sign-in with a country allowlist; 0010 post timer, seeding anywhere, caps only on SMS and AI, beta pass marks; 0011 adding places and photo-location checks; architecture accepted by Isaac except backups in a separate AWS account (E16). Detail: [[NOW Status History 20261022]].

### Tolu
**Latest (2026-10-22 evening, DELL laptop).** Merged on Tolu's word:
- **DB-12** (#52, `98b0a38`): `api.update_profile` and `api.get_settings`, migration `20261022140000`, 44 pgTAP tests. Review (Sonnet): no Critical/High; NOW-SF-025 to 030. Releasing a username at once is open question **E18** for Tolu (Isaac's E17 is about blocks).
- **#52 also fixed `main`:** types were missing DB-21 part 1's helpers (type check red since #50, pgTAP skipped), and the app's `query.test.tsx` left a member signed in, so Jest never exited and CI hit its 15-minute timeout (test-only fix).
- **Docs** (#53, `3b8a7c8`): Isaac's DB-18, DB-20 and DB-51 marked done; DB-21 part 1 merged (#50).

**Merged later the same evening:** #48 (DB-47, `c16b51c`), merged by Tolu through the shared UndeifyIT account (SR-013); Isaac reviews its three contract changes after the fact.

**Merged later the same evening (Tolu's word):** #54 (DB-31 post tables, DB-02 finished, DB-03 done; text limits 500/300 accepted by Tolu) and #55 (DB-33 ratings, DB-32 `api.create_post`). Both had Sonnet security reviews (NOW-SF-042 to 057), all fixes in, CI green. **Waiting on Tolu:** confirm the `create_post` limit (20 an hour) and decision 0010's timer proposals (tonight 22:00, only before 21:00; tomorrow morning 08:00). **Waiting on both founders:** E19, where "Choose people" picks live before publish (`create_post` refuses `picked` until then). **Next for Tolu:** DB-34 (the publish step) unblocks feeds, totals and Isaac's DB-21 part 2.

**Not done:** staging not checked this session; today's migrations (DB-51, DB-20, DB-18, DB-21 part 1, DB-12, and DB-47 once merged) go there with `supabase db push` from a clean `main`. The first all-Lagos import on staging is Tolu's (needs the connection string). No Docker on this laptop: CI is the test bed, and types come from CI's diff. Background CI watchers were stopped today for low memory (about 600 MB of 7.9 GB free).

Earlier entries: [[NOW Status History 20261022]] and [[NOW Log]].

## Next steps
Source of truth: the repo's `docs/roadmap.md` ("Start here" and "Waiting on Isaac"). In short:
1. Isaac: decide E17; fix SF-011 and SF-017 before the first AWS deploy; DB-21 (the visibility rule) once Tolu's DB-31 lands.
2. Tolu: accept or challenge decisions 0013 and 0014; the week-1 device spike and SMS provider spike; the E15 allowlist with Isaac; confirm the `acting_member` contract.
3. Joint: design direction (DES-01), GitHub Team for branch protection (FND-01), E16 backups, CAC registration.
4. Isaac: engage the lawyer (OPS-02), apply for PhotoDNA and Arachnid Shield (OPS-03), the device lab (QA-03), AWS (FND-09, FND-10).
5. Junior: participant notice, community rules and the interview script.

## Related
- [[NOW Architecture]]
- [[NOW Log]]
- [[NOW Security Findings]]
- [[LIFE and NOW Concept Research]]
- [[NOW Status History 20261022]]
