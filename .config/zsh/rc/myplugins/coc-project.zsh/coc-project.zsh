
function cd-coc-project() {
	local REPO
	REPO=$(cat ~/.local/share/nvim/coc-projec | jq -r 'keys | .[]' | fzf +m --prompt 'Project> ' --height 40% --reverse --preview "bat --color=always --style=header,grid --line-range :80 {}/README.*")
	if [ -n "${REPO}" ]; then
		BUFFER="cd ${GHQ_ROOT}/${REPO}"
	fi
	zle accept-line
}

zle -N cd-coc-project
#bindkey '^T' cd-coc-project
alias p cd-coc-project

function coc-project() {
	local REPO
	REPO=$(cat ~/.local/share/nvim/coc-projec | jq -r 'keys | .[]' | fzf +m --prompt 'Project> ' --height 40% --reverse --preview "bat --color=always --style=header,grid --line-range :80 {}/README.*")
	if [ -n "${REPO}" ]; then
		BUFFER="${GHQ_ROOT}/${REPO}"
	fi
}
zle -N coc-project
bindkey '^O' coc-project
