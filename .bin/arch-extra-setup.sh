#!/bin/bash

set -ue

current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")

source $current_dir/lib/arch-extra-setup/utils.sh
source $current_dir/lib/arch-extra-setup/development.sh

if [ -f /sys/module/battery/initstate ] || [ -d /proc/acpi/battery/BAT0 ]; then
  source $current_dir/lib/arch-extra-setup/laptop.sh
fi



