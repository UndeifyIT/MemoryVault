---
status: active
project: meta
type: plan
---
# Active Priorities

The single queue of open work across everything. Tag each item with its project where it isn't obvious. Add an item when work is parked; delete it when it's actually done (don't let it rot). This is the system of record for "what's still open" — a daily note's "In Progress" is a frozen snapshot that goes stale the moment something closes, so never treat an old daily note's open items as current truth.

### Open Tasks
- [ ] Marketing and strategy: build a plan Isaac and Tolu can run themselves, since neither is strong here. See [[Low-Budget Marketing Plan]].
- [ ] Budget constraint: funds are tight, so no paid ads for now. Every marketing and tooling suggestion starts with free or cheap options.
- [ ] Awareness: grow Undeify's presence on social media platforms organically.
- [ ] Coding efficiency: adopt loop engineering and graph engineering to save time. See [[Coding and Feature Work]].
- [ ] [[MindBridge]]: our most important project. Record its context, status, and next steps here once Isaac has added them.
- [ ] Add Tolu to the private repo UndeifyIT/MemoryVault and turn on multi-factor sign-in for the org (Isaac). See [[Security Register]] SR-001.
- [ ] Fill in the costs, budget and runway in [[Tool Register]] (Isaac).
- [ ] Set up Composio for connecting apps, with least-privilege access (Isaac). Steps are in [[Onboarding]].
- [ ] Confirm or correct the BakeFlow Status and Architecture drafts (Isaac). ShiftOS's were rewritten from the real repo on 2026-09-28.
- [ ] ShiftOS: merge or close `feat/staff-and-admin-handoff` — its migration 074 is already live in the database but not on `main` (Tolu). See [[ShiftOS Status]].
- [ ] ShiftOS: add every committer to the Vercel team, or have them commit with their Vercel email, so production deploys stop getting blocked (Isaac).
- [ ] ShiftOS launch blocker: connect a custom SMTP provider in Supabase Auth so verification emails reach real customers (Isaac). See [[ShiftOS Status]].
- [ ] ShiftOS: brand the Google sign-in consent screen so it doesn't show the raw Supabase address (Isaac).
- [ ] ShiftOS: work through `audit/2026-09-27-production-readiness/fixes.md` in the repo (Isaac).
- [ ] Vault sync broken on this machine: `git pull` on UndeifyIT/MemoryVault answers "Repository not found", so this machine's GitHub login can't reach the private repo. Commits here stay local until that's fixed (Isaac).
- [ ] Tell Junior where the MindBridge and Linhora repos are so their notes can be drafted (Isaac).

### Completed Tasks
- [x] 2026-09-26: vault pushed to the private repo UndeifyIT/MemoryVault.
