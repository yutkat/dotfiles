#--------------------------------------------------------------#
##          Plugins                                           ##
#--------------------------------------------------------------#

set-option -g @plugin "tmux-plugins/tpm"
set-option -g @plugin "tmux-plugins/tmux-resurrect"
set-option -g @plugin "tmux-plugins/tmux-continuum"
set-option -g @plugin "tmux-plugins/tmux-copycat"
set-option -g @plugin "tmux-plugins/tmux-yank"
set-option -g @plugin "tmux-plugins/vim-tmux-focus-events"
set-option -g @plugin "tmux-plugins/tmux-open"
set-option -g @plugin "jschaf/tmux-newline-detector"
set-option -g @plugin 'tmux-plugins/tmux-prefix-highlight'
set-option -g @plugin 'tmux-plugins/tmux-online-status'
if 'builtin command -v urlview > /dev/null 2>&1 ' \
  'set-option -g @plugin "tmux-plugins/tmux-urlview"'


#--------------------------------------------------------------#
##          Disable Plugins                                   ##
#--------------------------------------------------------------#

## Disabled for customize coloring
#set-option -g @plugin "jooize/tmux-powerline-theme"
## Disabled for include my tmux.conf
#set-option -g @plugin "#tmux-plugins/tmux-sensible"


#--------------------------------------------------------------#
##          Install/Execute tpm                               ##
#--------------------------------------------------------------#

if '[ ! -d ~/.tmux/plugins/tpm ]' \
  'run-shell "git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"'


if '[ $(echo "`tmux -V | cut -d" " -f2` >= "1.9"" | tr -d "[:alpha:]" | bc) -eq 1 ]' \
  'run-shell "~/.tmux/plugins/tpm/tpm"'


#--------------------------------------------------------------#
##          Plugins Config                                    ##
#--------------------------------------------------------------#

set -g @continuum-restore 'on'

if '[ -f ~/.tmux/plugins/tmux-newline-detector/scripts/paste.sh ]' \
  'bind -n C-down run-shell "~/.tmux/plugins/tmux-newline-detector/scripts/paste.sh"'


