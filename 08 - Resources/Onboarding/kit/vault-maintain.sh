#!/bin/sh
# vault-maintain: approval-gated upkeep of the two things that grow without limit: project Logs and the
# completed items in Active Priorities. Deterministic (no model edits the files) and it never pushes without approval.
#
#   propose             build the proposal in a separate git worktree on a local branch. Your working copy is not
#                       touched and nothing is pushed. Prints what would move and a patch id.
#   apply <patch-id>    after the human says "lock it": merge the approved proposal and push (never a force push).
#   discard             throw the pending proposal away.
#   status              show the pending proposal, if any.
#
# Only these two rotations are automated. Splitting Status or Architecture notes is advice, never automatic,
# so "Where we stopped" text cannot be lost. Needs POSIX sh, awk, git.

LOG_MAX=300; LOG_KEEP=100; DONE_MAX=10; DONE_KEEP=5; EXPIRE_DAYS=7

cmd=${1:-status}
p=$0; case $p in *\\*) p=$(printf '%s' "$p" | tr '\\' '/') ;; esac
here=${p%/*}; [ "$here" = "$p" ] && here=.
cd "$here" || exit 1; here=$PWD
if [ -n "$JUNIOR_VAULT" ]; then VAULT=$JUNIOR_VAULT; else cd ../../.. || exit 1; VAULT=$PWD; fi
CLAUDE_HOME=${JUNIOR_CLAUDE_HOME:-$HOME/.claude}
STATE_DIR=$CLAUDE_HOME/junior-state
REC=$STATE_DIR/maint.rec
[ -d "$STATE_DIR" ] || mkdir -p "$STATE_DIR"
cd "$VAULT" || exit 1
[ -d .git ] || { echo "Not a git repo: $VAULT"; exit 1; }

T=${TMPDIR:-/tmp}/vault-maintain.$$
trap 'rm -f "$T".*' EXIT
today=$(date +%Y-%m-%d); stamp8=$(date +%Y%m%d)

recget() { sed -n "s/^$1=//p" "$REC" 2>/dev/null | tail -1; }
ident() { # export a commit identity: the repo's own if set, else a neutral one
  n=$(git config user.name); e=$(git config user.email)
  export GIT_AUTHOR_NAME=${n:-Junior} GIT_COMMITTER_NAME=${n:-Junior}
  export GIT_AUTHOR_EMAIL=${e:-junior@undeify.invalid} GIT_COMMITTER_EMAIL=${e:-junior@undeify.invalid}
}

show_status() {
  if [ -f "$REC" ]; then
    echo "Pending proposal: branch $(recget branch), patch id $(recget patch), created $(recget created_day). Files: $(recget files)"
    echo "Say \"lock it\" to apply (vault-maintain.sh apply $(recget patch)), or discard it."
  else echo "No pending proposal."; fi
}

uniq_archive() { # uniq_archive <worktree> <name>: a name whose note does not exist yet, so a same-day rotation never overwrites an archive
  n=$2; i=2
  while [ -e "$1/07 - Archive/$n.md" ]; do n="$2 $i"; i=$((i+1)); done
  printf '%s' "$n"
}

sync_state() { # sets ahead/behind against the upstream after a fetch
  git fetch -q 2>/dev/null || echo "note: could not reach origin, using the last fetch"
  ab=$(git rev-list --left-right --count 'HEAD...@{u}' 2>/dev/null) || { echo "No upstream branch set."; return 1; }
  ahead=${ab%%[[:space:]]*}; behind=${ab##*[[:space:]]}
}

frontmatter() { # status project type
  printf -- '---\nstatus: %s\nproject: %s\ntype: %s\nauthor: junior\ncreated: %s\nupdated: %s\n---\n' "$1" "$2" "$3" "$today" "$today"
}

# rotate_log <worktree> <relative Log path>: writes the archive note and shortens the Log. Returns 1 if nothing to do.
rotate_log() {
  d=$1; f=$2; full="$d/$f"
  proj=$(basename "$f" " Log.md")
  slug=$(sed -n 's/^project: *//p' "$full" | head -1 | tr -d '\r')
  total=$(grep -c '^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] |' "$full")
  move=$(( total - LOG_KEEP ))
  [ "$move" -gt 0 ] || return 1
  : > "$T.pre"; : > "$T.mov"; : > "$T.kep"
  awk -v mv="$move" -v pre="$T.pre" -v mov="$T.mov" -v kep="$T.kep" '
    /^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] \|/ { started=1; n++ }
    !started { print > pre; next }
    { if (n <= mv) print > mov; else print > kep }' "$full"
  awk '/^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] \|/ { s=1 } s' "$full" > "$T.orig"
  cat "$T.mov" "$T.kep" > "$T.mk"
  cmp -s "$T.orig" "$T.mk" || { echo "Invariant failed for $f (moved + kept differs from the original). Nothing changed."; return 2; }
  an=$(uniq_archive "$d" "$proj Log archive $stamp8"); af="07 - Archive/$an.md"
  mkdir -p "$d/07 - Archive"
  { frontmatter archived "${slug:-meta}" log; printf '# %s\n\nEntries moved out of [[%s Log]] on %s to keep it short. Oldest first.\n\n' "$an" "$proj" "$today"; cat "$T.mov"; } > "$d/$af"
  { cat "$T.pre"; printf 'Older entries: [[%s]]\n' "$an"; cat "$T.kep"; } > "$full"
  first=$(head -1 "$T.mov" | cut -c1-10); lastd=$(tail -1 "$T.mov" | cut -c1-10)
  echo "  $proj Log: move the $move oldest entries ($first to $lastd) to \"$an\"; keep the newest $LOG_KEEP."
  ARCHIVES="$ARCHIVES$an|$proj Log entries $first to $lastd
