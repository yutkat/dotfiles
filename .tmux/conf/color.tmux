#--------------------------------------------------------------#
##          Color                                             ##
#--------------------------------------------------------------#


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

# Aliases (assuming Unicode support)
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "on"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline"'
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "yes"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline"'

if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "off"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "unicode"'
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "no"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "unicode"'
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "none"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "unicode"'
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "compatible"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "unicode"'

if-shell ': ${TMUX_POWERLINE_COMPACT_ACTIVE?}' 'set-environment -g TMUX_POWERLINE_COMPACT_CURRENT "${TMUX_POWERLINE_COMPACT_ACTIVE}" ; set-environment -r TMUX_POWERLINE_COMPACT_ACTIVE'

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

# Powerline glyphs at U+E000-U+F8FF range ("Private Use Area")
# These are the code points used in the new universal Powerline
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "powerline"' 'set-environment -g TMUX_POWERLINE_SYMBOL_RIGHT_FULL ""'
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "powerline"' 'set-environment -g TMUX_POWERLINE_SYMBOL_RIGHT_THIN ""'
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "powerline"' 'set-environment -g TMUX_POWERLINE_SYMBOL_LEFT_FULL ""'
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "powerline"' 'set-environment -g TMUX_POWERLINE_SYMBOL_LEFT_THIN ""'

# Powerline glyphs at U+2B60-U+2BFF range ("Miscellaneous Symbols and Arrows")
# These are the code points used in Lokaltog/vim-powerline
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "vim-powerline"' 'set-environment -g TMUX_POWERLINE_SYMBOL_RIGHT_FULL "⮀"'
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "vim-powerline"' 'set-environment -g TMUX_POWERLINE_SYMBOL_RIGHT_THIN "⮁"'
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "vim-powerline"' 'set-environment -g TMUX_POWERLINE_SYMBOL_LEFT_FULL "⮂"'
if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "vim-powerline"' 'set-environment -g TMUX_POWERLINE_SYMBOL_LEFT_THIN "⮃"'

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
set-window-option -g status-right "#{prefix_highlight}  #[fg=colour244]#S:#I.#P #[fg=colour231]#{online_status}  #[fg=colour240]${TMUX_POWERLINE_SYMBOL_LEFT_FULL}#[fg=colour231,bg=colour240] #H #[fg=colour252]${TMUX_POWERLINE_SYMBOL_LEFT_FULL}#[fg=black,bg=colour252,nobold] #(LANG=C date '+%%Y-%%m-%%d(%%a) %%H:%%M') "
set-window-option -g status-right-length 80

#
# Status bar window without activity
#
if-shell 'test $(echo "${TMUX_POWERLINE_COMPACT_INACTIVE}") = "on"' \
    'set-window-option -g window-status-format "#[fg=colour236,nounderscore]${TMUX_POWERLINE_SYMBOL_RIGHT_FULL}#[default,bold,nounderscore] #I${TMUX_POWERLINE_FLAG} #[fg=colour236,reverse]${TMUX_POWERLINE_SYMBOL_RIGHT_FULL}"' \
    'set-window-option -g window-status-format "#[fg=colour236,nounderscore]${TMUX_POWERLINE_SYMBOL_RIGHT_FULL}#[bg=colour244,fg=black,bold,nounderscore]#{?window_last_flag,#[bg=colour252],}#{?window_activity_flag,#[bg=colour219],}#{?window_bell_flag,#[bg=red],} #I${TMUX_POWERLINE_FLAG} #[fg=colour240,reverse]${TMUX_POWERLINE_SYMBOL_RIGHT_FULL}#[default]#[bg=colour240]#[nounderscore] #[default]#[fg=colour231,bg=colour240]#W#[nounderscore] #[fg=colour236,reverse]${TMUX_POWERLINE_SYMBOL_RIGHT_FULL}"'

# Black on green
set-window-option -g window-status-style "bg=colour244,fg=black,none"

#
# Status bar window currently active
#
if-shell 'test $(echo "${TMUX_POWERLINE_COMPACT_CURRENT}") = "on"' \
    'set-window-option -g window-status-current-format "#[fg=colour236]${TMUX_POWERLINE_SYMBOL_RIGHT_FULL}#[default,fg=colour231,bold] #I${TMUX_POWERLINE_FLAG} #[default,fg=colour236,reverse]${TMUX_POWERLINE_SYMBOL_RIGHT_FULL}"' \
    'set-window-option -g window-status-current-format "#[fg=colour236]${TMUX_POWERLINE_SYMBOL_RIGHT_FULL}#[bg=colour31,fg=colour235,bold] #I${TMUX_POWERLINE_FLAG} #[fg=colour123,reverse]${TMUX_POWERLINE_SYMBOL_RIGHT_FULL}#[default]#[bg=colour123,fg=black,none] #W #[fg=colour236,reverse]${TMUX_POWERLINE_SYMBOL_RIGHT_FULL}"'

set-window-option -g window-status-current-style "bg=colour31,fg=black,none"

#
# Status bar window last active (Tmux 1.8+)
#
set-window-option -g window-status-last-style "bg=colour252,fg=black,none"

#
# Status bar window with activity/silence (monitor-activity, monitor-silence)
#
set-window-option -g window-status-activity-style "bg=colour219,fg=black,bold,underscore"

#
# Status bar window with bell triggered
#
set-window-option -g window-status-bell-style "bg=red,fg=black,bold,underscore"

#
# Status bar window with content found (monitor-content)
#
#set-window-option -g window-status-content-style "bg=colour226,fg=black,bold,underscore"

#
# Race condition fix
# Loop once to let Tmux catch up on new environment variables
#
TMUX_POWERLINE_THEME_LOOPFILE="$HOME/.tmux/conf/unicode-theme.loop"
if-shell "test -e ${TMUX_POWERLINE_THEME_LOOPFILE}" "run-shell 'rm "${TMUX_POWERLINE_THEME_LOOPFILE}"'" 'run-shell "touch ${TMUX_POWERLINE_THEME_LOOPFILE}" ; source-file "$HOME/.tmux/conf/unicode-theme.tmux"'
#set-environment -r TMUX_POWERLINE_THEME_LOOPFILE

#
# Remove environment variables
#
#set-environment -r TMUX_POWERLINE_SYMBOL_RIGHT_FULL
#set-environment -r TMUX_POWERLINE_SYMBOL_RIGHT_THIN
#set-environment -r TMUX_POWERLINE_SYMBOL_LEFT_FULL
#set-environment -r TMUX_POWERLINE_SYMBOL_LEFT_THIN
#set-environment -r TMUX_POWERLINE_FLAG

