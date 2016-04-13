#!/bin/bash

set -ue

builtin source $(command dirname $0)/utilfuncs.sh


#--------------------------------------------------------------#
##          Functions                                         ##
#--------------------------------------------------------------#

helpmsg() {
  command echo "Usage: $0 [install | update] [--help | -h]" 0>&2
  command echo '  install:  add require package install and symbolic link to $HOME from dotfiles'
  command echo '  update: add require package install or update. [default]'
  command echo ""
}

install_vim_plug() {
  git_clone_or_fetch https://github.com/junegunn/vim-plug.git \
    $HOME/.vim/plugged/vim-plug
}

install_antigen() {
  git_clone_or_fetch https://github.com/zsh-users/antigen.git \
    "$HOME/.zsh/antigen"
}

install_tmux-powerline() {
  git_clone_or_fetch https://github.com/erikw/tmux-powerline.git \
    "$HOME/.tmux/tmux-powerline"
}

install_tmux-plugins() {
  git_clone_or_fetch https://github.com/tmux-plugins/tpm \
    "$HOME/.tmux/plugins/tpm"
}

install_fzf() {
  local fzf_dir="$HOME/.fzf"
  git_clone_or_fetch https://github.com/junegunn/fzf.git \
    $fzf_dir
  $fzf_dir/install --no-key-bindings --completion  --no-update-rc || \
    command cp $fzf_dir/fzf $fzf_dir/bin
}

install_tmuxinator() {
  local distro=`whichdistro`
  # install tmuxinator
  if ! type tmuxinator;then
    command echo "Installing tmuxinator..."
    command echo ""
    if [[ $distro == "debian" ]];then
      command sudo apt-get install -y ruby ruby-dev
    elif [[ $distro == "redhat" ]];then
      command sudo yum install -y ruby ruby-devel rubygems
    else
      :
    fi
    command sudo gem install tmuxinator
    command mkdir -p $HOME/.tmuxinator/completion
    command wget https://raw.github.com/aziz/tmuxinator/master/completion/tmuxinator.zsh \
      -O $HOME/.tmuxinator/completion/tmuxinator.zsh
  fi
}

copy_to_homedir() {
  local script_dir="$(builtin cd "$(command dirname "${BASH_SOURCE[0]}")" && builtin pwd)"
  local dotdir=$(command readlink -f ${script_dir}/..)
  if [[ "$HOME" != "$dotdir" ]];then
    command echo "cp -r${FORCE_OVERWRITE} ${dotdir}/* ${dotdir}/.[^.]* $HOME"
    if yes_or_no_select; then
      command cp -r${FORCE_OVERWRITE} ${dotdir}/* ${dotdir}/.[^.]* $HOME
    fi
  fi
}

link_to_homedir() {
  command echo "backup old dotfiles..."
  local backupdir="$HOME/.dotbackup"
  if [ ! -d "$backupdir" ];then
    command echo "$backupdir not found. Auto Make it"
    command mkdir "$backupdir"
  fi

  local script_dir="$(builtin cd "$(command dirname "${BASH_SOURCE[0]}")" && builtin pwd)"
  local dotdir=$(command readlink -f ${script_dir}/..)
  if [[ "$HOME" != "$dotdir" ]];then
    for f in $dotdir/.??*; do
      local f_filename=$(command basename $f)
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

if [[ "$IS_INSTALL" = true ]];then
  link_to_homedir
  command echo ""
  command echo "#####################################################"
  command echo -e "\e[1;36m $(command basename $0) install success!!! \e[m"
  command echo "#####################################################"
  command echo ""
fi

if [[ "$IS_UPDATE" = true ]];then
  checkinstall zsh git vim tmux ctags bc wget xsel
  install_tmux-plugins
  install_fzf

  if [[ $WITH_TMUX_EXTENSIONS != "true" ]];then
      install_tmux-powerline
      install_tmuxinator
  fi

  command echo ""
  command echo "#####################################################"
  command echo -e "\e[1;36m $(command basename $0) update finish!!! \e[m"
  command echo "#####################################################"
  command echo ""
fi

