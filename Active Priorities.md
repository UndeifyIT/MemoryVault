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

#### MindBridge
- [ ] [[MindBridge]] is our most important project. Tell Junior where its repo is so its notes can be drafted, and record its context, status and next steps (Isaac).

#### BakeFlow
- [ ] Confirm or correct the BakeFlow Status and Architecture drafts (Isaac). See [[BakeFlow Status]].

#### ShiftOS
- [ ] Confirm or correct the ShiftOS Status and Architecture drafts (Isaac). See [[ShiftOS Status]].
- [ ] Review the Batch 1 audit findings and approve fixes by ID (Isaac). The Critical invitation-takeover fix (C1+H1) comes first. Files: repo `audit/2026-09-27-production-readiness/`. See [[ShiftOS Log]].
- [ ] Run dashboard checks 1–6 listed in findings.md (Isaac or Tolu).
- [ ] Decide whether `UndeifyIT/ShiftOS` should be public; if not, make it private and protect `main` (Isaac). It is public today, and the audit's C1 exploit path is readable in its migrations. Never commit the `audit/` folder while it is public. See finding H4.
- [ ] Review the Batch 2 findings (H4–H6, M6–M11, L6–L9) and run dashboard checks 7–10 at the end of findings.md (Isaac). Check first whether `OPENAI_API_KEY` is set on Render and whether OpenAI has a budget cap (H5).
- [ ] Batches 3–4 of the production-readiness audit (Junior).

#### Linhora
- [ ] Tell Junior where the Linhora repo is so its notes can be drafted (Isaac).

### Completed Tasks
- [x] 2026-09-26: vault pushed to the private repo UndeifyIT/MemoryVault.