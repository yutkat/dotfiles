
#==============================================================#
##          Function                                          ##
#==============================================================#

###     cd      ###
chpwd() {
  ls_abbrev
}
ls_abbrev() {
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

###     history     ###
function history-all {
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

### replace source command ###
# conflict to auto-fu and zsh-syntax-highlighting
# then source ~/.zshrc command is broken
function source_auto-fu_syntax_conflict() {
  if [[ "$1" = "$ZDOTDIR/.zshrc" ]];then
    exec zsh
  else
    source $@
  fi
}


# ターミナルのウィンドウ・タイトルを動的に変更
precmd() {
  [[ -t 1 ]] || return
  case $TERM in
    *xterm*|rxvt|(dt|k|E)term|screen*)
      print -Pn "\e]2;[%n@%m %~]\a"
      ;;
  esac
}

# コマンドが実行される直前に実行
#preexec() {
#  [[ -t 1 ]] || return
#  case $TERM in
#    *xterm*|rxvt|(dt|k|E)term|screen*)
#      print -Pn "\e]0;$1\a"
#      ;;
#  esac
#}

