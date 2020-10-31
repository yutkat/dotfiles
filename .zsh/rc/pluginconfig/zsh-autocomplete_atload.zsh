function precmd_overwrite_options() {
	zstyle ':completion:*:default' menu select=1
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd precmd_overwrite_options
