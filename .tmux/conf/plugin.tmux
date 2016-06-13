#--------------------------------------------------------------#
##          Plugins                                           ##
#--------------------------------------------------------------#

if '[ $(echo "`tmux -V | cut -d" " -f2` >= "1.9"" | bc) -eq 1 ]' \
  'set-option -g @plugin "        \
    tmux-plugins/tpm                   \
    tmux-plugins/tmux-resurrect        \
    tmux-plugins/tmux-continuum        \
    tmux-plugins/tmux-copycat          \
    tmux-plugins/tmux-yank             \
    tmux-plugins/vim-tmux-focus-events \
    tmux-plugins/tmux-open             \
    "; \
   run-shell "~/.tmux/plugins/tpm/tpm"'

# Disabled for customize coloring
    #jooize/tmux-powerline-theme      \
    #tmux-plugins/tmux-sensible         \


#--------------------------------------------------------------#
##          Plugins Config                                    ##
#--------------------------------------------------------------#

set -g @continuum-restore 'on'

