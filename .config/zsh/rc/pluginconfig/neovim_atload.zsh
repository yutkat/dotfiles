export EDITOR=nvim
alias vi="$EDITOR"
alias sv="sudo $EDITOR"
alias v='nvim -c "PossessionLoadCurrent"'

function snvim() {
	local cwd firejail_bin
	local -a firejail_args

	if [ -x /run/wrappers/bin/firejail ]; then
		firejail_bin=/run/wrappers/bin/firejail
	else
		firejail_bin=/usr/bin/firejail
	fi

	cwd="${PWD:A}"
	firejail_args=(--profile="${XDG_CONFIG_HOME:-$HOME/.config}/firejail/nvim.profile")
	if [ "$cwd" != "$HOME" ] && [ "$cwd" != "/" ]; then
		firejail_args+=(--read-write="$cwd")
	fi
	if [ "${SNVIM_NET:-0}" != "1" ]; then
		firejail_args+=(--net=none)
	fi

	"$firejail_bin" "${firejail_args[@]}" nvim "$@"
}

alias snvim-net='SNVIM_NET=1 snvim'
if (( $+functions[compdef] )); then
	compdef snvim=nvim
fi
