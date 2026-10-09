#!/bin/sh

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
FLAKE_DIR=$(realpath "$SCRIPT_DIR/../../..")
if [ ! -f "$FLAKE_DIR/flake.nix" ]; then
	exit 1
fi

# Write the updated lock to a temp file so the repository's flake.lock stays untouched
LOCK_FILE=$(mktemp)
trap 'rm -f "$LOCK_FILE"' EXIT
nix flake update --flake "$FLAKE_DIR" --output-lock-file "$LOCK_FILE" 2>&1 | grep -c "Updated input"
