
#==============================================================#
##         Override Commands                                  ##
#==============================================================#

###     cd      ###
function ls_abbrev() {
	local ls_result
	ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command \
		\ls -1 -CF --show-control-char --color=always | sed $'/^\e\[[0-9;]*m$/d')

	if [ $(echo "$ls_result" | wc -l | tr -d ' ') -gt 50 ]; then
		echo "$ls_result" | head -n 10
		echo '......'
		echo "$ls_result" | tail -n 10
		echo "${fg_bold[yellow]}$(command ls -1 -A | wc -l | tr -d ' ')" \
			"files exist${reset_color}"
	else
		echo "$ls_result"
	fi
}

function cdwin(){
	line=$(sed -e 's#^J:##' -e 's#\\#/#g' <<< "$@")
	cd "$line"
}

###     history     ###
function history-all() {
	history -E 1
}

function zshaddhistory() {
	emulate -L zsh
	[[ ${1%%$'\n'} != ${~HISTORY_IGNORE} ]]
}

###     rm      ###
function rm-trash() {
	if [ ! -d ~/.local/share/Trash ]; then
		mkdir ~/.local/share/Trash
	fi
	if [ -d ~/.local/share/Trash ]; then
		local date
		date=`date "+%y%m%d-%H%M%S"`
		mkdir ~/.local/share/Trash/$date
		for j in $@; do
			# skip -
			if [ $j[1,1] != "-" ]; then
				# If the target is a file under ~/.local/share/Trash/, I'd like to call /bin/rm
				if [ -e $j ]; then
					echo "mv $j ~/.local/share/Trash/$date/"
					command mv $j ~/.local/share/Trash/$date/
				else
					echo "$j : not found"
				fi
			fi
		done
	else
		command rm $@
	fi
}

