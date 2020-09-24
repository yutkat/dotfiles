alias git=hub
alias hubb='hub browse $(ghq list | fzf --prompt "hub> " --height 40% --reverse | cut -d "/" -f 2,3)'
