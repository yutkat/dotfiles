# shellcheck disable=SC1009,SC1035,SC1072,SC1073
zmodload -F zsh/datetime p:EPOCHSECONDS
zmodload -F zsh/stat b:zstat

_GIT_AUTO_FETCH_INTERVAL=300
typeset -gA _GIT_AUTO_FETCH_LAST_ATTEMPT

_git_auto_fetch() {
	local dir=$PWD git_dir
	while [[ ! -e $dir/.git ]]; do
		[[ $dir == / ]] && return
		dir=${dir:h}
	done

	if [[ -d $dir/.git ]]; then
		git_dir="$dir/.git"
	else
		git_dir=$(git rev-parse --git-dir 2>/dev/null) || return
	fi

	local now=$EPOCHSECONDS
	local last_attempt=${_GIT_AUTO_FETCH_LAST_ATTEMPT[$git_dir]:-0}
	if ((now - last_attempt <= _GIT_AUTO_FETCH_INTERVAL)); then
		return
	fi

	local last_fetch=0
	local fetch_head="$git_dir/FETCH_HEAD"
	if [[ -f $fetch_head ]]; then
		local -a st
		zstat -A st +mtime "$fetch_head" 2>/dev/null && last_fetch=${st[1]:-0}
	fi

	if ((now - last_fetch > _GIT_AUTO_FETCH_INTERVAL)); then
		_GIT_AUTO_FETCH_LAST_ATTEMPT[$git_dir]=$now
		git fetch --quiet &>/dev/null &!
	fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _git_auto_fetch
