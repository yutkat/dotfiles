
#==============================================================#
##          Key Bindings                                      ##
#==============================================================#

export BIND_OPTION=${BIND_OPTION:=emacs}

# 端末設定
stty intr '^C'        # Ctrl+C に割り込み
stty susp '^Z'        # Ctrl+Z にサスペンド
stty stop undef

# zsh のキーバインド (EDITOR=vi かでも判断)
bindkey -e    # emacs 風
#bindkey -v     # vi 風

## delete ##
bindkey -M $BIND_OPTION '^?'    backward-delete-char
bindkey -M $BIND_OPTION '^H'    backward-delete-char
bindkey -M $BIND_OPTION '^[[3~' delete-char
bindkey -M $BIND_OPTION '^[[3;5~' delete-word
bindkey -M $BIND_OPTION '^[[1~' beginning-of-line
bindkey -M $BIND_OPTION '^[[4~' end-of-line
bindkey -M $BIND_OPTION '^U' backward-kill-line
bindkey -M $BIND_OPTION '^[^?' delete-char-or-list

## move ##
bindkey -M $BIND_OPTION '^[h' backward-char
bindkey -M $BIND_OPTION '^[j' down-line-or-history
bindkey -M $BIND_OPTION '^[k' up-line-or-history
bindkey -M $BIND_OPTION '^[l' forward-char
bindkey -M $BIND_OPTION '^[[1;5C' forward-word
bindkey -M $BIND_OPTION '^[[1;5D' backward-word

## history ##
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -M $BIND_OPTION '^P' history-beginning-search-backward-end
bindkey -M $BIND_OPTION '^N' history-beginning-search-forward-end
bindkey -M $BIND_OPTION '^[[A' history-beginning-search-backward-end
bindkey -M $BIND_OPTION '^[[B' history-beginning-search-forward-end
# history incremental search
#bindkey -M $BIND_OPTION "^R" history-incremental-search-backward
#bindkey -M $BIND_OPTION "^S" history-incremental-search-forward
bindkey -M $BIND_OPTION '^R' history-incremental-pattern-search-backward
bindkey -M $BIND_OPTION '^S' history-incremental-pattern-search-forward
autoload -Uz smart-insert-last-word
# [a-zA-Z], /, \ のうち少なくとも1文字を含む長さ2以上の単語
zstyle :insert-last-word match '*([[:alpha:]/\\]?|?[[:alpha:]/\\])*'
zle -N insert-last-word smart-insert-last-word
function _insert-last-word() { smart-insert-last-word; ARG=-2 }
zle -N _insert-last-word
bindkey -M $BIND_OPTION '^]' _insert-last-word
function insert-next-word() { zle insert-last-word -- 1 -1; ARG=-2 }
zle -N insert-next-word
bindkey -M $BIND_OPTION '^_' insert-next-word
function zle-line-finish() { ARG=-2 }
zle -N zle-line-finish
function insert-prev-arg() { zle insert-last-word -- 0 ${ARG:-2}; ARG=$(($ARG-1)) }
zle -N insert-prev-arg
bindkey -M $BIND_OPTION '^^' insert-prev-arg
bindkey -M $BIND_OPTION '\e#' pound-insert
# anyframe
bindkey -M $BIND_OPTION '^@' anyframe-widget-put-history
bindkey -M $BIND_OPTION '^Xb' anyframe-widget-cdr
bindkey -M $BIND_OPTION '^X^B' anyframe-widget-checkout-git-branch
#bindkey -M $BIND_OPTION '^Xr' anyframe-widget-execute-history
bindkey -M $BIND_OPTION '^X^R' anyframe-widget-execute-history
#bindkey -M $BIND_OPTION '^Xp' anyframe-widget-put-history
bindkey -M $BIND_OPTION '^X^P' anyframe-widget-put-history
#bindkey -M $BIND_OPTION '^Xg' anyframe-widget-cd-ghq-repository
bindkey -M $BIND_OPTION '^X^G' anyframe-widget-cd-ghq-repository
#bindkey -M $BIND_OPTION '^Xk' anyframe-widget-kill
bindkey -M $BIND_OPTION '^X^K' anyframe-widget-kill
#bindkey -M $BIND_OPTION '^Xi' anyframe-widget-insert-git-branch
bindkey -M $BIND_OPTION '^X^I' anyframe-widget-insert-git-branch
#bindkey -M $BIND_OPTION '^Xf' anyframe-widget-insert-filename
bindkey -M $BIND_OPTION '^X^F' anyframe-widget-insert-filename

## completion ##
# shift-tabで補完を逆走
zmodload zsh/complist
bindkey -M $BIND_OPTION '^[[Z' reverse-menu-complete
bindkey -M menuselect '^[[Z' reverse-menu-complete

## edit ##
# copy command
zle -N pbcopy-buffer
bindkey -M $BIND_OPTION '^X^C' pbcopy-buffer
bindkey -M $BIND_OPTION '^[u' undo
bindkey -M $BIND_OPTION '^[r' redo

## etc ##
# ワイルドカードの展開を確認
bindkey -M $BIND_OPTION '^X*' expand-word
# stack command
zle -N show_buffer_stack
bindkey -M $BIND_OPTION '^Q' show_buffer_stack

## zaw ##
#bindkey -M $BIND_OPTION '^@' zaw-cdr
bindkey -M $BIND_OPTION '^Xf' zaw-git-files
bindkey -M $BIND_OPTION '^Xc' zaw-git-branches
bindkey -M $BIND_OPTION '^Xp' zaw-process
bindkey -M $BIND_OPTION '^Xa' zaw-tmux

## auto-fu ##
if type afu+cancel-and-accept-line 1>/dev/null 2>&1; then
  bindkey -M $BIND_OPTION "^M" afu+cancel-and-accept-line
fi

