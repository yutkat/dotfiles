abbrev-alias -g G="| grep"
abbrev-alias -eg ~~='$(git rev-parse --show-cdup)'

# git
abbrev-alias gc='git commit'
abbrev-alias gb='git branch'
abbrev-alias gd='git diff HEAD'
abbrev-alias gs='git status --short'
abbrev-alias pr='gh pr view -w || gh pr create -w'

