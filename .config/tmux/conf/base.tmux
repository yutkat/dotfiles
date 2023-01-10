#--------------------------------------------------------------#
##          Base                                              ##
#--------------------------------------------------------------#

set-option -g status on
set-option -g status-interval 2

set-option -g prefix 'C-\'
unbind C-b

set-option -g default-terminal "screen-256color"
#set-option -g default-terminal "rxvt-unicode-256color"
#
# Default shell
set-option -g default-shell $SHELL
set-option -g default-command $SHELL

# Start window index at 1
set-option -g base-index 1
# Start pane index at 1
set-window-option -g pane-base-index 1
set-option -g renumber-windows on

# Renumber sessions
#set-hook -g session-created "run ~/.config/tmux/conf/scripts/renumber-sessions.sh"
#set-hook -g session-closed  "run ~/.config/tmux/conf/scripts/renumber-sessions.sh"

# Maximum number of lines in window history
set-option -g history-limit 5000

# Message display seconds
set-option -g display-time 1000

# Do not use alternate screen buffer (when parent terminal's TERM is xterm)
set-option -ga terminal-overrides ",xterm*:Tc"
set-option -ga terminal-overrides ",xterm*:smcup@:rmcup@"
set-option -ga terminal-overrides ',rxvt-uni*:XT:Ms=\E]52;%p1%s;%p2%s\007'
set-option -ga terminal-overrides ',*:U8=0'
set-option -ga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'

# Use vi key bindings
set-window-option -g mode-keys vi
set-option -g default-command ""

set-option -g set-clipboard on

# Enable visual notifications
set-window-option -g monitor-activity on
set-option -g visual-activity off

# bell
set-option -g bell-action other
set-option -g visual-bell off

# Esc seems to work well.
set-option -s escape-time 20

# Switch to simultaneous pane input
set-option -g synchronize-panes off

# Switch to mouse operation
set-option -g mouse off

# Use arrow keys to move panes
set-window-option -g xterm-keys on

# emacs key bindings in tmux command prompt (prefix + :) are better than
# vi keys, even for vim users
set-option -g status-keys emacs

# focus events enabled for terminals that support them
set-option -g focus-events on

# super useful when using "grouped sessions" and multi-monitor setup
set-window-option -g aggressive-resize on

# change window title
set-option -g set-titles on
set-option -g set-titles-string '#T'
set-window-option -g automatic-rename on

# change word delimiter
set-option -g word-separators " -_()@,[]{}:=/"

# pane-border("single", "double", "heavy", "simple", "number", NULL)
set-option -g pane-border-lines heavy

#--------------------------------------------------------------#
##          Environments                                      ##
#--------------------------------------------------------------#
set-environment -g TMUX_DATA_DIR "${HOME}/.local/share/tmux"

# set-option -ga update-environment "PS4 PROMPT4"

