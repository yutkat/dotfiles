#!/bin/bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh


#--------------------------------------------------------------#
##          Functions                                         ##
#--------------------------------------------------------------#

helpmsg() {
  echo "Usage: "${BASH_SOURCE[0]:-$0}" [install | update] [--no-gui] [--help | -h]" 0>&2
  echo '  install:  add require package install and symbolic link to $HOME from dotfiles'
  echo '  update: add require package install or update. [default]'
  echo ""
}

install_tmux-plugins() {
  git_clone_or_fetch https://github.com/tmux-plugins/tpm \
    "$HOME/.tmux/plugins/tpm"
}

link_neovim_config() {
  if [ ! -d ${HOME}/.config ];then
    mkdir ${HOME}/.config
  fi
  ln -snfv ${HOME}/.vim ${HOME}/.config/nvim
  ln -snfv ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim
}


setup_gnome_terminal_config() {
  if type gnome-terminal > /dev/null 2>&1;then
    if type dbus-launch > /dev/null 2>&1;then
      if type gsettings > /dev/null 2>&1;then
        $(dirname "${BASH_SOURCE[0]:-$0}")/gnome-terminal-config-restore.sh
      fi
    fi
  fi
}

copy_to_homedir() {
  local script_dir="$(builtin cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
  local dotdir=$(readlink -f ${script_dir}/..)
  if [[ "$HOME" != "$dotdir" ]];then
    echo "cp -r${FORCE_OVERWRITE} ${dotdir}/* ${dotdir}/.[^.]* $HOME"
    if yes_or_no_select; then
      command cp -r${FORCE_OVERWRITE} ${dotdir}/* ${dotdir}/.[^.]* $HOME
    fi
  fi
}

link_to_homedir() {
  echo "backup old dotfiles..."
  local backupdir="$HOME/.dotbackup"
  if [ ! -d "$backupdir" ];then
    echo "$backupdir not found. Auto Make it"
    mkdir "$backupdir"
  fi

  local script_dir="$(builtin cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
  local dotdir=$(readlink -f ${script_dir}/..)
  if [[ "$HOME" != "$dotdir" ]];then
    for f in $dotdir/.??*; do
      local f_filename=$(basename $f)
      local f_filepath="$HOME/$f_filename"
      [[ "$f_filename" == ".git" ]] && continue
      if [[ -L "$f_filepath" ]];then
        command rm -f "$f_filepath"
      fi
      if [[ -e "$f_filepath" ]];then
        command mv "$f_filepath" "$backupdir"
      fi
      command ln -snf "$f" "$HOME"
    done
  fi
}


#--------------------------------------------------------------#
##          main                                              ##
#--------------------------------------------------------------#

WITH_TMUX_EXTENSIONS="false"
IS_INSTALL="false"
IS_UPDATE="true"
NO_GUI="false"

while [ $# -gt 0 ];do
  case ${1} in
    --debug|-d)
      set -uex
      ;;
    --help|-h)
      helpmsg
      exit 1
      ;;
    install)
      IS_INSTALL="true"
      ;;
    update)
      IS_UPDATE="true"
      ;;
    --with-tmux-extentions)
      WITH_TMUX_EXTENSIONS="true"
      ;;
    --no-gui)
      NO_GUI="true"
      ;;
    *)
      ;;
  esac
  shift
done


if [[ ! -e "$HOME/.bin/"$(basename "${BASH_SOURCE[0]:-$0}") ]]; then
  IS_INSTALL=true
fi


if [[ "$IS_INSTALL" = true ]];then
  link_to_homedir
  link_neovim_config
  source $(dirname "${BASH_SOURCE[0]:-$0}")/gitconfig.sh
  echo ""
  echo "#####################################################"
  echo -e "\e[1;36m $(basename "${BASH_SOURCE[0]:-$0}") install success!!! \e[m"
  echo "#####################################################"
  echo ""
fi


if [[ "$IS_UPDATE" = true ]];then
  checkinstall zsh git vim tmux ctags bc curl xsel gawk
  if [[ "$NO_GUI" = false ]];then
    source $(dirname "${BASH_SOURCE[0]:-$0}")/install-i3.sh
  fi
  source $(dirname "${BASH_SOURCE[0]:-$0}")/install-fzf.sh

  if [[ $WITH_TMUX_EXTENSIONS = "true" ]];then
    source $(dirname "${BASH_SOURCE[0]:-$0}")/install-tmux-extension.sh
  fi

  echo ""
  echo "#####################################################"
  echo -e "\e[1;36m $(basename "${BASH_SOURCE[0]:-$0}") update finish!!! \e[m"
  echo "#####################################################"
  echo ""
fi

