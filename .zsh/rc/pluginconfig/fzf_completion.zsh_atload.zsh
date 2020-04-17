# export FZF_COMPLETION_TRIGGER=';'
export FZF_COMPLETION_TRIGGER=''
bindkey '^Y' fzf-completion

if builtin command -v auto-fu > /dev/null 2>&1; then
  bindkey '^I' afu+complete-word
fi
