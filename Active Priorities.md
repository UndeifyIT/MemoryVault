---
status: active
project: meta
type: plan
---
# Active Priorities

The single queue of open work across everything. Items sit under a project heading, or under Company for work that spans projects. Add an item when work is parked; delete it when it's actually done (don't let it rot). This is the system of record for "what's still open": a daily note's "In Progress" is a frozen snapshot that goes stale the moment something closes, so never treat an old daily note's open items as current truth. Put newly completed items at the top of Completed Tasks; Junior moves older ones to the Archive when there are more than ten.

### Open Tasks

#### Company
- [ ] Push rule follow-through (Isaac): CONTRIBUTING.md still requires a pull request approved by Isaac or Tolu, and the planned branch protection on `main` would block Tolu's direct pushes. Decide whether to change CONTRIBUTING.md to match and whether branch protection lets Tolu bypass it.
- [ ] Marketing and budget: build a plan Isaac and Tolu can run themselves, since neither is strong here, and grow Undeify's presence on social media organically. See [[Low-Budget Marketing Plan]]. Funds are tight, so no paid ads for now and every marketing and tooling suggestion starts with free or cheap options; fill in the costs, budget and runway in [[Tool Register]] (Isaac).
- [ ] Coding efficiency: adopt loop engineering and graph engineering to save time. See [[Coding and Feature Work]].
- [ ] Vault and Junior setup (Isaac): add Tolu to the private repo UndeifyIT/MemoryVault and turn on multi-factor sign-in for the org (see [[Security Register]] SR-001); set up Composio for connecting apps with least-privilege access (steps in [[Onboarding]]); point `vault-backup.sh` at a folder outside GitHub that only you control and do the restore drill once; run the [[Junior Checks]] once in a scratch project, and again after any Claude model change.
- [ ] DPCO sprint (Isaac said yes 2026-10-06; see [[Undeify Opportunity Scan]]). Kit is on Isaac's machine (machine-specific path: `C:\Users\HP\Downloads\Undeify DPCO Sprint`; local only; it holds DPCO contact details, so keep it off GitHub and out of the vault). By 19 Oct: finish and publish the Undeify NDPA pack. 13 Oct – 30 Nov: 12–15 DPCO calls. Gate on 30 Nov: at least 3 DPCOs prepay ≥₦50K or kill (Isaac).
- [ ] Open a free Polar test account and confirm how payouts reach Nigeria (currency, fees, KYC) before pricing anything in USD (Isaac or Tolu).
- [ ] Finish the CAC registration of Undeify (reserved as "UndeifyLTD") (Isaac). Blocks Apple, the Google Play organisation account, D-U-N-S, and using "Ltd" on the site.
- [ ] Publish Undeify's own NDPA documentation (privacy notice, data inventory, hosting/transfer basis) before selling any compliance product (Isaac).

#### Undeify Website
- [ ] Undeify website: the precompiled React replacement is built, tested locally, and pushed to CompanyWebsite's `isaac-revision` branch for Isaac's review; not merged or deployed. Isaac separately authorizes deployment. Pre-merge fixes (W4, W16, W17) are done locally and waiting for Isaac's push word; the site has no forms and hello@ is confirmed active; send full-size scene images if still wanted (Isaac); approve remaining "Junior's call" decisions in `docs/decisions.md`. See [[Undeify Website Status]].

