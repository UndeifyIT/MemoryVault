# vault-check.awk: all the vault facts in ONE process (process spawns are slow on Windows, so nothing here shells out).
# Run by vault-check.sh. Needs gawk (Git for Windows ships it) for systime() and mktime().
#
# Inputs, via -v: mode (startup|report|precommit), vault, home, claude, state, stfile (git status -b), logfile
# (git log --name-only --format=#%cs), allfile (all tracked .md), scanfile (notes to scan), and the thresholds.

function toepoch(d,   p) { if (split(d, p, "-") != 3) return 0; return mktime(p[1] " " p[2] " " p[3] " 12 00 00") }
function gapdays(a, b) { return int((toepoch(a) - toepoch(b)) / 86400) }
function say(msg) { n++; out[n] = msg }
# Should a tripped check speak? Yes if new, worse than last time, or older than snooze days.
function speak(k, m,   sk, p, le, lm) {
  sk = "seen." k
  if (mode != "startup") return 1
  if (sk in st) { p = index(st[sk], ","); le = substr(st[sk], 1, p - 1) + 0; lm = substr(st[sk], p + 1) + 0 }
  else { le = -1; lm = 0 }
  if (le < 0 || m > lm || now - le >= snooze * 86400) { st[sk] = now "," m; return 1 }
  return 0
}
function readfile(f, arr,   l, c) { c = 0; while ((getline l < f) > 0) { sub(/\r$/, "", l); arr[++c] = l }; close(f); return c }
function scan(f,   line, n, fence, fm, hasfm, upd, tmp, t) {
  fence = 0; fm = 0; hasfm = 0; upd = ""; n = 0
  while ((getline line < f) > 0) {
    n++; sub(/\r$/, "", line)
    if (n == 1 && line == "---") { fm = 1; hasfm = 1; continue }
    if (fm == 1) { if (line == "---") fm = 0; else if (line ~ /^updated:/) { upd = line; sub(/^updated:[ \t]*/, "", upd) }; continue }
    if (line ~ /^```/) { fence = !fence; continue }
    if (fence) continue
    if (line ~ /^<<<<<<< /) conf[f] = 1
    if (line ~ /^> Draft, not confirmed/) draft[f] = 1
    if (f ~ / Status\.md$/ && line ~ /[Pp]aused/) paused[f] = 1
    if (index(line, "C:\\Users\\") && line !~ /machine-specific|Isaac.s (local|machine)|on Isaac.s/) pathf[f] = 1
    tmp = line; gsub(/`[^`]*`/, "", tmp)
    while (match(tmp, /\[\[[^]]+\]\]/)) {
      t = substr(tmp, RSTART + 2, RLENGTH - 4); sub(/[|#].*/, "", t)
      nl++; lnk_f[nl] = f; lnk_t[nl] = t
      tmp = substr(tmp, RSTART + RLENGTH)
    }
  }
  close(f)
  size[f] = n; updd[f] = upd
  if (!hasfm) nofm[f] = 1
}

BEGIN {
  now = systime()
  # ---- state ----
  while ((getline l < state) > 0) { i = index(l, "="); if (i > 1) st[substr(l, 1, i - 1)] = substr(l, i + 1) }
  close(state)

  # ---- note names (for duplicate and link checks) ----
  na = readfile(allfile, all)
  for (i = 1; i <= na; i++) { b = all[i]; sub(/.*\//, "", b); sub(/\.md$/, "", b); cnt[b]++; nm[b] = 1 }
  ns = readfile(scanfile, sc)
  for (i = 1; i <= ns; i++) scan(sc[i])

  # ---- precommit: warnings only ----
  if (mode == "precommit") {
    w = 0
    for (i = 1; i <= ns; i++) { f = sc[i]
      if (f in nofm) { print "  missing front matter: " f; w++ }
      if (f in pathf) { print "  machine-specific path in a shared note: " f; w++ } }
    for (i = 1; i <= nl; i++) if (!(lnk_t[i] in nm)) { print "  link does not resolve: [[" lnk_t[i] "]] in " lnk_f[i]; w++ }
    for (b in cnt) if (cnt[b] > 1) { print "  duplicate note name: " b; w++ }
    if (w > 0) print "vault-check: warnings only, the commit continues."
    exit
  }

  # ---- git state (status -b first line, then changed files) ----
  dirty = 0; ahead = 0; behind = 0; tracked = 0
  first = 1
  while ((getline l < stfile) > 0) {
    if (first) { first = 0
      if (l ~ /\.\.\./) tracked = 1
      if (match(l, /ahead [0-9]+/)) ahead = substr(l, RSTART + 6, RLENGTH - 6) + 0
      if (match(l, /behind [0-9]+/)) behind = substr(l, RSTART + 7, RLENGTH - 7) + 0
    } else if (l != "") dirty++
  }
  close(stfile)

  # ---- last commit date per file ----
  while ((getline l < logfile) > 0) { if (l ~ /^#/) d = substr(l, 2); else if (l != "" && !(l in last)) last[l] = d }
  close(logfile)

  # 1. kit version
  vr = ""; vi = ""
  if ((getline l < (kitdir "/VERSION")) > 0) vr = l; close(kitdir "/VERSION")
  if ((getline l < (claude "/junior-kit-version")) > 0) vi = l; close(claude "/junior-kit-version")
  gsub(/[ \r\n]/, "", vr); gsub(/[ \r\n]/, "", vi)
  if (vr != "" && vr != vi) say("Kit out of date on this machine (installed: " (vi == "" ? "none" : vi) ", vault: " vr "). Run onboard.ps1, then the Junior Checks.")

  # 2. merge-conflict markers
  cl = ""; for (f in conf) cl = cl (cl == "" ? "" : ", ") f
  if (cl != "") say("Merge-conflict markers in: " cl ". Resolve before anything else.")

  # 3. vault git state (no network)
  if (dirty > 0 && speak("dirty", dirty)) say("Vault has " dirty " uncommitted change(s).")
  if (behind > 0 && speak("behind", behind)) say("Vault is " behind " commit(s) behind origin (as of the last fetch). Pull before writing.")
  if (ahead > 0 && speak("ahead", ahead)) say("Vault has " ahead " unpushed commit(s).")

  # 4. stale Status: the project Log moved on, but Status did not
  for (i = 1; i <= ns; i++) { f = sc[i]
    if (f !~ / Status\.md$/ || (f in paused)) continue
    dir = f; sub(/\/[^\/]*$/, "", dir); proj = f; sub(/.*\//, "", proj); sub(/ Status\.md$/, "", proj)
    lg = dir "/" proj " Log.md"
    if (updd[f] == "" || !(lg in last)) continue
    g = gapdays(last[lg], updd[f])
    if (g > stale && speak("stale." proj, g)) say(proj " Status looks stale: its Log moved " g " days after Status was last updated (" updd[f] ").")
  }

  # 5. drafts waiting for approval (anchored marker; age from the file's last commit)
  dn = 0; oldest = 0
  for (f in draft) { if (!(f in last)) continue; age = int((now - toepoch(last[f])) / 86400)
    if (age >= draftdays) { dn++; if (age > oldest) oldest = age } }
  if (dn > 0 && speak("drafts", oldest)) say(dn " draft(s) waiting for approval; the oldest has waited " oldest " days.")

  # 6. sizes
  for (i = 1; i <= ns; i++) { f = sc[i]
    if (f ~ /Daily Notes|Archive\//) continue
    m = notemax
    if (f ~ / Status\.md$/) m = statusmax; else if (f ~ / Architecture\.md$/) m = archmax; else if (f ~ / Log( [0-9]+)?\.md$/) m = logmax
    if (size[f] > m && speak("size." f, size[f])) { b = f; sub(/.*\//, "", b); say(b " has " size[f] " lines (limit " m "). Ask to split or rotate it.") } }

  # 7. open priorities (largest section, so per-project headings keep it short) and note count
  open = 0; o = 0; grp = ""; gc = 0; maxc = 0; maxg = "the list"; total = 0
  while ((getline l < (vault "/Active Priorities.md")) > 0) {
    if (l ~ /^### Open Tasks/) { o = 1; continue }
    if (l ~ /^### /) o = 0
    if (o && l ~ /^#### /) { if (gc > maxc) { maxc = gc; maxg = grp }; grp = substr(l, 6); gc = 0; continue }
    if (o && l ~ /^- \[ \]/) { gc++; total++ }
  }
  if (gc > maxc) { maxc = gc; maxg = (grp == "" ? "the list" : grp) }
  close(vault "/Active Priorities.md")
  open = total
  if (maxc > priomax && speak("prio", maxc)) say("Active Priorities has " maxc " open items under \"" maxg "\" (limit " priomax "). Split it or close some.")
  if (na > notesmax && speak("notes", na)) say("The vault has " na " notes (limit " notesmax "). Time to consider a topic index.")

  # 8. startup reading budget
  bytes = 0
  nb = split(home "/my-agent/CLAUDE.md|" claude "/CLAUDE.md|" vault "/VAULT-INDEX.md|" vault "/Active Priorities.md|" claude "/skills/junior/SKILL.md", bf, "|")
  for (i = 1; i <= nb; i++) { while ((getline l < bf[i]) > 0) bytes += length(l) + 1; close(bf[i]) }
  if (bytes > budget && speak("budget", bytes)) say("Junior's startup reading is " bytes " bytes (cap " budget "). Trim it.")

  # 9. weekly: duplicate names, broken links, machine paths
  lw = ("last.weekly" in st) ? st["last.weekly"] + 0 : 0
  weekly = (mode == "report") || lw == 0 || (now - lw >= weeklydays * 86400)
  if (weekly) {
    dups = 0; for (b in cnt) if (cnt[b] > 1) dups++
    broken = 0; for (i = 1; i <= nl; i++) if (!(lnk_t[i] in nm)) broken++
    paths = 0; for (f in pathf) paths++
    if (dups > 0 && speak("dups", dups)) say(dups " duplicate note name(s). Rename so links stay unambiguous.")
    if (broken > 0 && speak("broken", broken)) say(broken " wikilink(s) don't resolve.")
    if (paths > 0 && speak("paths", paths)) say(paths " shared note(s) contain machine-specific paths.")
    if (mode == "startup") st["last.weekly"] = now
  }

  # ---- kill count (friction log) ----
  kills = 0; cutoff = now - 30 * 86400
  while ((getline l < (statedir "/kills.log")) > 0) { split(l, kp, " "); if (toepoch(kp[1]) >= cutoff) kills++ }
  close(statedir "/kills.log")

  # ---- write state, then print ----
  if (mode == "startup") { for (k in st) print k "=" st[k] > state; close(state) }
  if (mode == "report") {
    dcount = 0; for (i = 1; i <= na; i++) if (all[i] ~ /^01 - Daily Notes\// && all[i] !~ /Template/) dcount++
    print "Vault report (" strftime("%Y-%m-%d", now) ")"
    print "  notes: " na " | daily notes: " dcount " | open priorities: " open " | startup bytes: " bytes "/" budget
    print "  git: dirty=" dirty " ahead=" ahead " behind=" behind (tracked ? "" : " (no upstream)") " | kit: vault=" vr " installed=" (vi == "" ? "none" : vi)
    print "  'kill junior' in the last 30 days on this machine: " kills
    if (n == 0) print "  Nothing needs attention."
    for (i = 1; i <= n; i++) print "  - " out[i]
  } else {
    for (i = 1; i <= n && i <= 6; i++) print out[i]
  }
  if (weekly && mode != "precommit") print "@weekly"
  exit
}
