---
status: active
project: meta
type: reference
author: junior
created: 2026-09-26
updated: 2026-09-26
---
# Security Register

Undeify's running record of security risks, findings and incidents, plus the incident-response runbook and the recurring checks. Junior owns it as CISO. Never write a secret value here; name where it lives.

## 1. Open risks

Severity is Junior's judgment (low, medium, high). "From repo docs" means it comes from a project's own documents and Junior has not verified it.

| ID | Project | Risk | Severity | Owner | Next step |
|---|---|---|---|---|---|
| SR-001 | Vault | Resolved 2026-09-26: the vault is pushed to the private repo UndeifyIT/MemoryVault. Remaining: add Tolu as a collaborator, and turn on multi-factor sign-in and branch protection for the org. | Low | Isaac | Add Tolu; enable MFA for everyone in the org. |
| SR-002 | Kit | The Playwright MCP server runs `npx @playwright/mcp@latest`, so each start fetches the newest version. Accepted for now. | Low | Isaac | Pin a version if it ever matters. |
| SR-003 | BakeFlow | `has_permission()` gates 0 of 109 RLS policies; role checks are authoritative and the permission keys are effectively client-side (repo TD-001). | Medium | Isaac | Decide whether to accept it or migrate. From repo docs. |
| SR-004 | BakeFlow | Committed migrations don't match the versions recorded on the live database, so the repo can't rebuild production. | Medium | Isaac | Reconcile per the repo's `docs/PROJECT-OVERVIEW.md`. From repo docs. |
| SR-005 | ShiftOS | Real Supabase JWT verification for the newly built operations was not tested at the HTTP layer. | Medium | Isaac, Tolu | Test with a real session. From repo audit. |
| SR-006 | Team | Composio (planned) would hold OAuth access to every connected account, which makes it one high-value target. | Medium | Isaac | Follow the least-privilege steps in [[Onboarding]] before connecting apps. The injection gate marks any Composio call as external content and asks before risky follow-up actions. |
| SR-008 | Kit | Junior's hooks fail open if `sh`, `gawk` or the hook files are missing on a machine (a hook that cannot run is a non-blocking error). | Medium | Junior | `vault-check.sh --doctor` runs each hook with a test payload; onboard.ps1 runs it after install. Run it monthly and after any Git or Claude update. |
| SR-009 | Kit | The prompt-injection gate (taint hooks) is a speed bump: it asks before risky actions after an email, chat or web read, but a determined injection can still shape a request the user approves. Read-only connector scopes are the real defence. | Medium | Isaac | Keep Composio and Gmail scopes read-only until needed; confirm every `ask`; test the gate with the seeded email in [[Junior Checks]]. Whether an `ask` prompts under every permission mode is unverified. Self-review 2026-09-26 closed five bypasses (an escaped quote hiding a chained command, a single `&`, a newline, the PowerShell tool and WebFetch were not covered); `kit/junior-gate.test.sh` now guards them. |
| SR-010 | Kit | Model or behaviour drift: Junior's rules are plain text and a new Claude version may follow them differently. | Medium | Isaac | Run [[Junior Checks]] after every model change and kit bump. |
| SR-011 | Team | Configuration drift between machines: skills, hooks and boot file are copies, and plugins auto-update. | Low | Isaac | Kit `VERSION` stamp; `load junior` prints one line when a machine is behind; re-run onboard.ps1. |
| SR-012 | Vault | GitHub is the only copy people rely on. | Medium | Isaac | `vault-backup.sh` writes a verified bundle outside GitHub; keep one off-machine, and run the restore drill monthly. |
| SR-007 | Repos | The vault's secret scan covers only the vault. Project repos have no scan unless a hook is installed. | Medium | Junior | Install the local guard hook per repo (see [[Onboarding]]). Done for the BakeFlow repo on Isaac's machine, 2026-09-26. The ShiftOS copy became a real clone on 2026-09-27 and still has no guard hook installed. |

## 2. Findings and incidents
Append-only, newest last. One line each: `date | project | what was found or happened | severity | status | link to the fix`.

2026-09-26 | Vault | Register created with the seven open risks above | n/a | open | none
2026-09-26 | Vault | Vault pushed to private repo UndeifyIT/MemoryVault after a secret scan of all history found nothing | n/a | closed | SR-001
2026-09-28 | ShiftOS | Full production-readiness audit (C1 invitation takeover and H8 leave-reading steps included) committed to public repo UndeifyIT/ShiftOS as `1f2c19c` at 00:11, by the isaaCecurity account. Found ~6 min later; 0 forks/stars/watchers at that point | high | open: repo still public | make repo private; then fix C1 first
2026-09-28 | ShiftOS | Incident above contained: repo made private by Isaac, verified 00:35 (GitHub returns 404 unauthenticated). Window ~00:11–00:35. C1 now treated as public knowledge | high | contained | fix C1 first (audit I1)
2026-09-28 | ShiftOS | Live DB check: `anon` can SELECT and INSERT `security_events` rows with null organization_id (2 rows exposed, each with a signup IP); any org member can INSERT and SELECT `audit_logs` via REST; `anon`/`authenticated` hold DELETE/UPDATE/TRUNCATE on `audit_logs` | high | open, draft | 2026-09-28 daily note

## 3. Incident-response runbook
Use it for a leaked secret, a suspected breach, a compromised account or a data exposure.
1. **Contain first.** Revoke or rotate the exposed key or token, sign out sessions, disable the account or feature. Don't wait to understand it fully.
2. **Preserve evidence.** Note the time, what was exposed, where, and who saw it. Don't delete logs.
3. **Assess.** What data or access was reachable, for how long, and was it used? Check the provider's logs (Supabase, GitHub, Google).
4. **Fix the cause.** Close the hole, then rotate anything that shared the same secret or trust.
5. **Notify.** Tell the other founder immediately. If customer or user personal data may be involved, get advice on notifying users and the regulator. Nigeria's data-protection law is understood to set a 72-hour window for notifying the regulator after a breach. Unverified: confirm with a lawyer before relying on it.
6. **Record.** Add the line in section 2, update the risk table, and save the lesson as a note per the Memory Standard.

## 4. Recurring checks
- **Weekly:** review open risks; run the dependency audit for each project (`npm audit` or `pnpm audit`); confirm the vault is pushed.
- **Monthly:** run the Tool Register review (access, owners, keys due for rotation); run `vault-check.sh --doctor`; write a backup with `vault-backup.sh` and do the **restore drill** (clone the newest bundle into an empty folder, open it, and run `load junior` from that copy); confirm multi-factor sign-in is still on for the GitHub org and every connected account.
- **Before each release:** run the security review (security-guidance, and claude-security or semgrep if installed) and re-check the open risks for that project.

## Change log
- 2026-09-26, Junior for Isaac: first version.
