# to remove semicolon on zsh-autocomplete's up-line-or-search
bindkey "^M" accept-line
bindkey "^x^M"   __abbrev_alias::magic_abbrev_expand_and_accept_line

abbrev-alias -g G="| grep"
abbrev-alias -eg ~~='$(git rev-parse --show-cdup)'

# git
abbrev-alias gc='git commit'
abbrev-alias ga='git add .'
abbrev-alias gb='git branch'
abbrev-alias gd='git diff HEAD'
abbrev-alias gs='git status --short'
abbrev-alias gr='gh renew'
abbrev-alias pr='gh pr view -w || gh pr create -w'
