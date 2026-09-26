# Dry-run tests for vault-maintain.sh: a scratch bare origin plus two clones ("isaac", "tolu"). Run: bash vault-maintain.test.sh
K="$(cd "$(dirname "$0")" && pwd)/vault-maintain.sh"
W=${TMPDIR:-/tmp}/vault-maintain-test
export JUNIOR_CLAUDE_HOME=$W/cc
pass=0; fail=0
ok(){ if [ "$1" = "0" ]; then pass=$((pass+1)); echo "  PASS  $2"; else fail=$((fail+1)); echo "  FAIL  $2"; fi; }
G(){ git -c core.autocrlf=false "$@"; }
mk_env() {
  rm -rf $W; mkdir -p $W/cc; cd $W
  git init -q --bare -b main origin.git
  git clone -q -c core.autocrlf=false origin.git isaac 2>/dev/null; cd isaac; git config user.name isaac; git config user.email i@x; git config core.autocrlf false
  mkdir -p "03 - BakeFlow" "07 - Archive"; : > "07 - Archive/.gitkeep"
  { printf -- '---\nstatus: active\nproject: bakeflow\ntype: log\nauthor: junior\ncreated: 2026-01-01\nupdated: 2026-01-01\n---\n# BakeFlow Log\n\nAppend-only record. One line per change.\n\n'
    i=1; while [ $i -le 400 ]; do
      if [ $((i%50)) = 0 ]; then printf '2026-01-01 | isaac | repeated line | none\n2026-01-01 | isaac | repeated line | none\n'; fi
      if [ $((i%37)) = 0 ]; then printf '2026-02-02 | tolu | crlf entry %s | abc\r\n' $i; else printf '2026-01-%02d | isaac | change %s | c%s\n' $(( (i%28)+1 )) $i $i; fi
      i=$((i+1)); done; } > "03 - BakeFlow/BakeFlow Log.md"
  { printf -- '---\nstatus: active\nproject: bakeflow\ntype: reference\nupdated: 2026-09-01\n---\n# BakeFlow Status\n\n## Where we stopped\n### Isaac\nmid-refactor of auth\n### Tolu\nwriting tests\n'; i=1; while [ $i -le 80 ]; do echo "line $i of status"; i=$((i+1)); done; } > "03 - BakeFlow/BakeFlow Status.md"
  { printf -- '---\nstatus: active\nproject: meta\ntype: plan\n---\n# Active Priorities\n\n### Open Tasks\n- [ ] one\n- [ ] two\n\n### Completed Tasks\n'; i=15; while [ $i -ge 1 ]; do echo "- [x] done item $i"; i=$((i-1)); done; } > "Active Priorities.md"
  git add -A; git commit -q -m seed; git push -q -u origin main 2>/dev/null
  cd $W; git clone -q -c core.autocrlf=false origin.git tolu 2>/dev/null; cd tolu; git config user.name tolu; git config user.email t@x; git config core.autocrlf false
  cd $W/isaac
}
run(){ ( cd $W/$1 && JUNIOR_VAULT=$W/$1 sh "$K" "${@:2}" 2>&1 ); }
entries(){ grep -c '^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] |' "$1"; }

