# ZSHZ_CMD=j
ZSHZ_DATA="$ZDATADIR/z"

if builtin command -v fzf > /dev/null 2>&1; then
	function z() {
		if [[ -z "$*" ]]; then
			cd "$(zshz -l 2>&1 | $(__fzfcmd) +s --tac  --prompt "z> " --height ${FZF_TMUX_HEIGHT:-40%} | sed 's/^[0-9,.]* *//')"
		else
			_last_z_args="$@"
			zshz "$@"
		fi
	}

	function zz() {
		cd "$(zshz -l 2>&1 | sed 's/^[0-9,.]* *//' | $(__fzfcmd) --tac --no-sort --prompt "z> " --height ${FZF_TMUX_HEIGHT:-40%} -q "$_last_z_args")"
	}
	alias jj=z
	alias j=zz
fi
