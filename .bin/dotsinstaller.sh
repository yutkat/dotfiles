#!/bin/bash

set -ue

CURRENT_DIR=$(dirname "${BASH_SOURCE[0]:-$0}")
source $CURRENT_DIR/lib/dotsinstaller/utilfuncs.sh


#--------------------------------------------------------------#
##          Functions                                         ##
#--------------------------------------------------------------#

function helpmsg() {
  print_default "Usage: "${BASH_SOURCE[0]:-$0}" [install | update] [--no-gui] [--emoji] [--extra] [--all] [--help | -h]" 0>&2
  print_default '  install:  add require package install and symbolic link to $HOME from dotfiles'
  print_default '  update: add require package install or update. [default]'
  print_default '  --all: --extra + --emoji'
  print_default ""
}


#--------------------------------------------------------------#
##          main                                              ##
#--------------------------------------------------------------#


function main() {
  local is_install="false"
  local is_update="true"
  local no_gui="false"
  local emoji="false"
  local extra="false"

  while [ $# -gt 0 ];do
    case ${1} in
      --help|-h)
        helpmsg
        exit 1
        ;;
      install)
        is_install="true"
        ;;
      update)
        is_update="true"
        ;;
      --no-gui)
        no_gui="true"
        ;;
      --emoji)
        emoji="true"
        ;;
      --extra)
        extra="true"
        ;;
      --all)
        emoji="true"
        extra="true"
        ;;
      --verbose|--debug)
        set -x; shift
        ;;
      *)
        echo "[ERROR] Invalid arguments '${1}'"
        usage
        exit 1
        ;;
    esac
    shift
  done


  if [[ ! -e "$HOME/.bin/"$(basename "${BASH_SOURCE[0]:-$0}") ]]; then
    is_install=true
  fi


  if [[ "$is_install" = true ]];then
    source $CURRENT_DIR/lib/dotsinstaller/install-required-packages.sh
    source $CURRENT_DIR/lib/dotsinstaller/link-to-homedir.sh
    source $CURRENT_DIR/lib/dotsinstaller/gitconfig.sh
    print_info ""
    print_info "#####################################################"
    print_info "$(basename "${BASH_SOURCE[0]:-$0}") install success!!!"
    print_info "#####################################################"
    print_info ""
  fi


  if [[ "$is_update" = true ]];then
    source $CURRENT_DIR/lib/dotsinstaller/install-basic-packages.sh
    source $CURRENT_DIR/lib/dotsinstaller/install-neovim.sh
    source $CURRENT_DIR/lib/dotsinstaller/install-fzf.sh

    if [[ "$emoji" = true ]];then
      source $CURRENT_DIR/lib/dotsinstaller/install-emoji-env.sh
    fi

    if [[ "$extra" = true ]];then
      source $CURRENT_DIR/lib/dotsinstaller/install-extra.sh
    fi

    if [[ "$no_gui" = false ]];then
      source $CURRENT_DIR/lib/dotsinstaller/setup-terminal.sh
      source $CURRENT_DIR/lib/dotsinstaller/install-i3.sh
    fi

    print_info ""
    print_info "#####################################################"
    print_info "$(basename "${BASH_SOURCE[0]:-$0}") update finish!!!"
    print_info "#####################################################"
    print_info ""
  fi
}


main "$@"

