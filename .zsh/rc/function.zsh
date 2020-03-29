
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

###     ssh      ###
function ssh() {
  local ppid=$(ps -p $$ -o ppid= 2> /dev/null | tr -d ' ')
  if [[ "$@" =~ .*BatchMode=yes.*ls.*-d1FL.* ]]; then
    command ssh "$@"
    return
  fi

  case $TERM in
    *xterm*|rxvt*|(dt|k|E)term|screen*)
      print -Pn "\e]2;sudo $@\a"
      ;;
  esac

  if [[ $ppid != 0 && "$(ps -p $ppid -o comm= 2> /dev/null)" =~ tmux ]]; then
    if [[ $(tmux show-window-options "automatic-rename" | cut -d ' ' -f 1) != "off" ]]; then
      local title=$(echo $@ | sed -e 's/.* \(.*\)@/\1@/' | cut -d ' ' -f 1)
      tmux rename-window -- "$title"
      command ssh "$@"
      local ret="$?"
      tmux set-window-option automatic-rename on 1>/dev/null
      return $ret
    fi
  fi
  command ssh "$@"
}

###     sudo      ###
function sudo() {
  if [[ "$(ps -p $(ps -p $$ -o ppid=) -o comm= 2> /dev/null)" =~ tmux ]]; then
    if [[ $(tmux show-window-options "automatic-rename" | cut -d ' ' -f 1) != "off" ]]; then
      local title=$(echo $@ | sed -e 's/-\w//g' | awk '{print $1}')
      if [ -n "$title" ]; then
        tmux rename-window -- "$title"
      else
        tmux rename-window -- sudo
      fi
      command sudo "$@"
      local ret="$?"
      tmux set-window-option automatic-rename on 1>/dev/null
      return $ret
    fi
  fi
  command sudo "$@"
}

function which () {
  (alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot $@
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

function precmd() {
  [[ -t 1 ]] || return
  # ターミナルのウィンドウ・タイトルを動的に変更
  case $TERM in
    *xterm*|rxvt*|(dt|k|E)term|screen*)
      print -Pn "\e]2;[%n@%m %~]\a"
      ;;
  esac
}

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

