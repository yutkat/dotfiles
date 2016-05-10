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
#bind-key P if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "unicode"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline" ; source-file "$HOME/.tmux/themes/unicode.tmux"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "unicode" ; source-file "$HOME/.tmux/themes/unicode.tmux"'
source-file "$HOME/.tmux/themes/unicode.tmux"