"
  MOVED_FILES="$MOVED_FILES$f
$af
"
  return 0
}

# rotate_prio <worktree>: move older completed items out of Active Priorities. Newest completed items sit at the top.
rotate_prio() {
  d=$1; f="Active Priorities.md"; full="$d/$f"
  done_n=$(awk '/^### Completed Tasks/{s=1;next} /^### /{s=0} s&&/^- \[x\]/{c++} END{print c+0}' "$full")
  [ "$done_n" -gt "$DONE_MAX" ] || return 1
  : > "$T.pm"; : > "$T.pn"
  awk -v keep="$DONE_KEEP" -v mov="$T.pm" -v out="$T.pn" '
    /^### Completed Tasks/ { sec=1; print > out; next }
    sec && /^### / { sec=0 }
    sec && /^- \[x\]/ { c++; if (c > keep) { print > mov; next } }
    { print > out }' "$full"
  awk '/^### Completed Tasks/{s=1;next} /^### /{s=0} s&&/^- \[x\]/' "$full" > "$T.po"
  awk '/^### Completed Tasks/{s=1;next} /^### /{s=0} s&&/^- \[x\]/' "$T.pn" > "$T.pk"
  cat "$T.pk" "$T.pm" > "$T.pmk"
  cmp -s "$T.po" "$T.pmk" || { echo "Invariant failed for Active Priorities (moved + kept differs from the original). Nothing changed."; return 2; }
  an=$(uniq_archive "$d" "Completed Priorities $stamp8"); af="07 - Archive/$an.md"
  mkdir -p "$d/07 - Archive"
  { frontmatter archived meta log; printf '# %s\n\nCompleted items moved out of [[Active Priorities]] on %s. Newest first.\n\n' "$an" "$today"; cat "$T.pm"; } > "$d/$af"
  awk -v link="- Older completed items: [[$an]]" '{ print } /^### Completed Tasks/ { print link }' "$T.pn" > "$full"
  moved=$(wc -l < "$T.pm" | tr -d ' ')
  echo "  Active Priorities: move $moved older completed items to \"$an\"; keep the newest $DONE_KEEP."
  ARCHIVES="$ARCHIVES$an|Completed priorities moved on $today
"
  MOVED_FILES="$MOVED_FILES$f
$af
"
  return 0
}

