#--------------------------------------------------------------#
##          Style                                             ##
#--------------------------------------------------------------#

if-shell ': ${TMUX_POWERLINE_SYMBOLS?}' '' 'set-environment -g TMUX_POWERLINE_SYMBOLS "unicode"'

# Show flag if terminal reports support for fewer than 8 colors
#
# Current: *
# Previous: -
# Bell: !
# Content: +
# Activity/Silence: #
#
if-shell 'test "$(tput colors)" -lt 8' 'set-environment -g TMUX_POWERLINE_FLAG "#F"' 'set-environment -g TMUX_POWERLINE_FLAG ""'
#if-shell 'test "$(tput colors)" -lt 16' 'set-environment -g TMUX_POWERLINE_FLAG "#F"' ''
#if-shell 'test "$(tput Co)" -lt 16' 'set-environment -g TMUX_POWERLINE_FLAG "#F"' ''

#if-shell 'test "$(tput colors)" -ge 16' \
    #'if-shell \'test "$(tput Co)" -ge 16\' \
        #\'TRUE\' \
        #\'FALSE\'' \
    #'set-environment -g TMUX_POWERLINE_FLAG "#F"'

# ASCII glyphs which don't require patched font or Unicode support
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "ascii"' 'set-environment -g TMUX_POWERLINE_SYMBOL_RIGHT_FULL ""'
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "ascii"' 'set-environment -g TMUX_POWERLINE_SYMBOL_RIGHT_THIN "|"'
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "ascii"' 'set-environment -g TMUX_POWERLINE_SYMBOL_LEFT_FULL ""'
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "ascii"' 'set-environment -g TMUX_POWERLINE_SYMBOL_LEFT_THIN "|"'

# Unicode glyphs which don't require patched font
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "unicode"' 'set-environment -g TMUX_POWERLINE_SYMBOL_RIGHT_FULL ""'
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "unicode"' 'set-environment -g TMUX_POWERLINE_SYMBOL_RIGHT_THIN "│"'
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "unicode"' 'set-environment -g TMUX_POWERLINE_SYMBOL_LEFT_FULL ""'
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "unicode"' 'set-environment -g TMUX_POWERLINE_SYMBOL_LEFT_THIN "│"'


###############################################################
# COLOUR (Solarized 256)
###############################################################

#
# Status bar background colour
#
set-window-option -g status-style "bg=colour236" # Gray


#
# Status bar left side
#
set-window-option -g status-left ""

# Show session name
#set-window-option -g status-left "#[bg=colour240,fg=white] #S #[fg=colour236,reverse]${TMUX_POWERLINE_SYMBOL_RIGHT_FULL}"
#set-window-option -g status-left-length 40


#
# Status bar right side
#
set-window-option -g status-right "#{prefix_highlight} #[bg=colour=236 fg=colour244]#S/#(tmux ls | wc -l | tr -d ' '):#I.#P #[bg=colour=236 fg=colour231]#{online_status} #(~/.config/tmux/conf/scripts/status-right.sh)"
set-window-option -g status-right-length 120


#
# Status bar window without activity
#
# shell execute (#()) occurs the `<cmd not ready> error`. It can be solved this workaround.
# https://github.com/gpakosz/.tmux/blob/master/.tmux.conf
# But it is so complex
set-window-option -g window-status-format "#[bg=colour244 fg=colour236 nounderscore]${TMUX_POWERLINE_SYMBOL_RIGHT_FULL}#[bg=colour244 fg=colour235]#{?window_last_flag,#[bg=colour252 fg=colour235 none],}#{?window_activity_flag,#[bg=colour219 fg=colour235 none],}#{?window_bell_flag,#[bg=red fg=colour235 underscore],} #I${TMUX_POWERLINE_FLAG} #[bg=colour244 fg=colour236 reverse]${TMUX_POWERLINE_SYMBOL_RIGHT_FULL}#[fg=colour231 bg=colour240 none] #{?#{m:#W,zsh},#{=/8/…:#{?#{m:#{pane_current_path},${HOME}},~,#{b:pane_current_path}}},#W} #[bg=colour236 fg=colour236 none]${TMUX_POWERLINE_SYMBOL_RIGHT_FULL}"

# Black on green
set-window-option -g window-status-style "bg=colour244,fg=colour235,none"
# Status bar window last active (Tmux 1.8+)
set-window-option -g window-status-last-style "bg=colour252,fg=colour235,none"
# Status bar window with activity/silence (monitor-activity, monitor-silence)
set-window-option -g window-status-activity-style "bg=colour219,fg=colour235,bold,underscore"
# Status bar window with bell triggered
set-window-option -g window-status-bell-style "bg=red,fg=colour235,bold,underscore"


#
# Status bar window currently active
#
set-window-option -g window-status-current-format "#[bg=colour31 fg=colour236 none]${TMUX_POWERLINE_SYMBOL_RIGHT_FULL} #[bg=colour31 fg=colour235]#I${TMUX_POWERLINE_FLAG} #[bg=colour31 fg=colour123 reverse]${TMUX_POWERLINE_SYMBOL_RIGHT_FULL} #[bg=colour123 fg=colour235 none]#{?#{m:#W,zsh},#{=/8/…:#{?#{m:#{pane_current_path},${HOME}},~,#{b:pane_current_path}}},#W} #[bg=colour31 fg=colour236 reverse]${TMUX_POWERLINE_SYMBOL_RIGHT_FULL}"

set-window-option -g window-status-current-style "bg=colour31 fg=colour235 none"


#
# etc
#
# set-option -g status-left-style "bg=magenta,fg=colour235"
# set-option -g status-right-style "bg=cyan,fg=colour235"
# Status bar window with content found (monitor-content)
#set-window-option -g window-status-content-style "bg=colour226,fg=colour235,bold,underscore"
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
