# overwrite bindkey
bindkey() {
	if [[ "$#" -eq 2 && "${1:0:1}" != '-' ]]; then
		builtin bindkey -M afu $@
	elif [ "$#" -eq 0 ]; then
		builtin bindkey -M afu
	else
		builtin bindkey $@
	fi
}
function zle-line-init () {
	auto-fu-init
}
zle -N zle-line-init
#zle_highlight=(default:fg=white)
zstyle ':auto-fu:var' postdisplay $''
## Enterを押したときは自動補完された部分を利用しない。
function afu+cancel-and-accept-line() {
	((afu_in_p == 1)) && { afu_in_p=0; BUFFER="$buffer_cur" }
	zle afu+accept-line
}
zle -N afu+cancel-and-accept-line
bindkey "^M" afu+cancel-and-accept-line

### replace source command ###
# conflict to auto-fu and zsh-syntax-highlighting
# then source ~/.zshrc command is broken
function source_auto-fu_syntax_conflict() {
	if [[ "$1" = "$ZDOTDIR/.zshrc" ]];then
		exec zsh
	else
		source $@
	fi
}
alias source='source_auto-fu_syntax_conflict'

# afu+cancel
function afu+cancel () {
	afu-clearing-maybe
	((afu_in_p == 1)) && { afu_in_p=0; BUFFER="$buffer_cur"; }
}
function bindkey-advice-before () {
	local key="$1"
	local advice="$2"
	local widget="$3"
	[[ -z "$widget" ]] && {
		local -a bind
		bind=(`bindkey -M main "$key"`)
		widget=$bind[2]
	}
	local fun="$advice"
	if [[ "$widget" != "undefined-key" ]]; then
		local code=${"$(<=(cat <<"EOT"
			function $advice-$widget () {
				zle $advice
				zle $widget
			}
			fun="$advice-$widget"
			EOT
))"}
eval "${${${code//\$widget/$widget}//\$key/$key}//\$advice/$advice}"
fi
zle -N "$fun"
bindkey -M afu "$key" "$fun"
}

# override function because I want to display if auto-fu is canceled
function with-afu-trapint-handling () {
local number="$1"; shift
local   name="$1"; shift
case "$WIDGET" in
afu+complete-word) {
		[[ "${LASTWIDGET-}" != afu+complete-word ]] && {
			# XXX: This is most likely menuselecting state ⇒ escape from it.
			return $((128+$number))
		}
	} ;;
history*) { zle send-break; return 0 } ;; # send-break escapes actually.
esac
[[ -n ${afu_match_ret-} ]] && ((${afu_match_ret} == 0)) && {
afu_match_ret=
zle send-break; return 0
}
"$@"
zle -R -c "" "Disable autocompletion"
return $?
}

bindkey-advice-before "^G" afu+cancel
bindkey-advice-before "^[" afu+cancel
bindkey-advice-before "^J" afu+cancel afu+accept-line
