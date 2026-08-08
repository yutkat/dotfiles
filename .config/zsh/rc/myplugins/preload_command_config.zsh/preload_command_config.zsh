#==============================================================#
## nix-direnv
#==============================================================#
if builtin command -v direnv >/dev/null 2>&1; then
	eval "$(direnv hook zsh)"
fi

if builtin command -v mise >/dev/null 2>&1; then
	eval "$(mise activate zsh)"
fi
