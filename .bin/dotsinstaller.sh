#!/bin/bash

set -ue

current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
source $current_dir/lib/dotsinstaller/utilfuncs.sh


#--------------------------------------------------------------#
##          Functions                                         ##
#--------------------------------------------------------------#

helpmsg() {
  print_default "Usage: "${BASH_SOURCE[0]:-$0}" [install | update] [--no-gui] [--emoji] [--extra] [--all] [--help | -h]" 0>&2
  print_default '  install:  add require package install and symbolic link to $HOME from dotfiles'
  print_default '  update: add require package install or update. [default]'
  print_default '  --all: --extra + --emoji'
  print_default ""
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
    --all)
      EMOJI="true"
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
  source $current_dir/lib/dotsinstaller/link-to-homedir.sh
  source $current_dir/lib/dotsinstaller/gitconfig.sh
  print_info ""
  print_info "#####################################################"
  print_info "$(basename "${BASH_SOURCE[0]:-$0}") install success!!!"
  print_info "#####################################################"
  print_info ""
fi


if [[ "$IS_UPDATE" = true ]];then
  source $current_dir/lib/dotsinstaller/install-basic-packages.sh
  source $current_dir/lib/dotsinstaller/install-fzf.sh

  if [[ "$EMOJI" = true ]];then
    source $current_dir/lib/dotsinstaller/install-emoji-env.sh
  fi

  if [[ "$EXTRA" = true ]];then
    source $current_dir/lib/dotsinstaller/install-extra.sh
  fi

  if [[ "$NO_GUI" = false ]];then
    source $current_dir/lib/dotsinstaller/setup-terminal.sh
    source $current_dir/lib/dotsinstaller/install-i3.sh
  fi

  print_info ""
  print_info "#####################################################"
  print_info "$(basename "${BASH_SOURCE[0]:-$0}") update finish!!!"
  print_info "#####################################################"
  print_info ""
fi

