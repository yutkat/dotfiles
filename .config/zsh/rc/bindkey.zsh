#==============================================================#
##          Key Bindings                                      ##
#==============================================================#

# alt keys '^[' are tmux's bindkey

stty intr '^C'        # Ctrl+C cancel
stty susp '^Z'        # Ctrl+Z suspend
stty stop undef

# zsh key bindings (also determine if EDITOR=vi)
bindkey -e    # emacs like
#bindkey -v     # vi like

# remap
bindkey -s '^[[32;2u' ' '

## delete ##
bindkey '^?'    backward-delete-char
bindkey '^H'    backward-delete-char
bindkey '^[[3~' delete-char
bindkey '^[[3;5~' delete-word

## jump ##
bindkey  '^[[H' beginning-of-line
bindkey  '^[[F' end-of-line
bindkey  '^[[69;5u' end-of-line # Ctrl-Shift-e
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[7~' beginning-of-line
bindkey '^[[8~' end-of-line
bindkey '^U' backward-kill-line
bindkey '^[^?' delete-char-or-list

## move ##
#bindkey '^[h' backward-char
#bindkey '^[j' down-line-or-history
#bindkey '^[k' up-line-or-history
#bindkey '^[l' forward-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

## history ##
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
# broken with auto-suggestion
#bindkey '^P' history-beginning-search-backward-end
#bindkey '^N' history-beginning-search-forward-end
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward
#bindkey "^[p" history-beginning-search-backward
#bindkey "^[n" history-beginning-search-forward
#bindkey '^[[A' history-beginning-search-backward-end
#bindkey '^[[B' history-beginning-search-forward-end
# history incremental search
#bindkey "^R" history-incremental-search-backward
#bindkey "^S" history-incremental-search-forward
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
autoload -Uz smart-insert-last-word
# Words of length 2 or more containing at least one of [a-zA-Z], /, or \
	zstyle :insert-last-word match '*([[:alpha:]/\\]?|?[[:alpha:]/\\])*'
zle -N insert-last-word smart-insert-last-word
function _insert-last-word() { smart-insert-last-word; ARG=-2 }
zle -N _insert-last-word
bindkey '^]' _insert-last-word
function insert-next-word() { zle insert-last-word -- 1 -1; ARG=-2 }
zle -N insert-next-word
bindkey '^_' insert-next-word
function zle-line-finish() { ARG=-2 }
zle -N zle-line-finish
function insert-prev-arg() { zle insert-last-word -- 0 ${ARG:-2}; ARG=$(($ARG-1)) }
zle -N insert-prev-arg
bindkey '^^' insert-prev-arg
bindkey '\e#' pound-insert

## cd ##
function cd-up { zle push-line && LBUFFER='builtin cd ..' && zle accept-line }
zle -N cd-up
zle -N dir_forward
zle -N dir_back
bindkey '^[[1;6C' dir_forward
bindkey '^[[1;6D' dir_back

## completion ##
# shift-tab to reverse completion
zmodload zsh/complist
bindkey '^[[Z' reverse-menu-complete
bindkey -M menuselect '^[[Z' reverse-menu-complete

## edit ##
# copy command
zle -N pbcopy-buffer
bindkey '^X^Y' pbcopy-buffer
bindkey '^Xy' pbcopy-buffer
bindkey '^[u' undo
bindkey '^[r' redo

# edit command-line using editor (like fc command)
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

## etc ##
# Check wildcard expansion
bindkey '^X*' expand-word
# stack command
zle -N show_buffer_stack
bindkey '^Q' show_buffer_stack

#bindkey '^X^F' vi-find-prev-char


# Remap reserved keys
# C-g
# C-j fzf-preview
# C-o mru
# C-t find file
# C-y completion
# C-s snippet
