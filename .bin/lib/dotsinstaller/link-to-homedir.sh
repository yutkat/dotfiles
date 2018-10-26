#!/bin/bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

function backup_and_link() {
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

function link_config_dir() {
  local backupdir="$HOME/.dotbackup/.config"
  mkdir_not_exist $backupdir
  local dest_dir="${HOME}/.config" # ${XDG_CONFIG_HOME}
  mkdir_not_exist $dest_dir

  local dotfiles_dir=$1
  for f in $dotfiles_dir/.config/??*; do
    backup_and_link $f $dest_dir $backupdir
  done

}

function link_to_homedir() {
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

link_to_homedir
