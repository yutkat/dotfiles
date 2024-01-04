if [[ ! -e "$HOME/.config/zsh/completions.local/_mise" ]]; then
	mise completion zsh > ~/.config/zsh/completions.local/_mise
fi
