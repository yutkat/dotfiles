#!/bin/bash

print_default() {
  echo -e "$*"
}

print_info() {
  echo -e "\e[1;36m$*\e[m" # cyan
}

print_notice() {
  echo -e "\e[1;35m$*\e[m" # magenta
}

print_success() {
  echo -e "\e[1;32m$*\e[m" # green
}

print_warning() {
  echo -e "\e[1;33m$*\e[m" # yellow
}

print_error() {
  echo -e "\e[1;31m$*\e[m" # red
}

print_debug() {
  echo -e "\e[1;34m$*\e[m" # blue
}

chkcmd() {
  if ! builtin command -v "$1";then
    print_error "${1}コマンドが見つかりません"
    exit
  fi
}

yes_or_no_select() {
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

whichdistro() {
  #which yum > /dev/null && { echo redhat; return; }
  #which zypper > /dev/null && { echo opensuse; return; }
  #which apt-get > /dev/null && { echo debian; return; }
  if [ -f /etc/debian_version ]; then
    echo debian; return;
  elif [ -f /etc/redhat-release ] ;then
    echo redhat; return;
  elif [ -f /etc/arch-release ] ;then
    echo arch; return;
  fi
}

checkinstall() {
  local distro=`whichdistro`
  if [[ $distro == "redhat" ]];then
    sudo yum install -y epel-release
  fi

  for PKG in "$@";do
    if ! builtin command -v "$PKG" > /dev/null 2>&1; then
      if [[ $distro == "debian" ]];then
        sudo apt-get install -y $PKG
      elif [[ $distro == "redhat" ]];then
        sudo yum install -y $PKG
      elif [[ $distro == "arch" ]];then
        sudo pacman -S --noconfirm --needed $PKG
      else
        :
      fi
    fi
  done
}

git_clone_or_fetch() {
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
      builtin cd $dest && git fetch --depth 1 && git rebase origin/master)
  fi
}

mkdir_not_exist() {
  if [ ! -d "$1" ];then
    mkdir -p "$1"
  fi
}

