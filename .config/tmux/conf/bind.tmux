#--------------------------------------------------------------#
##          Key Bind                                          ##
#--------------------------------------------------------------#

# Go to previous screen
bind 'C-\' run "tmux last-pane || tmux last-window || tmux new-window"
bind -n M-\; run "tmux last-pane || tmux last-window || tmux new-window"

bind d detach

# Change title
bind A command-prompt "rename-window %%"
bind R command-prompt "rename-session %%"

# Window Selection
bind C-w choose-window

# Select session/window/pane
bind -n M-Space choose-tree
bind -n M-a choose-tree
bind -n M-e choose-session
bind -n M-w choose-tree -w

# session
bind -n M-N switch-client -n
bind -n M-P switch-client -p
bind -n M-Enter new-session
bind -n M-s new-session
bind -n 'M-/' run-shell "~/.config/tmux/conf/scripts/popuptmux.sh"

# Reload configuration file
bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

# | to split the pane vertically
bind '\' split-window -hc "#{pane_current_path}"
bind -n 'M-\' split-window -hc "#{pane_current_path}"

# - to split the pane horizontally
bind - split-window -vc "#{pane_current_path}"
bind -n  M-- split-window -vc "#{pane_current_path}"

# Move panes with Vim key bindings
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Use arrow keys to move panes
bind -n S-left select-pane -L
bind -n S-down select-pane -D
bind -n S-up select-pane -U
bind -n S-right select-pane -R
bind -n M-S-left select-pane -L
bind -n M-S-down select-pane -D
bind -n M-S-up select-pane -U
bind -n M-S-right select-pane -R
bind -n M-H select-pane -L
bind -n M-J select-pane -D
bind -n M-K select-pane -U
bind -n M-L select-pane -R

# Quickly switch to copy mode
bind -n C-M-up copy-mode
bind -n C-M-down paste-buffer
bind -n C-M-k copy-mode
bind -n C-M-j paste-buffer

# Move window
bind -n M-left previous-window
bind -n M-right next-window
bind -n M-up new-window -c "#{pane_current_path}"
bind -n M-down confirm-before 'kill-window'
bind -n M-h previous-window
bind -n M-j confirm-before 'kill-window'
bind -n M-k new-window -c "#{pane_current_path}"
bind -n M-l next-window
bind-key -n M-BSpace last-window

bind-key -n M-1 select-window -t :=1
bind-key -n M-2 select-window -t :=2
bind-key -n M-3 select-window -t :=3
bind-key -n M-4 select-window -t :=4
bind-key -n M-5 select-window -t :=5
bind-key -n M-6 select-window -t :=6
bind-key -n M-7 select-window -t :=7
bind-key -n M-8 select-window -t :=8
bind-key -n M-9 select-window -t :=9
bind-key -n M-0 select-window -t :=10

# shift
bind-key -n M-! join-pane -v -t :=1
bind-key -n M-@ join-pane -v -t :=2
bind-key -n M-# join-pane -v -t :=3
bind-key -n M-$ join-pane -v -t :=4
bind-key -n M-% join-pane -v -t :=5
bind-key -n M-^ join-pane -v -t :=6
bind-key -n M-& join-pane -v -t :=7
bind-key -n M-* join-pane -v -t :=8
bind-key -n M-( join-pane -v -t :=9
bind-key -n M-) join-pane -v -t :=10

# ctrl
bind-key -n ± join-pane -h -t :=1
bind-key -n M-C-@ join-pane -h -t :=2
bind-key -n M-Escape join-pane -h -t :=3
bind-key -n M-C-\\ join-pane -h -t :=4
bind-key -n M-C-] join-pane -h -t :=5
bind-key -n M-C-^ join-pane -h -t :=6
bind-key -n M-C-_ join-pane -h -t :=7
bind-key -n ÿ join-pane -h -t :=8
bind-key -n ¹ join-pane -h -t :=9
bind-key -n ° join-pane -h -t :=10

# Replace window
if '[ $(echo "`tmux -V | cut -d" " -f2` >= "3.0"" | tr -d "[:alpha:]-_" | bc) -eq 1 ]' \
  'set-environment -g TMUX_SWAP_OPTION "-d"' \
  'set-environment -g TMUX_SWAP_OPTION ""'
run-shell 'tmux bind-key -n C-M-left swap-window $TMUX_SWAP_OPTION -t -1'
run-shell 'tmux bind-key -n C-M-right swap-window $TMUX_SWAP_OPTION -t +1'
run-shell 'tmux bind-key -n C-M-h swap-window $TMUX_SWAP_OPTION -t -1'
run-shell 'tmux bind-key -n C-M-l swap-window $TMUX_SWAP_OPTION -t +1'

# Rotate pane
#bind -n C-O select-pane -t :.+
bind -r C-o select-pane -t :.+
bind -r C-h select-window -t :-
bind -r C-l select-window -t :+

