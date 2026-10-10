---
status: active
project: meta
type: plan
---
# Active Priorities

The single queue of open work across everything. Items sit under a project heading, or under Company for work that spans projects. Add an item when work is parked; delete it when it's actually done (don't let it rot). This is the system of record for "what's still open": a daily note's "In Progress" is a frozen snapshot that goes stale the moment something closes, so never treat an old daily note's open items as current truth. Put newly completed items at the top of Completed Tasks; Junior moves older ones to the Archive when there are more than ten.

### Open Tasks

#### Company
- [ ] Marketing and strategy: build a plan Isaac and Tolu can run themselves, since neither is strong here. See [[Low-Budget Marketing Plan]].
- [ ] Budget: funds are tight, so no paid ads for now. Every marketing and tooling suggestion starts with free or cheap options. Fill in the costs, budget and runway in [[Tool Register]] (Isaac).
- [ ] Awareness: grow Undeify's presence on social media platforms organically.
- [ ] Coding efficiency: adopt loop engineering and graph engineering to save time. See [[Coding and Feature Work]].
- [ ] Add Tolu to the private repo UndeifyIT/MemoryVault and turn on multi-factor sign-in for the org (Isaac). See [[Security Register]] SR-001.
- [ ] Set up Composio for connecting apps, with least-privilege access (Isaac). Steps are in [[Onboarding]].
- [ ] Point `vault-backup.sh` at a folder outside GitHub that only you control (Isaac), and do the restore drill once.
- [ ] Run the [[Junior Checks]] once in a scratch project, and again after any Claude model change (Isaac).

- [ ] DPCO sprint (Isaac said yes 2026-10-06; see [[Undeify Opportunity Scan]]). Kit is in `C:\Users\HP\Downloads\Undeify DPCO Sprint` (local only; it holds DPCO contact details, so keep it off GitHub and out of the vault). By 19 Oct: finish and publish the Undeify NDPA pack. 13 Oct – 30 Nov: 12–15 DPCO calls. Gate on 30 Nov: at least 3 DPCOs prepay ≥₦50K or kill (Isaac).
- [ ] Open a free Polar test account and confirm how payouts reach Nigeria (currency, fees, KYC) before pricing anything in USD (Isaac or Tolu).
- [ ] Publish Undeify's own NDPA documentation (privacy notice, data inventory, hosting/transfer basis) before selling any compliance product (Isaac).

#### MindBridge
- [ ] [[MindBridge]] is our most important project. Tell Junior where its repo is so its notes can be drafted, and record its context, status and next steps (Isaac).

#### BakeFlow
- [ ] Confirm or correct the BakeFlow Status and Architecture drafts (Isaac). See [[BakeFlow Status]].

#### ShiftOS
- [ ] Fix C1 now, ahead of every other finding: its exploit path was public from 00:11 to about 00:35 on 2026-09-28 (Incident I1, contained; repo private since). Then add `audit/` to `.gitignore` or move it out of the repo, so a "commit all" can't publish it again (Isaac to approve; Engineering).
- [ ] Review Batch 5, the live production checks (I1, H10–H13, M25, M26, L19) in the repo's `audit/` folder (Isaac). H11 and H12 are one migration each; H13 means production is running 18 September's backend.
- [ ] Confirm the `DATABASE_URL` username on Render (the username only, never the password) (Isaac). If it is `postgres`, RLS does nothing on the backend path and the repository classes are the only tenant isolation.
- [ ] Find out why Render stopped auto-deploying after 2026-09-18, and where `074_extend_admin_role` came from; it is live and not in the repo (Isaac, Tolu).
- [ ] Delete the orphan Render service `shiftos-backend` after checking what secrets it holds (Isaac). It has never built.
- [ ] Confirm or correct the ShiftOS Status and Architecture drafts (Isaac). See [[ShiftOS Status]].
- [ ] Review the Batch 1 audit findings and approve fixes by ID (Isaac). The Critical invitation-takeover fix (C1+H1) comes first. Files: repo `audit/2026-09-27-production-readiness/`. See [[ShiftOS Log]].
- [ ] Run dashboard checks 1–6 listed in findings.md (Isaac or Tolu).
- [ ] Decide whether `UndeifyIT/ShiftOS` should be public; if not, make it private and protect `main` (Isaac). It is public today, and the audit's C1 exploit path is readable in its migrations. Never commit the `audit/` folder while it is public. See finding H4.
- [ ] Review the Batch 2 findings (H4–H6, M6–M11, L6–L9) and run dashboard checks 7–10 at the end of findings.md (Isaac). Check first whether `OPENAI_API_KEY` is set on Render and whether OpenAI has a budget cap (H5).
- [ ] Review the Batch 3 findings (H7, M12–M16, L10–L12) and run dashboard checks 11–13 (Isaac). H7 first: there is no monitoring or request logging at all, so there is currently no way to tell whether C1 has been used.
- [ ] Review the Batch 4 findings (H8, H9, M17–M24, L13–L18) and run dashboard checks 14–17 (Isaac). H8 first: any Staff member can read a colleague's leave reasons and attendance, which is health and family information. H9 next: a failed read renders as "no shifts this week", so staff can conclude they aren't rostered.
- [ ] Decide the two things in Batch 4 only Isaac can decide: whether a Supervisor should see a peer's leave *reason* at all or only the dates and status (fixes.md H8), and how long an offboarded employee's attendance, leave and photo are kept (fixes.md M17). Both block the privacy policy being made true.