case "$cmd" in
  status) show_status ;;

  discard)
    if [ -f "$REC" ]; then
      git worktree remove --force "$(recget dir)" 2>/dev/null; git branch -D "$(recget branch)" >/dev/null 2>&1; rm -f "$REC"; echo "Proposal discarded."
    else echo "No pending proposal."; fi ;;

  propose)
    if [ -f "$REC" ]; then echo "A proposal is already pending. Apply it or discard it first."; show_status; exit 1; fi
    sync_state || exit 1
    [ "${ahead:-0}" -gt 0 ] && { echo "Refusing: this vault has $ahead unpushed commit(s). Push or resolve them first."; exit 1; }
    if [ "${behind:-0}" -gt 0 ]; then git merge --ff-only -q '@{u}' 2>/dev/null || { echo "Refusing: could not fast-forward to origin."; exit 1; }; fi
    # candidates
    cand=""
    git ls-files '*Log.md' | grep -v '^07 - Archive/' > "$T.logs"
    while IFS= read -r f; do
      [ -z "$f" ] && continue
      n=$(grep -c '^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] |' "$f")
      [ "$n" -gt "$LOG_KEEP" ] && [ "$(wc -l < "$f" | tr -d ' ')" -gt "$LOG_MAX" ] && cand="$cand$f
"
    done < "$T.logs"
    doneN=$(awk '/^### Completed Tasks/{s=1;next} /^### /{s=0} s&&/^- \[x\]/{c++} END{print c+0}' "Active Priorities.md" 2>/dev/null)
    [ "$doneN" -gt "$DONE_MAX" ] && cand="${cand}Active Priorities.md
"
    [ -z "$cand" ] && { echo "Nothing to rotate."; exit 0; }
    # refuse if any touched file has local edits
    dirty=""
    while IFS= read -r f; do [ -z "$f" ] && continue; [ -n "$(git status --porcelain -- "$f")" ] && dirty="$dirty $f"; done <<EOF
$cand
EOF
    [ -n "$dirty" ] && { echo "Refusing: these files have uncommitted edits:$dirty. Commit or discard them first."; exit 1; }

    stamp=$(date +%Y%m%d-%H%M%S); dir="$CLAUDE_HOME/junior-maint/$stamp"; branch="maintenance/$stamp"
    mkdir -p "$CLAUDE_HOME/junior-maint"
    git worktree add -q -b "$branch" "$dir" HEAD || { echo "Could not create the worktree."; exit 1; }
    ARCHIVES=""; MOVED_FILES=""; fail=0
    echo "Proposal ($today):"
    while IFS= read -r f; do
      [ -z "$f" ] && continue
      if [ "$f" = "Active Priorities.md" ]; then rotate_prio "$dir"; else rotate_log "$dir" "$f"; fi
      r=$?; [ "$r" = 2 ] && fail=1
    done <<EOF
$cand
EOF
    if [ "$fail" = 1 ]; then git worktree remove --force "$dir" 2>/dev/null; git branch -D "$branch" >/dev/null 2>&1; exit 1; fi
    # archive index
    idx="$dir/07 - Archive/Archive.md"
    if [ ! -f "$idx" ]; then { frontmatter active meta index; printf '# Archive\n\nCompleted work and rotated history. Newest last.\n\n## Notes in this folder\n'; } > "$idx"; fi
    printf '%s' "$ARCHIVES" | while IFS='|' read -r an desc; do [ -n "$an" ] && printf -- '- [[%s]] — %s\n' "$an" "$desc" >> "$idx"; done
    MOVED_FILES="$MOVED_FILES07 - Archive/Archive.md
