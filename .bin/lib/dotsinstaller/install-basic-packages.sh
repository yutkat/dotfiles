#!/bin/bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

checkinstall zsh git vim neovim tmux ctags bc curl xsel gawk python-pip unzip sqlite
sudo pip install neovim