#### NOW
The detail for every item below is in [[NOW Status]], [[NOW Security Findings]] and the repo's `docs/roadmap.md` ("Waiting on Isaac"); this list keeps one line of who-does-what. Condensed 2026-10-22; the earlier long lines are in the git history of this note.
- [ ] NOW decisions waiting on Tolu: 0014 (base map from OpenFreeMap through our own style file, Protomaps on AWS as a measured fallback; if accepted it drops MAP-03 and MAP-04 and shrinks MAP-01) and 0013 (beta cut line and measure-first). Isaac still gives the real end date for his 10-hour days so plan section 11 and T1 can be fixed (Tolu, Isaac).
- [ ] NOW sign-in follow-ups: pick the E15 country allowlist for phone sign-in (Isaac, Tolu); SMS provider spike and delivery test on the four networks and each allowlisted country, plus the 0012 VerifyNow pre-tester conditions (Tolu).
- [ ] NOW legal and vendors (Isaac): engage the lawyer (OPS-02, critical path) and have them review hosting and data flows before real tester data (legal items 12, 24); apply for PhotoDNA and Arachnid Shield (OPS-03, vetting takes weeks); the Jev bake-off against Haiku 5.5 is still an open call.
- [ ] NOW architecture and 0010 follow-ups (Junior, Isaac, Tolu): the founders decide the section 15 list and the pass-3 decisions in [[NOW Architecture Review Pass 3]] (the architecture is now v6.1, accepted by Isaac except backups in a separate account, E16; Tolu still to agree v5 and v6; full property and speed tests and the docs-consistency review not run). Junior changes the design to the member's post timer (F-03 step 6, section 7.2, AD-12; unverified whether already done) and writes the no-freebies rule into the tester and team onboarding when the participant notice is drafted.
- [ ] NOW documents (Junior reminds at the trigger; see the repo's `docs/document-register.md`): technical design when the stack is chosen (Tolu); privacy notice, terms and DPIA when hosting and vendors are chosen (Junior drafts, lawyer); app store checklist about 2 weeks before the first test build; beta cut line and cost model once there is a build estimate; device and account policy before the build starts (Isaac).
- [ ] NOW app stores (Isaac): open a personal Google Play account for the beta, with two-step sign-in and Tolu as a separate admin. **Reminder at the launch plan (Junior raises it):** before or during public launch, move to an organisation account: CAC-registered Ltd, D-U-N-S number (free, 2–4 weeks, never pay a middleman), website, business address and phone (shown publicly). Apple TestFlight only when the $99 a year is affordable. See open question E11 in the repo.
- [ ] NOW database (Isaac, Tolu): DB-51 and DB-20 merged (#49), DB-18 (#51), DB-21 part 1 (#50), DB-12 (#52), all checked 2026-10-22. Isaac decides E17 (does a block survive account deletion; blocks DB-23 and DB-65); DB-21 part 2 waits for Tolu's DB-31. Tolu decides E18 (hold a released username; NOW-SF-025) #48 (DB-47) merged by Tolu: Isaac reviews its three contract changes after the fact. #54 (DB-31, with DB-02 and DB-03 finished) is green: Tolu confirms the text limits (500/300), then merge; DB-21 part 2 can then start (Isaac). Push today's migrations to staging from a clean `main` (staging not checked 2026-10-22). DB-15's daily job must call `private.expire_unattached_photos()` (Tolu).
- [ ] NOW database and build housekeeping (Isaac, Tolu): Isaac reviews the contract changes in #36–#38 after the fact (contracts.md §1 rule 5 needs both founders); Tolu confirms `get_app_config` stays callable without the edge (DB-03 exemption); at go-live set Auth's 30-day inactivity timeout on the Pro production project (AD-21); plan the Expo SDK 58 upgrade (`npx expo install --fix`) and add tests for `packages/shared`.
- [ ] NOW repo protection (Isaac): switch on branch protection on `main` with code-owner review (needs GitHub Team, FND-01) and confirm Tolu's GitHub handle for CODEOWNERS; switch on Dependabot alerts and security updates (FND-07); remove UndeifyIT from the GitHub organisation and require two-factor sign-in. Decide SR-013 in [[Security Register]], the shared UndeifyIT user account (draft, waiting for "lock it"; deferred by Isaac on 2026-10-15 until NOW is done; Junior raises it again before the first code is pushed).
- [ ] NOW capacity and beta timing: answer capacity and area (T1, T2); recruit founding posters at least 14 days before the beta (0007); set the beta start date once the build date is known (Isaac). See [[NOW Status]].

#### MindBridge
- [ ] [[MindBridge]] is parked (2026-10-13). Before it restarts, tell Junior where its repo is so its notes can be drafted (Isaac).

#### BakeFlow
- [ ] Confirm or correct the BakeFlow Status and Architecture drafts (Isaac). See [[BakeFlow Status]].

#### ShiftOS
Checked against GitHub `main` and production on 2026-10-13: the audit fixes in PRs #29–#37 are merged, and the production backend runs the latest `main` (`59801cf`). See [[ShiftOS Status]].
- [ ] Confirm in the Supabase dashboard that migrations 075–081 are applied to production. Confirm that Render's `DATABASE_URL` uses the new backend role from H10 (the username only, never the password) (Isaac or Tolu).
- [ ] Fix the audit findings not covered by PRs #29–#37. Covered so far: C1, H1–H3, H5–H13, M1, M2, M10, M11, M14, M18, M19, M21, M23, M26, L9, L16, L19. Do H4 first (protect `main`), then M25 (get production's schema back into Git and find where `074_extend_admin_role` came from) (Isaac to approve; Engineering).
- [ ] Run the dashboard checks 1–17 listed in the repo's findings.md (Isaac or Tolu). Status unknown.
- [ ] Mark the merged fixes in the repo's `audit/.../fixes.md`, which still says nothing was applied. Decide whether `audit/` stays tracked now that the repo is private (Engineering).
- [ ] Delete the orphan Render service `shiftos-backend` after checking what secrets it holds (Isaac).
- [ ] Two Batch 4 decisions only Isaac can make. H8 shipped self-scoped leave reads: is that the intended answer to "should a Supervisor see a peer's leave reason"? And M17: how long an offboarded employee's attendance, leave and photo are kept. Both block making the privacy policy true.
- [ ] Confirm or correct the ShiftOS Status and Architecture drafts (Isaac).
- [ ] Marketing P0 before any traffic (Isaac decides, Junior or Tolu builds): pick the name and a domain we control, since `shiftos.app` is another company's product and receives our hello@ and privacy@ email; and make the demo and newsletter forms store leads, with a bot check and rate limit (both discard submissions today). See [[ShiftOS Marketing Review]].
- [ ] Decide ShiftOS pricing (Isaac): the pricing page and PF-012 disagree, and nothing in code enforces plans or takes payment.

#### Lingora
**On hold until further notice (Isaac, 2026-10-14)** while NOW goes first; resume when there is data on user need (expected end of 2026 or early 2027). The items below wait; none is cancelled. See [[Lingora Status]].
- [ ] Lingora: pick a new name and run a trademark search before any brand spend; 12+ App Store apps are already called "Lingora" (Isaac). See [[Lingora Market Validation]].
- [ ] Lingora: hire a native Yorùbá linguist to QA every string and tone mark; the prototype spells its first greeting two ways (Isaac, Tolu).
- [ ] Lingora: set the validation sprint start date (Isaac). The gates are drafted in decision 0014 (proposed; Isaac may still revise them until the sprint starts, then they freeze); no production code until they pass. Corrected 2026-10-12: the gates were already drafted.
- [ ] Lingora: check that Apple can pay Undeify's bank (search the bank in App Store Connect) and get a D-U-N-S number before Apple enrolment (Isaac). See roadmap stage 12.
- [ ] Lingora: decide the language order after Yorùbá (research recommends Igbo → Twi, not Hausa or Swahili/Zulu) (Isaac). Corrected 2026-10-12: the launch buyer is already decided in the repo (diaspora families, the parent learning on their own account; decisions 0003 and 0031).
- [ ] Lingora legal reminder (Junior raises this at the start of every Lingora session until done): 59 legal items are tracked in the repo's `docs/legal/legal-action-list.md` (UndeifyIT/Lingora). Before the validation sprint (marked V): privacy notice and terms live before the waitlist collects emails, NDPC registration past 200 sign-ups, company and tax ID checks, USD account and Apple payout check, D-U-N-S and store accounts, ARCON and marketing-email questions, refund policy, tax on web checkout (merchant of record such as Polar, or UK VAT registration before the first sale; item 53), whether the landing page's goal question reveals ethnic origin (item 50, decision 0031), ownership of AI-generated drafts and art (item 56) (Isaac, lawyer, accountant).
- [ ] Lingora: engage a lawyer before the build (Isaac). Top question: NDPA s.2(2)(a) covers processing by any controller domiciled in Nigeria, so on a literal reading Nigeria's under-18 rules (verified parental consent, s.31) may apply to all Lingora users, including UK and US children and teens; also whether a separate non-Nigerian company as controller would change that (with an accountant), plus the full list in the repo's `docs/open-questions.md`.
- [ ] Lingora: tech stack discussion, started 2026-10-12 when Isaac locked the accounts MVP spec (0023); choose before validation sprint week 4 at the latest; inputs in the repo's roadmap Track D (Isaac, Tolu).
- [ ] Lingora: Tolu reviews and locks: 0038 (goal paths) and 0037 (Isaac's review) via their "Summary for Tolu" sections, the 0028 stalemate amendment, and Isaac's culture sign-off with changes (culture proposal section 10: items 5, 6, 11 changed; additions on 4, 7, 9, 10, 12) (Tolu). Isaac commits the repo changes first.
- [ ] Lingora: get the Spitch partnership terms (pricing, accuracy on learner speech) in writing before designing the free tier (Isaac).

### Completed Tasks
- [x] 2026-10-22: NOW housekeeping verified done and removed from Open Tasks: decisions 0008 and 0011 accepted by Isaac 2026-10-15 (decision files), 0010 lock committed (adc862e, 92cf9d7), FND-06 monorepo skeleton built (roadmap), Tolu's DB-04 member half merged in #41 (edc70e0), 0014 docs-consistency fixes committed (b3cb719, message checked).
- [x] 2026-10-22: NOW DB-16 (tester list, SMS check, invites, #44) and DB-30 (place tables, #45) merged to `main` by Tolu.
- [x] 2026-10-15: NOW decision 0010 (post timer, seeding anywhere, caps only on SMS and AI) accepted by Isaac with Tolu's answers to T2, T4, T13, T14, NFR-PRIV-09 (keyed hash) and P14; beta pass marks locked; locked in the Now repo working tree (uncommitted).
- [x] 2026-10-15: push rule decided by Isaac: Tolu may push to project repos as he sees fit in his own sessions. Junior still does not commit or push in an Isaac session without Isaac's explicit word.
- [x] 2026-10-15: NOW 0009 lock committed by Isaac (Now 56a949c).
- [x] 2026-10-15: NOW decision 0009 (phone and SMS sign-in) accepted by Isaac with foreign numbers from an allowlist; locked in the Now repo working tree (uncommitted).
- [x] 2026-10-14: NOW T17 answered and welcome screen decided by Tolu (P13); both on main (Now 33e63e0, b73a21a).
- [x] NOW: Isaac reviewed and merged Tolu's 2026-10-14 decisions with review fixes into main, pushed (Now 8ac1e5e, 2026-10-14).
- [x] 2026-10-14: NOW sign-in decided by Tolu (E13: Google, Apple or email code, phone optional); 0007 low-cost seeding accepted by Tolu; T16 answered (founding posters 14 days early). In the Now repo, uncommitted.
- [x] 2026-10-14: NOW decision 0006 (social map, proposed by Tolu) and the private beta accepted by Isaac and locked in the repo (824fe1b); Lingora put on hold.
- [x] 2026-09-28/29: ShiftOS audit fixes merged (PRs #29–#37), including Critical C1+H1. Production backend verified on `59801cf` via `/health` on 2026-10-13. Migrations still to be confirmed (open item above).
- [x] 2026-10-12: Lingora accounts MVP spec reviewed (sections 2–13 with passes) and locked by Isaac (decision 0023 Accepted).
- [x] 2026-10-12: Isaac confirmed the vault's "Lingora" project is Lingora (repo UndeifyIT/Lingora); folder and notes renamed to Lingora, links fixed, market validation note moved out of the Inbox.
- [x] 2026-10-12: Lingora 0029, 0032 and 0033 accepted by both founders and the stage 5 journeys reviewed by Tolu (PR #3, merged into UndeifyIT/Lingora main).
- [x] 2026-10-06: Lingora `research/` is in the repo (committed in 5d9830a and cb4fd26, verified with git log).
- [x] 2026-09-28: ShiftOS repo made private after the audit was pushed to it (verified 00:35). Batch 5 live checks written into the audit folder.
- [x] 2026-09-27: ShiftOS production-readiness audit complete — all 4 batches, all 36 checklist sections. 1 Critical, 9 High, 24 Medium, 18 Low. Output in repo `audit/2026-09-27-production-readiness/`. Nothing applied.
- [x] 2026-09-26: vault pushed to the private repo UndeifyIT/MemoryVault.