if [[ -f $ZRCDIR/pluginconfig/p10k.zsh ]]; then
  source $ZRCDIR/pluginconfig/p10k.zsh
fi
typeset -g POWERLEVEL9K_TERM_SHELL_INTEGRATION=true
PROMPT="%~"$'\n'"> "
