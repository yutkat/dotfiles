#!/bin/bash

function print_default() {
  echo -e "$*"
}

function print_info() {
  echo -e "\e[1;36m$*\e[m" # cyan
}

function print_notice() {
  echo -e "\e[1;35m$*\e[m" # magenta
}

function print_success() {
  echo -e "\e[1;32m$*\e[m" # green
}

function print_warning() {
  echo -e "\e[1;33m$*\e[m" # yellow
}

function print_error() {
  echo -e "\e[1;31m$*\e[m" # red
}

function print_debug() {
  echo -e "\e[1;34m$*\e[m" # blue
}

function chkcmd() {
  if ! builtin command -v "$1";then
    print_error "${1}コマンドが見つかりません"
    exit
  fi
}

function yes_or_no_select() {
  local answer
  print_notice "Are you ready? [yes/no]"
  read answer
  case $answer in
    yes|y)
      return 0
      ;;
    no|n)
      return 1
      ;;
    *)
      yes_or_no_select
      ;;
  esac
}

function whichdistro() {
  #which yum > /dev/null && { echo redhat; return; }
  #which zypper > /dev/null && { echo opensuse; return; }
  #which apt-get > /dev/null && { echo debian; return; }
  if [ -f /etc/debian_version ]; then
    echo debian; return;
  elif [ -f /etc/fedora-release ] ;then
    # echo fedora; return;
    echo redhat; return;
  elif [ -f /etc/redhat-release ] ;then
    echo redhat; return;
  elif [ -f /etc/arch-release ] ;then
    echo arch; return;
  fi
}

function checkinstall() {
  local distro=`whichdistro`
  if [[ $distro == "redhat" ]];then
    if ! cat /etc/redhat-release | grep -i "fedora" > /dev/null; then
      sudo yum install -y epel-release
    fi
  fi

  for PKG in "$@";do
    if ! builtin command -v "$PKG" > /dev/null 2>&1; then
      if [[ $distro == "debian" ]];then
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y $PKG
      elif [[ $distro == "redhat" ]];then
        sudo yum clean all && sudo yum install -y $PKG
      elif [[ $distro == "arch" ]];then
        sudo pacman -S --noconfirm --needed $PKG
      else
        :
      fi
    fi
  done
}

function git_clone_or_fetch() {
  local repo="$1"
  local dest="$2"
  local name=$(basename "$repo")
  if [ ! -d "$dest/.git" ];then
    print_default "Installing $name..."
    print_default ""
    mkdir -p $dest
    git clone --depth 1 $repo $dest
  else
    print_default "Pulling $name..."
    (builtin cd $dest && git pull --depth 1 --rebase origin master || \
      print_notice "Exec in compatibility mode [git pull --rebase]" && \
      builtin cd $dest && git fetch --unshallow && git rebase origin/master)
  fi
}

function mkdir_not_exist() {
  if [ ! -d "$1" ];then
    mkdir -p "$1"
  fi
}


