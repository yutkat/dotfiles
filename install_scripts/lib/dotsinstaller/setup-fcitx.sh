#!/usr/bin/env bash

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

#if [ -f ~/.xprofile ]; then
#  echo "ERROR: ~/.xprofile is exist"
#  exit 1
#fi
#
#{
#echo export GTK_IM_MODULE=fcitx
#echo export QT_IM_MODULE=fcitx
#echo export XMODIFIERS=@im=fcitx
#echo fcitx
#} >> ~/.xprofile

# fcitx > /dev/null 2>&1 || true
# if [ -f ~/.config/fcitx/config ]; then
#   sed -i -e 's/#InactivateKey=/InactivateKey=ESCAPE CTRL_[/g' ~/.config/fcitx/config
# else
#   print_error "Please execute fcitx"
#   exit 1
# fi

# https://zenn.dev/anyakichi/articles/a3aab8d80994d1
function setup_fcitx_extension() {
	mkdir -p ~/.local/share/fcitx5/addon
	mkdir -p ~/.local/share/fcitx5/lua/hotkey-extension
	local current_dir
	current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
	cp "$current_dir"/fcitx5/hotkey-extension.conf ~/.local/share/fcitx5/addon/
	cp "$current_dir"/fcitx5/escape_pass_through.lua ~/.local/share/fcitx5/lua/hotkey-extension/
}

setup_fcitx_extension
