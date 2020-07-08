
#==============================================================#
##         Override Commands                                  ##
#==============================================================#

###     cd      ###
function ls_abbrev() {
  local ls_result
  ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command \
    ls -CF --show-control-char --color=always | sed $'/^\e\[[0-9;]*m$/d')

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

###     rm      ###
function rm-trash() {
  if [ ! -d ~/.trash ]; then
    mkdir ~/.trash
  fi
  if [ -d ~/.trash ]; then
    local date
    date=`date "+%y%m%d-%H%M%S"`
    mkdir ~/.trash/$date
    for j in $@; do
      # skip -
      if [ $j[1,1] != "-" ]; then
        # 対象が ~/.trash/ 以下なファイルならば /bin/rm を呼び出したいな
        if [ -e $j ]; then
          echo "mv $j ~/.trash/$date/"
          command mv $j ~/.trash/$date/
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
  local TRASH_DIR="$HOME/.trash"
  if [ -d $TRASH_DIR ]; then
    local num=$(ls -1 $TRASH_DIR | wc -l)
    local size=$(du -hs $TRASH_DIR)
    echo "${num} files        $size\n"

    # while true; do
    #   echo -n 'Do you want to delete ~/.trash? [y/n]'
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
      local title=$(echo "$cmd" | cut -d ' ' -f 2- | sed -e 's/-\w//g' | awk '{print $1}')
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
    count=$(($(stty size|awk '{print $1}')/2))
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

function zsh-startuptime() {
  for i in $(seq 1 10); do time zsh -i -c exit; done
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

  if [[ -v TMUX ]]; then
    print_info "Update tmux plugins"
    $TMUX_PLUGIN_MANAGER_PATH/tpm/bin/update_plugins all
    print_info "Finish tmux plugins"
  fi

  print_info "Update vim plugins"
  nvim +PlugUpdate +qall
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

