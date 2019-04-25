#--------------------------------------------------------------#
##          Color                                             ##
#--------------------------------------------------------------#

set-option -g default-terminal "screen-256color"
#set-option -g default-terminal "rxvt-unicode-256color"

# set-option -g status-left-style "bg=magenta,fg=black"
# set-option -g status-right-style "bg=cyan,fg=black"

#### COLOUR (Solarized 256)

# default statusbar colors
set-option -g status-style "bg=colour235,fg=colour136,default"
# default window title colors
set-window-option -g window-status-style "bg=colour244,fg=black,none"
#set-window-option -g window-status-attr dim
# active window title colors
set-window-option -g window-status-current-style "bg=colour31,fg=black,bright"
# pane border
set-option -g pane-border-style "fg=colour244"
set-option -g pane-active-border-style "fg=colour240"
# message text
set-option -g message-style "bg=colour235,fg=colour76"
# pane number display
set-option -g display-panes-active-colour colour33 #blue
set-option -g display-panes-colour colour166 #orange
# clock
set-window-option -g clock-mode-colour colour64 #green
# bell
set-window-option -g window-status-bell-style "fg=colour235,bg=colour160"


