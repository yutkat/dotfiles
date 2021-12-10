
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
  history -E 1  # 全履歴の一覧を出力する
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
        # 対象が ~/.local/share/Trash/ 以下なファイルならば /bin/rm を呼び出したいな
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

  case $TERM in
   *xterm*|rxvt*|(dt|k|E)term|screen*)
     print -Pn "\e]2;ssh $@\a"
     ;;
  esac

  __exec_command_with_tmux "ssh $args"
}

###     sudo      ###
function sudo() {
  local args=$(printf ' %q' "$@")
  __exec_command_with_tmux "sudo $args"
}

function which () {
  (alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot $@
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
  # ターミナルのウィンドウ・タイトルを動的に変更
  case $TERM in
    *xterm*|rxvt*|(dt|k|E)term|screen*)
      print -Pn "\e]2;[%n@%m %d]\a"
      ;;
  esac
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd precmd_prompt

# コマンドが実行される直前に実行
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

  print_info "Update asdf plugins"
  update-asdf-to-latest
  print_info "Finish asdf plugins"

  if [[ -v TMUX ]]; then
    print_info "Update tmux plugins"
    $TMUX_PLUGIN_MANAGER_PATH/tpm/bin/update_plugins all
    print_info "Finish tmux plugins"
  fi

  # https://github.com/wbthomason/packer.nvim/issues/198
  print_info "Update $EDITOR plugins"
  $EDITOR -c 'silent CocUpdateSync' \
    -c 'autocmd User PackerComplete sleep 100m | write ~/.packer.sync.result | qall' \
    -c PackerSync
  cat ~/.packer.sync.result | rg -v 'Press'

  print_info "Finish vim plugins"
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
    echo "${(l:2:)i}: ${msec} [ms]"
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

function vim-startuptime() {
  local file=$1
  local total_msec=0
  local msec
  local i
  for i in $(seq 1 10); do
    msec=$({(TIMEFMT='%mE'; time nvim --headless -c q $file ) 2>&3;} 3>/dev/stdout >/dev/null)
    msec=$(echo $msec | tr -d "ms")
    echo "${(l:2:)i}: ${msec} [ms]"
    total_msec=$(( $total_msec + $msec ))
  done
  local average_msec
  average_msec=$(( ${total_msec} / 10 ))
  echo "\naverage: ${average_msec} [ms]"
}

function vim-startuptime-detail() {
  local file=$1
  local time_file
  time_file=$(mktemp --suffix "_vim_startuptime.txt")
  echo "output: $time_file"
  time nvim --headless --startuptime $time_file -c q $file
  tail -n 1 $time_file | cut -d " " -f1 | tr -d "\n" && echo " [ms]\n"
  cat $time_file | sort -n -k 2 | tail -n 20
}

function vim-profiler() {
  python <(curl -sSL https://raw.githubusercontent.com/hyiltiz/vim-plugins-profile/master/vim-plugins-profile.py)
}

function vim-startuptime-slower-than-default() {
  local file=$1
  local time_file_rc
  time_file_rc=$(mktemp --suffix "_vim_startuptime_rc.txt")
  local time_rc
  time_rc=$(nvim --headless --startuptime ${time_file_rc} -c "quit" $file > /dev/null && tail -n 1 ${time_file_rc} | cut -d " " -f1)

  local time_file_norc
  time_file_norc=$(mktemp --suffix "_vim_startuptime_norc.txt")
  local time_norc
  time_norc=$(nvim --headless --noplugin -u NONE --startuptime ${time_file_norc} -c "quit" $file > /dev/null && tail -n 1 ${time_file_norc} | cut -d " " -f1)

  echo "my vimrc: ${time_rc}s\ndefault vim: ${time_norc}s\n"
  local result
  result=$(scale=3 echo "${time_rc} / ${time_norc}" | bc)
  echo "${result}x slower your Vim than the default."
}

function vim-minimal-env() {
  cd "$(mktemp -d)"
  export HOME=$PWD
  export XDG_CONFIG_HOME=$HOME/.config
  export XDG_DATA_HOME=$HOME/.local/share
  export XDG_CACHE_HOME=$HOME/.cache
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  mkdir -p ~/.config/nvim
  cat << EOF > ~/.config/nvim/init.vim
syntax enable
filetype plugin indent on

call plug#begin(stdpath('data') . '/plugged')
" Plug ''
call plug#end()
EOF
  pwd
  ls -la
}

function vim-minimal-env-packer() {
  cd "$(mktemp -d)"
  export HOME=$PWD
  export XDG_CONFIG_HOME=$HOME/.config
  export XDG_DATA_HOME=$HOME/.local/share
  export XDG_CACHE_HOME=$HOME/.cache
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  mkdir -p ~/.config/nvim
  cat << EOF > ~/.config/nvim/init.lua
vim.cmd [[syntax enable]]
vim.cmd [[filetype plugin indent on]]

local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}
end)
EOF
--- do not write under this line because it was returned

  pwd
  ls -la
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


#==============================================================#
##         For ShellScript                                    ##
#==============================================================#

function version2 {
  echo "$@" | awk -F. '{ printf("%03d%03d\n", $1,$2); }';
}

function version3 {
  echo "$@" | awk -F. '{ printf("%03d%03d%03d\n", $1,$2,$3); }';
}

