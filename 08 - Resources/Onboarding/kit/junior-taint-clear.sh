#!/bin/sh
# UserPromptSubmit hook. Part of the prompt-injection gate.
# A new prompt from the human is a fresh instruction, so forget any "this session read external content" mark.

IFS= read -r -d '' in
ch=${JUNIOR_CLAUDE_HOME:-$HOME/.claude}
in=${in//\": \"/\":\"}                    # tolerate pretty-printed JSON
sid=${in#*\"session_id\":\"}; sid=${sid%%\"*}
case "$in" in *\"session_id\":\"*) ;; *) sid=nosid ;; esac
[ -f "$ch/junior-taint/$sid" ] && rm -f "$ch/junior-taint/$sid"
exit 0
