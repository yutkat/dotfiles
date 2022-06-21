#!/usr/bin/env bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

function backup_and_link() {
	local link_src_file=$1
	local link_dest_dir=$2
	local backupdir=$3
	local f_filename
	f_filename=$(basename "$link_src_file")
	local f_filepath="$link_dest_dir/$f_filename"
	if [[ -L "$f_filepath" ]]; then
		command rm -f "$f_filepath"
	fi

	if install_by_local_installer "$link_src_file" "$backupdir"; then
		return
	fi

	if [[ -e "$f_filepath" && ! -L "$f_filepath" ]]; then
		command mv "$f_filepath" "$backupdir"
	fi
	print_default "Creating symlink for $link_src_file -> $link_dest_dir"
	command ln -snf "$link_src_file" "$link_dest_dir"
}

function install_by_local_installer() {
	local link_src_file=$1
	local backupdir=$2

	local file_list
	file_list=$(command find "$link_src_file" -name "_install.sh" -type f 2>/dev/null)
	if [[ -n "$file_list" ]]; then
		if [[ -e "$f_filepath" ]]; then
			command cp -r "$f_filepath" "$backupdir"
		fi
		for f in $file_list; do
			eval "$f"
		done
		return 0
	fi
	return 1
}

function link_config_dir() {
	local dotfiles_dir=$1
	local backupdir="${2}/.config"
	mkdir_not_exist "$backupdir"
	local dest_dir="${HOME}/.config" # ${XDG_CONFIG_HOME}
	mkdir_not_exist "$dest_dir"

	for f in "$dotfiles_dir"/.config/??*; do
		backup_and_link "$f" "$dest_dir" "$backupdir"
	done
}

function link_to_homedir() {
	print_notice "backup old dotfiles..."
	local tmp_date
	tmp_date=$(date '+%y%m%d-%H%M%S')
	local backupdir="${XDG_CACHE_HOME:-$HOME/.cache}/dotbackup/$tmp_date"
	mkdir_not_exist "$backupdir"
	print_info "create backup directory: $backupdir\n"

	print_info "Creating symlinks"
	local current_dir
	current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
	local dotfiles_dir
	dotfiles_dir="$(builtin cd "$current_dir" && git rev-parse --show-toplevel)"
	linkignore=()
	if [[ -e "$dotfiles_dir/.linkignore" ]]; then
		mapfile -t linkignore <"$dotfiles_dir/.linkignore"
	fi
	if [[ "$HOME" != "$dotfiles_dir" ]]; then
		for f in "$dotfiles_dir"/.??*; do
			local f_filename
			f_filename=$(basename "$f")
			[[ ${linkignore[*]} =~ $f_filename ]] && continue
			[[ "$f_filename" == ".config" ]] && link_config_dir "$dotfiles_dir" "$backupdir" && continue
			backup_and_link "$f" "$HOME" "$backupdir"
		done
	fi
}

link_to_homedir
