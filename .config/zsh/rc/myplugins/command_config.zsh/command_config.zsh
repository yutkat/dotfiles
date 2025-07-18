function existsCommand() {
	builtin command -v $1 > /dev/null 2>&1
}

function source-safe() { if [ -f "$1" ]; then source "$1"; fi }

#==============================================================#
## Apply XDG
#==============================================================#
mkdir -p "$XDG_CACHE_HOME"/less
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
mkdir -p "$XDG_CACHE_HOME"/gdb
export SQLITE_HISTORY="$XDG_CACHE_HOME"/sqlite_history

#==============================================================#
## aws completion
#==============================================================#
if existsCommand aws_zsh_completer.sh; then
	source aws_zsh_completer.sh
fi

#==============================================================#
## terraform completion
#==============================================================#
if existsCommand terraform; then
	autoload -U +X bashcompinit && bashcompinit
	complete -o nospace -C /usr/bin/terraform terraform
fi

##==============================================================#
### nerdctl completion
##==============================================================#
if existsCommand nerdctl; then
	if [[ ! -e "$HOME/.config/zsh/completions.local/_nerdctl" ]]; then
		nerdctl completion zsh > ~/.config/zsh/completions.local/_nerdctl
	fi
	compctl -K _nerdctl docker
fi

# this is not required from v2 https://github.com/docker/compose/issues/8550
##==============================================================#
### docker-compose completion
##==============================================================#
#if existsCommand docker-compose; then
#  if [[ ! -e "$HOME/.config/zsh/completions.local/_docker-compose" ]]; then
#    curl -Ls https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/zsh/_docker-compose > ~/.config/zsh/completions.local/_docker-compose
#  fi
#fi

#==============================================================#
## pip completion
#==============================================================#
if existsCommand pip; then
	eval "$(pip completion --zsh)"
fi


##==============================================================#
### pipenv completion
##==============================================================#
# bug: tab completion with autosuggestion and autocompletion
#if existsCommand pipenv; then
#  eval "$(pipenv --completion)"
#fi

##==============================================================#
### poetry completion
##==============================================================#
if existsCommand poetry; then
	if [[ ! -e "$HOME/.config/zsh/completions.local/_poetry" ]]; then
		poetry completions zsh > ~/.config/zsh/completions.local/_poetry
	fi
fi


#==============================================================#
## cargo completion
#==============================================================#
if existsCommand cargo; then
	d=$(readlink -f $HOME/.rustup/toolchains/*/share/zsh/site-functions)
	if [ -d "$d" ]; then
		fpath=($d $fpath)
	fi
fi


#==============================================================#
## npm completion
#==============================================================#
_npm_path_hook() {
	if [[ -n $NPM_DIR ]]; then
		# remove old dir from path
		path=(${path:#$NPM_DIR})
		unset NPM_DIR
	fi

	if [[ -d "${PWD}/node_modules/.bin" ]]; then
		NPM_DIR="${PWD}/node_modules/.bin"
		path=($NPM_DIR $path)
	fi
}
[[ -z $chpwd_functions ]] && chpwd_functions=()
chpwd_functions=($chpwd_functions _npm_path_hook)

#==============================================================#
## Copilot cli
#==============================================================#
# sudo npm install -g @githubnext/github-copilot-cli
# github-copilot-cli auth
if existsCommand github-copilot-cli; then
	eval "$(github-copilot-cli alias -- "$0")"
fi

#==============================================================#
## fasd
#==============================================================#
if existsCommand fasd; then
	eval "$(fasd --init auto)"
	alias d='fasd -d'
	alias f='fasd -f'
	alias vf='f -e vim'
fi
