#!/bin/sh
# PreToolUse hook for the Read tool: stop Claude opening a huge file whole.
# A read that names a range (offset/limit) or PDF pages is always allowed, so this only redirects the lazy whole-file read.
# Change the limit with JUNIOR_READ_LIMIT_BYTES (default 60000 bytes, roughly 15,000 tokens).

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

[ -f "$f" ] || exit 0
size=$(wc -c < "$f" 2>/dev/null | tr -d ' ')
[ -n "$size" ] && [ "$size" -gt "$limit_bytes" ] || exit 0

kb=$((size / 1000))
lines=$(wc -l < "$f" | tr -d ' ')
tokens=$((size / 4000))
msg="This file is about ${kb} KB (${lines} lines), roughly ${tokens}k tokens. Do not read it whole. Search it with Grep for what you need, then Read only that part using offset and limit, or read just its start or end. If the whole file is really needed, say why and read it in ranges."
printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"%s"}}\n' "$msg"
exit 0
