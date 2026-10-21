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
- [ ] Marketing and strategy: build a plan Isaac and Tolu can run themselves, since neither is strong here. See [[Low-Budget Marketing Plan]].
- [ ] Budget: funds are tight, so no paid ads for now. Every marketing and tooling suggestion starts with free or cheap options. Fill in the costs, budget and runway in [[Tool Register]] (Isaac).
- [ ] Awareness: grow Undeify's presence on social media platforms organically.
- [ ] Coding efficiency: adopt loop engineering and graph engineering to save time. See [[Coding and Feature Work]].
- [ ] Add Tolu to the private repo UndeifyIT/MemoryVault and turn on multi-factor sign-in for the org (Isaac). See [[Security Register]] SR-001.
- [ ] Set up Composio for connecting apps, with least-privilege access (Isaac). Steps are in [[Onboarding]].
- [ ] Point `vault-backup.sh` at a folder outside GitHub that only you control (Isaac), and do the restore drill once.
- [ ] Run the [[Junior Checks]] once in a scratch project, and again after any Claude model change (Isaac).

- [ ] DPCO sprint (Isaac said yes 2026-10-06; see [[Undeify Opportunity Scan]]). Kit is on Isaac's machine (machine-specific path: `C:\Users\HP\Downloads\Undeify DPCO Sprint`; local only; it holds DPCO contact details, so keep it off GitHub and out of the vault). By 19 Oct: finish and publish the Undeify NDPA pack. 13 Oct – 30 Nov: 12–15 DPCO calls. Gate on 30 Nov: at least 3 DPCOs prepay ≥₦50K or kill (Isaac).
- [ ] Open a free Polar test account and confirm how payouts reach Nigeria (currency, fees, KYC) before pricing anything in USD (Isaac or Tolu).
- [ ] Undeify website: the precompiled React replacement is built, tested locally, and pushed to CompanyWebsite's `isaac-revision` branch for Isaac's review; not merged or deployed. Isaac separately authorizes deployment. Before enabling the disabled Formspree form, provide its ID and confirm provider privacy, retention and transfer settings (Isaac); confirm hello@undeify.com forwarding (Tolu); send full-size scene images if still wanted (Isaac); approve remaining "Junior's call" decisions in `docs/decisions.md`. See [[Undeify Website Status]].
- [ ] Finish the CAC registration of Undeify (reserved as "UndeifyLTD") (Isaac). Blocks Apple, the Google Play organisation account, D-U-N-S, and using "Ltd" on the site.
- [ ] Publish Undeify's own NDPA documentation (privacy notice, data inventory, hosting/transfer basis) before selling any compliance product (Isaac).

- [ ] NOW (first priority): Isaac accepts or challenges decision 0008, the tech stack proposed by Tolu, (the map and hosting are settled by Isaac's change of 2026-10-15: Protomaps and all hosting on AWS; Cloudflare Access and Turnstile kept; CSAM detection service to choose and apply for (EC-49); see [[NOW Status]]) and whether Jev gets a bake-off against Haiku 5.5 (Isaac). Then Tolu runs the week-1 spike: low-end phone, tile failure, share-in (Tolu). Lawyer review of hosting and data flows before real tester data (legal items 12, 24) (Isaac).
- [ ] NOW 0009 follow-ups: pick the country allowlist for phone sign-in, E15 (Isaac, Tolu); SMS provider spike and delivery test on the four networks and each allowlisted country (Tolu).
- [ ] NOW: Isaac accepts or challenges decision 0011 (Tolu, 2026-10-15: same-place prompt, photo-location check on the phone, fixed spots only in the beta, all-Lagos Overture import, and point 6 amending NFR-PRIV-02 on where location may be used) (Now 40fc014, 8d597d1) (Isaac).
- [ ] Security (Isaac): decide SR-013 in [[Security Register]], the shared UndeifyIT user account (draft, waiting for "lock it"). Deferred by Isaac on 2026-10-15 until NOW is done; Junior raises it again before the first code is pushed.
- [ ] NOW 0010 follow-ups: commit the 0010 lock (uncommitted on Isaac's clone, 15 doc files) (Isaac). Change the architecture design to the member's post timer: F-03 step 6, section 7.2, AD-12 (Junior, before the design is locked). Write the written no-freebies rule into the tester and team onboarding when the participant notice is drafted (Junior).
- [ ] NOW architecture: Draft v4 after the last review pass, with all 24 pass-3 findings fixed. The prototype fixes are tested; the document-only fixes are untested at Isaac's request. Committed and pushed by Isaac (Now fdbbf86, 2026-10-15). Still not run: the full v4 property and speed tests, and the docs-consistency review. Founders: decide the section 15 list plus the pass-3 decisions in [[NOW Architecture Review Pass 3]]; it changes parts of 0008 and now 0009 (sign-in), so decide those first (Isaac, Tolu).
- [ ] NOW: lock the beta pass marks (T14) and set the abuse-signal retention (NFR-PRIV-09) (Isaac, Tolu).
- [ ] NOW documents (Junior reminds at the trigger; see the repo's `docs/document-register.md`): technical design when the stack is chosen (Tolu); privacy notice, terms and DPIA when hosting and vendors are chosen (Junior drafts, lawyer); app store checklist about 2 weeks before the first test build; beta cut line and cost model once there is a build estimate; device and account policy before the build starts (Isaac).
- [ ] NOW app stores: open a personal Google Play account for the beta, with two-step sign-in and Tolu as a separate admin (Isaac). **Reminder at the launch plan (Junior raises it):** before or during public launch, move to an organisation account: CAC-registered Ltd, D-U-N-S number (free, 2–4 weeks, never pay a middleman), website, business address and phone (shown publicly). Apple TestFlight only when the $99 a year is affordable. See open question E11 in the repo.
- [ ] NOW FND-06: the monorepo skeleton is built and tested in Isaac's working tree, uncommitted. After FND-01, put it on a branch and open a PR for Tolu to review the tooling picks (pnpm 12, TypeScript 6.0, ESLint and Prettier) (Isaac, Tolu).
- [ ] NOW database (Isaac, Tolu): DB-04, DB-06 and DB-19 merged by Tolu (#36–#38, `main` CI green). **Isaac reviews the contract changes in #36–#38 after the fact** (contracts.md §1 rule 5 needs both founders; Tolu merged on his own word). Rules acceptance: `members.rules_version` (decided by Tolu 2026-10-21); the member half of `require_member` follows DB-10, where Tolu confirms the proposed PT403 "rules" error and `api.accept_rules`. Tolu confirms `get_app_config` stays callable without the edge (DB-03 exemption). At go-live set Auth's 30-day inactivity timeout on the Pro production project (AD-21). Then plan the Expo SDK 58 upgrade (`npx expo install --fix`) and add tests for `packages/shared`. See [[NOW Status]].
- [ ] NOW: switch on branch protection on `main` with code-owner review, and confirm Tolu's GitHub handle for CODEOWNERS.
- [ ] NOW: answer capacity and area (T1, T2); recruit founding posters at least 14 days before the beta (0007); set the beta start date once the build date is known (Isaac). See [[NOW Status]].

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