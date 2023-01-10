#==============================================================#
##          Prompt Configuration                              ##
#==============================================================#

###     git      ###
function rprompt-git-current-branch {
	local name st color gitdir action
	if [[ "$PWD" =~ /\.git(/.*)?$ ]]; then
		return
	fi
	name=$(git symbolic-ref HEAD 2> /dev/null)
	name=${name##refs/heads/}
	if [[ -z $name ]]; then
		return
	fi

	gitdir=$(git rev-parse --git-dir 2> /dev/null)
	if ! builtin command -v VCS_INFO_get_data_git > /dev/null 2>&1; then
		autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
	fi
	action=$(VCS_INFO_git_getaction "$gitdir") && action="($action)"

	st=$(git status 2> /dev/null)
	if echo "$st" | grep -q "^nothing to"; then
		color=%F{green}
	elif echo "$st" | grep -q "^nothing added"; then
		color=%F{yellow}
	elif echo "$st" | grep -q "^# Untracked"; then
		color=%B%F{red}
	else
		color=%F{red}
	fi
	echo "($color$name$action%f%b)"
}

# Change % color by return code
function __show_status() {
	exit_status=${pipestatus[*]}
	local SETCOLOR_DEFAULT="%f"
	local SETCOLOR=${SETCOLOR_DEFAULT}
	local s
	for s in $(echo -en "${exit_status}"); do
		if [ "${s}" -eq 147 ] ; then
			SETCOLOR=${SETCOLOR_DEFAULT}
			break
		elif [ "${s}" -gt 100 ] ; then
			SETCOLOR="%F{red}"
			break
		elif [ "${s}" -gt 0 ] ; then
			SETCOLOR="%F{yellow}"
		fi
	done
	if [ "${SETCOLOR}" != "${SETCOLOR_DEFAULT}" ]; then
		echo -ne "${SETCOLOR}(${exit_status// /|})%f%b"
	else
		echo -ne "${SETCOLOR}%f%b"
	fi
}
#pct=$'%0(?||%147(?||%F{red}))%#%f'


# Left prompt
PROMPT='[%n@%m:%.$(rprompt-git-current-branch)]${WINDOW:+"[$WINDOW]"}$(__show_status)%# '
## <escape sequence>.
## If prompt_bang is enabled, then != current history event number, !! ='!' (literal)
# ${WINDOW:+"[$WINDOW]"} = screen number at runtime (prompt_subst is required)
# %B = underline
# %/ or %d = directory (0=all, -1=number from forward)
# %~ = directory
# %h or %! = current history event number
# %L = current $SHLVL value
# %M = full hostname of machine
# %m = first `.' of hostname
# %S (%s) = start (end) of background mode
# %U (%u) = start (end) of underline mode
# %B (%b) = start (end) of bold mode
# %t or %@ = current time in 12-hour format, am/pm
# %n or $USERNAME = user ($USERNAME is an environment variable and requires setopt prompt_subst)
# %N = shell name
# %i = number of line currently executed in script, source, or shell function given by %N (for debug)
# %T = current time in 24-hour format
# %* = current time in 24-hour format, with seconds
# %w = date in `day-day-of-week' format
# %W = date in `month/day/year' format
# %D = date in `year-month-day' format
# %D{string} = string formatted using the strftime function (man 3 strftime shows the format specification)
# %l = the terminal where the user is logged in, stripped of /dev/ prefix # %y = the terminal where the user is logged in, stripped of /dev/ prefix
# %y = user's login terminal without /dev/ prefix (/dev/tty* is sonoma)
# %? = return code of the command executed immediately before the prompt.
# %_ = parser status
# %E = clear to end of line
# %# = `#' if privileged shell is running, otherwise `%' == %(! #. %%)
# %v = value of first element of psvar array parameter
# %{... %} = include string as literal escape sequence
# %(x.true-text.false-text) = triplet expression
# %<string<, %>string>, %[xstring] = truncation behavior for the rest of the prompt
# `<' form truncates the left side of the string, `>' form truncates the right side of the string
# %c, %. , %C = backward component of $PWD

#PROMPT=ubst is required
# Right prompt

# ShellScript Debug
# PS4 for zsh script is overwritten by ~/.zshenv
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
export PROMPT4='+%N:%i> '
