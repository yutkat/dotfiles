# -C skips compinit's check for new completion files; run the full check once a day
ZINIT[COMPINIT_OPTS]=-C
_zcompdump_stale=($ZDOTDIR/.zcompdump(N.mh+24))
if (($#_zcompdump_stale)); then
	ZINIT[COMPINIT_OPTS]=
	touch $ZDOTDIR/.zcompdump
fi
unset _zcompdump_stale

# zsh-autocomplete (wait'0c') adds its #autoload helpers to fpath after this compinit, so a
# full check would drop them from the dump; add them up front
fpath=(${ZINIT[PLUGINS_DIR]}/marlonrichert---zsh-autocomplete/Completions(N/) $fpath)

zicompinit
zicdreplay
