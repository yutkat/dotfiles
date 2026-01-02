#!/bin/sh

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
FLAKE_DIR=$(realpath "$SCRIPT_DIR/../../..")
if [ ! -f "$FLAKE_DIR/flake.nix" ]; then
	exit 1
fi

nix flake update --flake "$FLAKE_DIR" --dry-run 2>&1 | grep -c "Upgrading"
echo 1
