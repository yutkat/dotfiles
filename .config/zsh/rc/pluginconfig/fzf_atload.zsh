
# export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/\.*" -printf "%T@\t%p\n" | sort -rn | cut -f 2-'
export FZF_CTRL_T_COMMAND='fd --hidden --follow --exclude .git'

export FZF_PREVIEW_OPTS='--preview "$ZRCDIR/myplugins/fzf-preview.sh {}" --bind "?:toggle-preview,ctrl-a:select-all,ctrl-d:preview-page-down,ctrl-u:preview-page-up" --preview-window wrap'
export FZF_DEFAULT_OPTS='--no-mouse --bind "?:toggle-preview,ctrl-a:select-all,ctrl-d:preview-page-down,ctrl-u:preview-page-up"'
export FZF_ALT_C_OPTS=""
export FZF_CTRL_R_OPTS='--preview "$ZRCDIR/myplugins/fzf-preview.sh {}" --bind "?:toggle-preview,ctrl-a:select-all,ctrl-d:preview-page-down,ctrl-u:preview-page-up" --preview-window up:10%:wrap --height 50%'
export FZF_CTRL_T_OPTS="--keep-right $FZF_PREVIEW_OPTS"
export FZF_TMUX_OPTS="-p 90%"

alias -g F="--line-number --no-heading --case-sensitive --hidden --follow 2>/dev/null | $(__fzfcmd) -d ':' --ansi --prompt 'Rg> ' --height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --bind=ctrl-r:toggle-sort $FZF_PREVIEW_OPTS --bind \"enter:execute(nvim {1} +{2} </dev/tty)\""

function fzf-cd-currect() {
	local res
	res=$(find ${1:-.} -type d -not -iwholename '*.git*' 2> /dev/null | FZF_DEFAULT_OPTS=" +m --prompt 'ChangeDir> ' --height 40% --reverse $FZF_PREVIEW_OPTS" $(__fzfcmd))
	if [ -n "$res" ]; then
		BUFFER+="cd $res"
		zle accept-line
	else
		zle redisplay
		return 1
	fi
}
zle -N fzf-cd-currect
bindkey '^Xs' fzf-cd-currect

function fzf-command-search-widget() {
	LBUFFER="${LBUFFER}$(whence -pm '*' | xargs -i basename {} | FZF_DEFAULT_OPTS="--prompt 'SearchCommand> ' --height 40% --reverse $FZF_PREVIEW_OPTS" $(__fzfcmd))"
	local ret=$?
	zle reset-prompt
	return $ret
}
zle -N fzf-command-search-widget
bindkey '^Xc' fzf-command-search-widget
bindkey '^X^c' fzf-command-search-widget

function __gsel() {
	local cmd="command git ls-files"
	setopt localoptions pipefail 2> /dev/null
	eval "$cmd" | FZF_DEFAULT_OPTS=" --prompt 'GitFiles> ' --height ${FZF_TMUX_HEIGHT:-40%} $FZF_PREVIEW_OPTS --reverse -m" $(__fzfcmd) "$@" | while read item; do
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
bindkey '^Xg' fzf-git-files-widget

function gadd() {
	local selected
	selected=$(stdbuf -oL git status -s | FZF_DEFAULT_OPTS="-m --ansi --preview=\"echo {} | awk '{print \$2}' | xargs git diff --color\""  $(__fzfcmd) | awk '{print $2}')
	if [[ -n "$selected" ]]; then
		selected=$(tr '\n' ' ' <<< "$selected")
		git add $(echo $selected)
		echo "Completed: git add $selected"
	fi
}

function vim-fzf-find() {
	local FILE
	FILE=$(find ./ -path '*/\.*' -name .git -prune -o -type f -print 2> /dev/null | FZF_DEFAULT_OPTS="+m $FZF_PREVIEW_OPTS" $(__fzfcmd))
	if [ -n "$FILE" ]; then
		print -s ${EDITOR:-vim} $FILE
		${EDITOR:-vim} $FILE
	fi
}
alias fzf-vim=vim-fzf-find
zle     -N   vim-fzf-find
bindkey '^Xv' vim-fzf-find
alias f='vim-fzf-find'

function _fzf_grep() {
	local selected
	selected=$("$@" | FZF_DEFAULT_OPTS="--prompt 'Grep> ' -m --ansi $FZF_PREVIEW_OPTS"  $(__fzfcmd))
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
