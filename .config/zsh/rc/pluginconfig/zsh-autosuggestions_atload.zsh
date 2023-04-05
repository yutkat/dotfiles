# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

# ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)
# ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

#ZSH_AUTOSUGGEST_USE_ASYNC=true

bindkey "^Y" autosuggest-accept
bindkey "^[[89;5u" autosuggest-accept
#bindkey autosuggest-execute
#bindkey autosuggest-clear
#bindkey autosuggest-fetch
#bindkey autosuggest-disable
#bindkey autosuggest-enable
#bindkey autosuggest-toggle

# This speeds up pasting w/ autosuggest. Disable zsh-autocompletion on paste
# https://github.com/zsh-users/zsh-autosuggestions/issues/238#issuecomment-389324292
pasteinit() {
	OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
	zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
	zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
