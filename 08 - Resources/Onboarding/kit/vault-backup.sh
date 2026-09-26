#!/bin/sh
# Second copy of the vault that lives OUTSIDE GitHub: a single verified `git bundle` file with all history.
# Run by hand (or from the weekly review):  sh vault-backup.sh [vault-dir] [backup-dir]
# Default backup folder: ~/Backups/UndeifyVault. Point it at an external drive or a synced folder you control.
# Keeps the newest 8 bundles. A bundle holds the whole vault, so store it somewhere private.

vault=${1:-$HOME/Undeify}
dest=${2:-$HOME/Backups/UndeifyVault}
keep=8

[ -d "$vault/.git" ] || { echo "Not a git repo: $vault" >&2; exit 1; }
mkdir -p "$dest" || { echo "Cannot create $dest" >&2; exit 1; }

stamp=$(date +%Y%m%d-%H%M%S)
out="$dest/undeify-vault-$stamp.bundle"

git -C "$vault" bundle create "$out" --all >/dev/null 2>&1 || { echo "Bundle failed" >&2; rm -f "$out"; exit 1; }
git -C "$vault" bundle verify "$out" >/dev/null 2>&1 || { echo "Bundle did not verify, removed" >&2; rm -f "$out"; exit 1; }

# Prune: keep the newest $keep bundles.
ls -1t "$dest"/undeify-vault-*.bundle 2>/dev/null | tail -n +$((keep + 1)) | while IFS= read -r old; do rm -f "$old"; done

size=$(wc -c < "$out" | tr -d ' ')
echo "Backup written and verified: $out ($size bytes). Restore drill: git clone \"$out\" some-empty-folder"
