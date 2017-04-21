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

backup_and_link() {
  link_src_file=$1
  link_dest_dir=$2
  backupdir=$3
  local f_filename=$(basename $link_src_file)
  local f_filepath="$link_dest_dir/$f_filename"
  if [[ -L "$f_filepath" ]];then
    command rm -f "$f_filepath"
  fi
  if [[ -e "$f_filepath" ]];then
    command mv "$f_filepath" "$backupdir"
  fi
  command ln -snf "$link_src_file" "$link_dest_dir"
}

link_neovim_config() {
  mkdir_not_exist ${HOME}/.config
  ln -snfv ${HOME}/.vim ${HOME}/.config/nvim
  ln -snfv ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim
}

link_config_dir() {
  local backupdir="$HOME/.dotbackup/.config"
  mkdir_not_exist $backupdir
  local dest_dir="${HOME}/.config"
  mkdir_not_exist $dest_dir

  local dotdir=$1
  for f in $dotdir/.config/??*; do
    backup_and_link $f $dest_dir $backupdir
  done

}

link_to_homedir() {
  echo "backup old dotfiles..."
  local backupdir="$HOME/.dotbackup"
  mkdir_not_exist $backupdir

  local script_dir="$(builtin cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
  local dotdir=$(readlink -f ${script_dir}/..)
  if [[ "$HOME" != "$dotdir" ]];then
    for f in $dotdir/.??*; do
      local f_filename=$(basename $f)
      [[ "$f_filename" == ".git" ]] && continue
      [[ "$f_filename" == ".config" ]] && link_config_dir $dotdir && continue
      backup_and_link $f $HOME $backupdir
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
EMOJI="false"

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
    --emoji)
      EMOJI="true"
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

  if [[ "$EMOJI" = true ]];then
    source $(dirname "${BASH_SOURCE[0]:-$0}")/install-emoji-env.sh
  fi

  echo ""
  echo "#####################################################"
  echo -e "\e[1;36m $(basename "${BASH_SOURCE[0]:-$0}") update finish!!! \e[m"
  echo "#####################################################"
  echo ""
fi

