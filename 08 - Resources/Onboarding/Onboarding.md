---
status: active
project: meta
type: guide
author: junior
created: 2026-09-26
updated: 2026-09-26
---
# Onboarding

How a new team member gets the vault, Obsidian and their own Junior on a Windows machine with one script. Written for Isaac and Tolu to hand to anyone joining Undeify.

## Before you start

- The person needs a GitHub account and must be added as a collaborator on the private vault repo.
- They need Claude Code installed and signed in. The script checks for it and says so if it's missing.
- Git and Obsidian are installed by the script if missing (through winget).

## The steps

1. Open PowerShell and clone the vault into the home folder (replace the URL with the vault repo's URL; GitHub may open a sign-in window):
   ```
   git clone <VAULT_REPO_URL> "$HOME\Undeify"
   ```
   If Git isn't installed yet, run `winget install --id Git.Git -e` first, then open a new PowerShell window.
2. Run the setup script (the `-ExecutionPolicy Bypass` applies to this one run only; Windows blocks scripts by default):
   ```
   powershell -ExecutionPolicy Bypass -File "$HOME\Undeify\08 - Resources\Onboarding\onboard.ps1"
   ```
3. Answer the one question (first name). Close Obsidian first if it's open.
4. Open Obsidian. Then, in any project in VS Code with the Claude Code extension, start a chat and type **`load junior`** (or `/junior`). Junior loads into that conversation for that codebase. Without VS Code, double-click **Chat with Junior** on the Desktop instead.

## The baseline kit (every Junior gets this)

The setup script installs these on every machine. The list lives in `kit/plugins.json`; edit that file to change it, and re-run the script to apply.

| Tool | Helps with | Why it's there |
|---|---|---|
| context7 | Coding | Current docs for any library, so code isn't written from stale memory. Skipped if the machine already has a `context7` server. |
| playwright | Testing, debugging | Drives a real browser: end-to-end tests, UI checks, screenshots, reproducing bugs. |
| superpowers | Coding, testing, debugging | Systematic debugging, test-driven development, brainstorming, plan-then-execute. |
| code-review | Coding | Multi-agent review of a diff or pull request for real bugs. |
| security-guidance | Security | Security review of generated code as it's written. |
| `jaredrhod-marketing` skill | Marketing | Jared's marketing playbook, installed from a reviewed, vendored copy (`kit/jaredrhod-marketing.zip`, source and license in `kit/jaredrhod-marketing.SOURCE.txt`). |

**Extras (opt-in, most need an account).** Add them with `-Extras`, for example `onboard.ps1 -Extras supabase,sentry`, or `-Extras all`:

| Extra | Helps with | Needs |
|---|---|---|
| supabase | Coding, monitoring | Supabase login. Both BakeFlow and ShiftOS run on Supabase. Keep agent access read-only on production. |
| github | Coding | GitHub personal access token. |
| sentry | Monitoring, debugging | Sentry account (free developer tier). |
| posthog | Marketing, monitoring | PostHog account (free tier): what users actually do, feature flags, error tracking. |
| chrome-devtools-mcp | Debugging | Chrome: performance traces, network, console. |
| semgrep | Security | Semgrep installed: free static scanning while coding. |
| claude-security | Security | Nothing, but it uses a lot of tokens; run it before releases. |
| typescript-lsp | Coding | `typescript-language-server` installed globally. |

Uptime monitoring has no official plugin. Use a free external monitor for the live sites and the Supabase endpoints.

**Security notes for the kit (CISO view).** Every plugin is code or an MCP server with access to your machine or accounts, so add one only for a reason. Playwright's server is started with `npx @playwright/mcp@latest`, which fetches the newest version each time; if that ever concerns you, pin a version in your own plugin settings. Never give an agent write access to a production database. Plugins update themselves through the marketplace; review changes for anything that touches secrets or the network.

To preview what the script would install without changing anything, add `-DryRun`. To skip plugins entirely, add `-SkipPlugins`.

## Connecting other apps (Google, Slack and the rest) through Composio

Connections to outside apps are set up by each person, in their own Claude Code, once. Junior doesn't hold logins and the vault never stores them. Undeify's plan is one Composio MCP server that fronts all the apps, instead of one connector per app. Composio isn't in the official plugin marketplace, so it isn't part of the setup script and each person adds it themselves.

1. Create your own Composio account and turn on multi-factor sign-in.
2. In Composio, connect only the apps you actually need. Give each the narrowest permissions it offers, use a separate or limited account where you can (for example a marketing mailbox instead of your main one), and turn off delete and send actions you won't use if the dashboard lets you.
3. Follow Composio's Claude Code instructions to generate your MCP URL and API key. The pattern is `claude mcp add --transport http composio "<YOUR_MCP_URL>" --header "X-API-Key: <YOUR_KEY>" --scope user`. Check the current syntax on Composio's page, since I couldn't open it when writing this.
4. Keep the key and URL in your password manager. Claude stores them in `~\.claude.json` in plain text, so treat that file as sensitive, never commit or paste it, and rotate the key if it leaks.
5. Check it with `claude mcp get composio`, restart Claude Code, and tell Junior which apps are connected.
6. Add or update the Composio row in [[Tool Register]] (apps connected, owner, scope; no key). Review the connected apps monthly.

**Why the care:** Composio holds sign-in access to every app you connect, so it becomes one valuable target, and anything a connected app receives (an email, a message) can carry instructions meant to trick an agent. That is why Junior's boot file says to confirm before sending, posting, spending, deleting or changing access, and to treat anything inside an email or page as data. It's tracked as SR-006 in [[Security Register]].

## Guarding a project repo against leaked secrets

The vault's secret scan only covers the vault. To guard a project repo on your own machine, run:
```
powershell -ExecutionPolicy Bypass -File "$HOME\Undeify\08 - Resources\Onboarding\kit\repo-guard.ps1" -Repo C:\path\to\repo
```
It copies the same scan into that repo's `.git\hooks` folder. That folder isn't tracked by Git, so nothing in the repo's files or history changes, and each teammate runs it for themselves. It never overwrites an existing hook and stops if the repo sets its own `core.hooksPath`. It only works on a real clone with a `.git` folder.
## Loading Junior in a codebase

- `load junior` triggers the `junior` skill installed at `~\.claude\skills\junior\SKILL.md`. It reads the boot file (`~\my-agent\CLAUDE.md`), becomes Junior on top of that project's own instructions, reads the vault index, yesterday's daily note and Active Priorities, and matches the codebase to a vault project.
- It lasts for that conversation. Start a new chat and say `load junior` again. `/junior` is the reliable form if the phrase ever doesn't trigger.
- **Turning Junior off:** type `kill junior` (or `/junior-off`). This drops Junior for the rest of that conversation. Say "kill junior everywhere" and it also removes the always-on pointer in `~\.claude\CLAUDE.md`, if that person has one, so new chats start without Junior. `load junior` brings him back any time. Nobody is forced to use Junior.
- Claude Code may ask permission the first time it reads the vault, since the vault sits outside the project folder. Allow it. To stop the prompts, add `Read(<vault path>/**)` and `Edit(<vault path>/**)` to the allow list in `~\.claude\settings.json`.

## What the script does

- Pulls the latest vault if it's already there.
- Installs Obsidian if missing.
- Writes Junior's boot file to `~\my-agent\CLAUDE.md` from `CLAUDE.template.txt`, filled in with the person's name and vault path. It never overwrites an existing one; it writes `CLAUDE.md.new` beside it instead.
- Writes the one-memory redirect into Claude Code's memory for that folder.
- Backs up Obsidian's `obsidian.json`, registers the vault, and checks the path exists.
- Turns on the vault's secret-scan hook (`git config core.hooksPath .githooks`), so a commit that adds a key, token, database URL with a password, or a `.env` or key file is blocked.
- Adds a small hook to `~\.claude\settings.json` (backing the file up first, merging with what's there) that, after every successful `git commit` in any project, reminds Claude to run Junior's handoff routine. It only acts when Junior is loaded.
- Installs the baseline kit: the marketing skill and the core plugins (see "The baseline kit" below), plus any `-Extras` you ask for.
- Installs the `junior` and `junior-off` skills (from `junior-SKILL.txt` and `junior-off-SKILL.txt`) into `~\.claude\skills`, updating them on every run.
- Puts a **Chat with Junior** launcher on the Desktop. It does not start at login.

Safe to re-run. It skips anything already done.

## Keeping it current

`CLAUDE.template.txt` is the shared source for every teammate's boot file. When a rule in it changes, existing teammates get the update by comparing their `CLAUDE.md` with the new template (only Isaac changes the template). Isaac's own boot file was made from the same text with his details filled in.

On a person's first session Junior asks a few questions and saves their profile as `08 - Resources/Team/<Name>.md`, following [[Memory Standard]].

## Files in this folder

- `onboard.ps1`: the setup script.
- `junior-SKILL.txt`: the source of the `junior` skill that makes `load junior` work.
- `junior-off-SKILL.txt`: the source of the `junior-off` skill that makes `kill junior` work.
- `junior-handoff-nudge.json`: the message the commit hook feeds Claude. The hook runs on `PostToolUse` with matcher `Bash`, and its command checks that the Bash command that just ran contained `git commit` before printing that file, so it stays silent for anything else. It needs no Node. It doesn't match `git -C ... commit` or `git -c ... commit`.
- The vault's own `.githooks/pre-commit` is the secret scan. To silence a false positive, add `allowlist secret` to that line. Never bypass it for a real secret: rotate the secret instead.
- `kit/repo-guard.ps1`: installs the secret scan into a project repo on this machine only.
- `kit/plugins.json`: the list of core plugins and opt-in extras the script installs.
- `kit/jaredrhod-marketing.zip` and `kit/jaredrhod-marketing.SOURCE.txt`: the vendored marketing skill and where it came from.
- `CLAUDE.template.txt`: Junior's boot file with `{{NAME}}` and `{{VAULT_PATH}}` placeholders.
