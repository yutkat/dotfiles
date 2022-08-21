#!/usr/bin/env bash
set -euo pipefail

# Export all variables
set -a
# Call the systemd generator that reads all files in environment.d
source /dev/fd/0 <<EOF
  $(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)
EOF
set +a

exec Hyprland