echo "S1 baseline propose + apply"
mk_env
sh_hash=$(cd $W/isaac && git hash-object "03 - BakeFlow/BakeFlow Status.md")
out=$(run isaac propose); echo "$out" | sed 's/^/    | /' | head -12
echo "$out" | grep -q "Patch id" ; ok $? "proposal produced a patch id"
( cd $W/isaac; [ -z "$(git status --porcelain)" ] ); ok $? "working copy untouched by propose"
( cd $W/isaac; [ "$(entries "03 - BakeFlow/BakeFlow Log.md")" -gt 400 ] ); ok $? "main Log still full before approval"
pid=$(echo "$out" | sed -n 's/^Patch id: \([0-9a-f]*\).*/\1/p')
out2=$(run isaac apply "$pid"); echo "$out2" | sed 's/^/    | /'
echo "$out2" | grep -q "Applied and pushed"; ok $? "applied and pushed"
( cd $W/tolu; git pull -q 2>/dev/null; [ "$(entries "03 - BakeFlow/BakeFlow Log.md")" = 100 ] ); ok $? "Tolu pulls a Log with exactly 100 entries"
( cd $W/tolu; ls "07 - Archive" | grep -q "BakeFlow Log archive" ); ok $? "archive note exists"
( cd $W/tolu; a=$(ls "07 - Archive"/BakeFlow\ Log\ archive*.md); [ "$(entries "$a")" -gt 300 ] ); ok $? "archive holds the moved entries"
( cd $W/tolu; grep -q 'Older entries: \[\[BakeFlow Log archive' "03 - BakeFlow/BakeFlow Log.md" ); ok $? "Log links to the archive"
( cd $W/tolu; [ "$(git hash-object "03 - BakeFlow/BakeFlow Status.md")" = "$sh_hash" ] ); ok $? "Status note byte-identical (per-person sections safe)"
( cd $W/tolu; [ "$(grep -c '^- \[x\]' 'Active Priorities.md')" = 5 ] && grep -q 'Older completed items: \[\[Completed Priorities' 'Active Priorities.md' && ls "07 - Archive" | grep -q "Completed Priorities" ); ok $? "priorities rotated: 5 kept, rest archived and linked"
( cd $W/tolu; grep -q 'Archive' "07 - Archive/Archive.md" && grep -q 'BakeFlow Log archive' "07 - Archive/Archive.md" ); ok $? "Archive index lists the new notes"
( cd $W/tolu; total=$(( $(entries "03 - BakeFlow/BakeFlow Log.md") + $(entries "$(ls "07 - Archive"/BakeFlow\ Log\ archive*.md)") )); [ "$total" = 416 ] ); ok $? "no entries lost (400 lines + 16 repeated = 416)"
( cd $W/isaac; git worktree list | wc -l | grep -q '^1$' ); ok $? "worktree cleaned up"

echo "S2 idempotent"; out=$(run isaac propose); echo "$out" | grep -q "Nothing to rotate"; ok $? "second propose finds nothing"

echo "S3 Tolu appends to the Log between propose and apply -> refused"
mk_env; out=$(run isaac propose); pid=$(echo "$out" | sed -n 's/^Patch id: \([0-9a-f]*\).*/\1/p')
( cd $W/tolu; echo "2026-09-26 | tolu | fixed a bug | zzz" >> "03 - BakeFlow/BakeFlow Log.md"; git commit -qam "tolu append"; git push -q 2>/dev/null )
out2=$(run isaac apply "$pid"); echo "$out2" | sed 's/^/    | /'
echo "$out2" | grep -q "changed one of these files"; ok $? "apply refused and proposal discarded"
( cd $W/origin.git; git show main:"03 - BakeFlow/BakeFlow Log.md" | grep -q 'fixed a bug' ); ok $? "Tolu's entry intact on origin"
out3=$(run isaac propose); echo "$out3" | grep -q "Patch id"; ok $? "a fresh proposal can be made afterwards (includes Tolu's entry)"

echo "S4 Tolu edits a DIFFERENT file -> rebase path works"
mk_env; out=$(run isaac propose); pid=$(echo "$out" | sed -n 's/^Patch id: \([0-9a-f]*\).*/\1/p')
( cd $W/tolu; echo "tolu note" > "03 - BakeFlow/Other.md"; git add -A; git commit -qm other; git push -q 2>/dev/null )
out2=$(run isaac apply "$pid"); echo "$out2" | sed 's/^/    | /'
echo "$out2" | grep -q "Applied and pushed"; ok $? "applied after rebase onto Tolu's commit"
( cd $W/origin.git; git show main:"03 - BakeFlow/Other.md" | grep -q 'tolu note' ); ok $? "Tolu's other change preserved"

echo "S5 refusals"
mk_env; ( cd $W/isaac; echo "x" >> "03 - BakeFlow/BakeFlow Log.md" )
out=$(run isaac propose); echo "$out" | grep -q "uncommitted edits"; ok $? "dirty Log refuses propose"
( cd $W/isaac; git checkout -q -- . ; echo "n" > new.md; git add -A; git commit -qm local )
out=$(run isaac propose); echo "$out" | grep -q "unpushed commit"; ok $? "unpushed commit refuses propose"
( cd $W/isaac; git push -q 2>/dev/null ); out=$(run isaac propose); pid=$(echo "$out" | sed -n 's/^Patch id: \([0-9a-f]*\).*/\1/p')
out=$(run isaac apply deadbeef); echo "$out" | grep -q "not the pending one"; ok $? "wrong patch id refused"
sed -i 's/^created=.*/created=1000/' $W/cc/junior-state/maint.rec
out=$(run isaac apply "$pid"); echo "$out" | grep -q "older than"; ok $? "expired proposal refused"
run isaac discard | grep -q discarded; ok $? "discard works"

echo; echo "RESULT: $pass passed, $fail failed"
rm -rf $W
