#--------------------------------------------------------------#
##          Key Bind                                          ##
#--------------------------------------------------------------#

# 直前の画面に移動
bind 'C-\' run "tmux last-pane || tmux last-window || tmux new-window"

# デタッチ
bind d detach

# タイトル変更
bind A command-prompt "rename-window %%"
bind R command-prompt "rename-session %%"

# ウィンドウ選択
bind C-w choose-window

# select session/window/pane
bind -n M-a choose-tree
bind -n M-e choose-session
bind -n M-w choose-tree -w

# 設定ファイルをリロードする
bind r source-file ~/.tmux.conf \; display "Reloaded!"

# | でペインを縦に分割する
bind | split-window -hc "#{pane_current_path}"
bind -n 'M-\' split-window -hc "#{pane_current_path}"

# - でペインを横に分割する
bind - split-window -vc "#{pane_current_path}"
bind -n  M-- split-window -vc "#{pane_current_path}"

# Vimのキーバインドでペインを移動する
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# 矢印キーでペインを移動する
bind -n S-left select-pane -L
bind -n S-down select-pane -D
bind -n S-up select-pane -U
bind -n S-right select-pane -R
bind -n C-M-h select-pane -L
bind -n C-M-j select-pane -D
bind -n C-M-k select-pane -U
bind -n C-M-l select-pane -R

# すばやくコピーモードに移行する
bind -n C-up copy-mode
bind -n C-down paste-buffer

# tmux以外で使われていて使えないキー
# C-left,C-right: word backward/forward
# C-S-up/down: scroll up/down

# ウィンドウの移動
bind -n M-left previous-window
bind -n M-right next-window
bind -n M-up new-window -c "#{pane_current_path}"
bind -n M-down confirm-before 'kill-window'
bind -n M-h previous-window
bind -n M-j confirm-before 'kill-window'
bind -n M-k new-window -c "#{pane_current_path}"
bind -n M-l next-window

bind-key -n M-1 select-window -t :=1
bind-key -n M-2 select-window -t :=2
bind-key -n M-3 select-window -t :=3
bind-key -n M-4 select-window -t :=4
bind-key -n M-5 select-window -t :=5
bind-key -n M-6 select-window -t :=6
bind-key -n M-7 select-window -t :=7
bind-key -n M-8 select-window -t :=8
bind-key -n M-9 select-window -t :=9

# ウィンドウの置換
if '[ $(echo "`tmux -V | cut -d" " -f2` >= "3.0"" | tr -d "[:alpha:]" | bc) -eq 1 ]' \
  'set-environment -g TMUX_SWAP_OPTION "-d"' \
  'set-environment -g TMUX_SWAP_OPTION ""'
run-shell 'tmux bind-key -n M-S-left swap-window $TMUX_SWAP_OPTION -t -1'
run-shell 'tmux bind-key -n M-S-right swap-window $TMUX_SWAP_OPTION -t +1'
run-shell 'tmux bind-key -n M-H swap-window $TMUX_SWAP_OPTION -t -1'
run-shell 'tmux bind-key -n M-L swap-window $TMUX_SWAP_OPTION -t +1'

# ペインの移動(ローテート)
#bind -n C-O select-pane -t :.+
bind -r C-o select-pane -t :.+
bind -r C-h select-window -t :-
bind -r C-l select-window -t :+

# Move pane to window
bind-key f command-prompt -p "join pane from: [session:window.pane] "  "join-pane -h -s '%%'"
bind-key t command-prompt -p "send pane to: [session:window.pane] "  "join-pane -h -t '%%'"
bind-key F command-prompt -p "join pane from: [session:window.pane] "  "join-pane -v -s '%%'"
bind-key T command-prompt -p "send pane to: [session:window.pane] "  "join-pane -v -t '%%'"
bind-key ! break-pane \; display "break-pane"
bind-key @ choose-window 'join-pane -v -s "%%"'

# Vimのキーバインドでペインをリサイズする
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# ペイン同時入力切り替え
bind e set-window-option synchronize-panes on \;\
  set-option -g status-bg red \; display 'synchronize begin'
bind E set-window-option synchronize-panes off \;\
  set-option -g status-bg colour235 \; display 'synchronize end'

