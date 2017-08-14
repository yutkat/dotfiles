#!/bin/bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

install_fzf() {
  local fzf_dir="$HOME/.fzf"
  git_clone_or_fetch https://github.com/junegunn/fzf.git \
    $fzf_dir
  $fzf_dir/install --no-key-bindings --completion  --no-update-rc || \
    install_fzf_local
}

install_fzf
