#!/bin/bash

chkcmd() {
  if ! type "$1";then
    echo "${1}コマンドが見つかりません"
    exit
  fi
}

yes_or_no_select() {
  local answer
  echo "Are you ready? [yes/no]"
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
  fi
}

checkinstall() {
  local distro=`whichdistro`

  for PKG in "$@";do
    if ! type "$PKG" > /dev/null 2>&1; then
      if [[ $distro == "debian" ]];then
        sudo apt-get install -y $PKG
      elif [[ $distro == "redhat" ]];then
        sudo yum install -y $PKG
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
    echo "Installing $name..."
    echo ""
    mkdir -p $dest
    git clone $repo $dest
  else
    echo "Pulling $name..."
    (builtin cd $dest; git pull origin master)
  fi
}