- [ ] Marketing P0 before any traffic (Isaac decides, Junior or Tolu builds): pick the name and a domain we control, since `shiftos.app` is another company's product and receives our hello@ and privacy@ email; and make the demo and newsletter forms store leads, with a bot check and rate limit (both discard submissions today). See [[ShiftOS Marketing Review]].
- [ ] Decide ShiftOS pricing (Isaac): the pricing page and PF-012 disagree, and nothing in code enforces plans or takes payment.

#### Linhora
- [ ] Tell Junior where the Linhora repo is so its notes can be drafted (Isaac).
- [ ] Confirm whether Lingora (repo UndeifyIT/Lingora) is the same project as Linhora, so [[Lingora Market Validation]] can move out of the Inbox (Isaac).
- [ ] Lingora: pick a new name and run a trademark search before any brand spend; 12+ App Store apps are already called "Lingora" (Isaac). See [[Lingora Market Validation]].
- [ ] Lingora: hire a native Yorùbá linguist to QA every string and tone mark; the prototype spells its first greeting two ways (Isaac, Tolu).
- [ ] Lingora: fix the validation sprint gates and its start date (Isaac). The sprint and proposed gates are in the repo's `docs/roadmap.md` stage 3; no production code until they pass.
- [ ] Lingora: check that Apple can pay Undeify's bank (search the bank in App Store Connect) and get a D-U-N-S number before Apple enrolment (Isaac). See roadmap stage 12.
- [ ] Lingora: pick ONE launch buyer (research recommends diaspora parents on a family plan) and decide the language order after Yorùbá (research recommends Igbo → Twi, not Hausa or Swahili/Zulu) (Isaac).
- [ ] Lingora legal reminder (Junior raises this at the start of every Lingora session until done): 53 legal items are tracked in the repo's `docs/legal/legal-action-list.md` (UndeifyIT/Lingora). Before the validation sprint (marked V): privacy notice and terms live before the waitlist collects emails, NDPC registration past 200 sign-ups, company and tax ID checks, USD account and Apple payout check, D-U-N-S and store accounts, ARCON and marketing-email questions, refund policy, tax on web checkout (merchant of record such as Polar, or UK VAT registration before the first sale; item 53) (Isaac, lawyer, accountant).
- [ ] Lingora: engage a lawyer before the build (Isaac). Top question: NDPA s.2(2)(a) covers processing by any controller domiciled in Nigeria, so on a literal reading Nigeria's under-18 rules (verified parental consent, s.31) may apply to all Lingora users, including UK and US children and teens; also whether a separate non-Nigerian company as controller would change that (with an accountant), plus the full list in the repo's `docs/open-questions.md`.
- [ ] Lingora: get the Spitch partnership terms (pricing, accuracy on learner speech) in writing before designing the free tier (Isaac).

### Completed Tasks
- [x] 2026-10-06: Lingora `research/` is in the repo (committed in 5d9830a and cb4fd26, verified with git log).
- [x] 2026-09-28: ShiftOS repo made private after the audit was pushed to it (verified 00:35). Batch 5 live checks written into the audit folder.
- [x] 2026-09-27: ShiftOS production-readiness audit complete — all 4 batches, all 36 checklist sections. 1 Critical, 9 High, 24 Medium, 18 Low. Output in repo `audit/2026-09-27-production-readiness/`. Nothing applied.
- [x] 2026-09-26: vault pushed to the private repo UndeifyIT/MemoryVault.