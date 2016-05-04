source ~/.zsh/antigen/antigen.zsh

# antigen-update
# antigen-selfupdate

# z #
_Z_CMD=j

# enhancd #
export ENHANCD_COMMAND=dc


##################
# Plugin load    #
##################
antigen-bundle olivierverdier/zsh-git-prompt
antigen-bundle zsh-users/zaw
antigen-bundle hchbaw/auto-fu.zsh --branch=pu
antigen-bundle rupa/z
antigen-bundle zsh-users/zsh-completions
antigen-bundle zsh-users/zsh-syntax-highlighting
antigen-bundle zsh-users/zsh-history-substring-search
antigen-bundle mollifier/cd-gitroot
antigen-bundle b4b4r07/enhancd
antigen-bundle mollifier/anyframe

# old plugins
#antigen-bundle autojump # ->z
#antigen-bundle tarruda/zsh-autosuggestions # ->auto-fu


[ -f "$HOME/.zsh/rc/pluginconf.zsh" ] && source $HOME/.zsh/rc/pluginconf.zsh


antigen-apply


