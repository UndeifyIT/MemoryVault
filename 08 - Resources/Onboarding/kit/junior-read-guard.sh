#!/bin/sh
# PreToolUse hook for the Read tool: stop Junior opening a huge file whole.
# It acts ONLY while Junior is active in this conversation, and it always lets a read through that names a range
# (offset/limit) or PDF pages, so it only redirects the lazy whole-file read.
# Change the size limit with JUNIOR_READ_LIMIT_BYTES (default 60000 bytes, roughly 15,000 tokens).
#
# How it knows Junior is active: the junior skill leaves the marker "junior-state: loaded" in the conversation
# transcript, the junior-off skill leaves "junior-state: unloaded", and the latest one wins. A session started in
# the my-agent folder counts as active, because Junior's boot file loads there automatically.

limit_bytes=${JUNIOR_READ_LIMIT_BYTES:-60000}
in=$(cat)

# An explicit range or page selection means the caller already chose a slice.
case "$in" in
  *'"limit"'*|*'"pages"'*) exit 0 ;;
esac

# Pull the path out of the JSON payload and turn Windows backslashes into slashes.
f=$(printf '%s' "$in" | sed -n 's/.*"file_path" *: *"\([^"]*\)".*/\1/p' | sed 's/\\\\/\//g; s/\\\//\//g')
[ -z "$f" ] && exit 0

# Images, PDFs and notebooks are handled by the tool itself.
case "$f" in
  *.png|*.jpg|*.jpeg|*.gif|*.webp|*.pdf|*.ipynb|*.PNG|*.JPG|*.JPEG|*.PDF) exit 0 ;;
esac

# Cheap checks first: only a big file gets as far as the "is Junior active" check.
[ -f "$f" ] || exit 0
size=$(wc -c < "$f" 2>/dev/null | tr -d ' ')
[ -n "$size" ] && [ "$size" -gt "$limit_bytes" ] || exit 0

# Is Junior active in this conversation?
active=0
cwd=$(printf '%s' "$in" | sed -n 's/.*"cwd" *: *"\([^"]*\)".*/\1/p')
case "$cwd" in *my-agent*) active=1 ;; esac
if [ "$active" = 0 ]; then
  tp=$(printf '%s' "$in" | sed -n 's/.*"transcript_path" *: *"\([^"]*\)".*/\1/p' | sed 's/\\\\/\//g; s/\\\//\//g')
  if [ -f "$tp" ]; then
    on=$(grep -noF 'junior-state: loaded' "$tp" | tail -1 | cut -d: -f1)
    off=$(grep -noF 'junior-state: unloaded' "$tp" | tail -1 | cut -d: -f1)
    if [ -n "$on" ] && { [ -z "$off" ] || [ "$on" -gt "$off" ]; }; then active=1; fi
  fi
fi
[ "$active" = 1 ] || exit 0

kb=$((size / 1000))
lines=$(wc -l < "$f" | tr -d ' ')
tokens=$((size / 4000))
msg="This file is about ${kb} KB (${lines} lines), roughly ${tokens}k tokens. Do not read it whole. Search it with Grep for what you need, then Read only that part using offset and limit, or read just its start or end. If the whole file is really needed, say why and read it in ranges."
printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"%s"}}\n' "$msg"
exit 0
