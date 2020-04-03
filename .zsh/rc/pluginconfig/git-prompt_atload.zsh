
PROMPT='[%n@%m:%.$(gitprompt)]${WINDOW:+"[$WINDOW]"}$(__show_status)%# '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[white]%})"
ZSH_THEME_GIT_PROMPT_SEPARATOR="$fg[white]%}|"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[yellow]%}%{+%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg_bold[magenta]%}%{!%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg_bold[red]%}%{*%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[blue]%}%{<%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[blue]%}%{>%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[white]%}%{?%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{/%G%}"
ZSH_THEME_GIT_PROMPT_DETACHED="%{$fg_bold[cyan]%}:"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}%{X%G%}"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[red]%}%{+%G%}"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}%{#%G%}"