# Move pane to window
bind-key f command-prompt -p "join pane from: [session:window(.pane)] "  "join-pane -h -s '%%'"
bind-key t command-prompt -p "send pane to: [session:window(.pane)] "  "join-pane -h -t '%%'"
bind-key F command-prompt -p "join pane from: [session:window(.pane)] "  "join-pane -v -s '%%'"
bind-key T command-prompt -p "send pane to: [session:window(.pane)] "  "join-pane -v -t '%%'"
bind-key C-f command-prompt -p "move pane to: [session:window] "  "move-pane -s '%%'"
bind-key C-t command-prompt -p "move pane to: [session:window] "  "move-pane -t '%%'"
bind-key ! break-pane \; display "break-pane"
bind-key C-s choose-window 'join-pane -v -s "%%"'
bind-key C-v choose-window 'join-pane -h -s "%%"'
bind-key -n M-S choose-window 'join-pane -v -s "%%"'
bind-key -n M-V choose-window 'join-pane -h -s "%%"'
bind-key -n M-_ choose-window 'join-pane -v -s "%%"'
bind-key -n M-| choose-window 'join-pane -h -s "%%"'
bind-key -n M-~ break-pane \; display "break-pane"

# Resize the pane with Vim key bindings
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# Switch pane synchronous input mode
bind e set-window-option synchronize-panes on \;\
  set-option -g status-bg red \; display 'synchronize begin'
bind E set-window-option synchronize-panes off \;\
  set-option -g status-bg colour235 \; display 'synchronize end'

# Send command to all window
bind C-e command-prompt -p "session?,message?" "run-shell \"tmux list-windows -t %1 \| cut -d: -f1\| xargs -I\{\} tmux send-keys -t %1:\{\} %2 Enter\""

# quick layout switch
bind-key -n M-. next-layout
# bind-key -n M-1 select-layout even-horizontal
# bind-key -n M-2 select-layout even-vertical
# bind-key -n M-3 select-layout main-horizontal
# bind-key -n M-4 select-layout main-vertical
# bind-key -n M-5 select-layout tiled

# Enable mouse
bind m set-option -g mouse on \; display "Mouse: ON"
bind M set-option -g mouse off \; display "Mouse: OFF"

# Set up vi-like copy mode
bind Space copy-mode \; display "copy mode"
bind P paste-buffer
# new: -Tcopy-mode-vi, old: -t vi-copy
bind -Tcopy-mode-vi v send -X begin-selection
bind -Tcopy-mode-vi V send -X select-line
bind -Tcopy-mode-vi C-v send -X rectangle-toggle
bind -Tcopy-mode-vi y send -X copy-selection-and-cancel
bind -Tcopy-mode-vi Y send -X copy-line-and-cancel
bind -Tcopy-mode-vi Escape send -X cancel
if 'builtin command -v xsel > /dev/null 2>&1' \
  "run-shell 'tmux bind -Tcopy-mode-vi Enter send -X copy-pipe-and-cancel \"xsel -i --clipboard\"'"
if 'builtin command -v xclip > /dev/null 2>&1' \
  "run-shell 'tmux bind -Tcopy-mode-vi Enter send -X copy-pipe-and-cancel \"xclip -i -selection clipboard\"'"
if '$WAYLAND_DISPLAY != "" && builtin command -v wl-copy > /dev/null 2>&1' \
  "run-shell 'tmux bind -Tcopy-mode-vi Enter send -X copy-pipe-and-cancel \"wl-copy\"'"

run-shell 'tmux bind -Tcopy-mode-vi O send -X copy-pipe-and-cancel "~/.config/tmux/conf/scripts/open-editor.sh"'

# copy paste
bind [ copy-mode \; display "copy mode"
bind -n M-[ copy-mode \; display "copy mode"
bind ] paste-buffer
bind C-] choose-buffer

# kill the pane
bind C-x confirm-before 'kill-pane'
# kill the window
bind C-X confirm-before 'kill-window'
# kill the session
bind q confirm-before 'kill-session'
# Kill tmux itself (including server and client)
bind C-q confirm-before 'kill-server'

# log output
bind-key '{' pipe-pane 'mkdir -p #{TMUX_DATA_DIR}/log; cat >> #{TMUX_DATA_DIR}/log/tmux-#W.log' \; display-message -d 3000 'Started logging to #{TMUX_DATA_DIR}/log/tmux-#W.log'
bind-key '}' pipe-pane \; display-message -d 3000 'Ended logging to #{TMUX_DATA_DIR}/log/tmux-#W.log'

# switch session/window/pane switcher
bind-key -n M-` run-shell -b "~/.config/tmux/conf/scripts/tmux-switch-pane.sh"


# Keys that are used outside of tmux and cannot be used
# C-left,C-right: word backward/forward
# C-S-up/down: scroll up/down
# Shell: A-d, A-f, A-b, A-u, A-r, A-p, A-n

# Keys that are still usable and useful
