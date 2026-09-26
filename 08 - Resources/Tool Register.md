---
status: active
project: meta
type: reference
author: junior
created: 2026-09-26
updated: 2026-09-26
---
# Tool Register

Every tool, integration and subscription Undeify uses, what it costs, who owns it, and what it can touch. It is also the budget note: funds are tight, so Junior checks any new tool against this before suggesting it.

Never put a password, key or token in this note. "Credentials live in" names the place (a password-manager item), never the value. Facts not yet recorded say "Not recorded yet". Isaac fills in the costs.

## Budget
- **Monthly tool budget:** Not recorded yet.
- **Total monthly spend:** Not recorded yet (sum of the table below).
- **Cash runway:** Not recorded yet.
- **Rule:** Junior suggests free or cheap options first, and never recommends anything paid without stating the cost and asking.

## Register

| Tool | Used for | Monthly cost | Owner | Access it has | Credentials live in | Status |
|---|---|---|---|---|---|---|
| Claude (Code and plan) | Coding and Junior | Not recorded yet | Isaac, Tolu | Their machines and connected accounts | Their Claude accounts | In use |
| Obsidian | Viewing the vault | Free | Each person | Local vault folder | none | In use |
| GitHub | Code and the vault repo | Not recorded yet | Isaac | Repos and org access | Not recorded yet | In use; the vault lives in the private repo UndeifyIT/MemoryVault |
| Supabase (BakeFlow, ShiftOS live projects) | Database, auth, storage | Not recorded yet | Isaac | Production data | Not recorded yet | In use |
| Resend (BakeFlow invite emails) | Transactional email | Not recorded yet | Isaac | Sends email from the app | Supabase secrets | In use, per repo docs |
| Expo and EAS (BakeFlow push) | Mobile builds and push | Not recorded yet | Isaac | Expo account | Not recorded yet | Push credentials not yet set up |
| context7 | Up-to-date library docs | Free | Each person | Sends doc-lookup queries to Upstash; no code | none | In the kit |
| Playwright MCP | Browser testing | Free | Each person | Controls a local browser | none | In the kit |
| superpowers, code-review, security-guidance | Debugging, review, security | Free (uses Claude tokens) | Each person | Run inside Claude | none | In the kit |
| jaredrhod-marketing skill | Marketing playbook | Free (CC BY-SA 4.0) | Each person | Read-only markdown | none | In the kit |
| Gmail (claude.ai connector) | Reading and drafting email | Free | Isaac | Mailbox access | His Google account | Connected on Isaac's account |
| Composio | Connecting other apps through one MCP server | Not recorded yet | Isaac | Whatever apps are connected to it | Password manager | Planned; see [[Onboarding]] |

## Monthly review
On the 1st of each month Junior checks the register against real invoices and accounts: remove anything unused, confirm each owner is still right, confirm what access each tool has, and list any key due for rotation. Record the result as a line in that month's daily note.

## Change log
- 2026-09-26, Junior for Isaac: first version.
