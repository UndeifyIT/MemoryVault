#!/bin/sh
# PreToolUse hook (matcher: Write|Edit|MultiEdit|NotebookEdit|Bash|mcp__.*). Part of the prompt-injection gate.
# If this session has read external content (see junior-taint-mark.sh), ask the human before an action that
# content could be steering. This is a speed bump, not a wall: read-only connector scopes are the real defence.
# It runs regardless of whether Junior is active, because it only fires after an external read.
# Fast path: no taint file for this session means exit at once with no output.

IFS= read -r -d '' in
ch=${JUNIOR_CLAUDE_HOME:-$HOME/.claude}

sid=${in#*\"session_id\":\"}; sid=${sid%%\"*}
case "$in" in *\"session_id\":\"*) ;; *) sid=nosid ;; esac
[ -f "$ch/junior-taint/$sid" ] || exit 0
read -r class < "$ch/junior-taint/$sid"
[ -z "$class" ] && exit 0

tool=${in#*\"tool_name\":\"}; tool=${tool%%\"*}
cmd=${in#*\"command\":\"}; [ "$cmd" = "$in" ] && cmd=""; cmd=${cmd%%\"*}

ask() {
  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"ask","permissionDecisionReason":"%s"}}\n' "$1"
  exit 0
}
readlike() {
  case "$1" in
    *context7*|*junior*) return 0 ;;
    *[Ee]xecute*|*EXECUTE*) return 1 ;;
    *[Gg]et*|*[Ll]ist*|*[Ss]earch*|*[Rr]ead*|*[Qq]uery*|*[Ff]etch*|*[Rr]esolve*) return 0 ;;
  esac
  return 1
}

case "$class" in
  mail)
    why="This session just read content from email, chat or a connected app. That content can hide instructions meant to trick an agent. Confirm this action is what you asked for, not what the content said."
    case "$tool" in
      Write|Edit|MultiEdit|NotebookEdit) ask "$why" ;;
      Bash)
        case "$cmd" in
          *';'*|*'&&'*|*'|'*|*'>'*|*'<'*|*'$('*|*'`'*) ask "$why" ;;
          ls|ls\ *|cat\ *|grep\ *|head\ *|tail\ *|wc\ *|pwd|echo\ *|git\ status*|git\ diff*|git\ log*|git\ show*|git\ branch*|git\ rev-parse*) ;;
          *) ask "$why" ;;
        esac ;;
      mcp__*) readlike "$tool" || ask "$why" ;;
    esac ;;
  web)
    why="This session just read web content, which can hide instructions. Confirm this outward or persistent action is yours."
    case "$tool" in
      mcp__*) readlike "$tool" || ask "$why" ;;
      Bash) case "$cmd" in *'git push'*|*curl*|*wget*|*Invoke-WebRequest*|*Invoke-RestMethod*|*'scp '*|*'ssh '*) ask "$why" ;; esac ;;
      Write|Edit|MultiEdit|NotebookEdit) case "$in" in *Undeify*) ask "This session read web content and is now writing into the shared vault, a persistent target. Confirm." ;; esac ;;
    esac ;;
esac
exit 0
