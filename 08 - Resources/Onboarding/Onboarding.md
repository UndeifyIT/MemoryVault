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
- `CLAUDE.template.txt`: Junior's boot file with `{{NAME}}` and `{{VAULT_PATH}}` placeholders.
