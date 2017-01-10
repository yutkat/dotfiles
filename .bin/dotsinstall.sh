#!/bin/bash

set -ue

source $(dirname "${BASH_SOURCE:-$0}")/utilfuncs.sh


#--------------------------------------------------------------#
##          Functions                                         ##
#--------------------------------------------------------------#

helpmsg() {
  echo "Usage: "${BASH_SOURCE:-$0}" [install | update] [--help | -h]" 0>&2
  echo '  install:  add require package install and symbolic link to $HOME from dotfiles'
  echo '  update: add require package install or update. [default]'
  echo ""
}

install_tmux-powerline() {
  git_clone_or_fetch https://github.com/erikw/tmux-powerline.git \
    "$HOME/.tmux/tmux-powerline"
}

install_tmux-plugins() {
  git_clone_or_fetch https://github.com/tmux-plugins/tpm \
    "$HOME/.tmux/plugins/tpm"
}

install_fzf_local() {
  echo "Installing fzf local..."
  echo ""
  local distro=`whichdistro`
  if [[ $distro == "debian" ]];then
    sudo apt-get install -y ruby ruby-dev gem ncurses-dev
  elif [[ $distro == "redhat" ]];then
    sudo yum install -y ruby ruby-devel rubygems ncurses-devel
  else
    :
  fi
  command cp $fzf_dir/fzf $fzf_dir/bin && \
    echo "export PATH=$PATH:$fzf_dir/bin" > $HOME/.fzf.zsh
}

install_fzf() {
  local fzf_dir="$HOME/.fzf"
  git_clone_or_fetch https://github.com/junegunn/fzf.git \
    $fzf_dir
  $fzf_dir/install --no-key-bindings --completion  --no-update-rc || \
    install_fzf_local
}

install_tmuxinator() {
  local distro=`whichdistro`
  if ! type tmuxinator > /dev/null 2>&1;then
    echo "Installing tmuxinator..."
    echo ""
    if [[ $distro == "debian" ]];then
      sudo apt-get install -y ruby ruby-dev
    elif [[ $distro == "redhat" ]];then
      sudo yum install -y ruby ruby-devel rubygems
    else
      :
    fi
    sudo gem install tmuxinator
    mkdir -p $HOME/.tmuxinator/completion
    wget https://raw.github.com/aziz/tmuxinator/master/completion/tmuxinator.zsh \
      -O $HOME/.tmuxinator/completion/tmuxinator.zsh
  fi
}

link_neovim_config() {
  if [ ! -d ${HOME}/.config ];then
    mkdir ${HOME}/.config
  fi
  ln -snfv ${HOME}/.vim ${HOME}/.config/nvim
  ln -snfv ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim
}


install_i3() {
  local distro=`whichdistro`
  if [[ $distro == "debian" ]];then
    sudo apt-get install -y i3 feh
    sudo apt-get install -y i3blocks gnome-terminal || true
  elif [[ $distro == "redhat" ]];then
    sudo yum install -y i3 feh
    sudo yum install -y gnome-terminal || true
  fi
  setup_gnome_terminal_config
  (cd $(dirname "${BASH_SOURCE:-$0}") && ../.i3/scripts/mkconfig.sh)
}

setup_gnome_terminal_config() {
  if type gnome-terminal > /dev/null 2>&1;then
    $(dirname "${BASH_SOURCE:-$0}")/gnome-terminal-config-restore.sh
  fi
}

setup_i3() {
  local distro=`whichdistro`
  if [[ $distro == "debian" ]];then
    sudo apt-get install -y scrot
  elif [[ $distro == "redhat" ]];then
    sudo yum install -y scrot || true
  fi
  if [ ! -d mkdir ${HOME}/Pictures/screenshots ];then
    mkdir ${HOME}/Pictures/screenshots
  fi
}

copy_to_homedir() {
  local script_dir="$(builtin cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)"
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

  local script_dir="$(builtin cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)"
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
    *)
      ;;
  esac
  shift
done


if [[ ! -e "$HOME/.bin/"$(basename "${BASH_SOURCE:-$0}") ]]; then
  IS_INSTALL=true
fi


if [[ "$IS_INSTALL" = true ]];then
  link_to_homedir
  link_neovim_config
  source $(dirname "${BASH_SOURCE:-$0}")/gitconfig.sh
  echo ""
  echo "#####################################################"
  echo -e "\e[1;36m $(basename "${BASH_SOURCE:-$0}") install success!!! \e[m"
  echo "#####################################################"
  echo ""
fi


if [[ "$IS_UPDATE" = true ]];then
  checkinstall zsh git vim tmux ctags bc wget xsel gawk
  install_i3
  setup_i3
  install_fzf

  if [[ $WITH_TMUX_EXTENSIONS = "true" ]];then
      install_tmux-powerline
      install_tmuxinator
  fi

  echo ""
  echo "#####################################################"
  echo -e "\e[1;36m $(basename "${BASH_SOURCE:-$0}") update finish!!! \e[m"
  echo "#####################################################"
  echo ""
fi