# quick layout switch
bind-key -n M-` next-layout
# bind-key -n M-1 select-layout even-horizontal
# bind-key -n M-2 select-layout even-vertical
# bind-key -n M-3 select-layout main-horizontal
# bind-key -n M-4 select-layout main-vertical
# bind-key -n M-5 select-layout tiled

# マウス操作を有効にする
bind m \
  if '[ $(echo "`tmux -V | cut -d" " -f2` >= "2.1"" | tr -d "[:alpha:]" | bc) -eq 1 ]' \
    'set-option -g mouse on ; \
     display "Mouse: ON"' \
    'set-option -g mode-mouse on ; \
     set-option -g mouse-resize-pane on ; \
     set-option -g mouse-select-pane on ; \
     set-option -g mouse-select-window on ; \
     display "Mouse: ON"'

bind M \
  if '[ $(echo "`tmux -V | cut -d" " -f2` >= "2.1"" | tr -d "[:alpha:]" | bc) -eq 1 ]' \
    'set-option -g mouse off ; \
     display "Mouse: OFF"' \
    'set-option -g mode-mouse off ; \
     set-option -g mouse-resize-pane off ; \
     set-option -g mouse-select-pane off ; \
     set-option -g mouse-select-window off ; \
     display "Mouse: OFF"'

# コピーモードの操作をvi風に設定する
bind Space copy-mode \; display "copy mode"
bind P paste-buffer
# new: -Tcopy-mode-vi, old: -t vi-copy
if '[ $(echo "`tmux -V | cut -d" " -f2` >= "2.4"" | tr -d "[:alpha:]" | bc) -eq 1 ]' \
  'set-environment -g TMUX_VI_COPY "-Tcopy-mode-vi" ; \
   set-environment -g TMUX_SEND_OPTION "send -X" ; \
   set-environment -g TMUX_COPY_MODE "copy-pipe-and-cancel"' \
  'set-environment -g TMUX_VI_COPY "-t vi-copy" ; \
   set-environment -g TMUX_SEND_OPTION "" ; \
   set-environment -g TMUX_COPY_MODE "copy-pipe"'
run-shell 'tmux bind $TMUX_VI_COPY v $TMUX_SEND_OPTION begin-selection'
run-shell 'tmux bind $TMUX_VI_COPY V $TMUX_SEND_OPTION select-line'
run-shell 'tmux bind $TMUX_VI_COPY C-v $TMUX_SEND_OPTION rectangle-toggle'
run-shell 'tmux bind $TMUX_VI_COPY y $TMUX_SEND_OPTION copy-selection'
run-shell 'tmux bind $TMUX_VI_COPY Y $TMUX_SEND_OPTION copy-line'
run-shell 'tmux bind $TMUX_VI_COPY Escape $TMUX_SEND_OPTION cancel'
if 'builtin command -v xsel > /dev/null 2>&1' \
  "run-shell 'tmux bind $TMUX_VI_COPY Enter $TMUX_SEND_OPTION $TMUX_COPY_MODE \"xsel -i --clipboard\"'"
if 'builtin command -v xclip > /dev/null 2>&1' \
  "run-shell 'tmux bind $TMUX_VI_COPY Enter $TMUX_SEND_OPTION $TMUX_COPY_MODE \"xclip -i -selection clipboard\"'"
if '$WAYLAND_DISPLAY != "" && builtin command -v wl-copy > /dev/null 2>&1' \
  "run-shell 'tmux bind $TMUX_VI_COPY Enter $TMUX_SEND_OPTION $TMUX_COPY_MODE \"wl-copy\"'"

run-shell 'tmux bind $TMUX_VI_COPY O $TMUX_SEND_OPTION $TMUX_COPY_MODE "~/.tmux/conf/scripts/open-editor.sh"'

# copy paste
bind [ copy-mode \; display "copy mode"
bind ] paste-buffer
bind C-] choose-buffer

# Pre C-xでそのペインをkillする
bind C-x confirm-before 'kill-pane'
# Pre C-Xでそのウィンドウをkillする
bind C-X confirm-before 'kill-window'
# Pre qでそのセッションをkill-sessionする
bind q confirm-before 'kill-session'
# Pre C-qでtmuxそのもの（サーバとクライアント）をkillする
bind C-q confirm-before 'kill-server'

# log output
bind-key '{' pipe-pane 'cat >> $HOME/.tmux/log/tmux-#W.log' \; display-message 'Started logging to $HOME/.tmux/log/tmux-#W.log'
bind-key '}' pipe-pane \; display-message 'Ended logging to $HOME/.tmux/log/tmux-#W.log'


