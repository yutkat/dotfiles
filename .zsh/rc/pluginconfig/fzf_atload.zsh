
# export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/\.*" -printf "%T@\t%p\n" | sort -rn | cut -f 2-'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

export FZF_DEFAULT_OPTS='--bind ctrl-a:select-all --preview
        "
        if [[ $(file --mime {}) =~ /directory ]]; then
          echo {} is a directory;
        elif [[ $(file --mime {}) =~ binary ]]; then
          echo {} is a binary file;
        elif [[ {} == *:* ]]; then
          f=$(echo {} | cut -d : -f 1); n=$(echo {} | cut -d : -f 2) &&
           ((bat --color=always --style=grid $f ||
            tail +$n $f) 2>/dev/null | tail +$n | head -500);
        elif [[ -e $(echo {} | cut -d \" \" -f 2 2>/dev/null) ]]; then
          f=$(echo {} | cut -d \" \" -f 2);
           ((bat --color=always --style=grid $f) 2>/dev/null | head -500);
        elif [[ ! -e {} ]]; then
          :
        else
          (bat --color=always {} ||
           cat {} | head -500) 2> /dev/null;
        fi
        "
        --bind "?:toggle-preview"
        --preview-window hidden:wrap
        '


function fzf-z-search() {
  local res
  res=$(find ${1:-.} -type d -not -iwholename '*.git*' 2> /dev/null | fzf +m --prompt 'FindFile> ' --height 40% --reverse)
  if [ -n "$res" ]; then
    BUFFER+="cd $res"
    zle accept-line
  else
    zle redisplay
    return 1
  fi
}
zle -N fzf-z-search
bindkey '^F' fzf-z-search
bindkey '^Xs' fzf-z-search

function fzf-command-search-widget() {
  LBUFFER="${LBUFFER}$(whence -pm '*' | xargs -i basename {} | fzf --prompt 'SearchCommand> ' --height 40% --reverse)"
  local ret=$?
  zle reset-prompt
  return $ret
}
zle -N fzf-command-search-widget
bindkey '^Xc' fzf-command-search-widget
bindkey '^o' fzf-command-search-widget

function __gsel() {
  local cmd="command git ls-files"
  setopt localoptions pipefail 2> /dev/null
  eval "$cmd" | $(__fzfcmd) --prompt "GitFiles> " --height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_CTRL_T_OPTS -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

function fzf-git-files-widget() {
  LBUFFER="${LBUFFER}$(__gsel)"
  local ret=$?
  zle reset-prompt
  return $ret
}
zle     -N   fzf-git-files-widget
bindkey '^B' fzf-git-files-widget
bindkey '^Xg' fzf-git-files-widget

function gadd() {
  local selected
  selected=$(stdbuf -oL git status -s | fzf -m --ansi --preview="echo {} | awk '{print \$2}' | xargs git diff --color" | awk '{print $2}')
  if [[ -n "$selected" ]]; then
    selected=$(tr '\n' ' ' <<< "$selected")
    git add $(echo $selected)
    echo "Completed: git add $selected"
  fi
}

function vim-fzf-find() {
  local FILE
  FILE=$(find ./ -path '*/\.*' -name .git -prune -o -type f -print 2> /dev/null | fzf +m)
  if [ -n "$FILE" ]; then
    ${EDITOR:-vim} $FILE
  fi
}
alias fzf-vim=vim-fzf-find
zle     -N   vim-fzf-find
bindkey '^Xv' vim-fzf-find
bindkey '^y' vim-fzf-find

# if existsCommand zshz; then
#   function z() {
#     if [[ -z "$*" ]]; then
#       cd "$(zshz -l 2>&1 | fzf +s --tac  --prompt "z> " --height ${FZF_TMUX_HEIGHT:-40%} | sed 's/^[0-9,.]* *//')"
#     else
#       _last_z_args="$@"
#       zshz "$@"
#     fi
#   }
#
#   function zz() {
#     cd "$(zshz -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf --prompt "z> " --height ${FZF_TMUX_HEIGHT:-40%} -q "$_last_z_args")"
#   }
#   alias j=z
#   alias jj=zz
# fi

function _fzf_grep() {
  local selected
  selected=$("$@" | fzf --prompt "Grep> " -m --ansi --preview='
      f=$(echo {} | cut -d : -f 1); n=$(echo {} | cut -d : -f 2) &&
        (bat --color=always --style=grid <(tail +$n $f) ||
          highlight -O ansi -l <(tail +$n $f) ||
          coderay <(tail +$n $f) ||
          rougify <(tail +$n $f) ||
          tail +$n $f) 2> /dev/null')
  if [[ -n "$selected" ]]; then
    selected=$(tr '\n' ' ' <<< "$(echo $selected | cut -d : -f 1)")
    vi $(echo $selected)
  fi
}
function fzfag() {
  _fzf_grep ag $@
}
function fzfrg() {
  _fzf_grep rg -n $@
}

