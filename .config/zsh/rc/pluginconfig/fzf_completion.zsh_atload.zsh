# export FZF_COMPLETION_TRIGGER=';'
export FZF_COMPLETION_TRIGGER=''
# bindkey '^^' fzf-completion
# bindkey '^I' menu-select

if builtin command -v auto-fu > /dev/null 2>&1; then
	bindkey '^I' afu+complete-word
elif zle -l | \grep -q 'menu-select' > /dev/null 2>&1; then
	bindkey '^I' menu-select
else
	bindkey '^I' menu-complete
fi
# if builtin command -v .autocomplete.__init__ > /dev/null 2>&1; then
#   bindkey '^I' menu-select
# fi
