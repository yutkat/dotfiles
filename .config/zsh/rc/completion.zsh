
#==============================================================#
##          Completion                                        ##
#==============================================================#

setopt prompt_subst          # Pass escape sequence (environment variable) through prompt

# see http://zsh.sourceforge.net/Doc/Release/Completion-System.html

# :completion:function:completer:command:argument:tag

# Show explanation part with optional completion
zstyle ':completion:*' verbose yes
# Set the completion method. Execute in the specified order.
## _oldlist: Reuse previous completion results.
## _complete: normal completion function
## _ignored: Specify that the command is not a candidate for completion.
## _match: Completion of commands with globs such as *.
## _prefix: Ignore everything after the cursor and complete up to the cursor position.
## _approximate: Similar completion candidates are also completion candidates.
## _expand: Expand globs and variables. It allows finer control than the original expansion.
## _history: Completion from history. Used from _history_complete_word.
## _correct: Correct misspellings before completion.
zstyle ':completion:*' completer _oldlist _complete _ignored
zstyle ':completion:*:messages' format '%F{yellow}%d'
zstyle ':completion:*:warnings' format '%B%F{red}No matches for:''%F{white}%d%b'
zstyle ':completion:*:descriptions' format '%B%F{white}--- %d ---%f%b'
zstyle ':completion:*:corrections' format ' %F{green}%d (errors: %e) %f'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' recent-dirs-insert both
# Color-code the completion candidates (Adapted from GNU ls color definitions)
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*' special-dirs true
# Case insensitive when completing (but if uppercase letters are typed, they are not converted to lowercase)
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
# Some command line definitions take longer to unpack
# apt-get, dpkg (Debian), rpm (Redhat), urpmi (Mandrake), perl's -M option,
# bogofilter (zsh 4.2.1 or later), fink, mac_apps (MacOS X)(zsh 4.2.2 or later)
zstyle ':completion:*' use-cache true
# Select completion candidates with ←↓↑→ (completion candidates are displayed in different colors)
# zstyle show completion menu if 1 or more items to select
zstyle ':completion:*:default' menu select=1
# Candidate directories on cdpath only if there is no candidate in the current directory
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
# Specify order of completion list
zstyle ':completion:*:cd:*' group-order local-directories path-directories
# completion of ps command
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
# completion of sudo command
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
# complete variable subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
# display man completion by section number
zstyle ':completion:*:manuals' separate-sections true
# Display man completions in order of modification date
zstyle ':completion:*' file-sort 'modification'

# make completion is slow
zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:make::' tag-order targets:
zstyle ':completion:*:*:*make:*:targets' command awk \''/^[a-zA-Z0-9][^\/\t=]+:/ {print $1}'\' \$file
#zstyle ':completion:*:*:make:*:targets' ignored-patterns '*.o'
#zstyle ':completion:*:*:*make:*:*' tag-order '!targets !functions !file-patterns'
#zstyle ':completion:*:*:*make:*:*' avoid-completer '_files'
