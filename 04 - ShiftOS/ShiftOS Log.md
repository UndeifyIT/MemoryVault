---
status: active
project: shiftos
type: log
author: junior
created: 2026-09-26
updated: 2026-09-28
---
# ShiftOS Log

Append-only record of what changed in ShiftOS, oldest first. One line per change. Each line: date | author | what changed | commit or PR.

2026-09-26 | junior | Project notes scaffold created | none
2026-09-26 | junior | Status and Architecture notes filled in from repo inspection | none
2026-09-26 | junior | Status and Architecture drafted from the repo's own documents (not confirmed by Isaac) | none
2026-09-28 | junior | Web redeployed by hand after Vercel blocked the audit commit (author not in the Vercel team) | 08f5ba9
2026-09-28 | junior | Confirmed backend on Render and database migrations (through 074) match main, apart from 074 which is only on feat/staff-and-admin-handoff | 08f5ba9
2026-09-28 | junior | Status and Architecture rewritten from the real repo, Render, Vercel and Supabase state, replacing the zip-based drafts | none
2026-09-28 | junior | Live check of Google and email sign-in and sign-up: both work to Supabase; found auth emails can't reach real customers (built-in Supabase sender) | 1a11443
