#==============================================================#
## mise
#==============================================================#
# Loaded after the first prompt; the shims dir set in .zshenv covers tools until then.
if builtin command -v mise >/dev/null 2>&1; then
	eval "$(mise activate zsh)"
fi
