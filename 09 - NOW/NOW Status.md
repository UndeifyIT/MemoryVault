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
**Latest (2026-10-22, DB-51 review and fixes, Now af78cfe pushed to `feature/db-51-photos`):** DB-51 and DB-20 are committed (bbf3939) but **not on `main`**; checked 2026-10-22, the branch is pushed and I could not confirm a PR (Junior's GitHub token gets 403 creating PRs, and `gh` is not installed on this machine). `now-security-reviewer` on bbf3939: no Critical/High; NOW-SF-010 to 018 drafted. Fixed in af78cfe: SF-010 (SCP denies IAM users/access keys), SF-012 (IAM alert on every write, new Identity Center rule), SF-013 (receipt expiry ceiling), SF-014 (rotation order), SF-016 (`posting_paused` status); DB-51 tests 44/44 on PGlite (Docker isn't installed; pgcrypto shimmed), infra 5/5, real CI not run. Locked by Isaac 2026-10-22: NOW-SF-006 and NOW-SF-018; SF-007 to 017 are still drafts. Still Isaac's: SF-008 (accept the soft cap?), SF-011 (deploy role effectively admin; the earlier FND-09 review rated it High), SF-015 (FND-11 no-echo key copy), SF-017 (alert emails in cdk.json). Open question E17 (does a block survive account deletion) blocks DB-23 and DB-65. **Next:** Isaac opens the PR so CI runs, Tolu reviews, lock-it on the remaining findings, decide E17, then DB-21 (the visibility rule).

**Latest (2026-10-22, AWS, separate session):** FND-09 started. The account is empty (no stacks, buckets or Organization) and becomes the management account; creating the Organization moves it to AWS's Paid plan (the Free plan closes accounts after 6 months). Junior wrote `aws/infra` (not deployed; README has the first-deploy runbook); security review: 1 High (deploy role reaches AdministratorAccess through the CDK bootstrap) and 4 Medium. The infra files were swept into the DB-51 commit bbf3939 (pushed) and need splitting onto `feature/fnd-09-aws-org`. Isaac's console steps not started.

**Earlier (2026-10-22):** Isaac reopened the base map after researching a free Snap-Map-style stack: decision 0014 proposed (OpenFreeMap tiles through our own style file; Protomaps on AWS kept as a measured fallback with an exit drill and switch triggers; R-35). Isaac pushed 0014 and its wiring to `main` (b5bd424, 60cca05); the docs-consistency fixes (8 findings) appear to be committed in b3cb719 (commit message checked, diff not). Waiting for Tolu. On 2026-10-15 the move off OpenFreeMap was driven by "no SLA", which is unchanged. APP-04 done: merged in #46 and #47 (c6d71cd) after Junior's security review (5 findings in [[NOW Security Findings]], locked by Isaac; NOW-SF-003 and 004 wait in APP-10, NOW-SF-002 in APP-27 and MAP-11).

**Decisions that shaped the build (2026-10-15):** 0008 tech stack accepted with conditions (AWS, AI filter picker); 0009 phone and SMS sign-in with a country allowlist; 0010 post timer, seeding anywhere, caps only on SMS and AI, beta pass marks; 0011 adding places and photo-location checks; architecture accepted by Isaac except backups in a separate AWS account (E16). Detail: [[NOW Status History 20261022]].

### Tolu
**Latest (2026-10-21 late night, DELL laptop):** DB-10 merged (#40, c048074) and on staging. **Staging is one migration ahead of `main`:** Tolu's push ran while the clone was on #41's branch, so `20261021220000_db_04_require_member` was applied before #41 merged (#41 has since merged, edc70e0). DB-11 in PR #42 (`feature/db-11-create-profile`, head 3e01715): `api.create_profile` and `api.accept_rules`; security review (3 Medium: incident switches, look-alike names, CI check that member functions call `require_member`; plus Lows) all fixed, 57 pgTAP tests plus an API test that a client can't force `Prefer: tx=rollback`. Tolu accepted FR-PROF-10 (reserved names, widened to look-alikes and staff-posing display names). The `identity_key` in Vault never rotates (rotation means rehashing; runbook step). Bash stopped launching on the DELL laptop mid-session; Junior switched to PowerShell.

**Latest (2026-10-21 night, DELL laptop): DB-10 in PR #40** (`members`, `member_private`, `invites`, `age_refusals`, `beta_testers`, all closed to API roles; usernames per FR-PROF-01; invites with 12-32 character random codes; `member_private.rules_version`; tester list deleted 30 days after the beta). now-security-reviewer: no Critical/High; 5 Medium and the Lows fixed. 50 pgTAP tests. Later-task notes: never delete or ban users in the Supabase dashboard (runbook); `restore_account` needs a session-plus-status check, not `require_member`.

**Latest (2026-10-21):** Tolu merged DB-04, DB-06 and DB-19 (#36 to #38, `main` CI green, 129 pgTAP tests) and decided rules acceptance lives in `members.rules_version`. Staging is synced and verified by Junior on 2026-10-21. The Expo SDK 58 upgrade (the Dependabot backlog) is to be done in one go with `npx expo install --fix`. The shared `UndeifyIT` account opened PR #10 (SR-013). Full entry, with the Dependabot triage and CI fixes: [[NOW Status History 20261022]].

**Latest (2026-10-21, Isaac's call on a joint item):** `acting_member` in `create_post` is a shared-phone guard only (EC-61). The server rejects it unless it matches the token and always takes the author from the token; recorded in contracts.md, roadmap and plan. Tolu to confirm, since contracts need both founders.

**Latest (2026-10-21, later):** ambition pass on the plan. 108 of 135 beta requirements are Must, so cutting Shoulds and Coulds saves only about 22 days. Drafted decision 0013 (cut line candidates of at least 39 days, rebalance, size test for the visibility rule, measure-first), proposed by Isaac, waiting for Tolu. Stack check: self-hosting AWS is about 30 days of 510, no change.

## Next steps
Source of truth: the repo's `docs/roadmap.md` ("Start here" and "Waiting on Isaac"). In short:
1. Isaac: open the PR for `feature/db-51-photos`, lock or decide the remaining findings (SF-007 to 017), decide E17, then build DB-21 (the visibility rule).
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