function delete-trash() {
	local TRASH_DIR="$HOME/.local/share/Trash"
	if [ -d $TRASH_DIR ]; then
		local num=$(ls -1 $TRASH_DIR | wc -l)
		local size=$(du -hs $TRASH_DIR)
		echo "${num} files        $size\n"

		# while true; do
		#   echo -n 'Do you want to delete ~/.local/share/Trash? [y/n]'
		#   read yn
		#   case $yn in
		#     [Yy] ) break;;
		#     [Nn] ) echo 'exit...'; return;;
		#     * ) echo 'Please type[y/n]';;
		#   esac
		# done
		\rm -rf $TRASH_DIR/*
		echo 'Completely deleted!'
	fi
}


function __exec_command_with_tmux() {
	local cmd="$@"
	if [[ "$(ps -p $(ps -p $$ -o ppid=) -o comm= 2> /dev/null)" =~ tmux ]]; then
		if [[ $(tmux show-window-options -v automatic-rename) != "off" ]]; then
			local title=$(echo "$cmd" | cut -d ' ' -f 2- | tr ' ' '\n'  | grep -v '^-' | sed '/^$/d' | tail -n 1)
			if [ -n "$title" ]; then
				tmux rename-window -- "$title"
			else
				tmux rename-window -- "$cmd"
			fi
			trap 'tmux set-window-option automatic-rename on 1>/dev/null' 2
			eval command "$cmd"
			local ret="$?"
			tmux set-window-option automatic-rename on 1>/dev/null
			return $ret
		fi
	fi
	eval command "$cmd"
}

###     ssh      ###
function ssh() {
	local args=$(printf ' %q' "$@")
	local ppid=$(ps -p $$ -o ppid= 2> /dev/null | tr -d ' ')
	if [[ "$@" =~ .*BatchMode=yes.*ls.*-d1FL.* ]]; then
		command ssh "$args"
		return
	fi

	# @formatter:off
	case $TERM in
		*xterm*|rxvt*|(dt|k|E)term|screen*)
		print -Pn "\e]2;ssh $@\a"
		;;
	esac
	# @formatter:on
	__exec_command_with_tmux "ssh $args"
}

###     sudo      ###
function sudo() {
	local args=$(printf ' %q' "$@")
	__exec_command_with_tmux "sudo $args"
}

### echo ###
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

###     delta      ###
autoload -U delta

### search command ###
function search_commands() {
	# compgen -c will list all the commands you could run.
	# compgen -a will list all the aliases you could run.
	# compgen -b will list all the built-ins you could run.
	# compgen -k will list all the keywords you could run.
	# compgen -A function will list all the functions you could run.
	# compgen -A function -abck will list all the above in one go.
	local selected
	selected=$(compgen -c | FZF_DEFAULT_OPTS="-m --ansi --preview=\"command -V {}\""  $(__fzfcmd))
	if [[ -n "$selected" ]]; then
		echo "$selected $(command -V $selected)"
	fi
	return $ret
}


#==============================================================#
##         Override Shell Functions                           ##
#==============================================================#

###     copy     ###
function pbcopy() {
	local input
	if [ -p /dev/stdin ]; then
		if [ "`echo $@`" == "" ]; then
			input=`cat -`
		else
			input=$@
		fi
	else
		input=$@
	fi
	if [ "$WAYLAND_DISPLAY" != "" ]; then
		if builtin command -v wl-copy > /dev/null 2>&1; then
			echo -n $input | wl-copy
		fi
	else
		if builtin command -v xsel > /dev/null 2>&1; then
			echo -n $input | xsel -i --primary
			echo -n $input | xsel -i --clipboard
		elif builtin command -v xclip > /dev/null 2>&1; then
			echo -n $input | xclip -i -selection primary
			echo -n $input | xclip -i -selection clipboard
		fi
	fi
}

###     paste     ###
function pbpaste() {
	if builtin command -v xsel > /dev/null 2>&1; then
		xsel -o --clipboard
	elif builtin command -v xclip > /dev/null 2>&1; then
		xclip -o clipboard
	fi
}

###     copy buffer     ###
function pbcopy-buffer() {
	print -rn $BUFFER | pbcopy
	zle -M "pbcopy: ${BUFFER}"
}

###     stack command     ###
function show_buffer_stack() {
	POSTDISPLAY="
	stack: $LBUFFER"
	zle push-line-or-edit
}

function precmd_prompt() {
	[[ -t 1 ]] || return
	# Change terminal window title dynamically
	# @formatter:off
	case $TERM in
		*xterm*|rxvt*|(dt|k|E)term|screen*)
		print -Pn "\e]2;[%n@%m %d]\a"
		;;
	esac
	# @formatter:on
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd precmd_prompt

#function preexec() {
#  [[ -t 1 ]] || return
#  case $TERM in
#    *xterm*|rxvt|(dt|k|E)term|screen*)
#      print -Pn "\e]0;$1\a"
#      ;;
#  esac
#}


### directory back/forward ###
path_history=($(pwd))
path_history_index=1
path_history_size=1

function push_path_history() {
	local curr_path
	curr_path=$1
	if [ $curr_path != $path_history[$path_history_index] ]; then
		local path_history_cap
		path_history_cap=$#path_history
		if [ $path_history_index -eq $path_history_cap ]; then
			local next_cap
			next_cap=$(($path_history_cap * 2))
			path_history[$next_cap]=
		fi
		path_history_index=$(($path_history_index+1))
		path_history[$path_history_index]=$curr_path
		path_history_size=$path_history_index
	fi
}

function dir_back() {
	if [ $path_history_index -ne 1 ]; then
		path_history_index=$(($path_history_index-1))
		local prev_path
		prev_path=$path_history[$path_history_index]
		echo "cd $prev_path"
		cd $prev_path
		zle accept-line
	fi
}

function dir_forward() {
	if [ $path_history_index -ne $path_history_size ]; then
		path_history_index=$(($path_history_index+1))
		local next_path
		next_path=$path_history[$path_history_index]
		echo "cd $next_path"
		cd $next_path
		zle accept-line
	fi
}

function reset_path_history() {
	path_history=($(pwd))
	path_history_index=1
	path_history_size=1
}

function chpwd() {
	push_path_history $(pwd)
	ls_abbrev
}


#==============================================================#
##         New Commands                                      ##
#==============================================================#

# move bottom
function blank() {
	local count=10
	if [[ $@ -eq 0 ]]; then
		count=$(($(stty size| cut -d' ' -f1)/2))
	else
		count=$1
	fi
	for i in $(seq $count); do
		echo
	done
}

function 256color() {
	for code in {000..255}; do
		print -nP -- "%F{$code}$code %f";
		if [ $((${code} % 16)) -eq 15 ]; then
			echo ""
		fi
	done
}

function ascii_color_code() {
	seq 30 47 | xargs -n 1 -i{} printf "\x1b[%dm#\x1b[0m %d\n" {} {}
}

function cursor_block() {
	echo -ne '\e[1 q'
}

function cursor_bar() {
	echo -ne '\e[5 q'
}

function find_no_new_line_at_end_of_file() {
	find * -type f -print0 | xargs -0 -L1 bash -c 'test "$(tail -c 1 "$0")" && echo "No new line at end of $0"'
}


function change_terminal_title() {
	if typeset -f precmd > /dev/null; then
		unfunction precmd
	fi
	if [ "$#" -gt 0 ]; then
		echo -ne "\033]0;$@\007"
		return
	fi
	echo "Please reload zsh"
}

function xmodmap-reload() {
	setxkbmap -layout $(setxkbmap -query | grep layout | awk '{print $2}') && xmodmap ~/.Xmodmap
}

function xkbd-reload() {
	xkbcomp -I$HOME/.xkb ~/.xkb/keymap/mykbd $DISPLAY 2> /dev/null
}

function get_stdin_and_args() {
	local __str
	if [ -p /dev/stdin ]; then
		if [ "`echo $@`" == "" ]; then
			__str=`cat -`
		else
			__str="$@"
		fi
	else
		__str="$@"
	fi
	echo "$__str"
}

function ltrim() {
	local input
	input=$(get_stdin_and_args "$@")
	printf "%s" "`expr "$input" : "^[[:space:]]*\(.*[^[:space:]]\)"`"
}

function rtrim() {
	local input
	input=$(get_stdin_and_args "$@")
	printf "%s" "`expr "$input" : "^\(.*[^[:space:]]\)[[:space:]]*$"`"
}

function trim() {
	local input
	input=$(get_stdin_and_args "$@")
	printf "%s" "$(rtrim "$(ltrim "$input")")"
}

function trim_all_whitespace() {
	local input
	input=$(get_stdin_and_args "$@")
	echo "$input" | tr -d ' '
}

function plugupdate() {
	print_info "Update zinit plugins"
	zinit update --all -p 20
	print_info "Finish zinit plugins"

	if [[ -e ~/.tool-versions ]]; then
		print_info "Update asdf plugins"
		update-asdf-to-latest
		print_info "Finish asdf plugins"
	fi

	if [[ -v TMUX ]]; then
		print_info "Update tmux plugins"
		$TMUX_PLUGIN_MANAGER_PATH/tpm/bin/update_plugins all
		print_info "Finish tmux plugins"
	fi

	print_info "Update $EDITOR plugins"
	$EDITOR --headless -c 'Lazy! sync' -c 'qall'

	print_info "Update $EDITOR mason"
	$EDITOR --headless -c 'lua require("mason-registry").refresh(); require("mason-registry").update()' -c 'qall'

	print_info "Finish Neovim plugins"
}

function convert_ascii_to_hex() {
	echo -n "$@" | xxd -ps -c 200
}

function convert_hex_to_ascii() {
	echo -n "$@" | xxd -ps -r
}

function convert_hex_to_formatted_hex() {
	echo -n "$@" | sed 's/[[:xdigit:]]\{2\}/\\x&/g'
}

function count_line_per_project() {
	if [ $# = 1 ]; then
		option="-t \"${1}\""
	else
		option=""
	fi

	command ls -1 | xargs -i sh -c "echo -n {}' '; tokei ${option} {} -o json | jq '.Total.code'"
}

function search_archived_repo() {
	ls -1 | xargs -i sh -c "cd {} && gh api repos/{owner}/{repo} --jq '.name + \": \" + (.archived|tostring)' 2>/dev/null" | grep " true"
}

function __show_git_modified_date() {
	for d in $(ls -1); do
		(
			cd $d > /dev/null
			local repo=$(basename $(pwd))
			echo -n "${repo} "
			local log=$(git log -1 --date='format-local:%Y-%m-%dT%H:%M:%SZ' --format="%at %cd")
			echo ${log}
		)
	done
}

function show_git_modified_date() {
	__show_git_modified_date | sort -n -k 2 | cut -d ' ' -f 1,3- | column -t
}

#==============================================================#
##         Profiler                                           ##
#==============================================================#

function zsh-startuptime() {
	local total_msec=0
	local msec
	local i
	for i in $(seq 1 10); do
		msec=$((TIMEFMT='%mE'; time zsh -i -c exit) 2>/dev/stdout >/dev/null)
		msec=$(echo $msec | tr -d "ms")
		echo "${(l:2:)i}: ${msec}"
		total_msec=$(( $total_msec + $msec ))
	done
	local average_msec
	average_msec=$(( ${total_msec} / 10 ))
	echo "\naverage: ${average_msec} [ms]"
}

function zsh-profiler() {
	ZSHRC_PROFILE=1 zsh -i -c zprof
}

function zsh-startuptime-slower-than-default() {
	local time_rc
	time_rc=$((TIMEFMT="%mE"; time zsh -i -c exit) &> /dev/stdout)
	# time_norc=$((TIMEFMT="%mE"; time zsh -df -i -c exit) &> /dev/stdout)
	# compinit is slow
	local time_norc
	time_norc=$((TIMEFMT="%mE"; time zsh -df -i -c "autoload -Uz compinit && compinit -C; exit") &> /dev/stdout)
	echo "my zshrc: ${time_rc}\ndefault zsh: ${time_norc}\n"

	local result
	result=$(scale=3 echo "${time_rc%ms} / ${time_norc%ms}" | bc)
	echo "${result}x slower your zsh than the default."
}

function zsh-minimal-env() {
	cd "$(mktemp -d)"
	ZDOTDIR=$PWD HOME=$PWD zsh -df
}

function nvim-startuptime() {
	local file=$1
	local total_msec=0
	local msec
	local i
	for i in $(seq 1 10); do
		msec=$({(TIMEFMT='%mE'; time nvim --headless -c q $file ) 2>&3;} 3>/dev/stdout >/dev/null)
		msec=$(echo $msec | tr -d "ms")
		echo "${(l:2:)i}: ${msec}"
		total_msec=$(( $total_msec + $msec ))
	done
	local average_msec
	average_msec=$(( ${total_msec} / 10 ))
	echo "\naverage: ${average_msec} [ms]"
}

function nvim-profiler() {
	local file=$1
	local time_file
	time_file=$(mktemp --suffix "_nvim_startuptime.txt")
	echo "output: $time_file"
	time nvim --headless --startuptime $time_file -c q $file
	tail -n 1 $time_file | cut -d " " -f1 | tr -d "\n" && echo " [ms]\n"
	cat $time_file | sort -n -k 2 | tail -n 20
}

function vim-profiler() {
	python <(curl -sSL https://raw.githubusercontent.com/hyiltiz/vim-plugins-profile/master/vim-plugins-profile.py)
}

function nvim-startuptime-slower-than-default() {
	local file=$1
	local time_file_rc
	time_file_rc=$(mktemp --suffix "_nvim_startuptime_rc.txt")
	local time_rc
	time_rc=$(nvim --headless --startuptime ${time_file_rc} -c "quit" $file > /dev/null && tail -n 1 ${time_file_rc} | cut -d " " -f1)

	local time_file_norc
	time_file_norc=$(mktemp --suffix "_nvim_startuptime_norc.txt")
	local time_norc
	time_norc=$(nvim --headless --noplugin -u NONE --startuptime ${time_file_norc} -c "quit" $file > /dev/null && tail -n 1 ${time_file_norc} | cut -d " " -f1)

	echo "my neovim: ${time_rc}ms\ndefault neovim: ${time_norc}ms\n"
	local result
	result=$(scale=3 echo "${time_rc} / ${time_norc}" | bc)
	echo "${result}x slower your Neovim than the default."
}

function set_home_current_dir() {
	export HOME=$PWD
	export XDG_CONFIG_HOME=$HOME/.config
	export XDG_DATA_HOME=$HOME/.local/share
	export XDG_CACHE_HOME=$HOME/.cache
}

function nvim-minimal-env-lazy() {
	cd "$(mktemp -d)"
	set_home_current_dir
	mkdir -p ~/.config/nvim
	cat << EOF > ~/.config/nvim/init.lua
vim.cmd [[syntax enable]]
vim.cmd [[filetype plugin indent on]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "nvim-lua/plenary.nvim" },
	{ "MunifTanjim/nui.nvim" },
	{ "neovim/nvim-lspconfig" },
	{
		"williamboman/mason.nvim",
		event = "BufReadPre",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = "BufReadPre",
		config = function()
			require("mason-lspconfig").setup()
			local lspconfig = require("lspconfig")
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({})
				end,
			})
		end,
	},
}, {
	defaults = {
		lazy = true,
	},
})
EOF

	pwd
	ls -la
}

function arch-package-count() {
	echo -n "All Packages: "
	pacman -Q | wc -l
	echo -n "  Packages: "
	pacman -Qe | wc -l
	echo -n "    Official Packages: "
	pacman -Qen | wc -l
	echo -n "    AUR Packages: "
	pacman -Qem | wc -l
	echo -n "  Dependent Packages: "
	pacman -Qd | wc -l
	echo -n "    Official Dependent Packages: "
	pacman -Qdn | wc -l
	echo -n "    AUR Dependent Packages: "
	pacman -Qdm | wc -l
}


#==============================================================#
##         App Utils                                          ##
#==============================================================#

function xauth-paste() {
	local input
	if [[ "$#" -eq 1 ]]; then
		input=$1
	elif [[ "$#" -eq 0 ]]; then
		input=$(pbpaste)
	else
		return 1
	fi
	if [[ -z "$input" ]]; then
		echo "Empty input"
		return 1
	fi
	if [[ -z "$DISPLAY" ]]; then
		echo "DISPLAY variable does not found"
		return 1
	fi
	xauth add ${DISPLAY} . ${input}
	xauth list
}

function rename_wezterm_title() {
	echo "\x1b]1337;SetUserVar=panetitle=$(echo -n $1 | base64)\x07"
}

function change_background() {
	local color=${1:-0000ff}
	# Set default background to bright blue
	printf "\x1b]11;#${color}\x1b\\"
}

function wezterm() {
  if [ "$#" == 0 ]; then
    command wezterm
    return
  fi
  if [ "$1" == "ssh" ]; then
    # if [ "$2" =~ ".*example.com" ]; then
      command wezterm $@ -- sh -c 'printf "\033]1337;SetUserVar=%s=%s\007" production `echo -n 1 | base64`; eval $SHELL'
      return
    # fi
  fi
  command wezterm $@
}


#==============================================================#
##         For ShellScript                                    ##
#==============================================================#

function version2 {
  echo "$@" | awk -F. '{ printf("%03d%03d\n", $1,$2); }';
}

function version3 {
  echo "$@" | awk -F. '{ printf("%03d%03d%03d\n", $1,$2,$3); }';
}
