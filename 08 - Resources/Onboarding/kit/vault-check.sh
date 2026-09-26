#!/bin/sh
# vault-check: mechanical facts about the Undeify vault. No model involved; Junior turns the facts into proposals.
#
#   --startup       run at `load junior`. Prints NOTHING when all is well, otherwise at most 6 short lines.
#                   A tripped check repeats only when it gets worse or after SNOOZE_DAYS, so it never nags.
#   --report        full numbers, for the weekly review.
#   --precommit     warnings only (never blocks) about the staged notes: names, links, paths, front matter.
#   --doctor        verify the tools and every Junior hook actually run on this machine.
#   --note-kill [reason]   record a `kill junior` in the per-machine friction log.
#
# POSIX sh + gawk + git (Git for Windows has all three). The work is done in one awk process
# (vault-check.awk) because process spawns are slow on Windows. Tune the limits below.

STATUS_MAX=80; ARCH_MAX=120; NOTE_MAX=200; LOG_MAX=300
PRIORITIES_MAX=10; NOTES_MAX=120
STALE_DAYS=7; DRAFT_DAYS=7; SNOOZE_DAYS=3; WEEKLY_DAYS=7; BACKUP_DAYS=14
STARTUP_BYTES_MAX=24000

mode=${1:---startup}
p=$0; case $p in *\\*) p=$(printf '%s' "$p" | tr '\\' '/') ;; esac
here=${p%/*}; [ "$here" = "$p" ] && here=.
cd "$here" || exit 0; here=$PWD
if [ -n "$JUNIOR_VAULT" ]; then VAULT=$JUNIOR_VAULT; else cd ../../.. || exit 0; VAULT=$PWD; fi
CLAUDE_HOME=${JUNIOR_CLAUDE_HOME:-$HOME/.claude}
STATE_DIR=$CLAUDE_HOME/junior-state
[ -d "$STATE_DIR" ] || mkdir -p "$STATE_DIR" 2>/dev/null

# ---------- --note-kill (needs no vault) ----------
if [ "$mode" = "--note-kill" ]; then
  echo "$(date +%F) ${2:-no reason given}" >> "$STATE_DIR/kills.log"
  exit 0
fi

# ---------- --doctor (needs no vault) ----------
if [ "$mode" = "--doctor" ]; then
  bad=0; hd=$CLAUDE_HOME/hooks
  for t in sh grep sed awk wc cat find git date mktemp; do
    if command -v "$t" >/dev/null 2>&1; then echo "ok    $t"; else echo "FAIL  $t is not on PATH; Junior's hooks will not run here"; bad=1; fi
  done
  if awk 'BEGIN{ if (systime() > 0 && mktime("2026 01 01 12 00 00") > 0) exit 0; exit 1 }' 2>/dev/null; then echo "ok    gawk (systime, mktime)"; else echo "FAIL  awk is not gawk; vault-check cannot run (install Git for Windows or gawk)"; bad=1; fi
  for h in junior-read-guard.sh junior-taint-mark.sh junior-taint-gate.sh junior-taint-clear.sh; do
    if [ -f "$hd/$h" ]; then echo "ok    hook file $h"; else echo "FAIL  hook file $h is missing (run onboard.ps1)"; bad=1; fi
  done
  if [ -f "$hd/junior-taint-mark.sh" ] && [ -f "$hd/junior-taint-gate.sh" ]; then
    sid="doctor$$"
    printf '{"session_id":"%s","tool_name":"mcp__claude_ai_Gmail__search_threads","tool_input":{}}' "$sid" | JUNIOR_CLAUDE_HOME=$CLAUDE_HOME sh "$hd/junior-taint-mark.sh" >/dev/null 2>&1
    r=$(printf '{"session_id":"%s","tool_name":"Write","tool_input":{"file_path":"x.md"}}' "$sid" | JUNIOR_CLAUDE_HOME=$CLAUDE_HOME sh "$hd/junior-taint-gate.sh" 2>/dev/null)
    rm -f "$CLAUDE_HOME/junior-taint/$sid"
    case "$r" in
      *'"ask"'*) echo "ok    injection gate answers ask after an email read" ;;
      *) echo "FAIL  injection gate did not answer ask, so it is INACTIVE"; bad=1 ;;
    esac
  fi
  for n in junior-read-guard junior-taint-mark junior-taint-gate junior-taint-clear junior-handoff-nudge; do
    if grep -q "$n" "$CLAUDE_HOME/settings.json" 2>/dev/null; then echo "ok    settings.json wires $n"; else echo "FAIL  settings.json does not wire $n (run onboard.ps1)"; bad=1; fi
  done
  if [ "$bad" = 0 ]; then echo "Doctor: everything Junior needs is in place."; else echo "Doctor: fix the FAIL lines; the hook behind each one is inactive."; fi
  exit 0
fi

cd "$VAULT" 2>/dev/null || { echo "vault-check: cannot find the vault at $VAULT" >&2; exit 0; }
[ -d .git ] || { echo "vault-check: $VAULT is not a git repo" >&2; exit 0; }

T=${TMPDIR:-/tmp}/vault-check.$$
git ls-files '*.md' > "$T.all" 2>/dev/null
if [ "$mode" = "--precommit" ]; then
  git diff --cached --name-only --diff-filter=ACMR 2>/dev/null | grep '\.md$' > "$T.scan"
  : > "$T.st"; : > "$T.log"
else
  cp "$T.all" "$T.scan" 2>/dev/null || cat "$T.all" > "$T.scan"
  git status --porcelain -b > "$T.st" 2>/dev/null
  git log --name-only --format='#%cs' -n 400 > "$T.log" 2>/dev/null
fi
[ -s "$T.scan" ] || { rm -f "$T".*; exit 0; }

m=${mode#--}
awk -f "$here/vault-check.awk" -v mode="$m" -v vault="$VAULT" -v home="$HOME" -v claude="$CLAUDE_HOME" \
  -v kitdir="$here" -v statedir="$STATE_DIR" -v state="$STATE_DIR/state" \
  -v stfile="$T.st" -v logfile="$T.log" -v allfile="$T.all" -v scanfile="$T.scan" \
  -v statusmax=$STATUS_MAX -v archmax=$ARCH_MAX -v notemax=$NOTE_MAX -v logmax=$LOG_MAX \
  -v priomax=$PRIORITIES_MAX -v notesmax=$NOTES_MAX -v stale=$STALE_DAYS -v draftdays=$DRAFT_DAYS \
  -v snooze=$SNOOZE_DAYS -v weeklydays=$WEEKLY_DAYS -v budget=$STARTUP_BYTES_MAX > "$T.out" 2>/dev/null

weekly=0
while IFS= read -r line; do
  if [ "$line" = "@weekly" ]; then weekly=1; else echo "$line"; fi
done < "$T.out"

# weekly extras that need another program: secrets in tracked notes, and the age of the outside-GitHub backup
pre=""; [ "$mode" = "--report" ] && pre="  - "
if [ "$weekly" = 1 ]; then
  if git grep -qEI -e 'AKIA[0-9A-Z]{16}|-----BEGIN ([A-Z]+ )?PRIVATE KEY-----|gh[pousr]_[A-Za-z0-9]{30,}|xox[baprs]-[A-Za-z0-9-]{10,}|sk_(live|test)_[A-Za-z0-9]{16,}|sk-ant-[A-Za-z0-9_-]{20,}' -- . ':(exclude).githooks' ':(exclude)08 - Resources/Onboarding' 2>/dev/null; then
    echo "${pre}Possible secret in a tracked note. Run the incident runbook."
  fi
  newest=""
  for f in "$HOME"/Backups/UndeifyVault/undeify-vault-*.bundle; do
    [ -f "$f" ] || continue
    if [ -z "$newest" ] || [ "$f" -nt "$newest" ]; then newest=$f; fi
  done
  if [ -z "$newest" ]; then
    echo "${pre}No vault backup outside GitHub yet. Run vault-backup.sh."
  elif [ -n "$(find "$newest" -mtime +$BACKUP_DAYS 2>/dev/null)" ]; then
    echo "${pre}The newest vault backup is more than $BACKUP_DAYS days old. Run vault-backup.sh."
  fi
fi
rm -f "$T".*
exit 0
