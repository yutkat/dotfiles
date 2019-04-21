#--------------------------------------------------------------#
##          Color                                             ##
#--------------------------------------------------------------#

set-option -g default-terminal "screen-256color"
#set-option -g default-terminal "rxvt-unicode-256color"

#set-option -g status-fg white
#set-option -g status-bg colour235
#set-option -g status-attr default
#set-window-option -g window-status-current-fg white
#set-window-option -g window-status-current-bg colour61
#set-window-option -g window-status-current-attr bright
## Unsettings
#set-window-option -g window-status-bg colour2
#set-window-option -g window-status-fg black
#set-window-option -g window-status-attr dim
#set-window-option -g window-status-current-bg black
#set-window-option -g window-status-current-fg colour2
#set-window-option -g window-status-current-attr bright
#set-option -g status-left-bg  magenta
#set-option -g status-left-fg  black
#set-option -g status-right-bg cyan
#set-option -g status-right-fg black
## 区切り線のスタイル
#set-option -g pane-active-border-bg    green
#set-option -g pane-active-border-fg    red
#set-option -g pane-border-bg           colour7
#set-option -g pane-border-fg           black
#set-option -g message-bg black #base02
#set-option -g message-fg brightred #orange
#set-option -g display-panes-active-colour blue #blue
#set-option -g display-panes-colour brightred #orange

#### COLOUR (Solarized 256)

# default statusbar colors
set-option -g status-bg colour235 #base02
set-option -g status-fg colour136 #yellow
set-option -g status-attr default
# default window title colors
set-window-option -g window-status-fg colour244 #base0
set-window-option -g window-status-bg default
#set-window-option -g window-status-attr dim
# active window title colors
set-window-option -g window-status-current-fg colour166 #orange
set-window-option -g window-status-current-bg default
#set-window-option -g window-status-current-attr bright
# pane border
set-option -g pane-border-fg colour244
set-option -g pane-active-border-fg colour240 #base01
# message text
set-option -g message-bg colour235 #base02
#set-option -g message-fg colour166 #orange
set-option -g message-fg colour76 #green
# pane number display
set-option -g display-panes-active-colour colour33 #blue
set-option -g display-panes-colour colour166 #orange
# clock
set-window-option -g clock-mode-colour colour64 #green
# bell
if '[ $(echo "`tmux -V | cut -d" " -f2` >= "1.9"" | bc) -eq 1 ]' \
  'set-window-option -g window-status-bell-style fg=colour235,bg=colour160' \
  'set-window-option -g window-status-bell-fg colour235 ; \
   set-window-option -g window-status-bell-bg colour160'


