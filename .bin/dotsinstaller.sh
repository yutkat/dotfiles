#!/bin/bash

set -ue

current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
source $current_dir/lib/dotsinstaller/utilfuncs.sh


#--------------------------------------------------------------#
##          Functions                                         ##
#--------------------------------------------------------------#

helpmsg() {
  print_default "Usage: "${BASH_SOURCE[0]:-$0}" [install | update] [--no-gui] [--emoji] [--extra] [--help | -h]" 0>&2
  print_default '  install:  add require package install and symbolic link to $HOME from dotfiles'
  print_default '  update: add require package install or update. [default]'
  print_default ""
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

link_config_dir() {
  local backupdir="$HOME/.dotbackup/.config"
  mkdir_not_exist $backupdir
  local dest_dir="${HOME}/.config" # ${XDG_CONFIG_HOME}
  mkdir_not_exist $dest_dir

  local dotfiles_dir=$1
  for f in $dotfiles_dir/.config/??*; do
    backup_and_link $f $dest_dir $backupdir
  done

}

link_to_homedir() {
  print_notice "backup old dotfiles..."
  local backupdir="$HOME/.dotbackup"
  mkdir_not_exist $backupdir

  local script_dir="$(builtin cd "$current_dir" && pwd)"
  local dotfiles_dir=$(readlink -f ${script_dir}/..)
  if [[ "$HOME" != "$dotfiles_dir" ]];then
    for f in $dotfiles_dir/.??*; do
      local f_filename=$(basename $f)
      [[ "$f_filename" == ".git" ]] && continue
      [[ "$f_filename" == ".config" ]] && link_config_dir $dotfiles_dir && continue
      backup_and_link $f $HOME $backupdir
    done
  fi
}


#--------------------------------------------------------------#
##          main                                              ##
#--------------------------------------------------------------#

IS_INSTALL="false"
IS_UPDATE="true"
NO_GUI="false"
EMOJI="false"
EXTRA="false"

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
    --no-gui)
      NO_GUI="true"
      ;;
    --emoji)
      EMOJI="true"
      ;;
    --extra)
      EXTRA="true"
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
  source $current_dir/lib/dotsinstaller/gitconfig.sh
  print_info ""
  print_info "#####################################################"
  print_info "$(basename "${BASH_SOURCE[0]:-$0}") install success!!!"
  print_info "#####################################################"
  print_info ""
fi


if [[ "$IS_UPDATE" = true ]];then
  checkinstall zsh git vim neovim tmux ctags bc curl xsel gawk
  if [[ "$NO_GUI" = false ]];then
    source $current_dir/lib/dotsinstaller/install-i3.sh
    source $current_dir/lib/dotsinstaller/setup-terminal.sh
  fi
  source $current_dir/lib/dotsinstaller/install-fzf.sh

  if [[ "$EMOJI" = true ]];then
    source $current_dir/lib/dotsinstaller/install-emoji-env.sh
  fi

  if [[ "$EXTRA" = true ]];then
    source $current_dir/lib/dotsinstaller/install-extra.sh
  fi

  print_info ""
  print_info "#####################################################"
  print_info "$(basename "${BASH_SOURCE[0]:-$0}") update finish!!!"
  print_info "#####################################################"
  print_info ""
fi