"
    git -C "$dir" add -A
    ident
    git -C "$dir" commit -q -m "Maintenance: rotate Logs and completed priorities ($today)" || { echo "Nothing to commit."; git worktree remove --force "$dir"; git branch -D "$branch" >/dev/null 2>&1; exit 1; }
    pid=$(git -C "$dir" diff HEAD~1 HEAD | git patch-id --stable | cut -d' ' -f1)
    base=$(git rev-parse HEAD)
    touched=$(printf '%s' "$cand" | tr '\n' ',' | sed 's/,$//')
    { echo "branch=$branch"; echo "dir=$dir"; echo "base=$base"; echo "patch=$pid"; echo "created=$(date +%s)"; echo "created_day=$today"; echo "files=$touched"; } > "$REC"
    echo
    git -C "$dir" diff --stat HEAD~1 HEAD | sed 's/^/  /'
    echo
    echo "Patch id: $pid  (branch $branch, expires in $EXPIRE_DAYS days). Nothing is pushed. To approve say \"lock it\"; Junior then runs: vault-maintain.sh apply $pid"
    ;;

  apply)
    want=$2
    ident                                   # the rebase below commits, so it needs an identity even on a fresh machine
    [ -f "$REC" ] || { echo "No pending proposal."; exit 1; }
    pid=$(recget patch); branch=$(recget branch); dir=$(recget dir); base=$(recget base); files=$(recget files); created=$(recget created)
    [ "$want" = "$pid" ] || { echo "Refusing: the patch id you approved ($want) is not the pending one ($pid)."; exit 1; }
    now=$(date +%s); [ $(( now - created )) -gt $(( EXPIRE_DAYS * 86400 )) ] && { echo "Refusing: the proposal is older than $EXPIRE_DAYS days. Discard it and propose again."; exit 1; }
    sync_state || exit 1
    [ "${ahead:-0}" -gt 0 ] && { echo "Refusing: this vault has $ahead unpushed commit(s). Push or resolve them first."; exit 1; }
    # did anyone change the same files since the proposal?
    stale=0
    upsha=$(git rev-parse '@{u}')
    if [ "$upsha" != "$base" ]; then
      git diff --name-only "$base" "$upsha" > "$T.chg"
      printf '%s' "$files" | tr ',' '\n' > "$T.fl"
      while IFS= read -r f; do
        [ -n "$f" ] && grep -Fxq "$f" "$T.chg" && stale=1
      done < "$T.fl"
    fi
    if [ "$stale" = 1 ]; then
      git worktree remove --force "$dir" 2>/dev/null; git branch -D "$branch" >/dev/null 2>&1; rm -f "$REC"
      echo "Refusing: someone changed one of these files since the proposal, so it was discarded. Propose again."; exit 1
    fi
    if [ "$upsha" != "$base" ]; then
      git -C "$dir" rebase -q "$upsha" 2>/dev/null || { git -C "$dir" rebase --abort 2>/dev/null; echo "Rebase failed, so nothing was applied. Discard and propose again."; exit 1; }
      npid=$(git -C "$dir" diff HEAD~1 HEAD | git patch-id --stable | cut -d' ' -f1)
      [ "$npid" = "$pid" ] || { echo "Refusing: after rebasing, the change differs from the one approved. Discard and propose again."; exit 1; }
    fi
    if [ "${behind:-0}" -gt 0 ]; then git merge --ff-only -q '@{u}' 2>/dev/null || { echo "Refusing: could not fast-forward main to origin."; exit 1; }; fi
    git merge --ff-only -q "$branch" 2>/dev/null || { echo "Refusing: main could not fast-forward to the approved branch. Nothing was pushed."; exit 1; }
    if git push -q 2>/dev/null; then echo "Applied and pushed. $(git log -1 --format=%h) $(git log -1 --format=%s)"; else echo "Merged locally but the push was rejected. Pull, check, and push by hand; nothing was forced."; fi
    git worktree remove --force "$dir" 2>/dev/null; git branch -d "$branch" >/dev/null 2>&1; rm -f "$REC"
    ;;

  *) echo "usage: vault-maintain.sh propose | apply <patch-id> | discard | status"; exit 1 ;;
esac
