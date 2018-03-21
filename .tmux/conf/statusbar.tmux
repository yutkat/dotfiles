#--------------------------------------------------------------#
##          Status bar                                        ##
#--------------------------------------------------------------#

#if '[ "${ENABLE_TMUX_POWERLINE}" = "false" ]' \
#  'set-option -g status-justify "left" ; \
#   set-option -g status-position bottom ; \
#   set-option -g status-left-length 40 ; \
#   set-option -g status-left "#[fg=green][#S:#I:#P]" ; \
#   set-option -g status-right "#[fg=colour111][%Y-%m-%d(%a) %H:%M]"' \
#  'set-option -g status-justify "left" ; \
#   set-option -g status-left-length 90 ; \
#   set-option -g status-right-length 60 ; \
#   set-option -g status-left "#(~/.tmux/tmux-powerline/powerline.sh left)" ; \
#   set-option -g status-right "#(~/.tmux/tmux-powerline/powerline.sh right)"'

if-shell ': ${TMUX_POWERLINE_SYMBOLS?}' '' 'set-environment -g TMUX_POWERLINE_SYMBOLS "unicode"'
#bind-key P if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "unicode"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline" ; source-file "$HOME/.tmux/conf/unicode-theme.tmux"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "unicode" ; source-file "$HOME/.tmux/conf/unicode-theme.tmux"'
source-file "$HOME/.tmux/conf/unicode-theme.tmux"

#if '[ $(echo "`tmux -V | cut -d" " -f2` >= "2.3"" | bc) -eq 1 ]' \
#  'set-option -g pane-border-status bottom ; \
#   set-option -g pane-border-format "#[fg=black,bg=colour244] #P #($HOME/.bin/tmux-pane-border.zsh #{pane_current_path})" ; \
#   set-option -g pane-border-style bg=default,fg=colour023 ; \
#   set-option -g pane-active-border-style bg=default,fg=blue'

