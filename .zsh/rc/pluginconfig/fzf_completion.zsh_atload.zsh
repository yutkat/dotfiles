# export FZF_COMPLETION_TRIGGER=';'
export FZF_COMPLETION_TRIGGER=''
bindkey '^^' fzf-completion

if builtin command -v auto-fu > /dev/null 2>&1; then
  bindkey '^I' afu+complete-word
fi
if builtin command -v _autocomplete._main_complete > /dev/null 2>&1; then
  bindkey '^I' menu-complete
fi
