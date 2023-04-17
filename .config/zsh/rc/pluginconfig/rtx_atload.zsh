if [[ ! -e "$HOME/.config/zsh/completions.local/_rtx" ]]; then
	rtx completion zsh > ~/.config/zsh/completions.local/_rtx
fi
