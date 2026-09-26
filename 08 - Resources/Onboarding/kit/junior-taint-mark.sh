#!/bin/sh
# PostToolUse hook (matcher: WebFetch|mcp__.*). Part of the prompt-injection gate.
# After Claude READS external content (an email, a chat, a web page, a Composio app), remember that for this
# session. junior-taint-gate.sh then asks the human before risky actions. junior-taint-clear.sh forgets it
# when the human sends a new prompt. Needs bash (`sh` in Git for Windows is bash): it avoids spawning processes.
#
#   mail  strict: email, chat and Composio (its tools both read and act, so any call counts)
#   web   loose: WebFetch and browser tools

IFS= read -r -d '' in
ch=${JUNIOR_CLAUDE_HOME:-$HOME/.claude}
in=${in//\": \"/\":\"}                    # tolerate pretty-printed JSON

tool=${in#*\"tool_name\":\"}; tool=${tool%%\"*}
sid=${in#*\"session_id\":\"}; sid=${sid%%\"*}
case "$in" in *\"session_id\":\"*) ;; *) sid=nosid ;; esac

class=""
case "$tool" in
  *context7*|*junior*) exit 0 ;;
  WebFetch|*playwright*|*browser*|*chrome*) class=web ;;
  *omposio*|*OMPOSIO*) class=mail ;;
  mcp__*) case "$tool" in *[Gg]et*|*[Ll]ist*|*[Ss]earch*|*[Rr]ead*|*[Qq]uery*|*[Ff]etch*) class=mail ;; esac ;;
esac
[ -z "$class" ] && exit 0

[ -d "$ch/junior-taint" ] || mkdir -p "$ch/junior-taint" 2>/dev/null
cur=""; [ -f "$ch/junior-taint/$sid" ] && read -r cur < "$ch/junior-taint/$sid"
[ "$cur" = mail ] && class=mail          # never downgrade mail to web
printf '%s' "$class" > "$ch/junior-taint/$sid"
exit 0
