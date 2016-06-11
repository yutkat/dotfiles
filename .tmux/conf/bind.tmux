#--------------------------------------------------------------#
##          Key Bind                                          ##
#--------------------------------------------------------------#

# 直前の画面に移動
bind 'C-\' run "tmux last-pane || tmux last-window || tmux new-window"

# デタッチ
bind d detach

# タイトル変更
bind A command-prompt "rename-window %%"
bind S command-prompt "rename-session %%"

# ウィンドウ選択
bind C-w choose-window

# 設定ファイルをリロードする
bind r source-file ~/.tmux.conf \; display "Reloaded!"

# | でペインを縦に分割する
bind | split-window -hc "#{pane_current_path}"

# - でペインを横に分割する
bind - split-window -vc "#{pane_current_path}"

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

# すばやくコピーモードに移行する
bind -n C-up copy-mode
bind -n C-down paste-buffer

# ウィンドウの移動
bind -n C-S-left previous-window
bind -n C-S-right next-window
bind -n C-S-up new-window -c "#{pane_current_path}"
bind -n C-S-down confirm-before 'kill-window'

# ペインの移動(ローテート)
#bind -n C-O select-pane -t :.+
bind -r C-o select-pane -t :.+
bind -r C-h select-window -t :-
bind -r C-l select-window -t :+

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

# マウス操作を有効にする
bind m \
  if '[ $(echo "`tmux -V | cut -d" " -f2` >= "2.1"" | bc) -eq 1 ]' \
    'set-option -g mouse on ; \
     display "Mouse: ON"' \
    'set-option -g mode-mouse on ; \
     set-option -g mouse-resize-pane on ; \
     set-option -g mouse-select-pane on ; \
     set-option -g mouse-select-window on ; \
     display "Mouse: ON"'

bind M \
  if '[ $(echo "`tmux -V | cut -d" " -f2` >= "2.1"" | bc) -eq 1 ]' \
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
bind -t vi-copy v begin-selection
bind -t vi-copy V select-line
bind -t vi-copy C-v rectangle-toggle
bind -t vi-copy y copy-selection
bind -t vi-copy Y copy-line
unbind -t vi-copy Enter
bind -t vi-copy Enter copy-pipe "xsel -i -b"
bind -t vi-copy Escape cancel

# copy paste
bind [ copy-mode \; display "copy mode"
bind ] paste-buffer
bind C-] choose-buffer

# ペインをbreakする
bind D break-pane -d \; display "break-pane"
# Pre C-xでそのペインをkillする
bind C-x confirm-before 'kill-pane'
# Pre C-Xでそのウィンドウをkillする
bind C-X confirm-before 'kill-window'
# Pre qでそのセッションをkill-sessionする
bind q confirm-before 'kill-session'
# Pre C-qでtmuxそのもの（サーバとクライアント）をkillする
bind C-q confirm-before 'kill-server'

# vi-choice
bind -t vi-choice Escape cancel

# vi-edit
bind -t vi-edit Escape cancel

# log output
bind-key { pipe-pane 'cat >> $HOME/.tmux/log/tmux-#W.log' \; display-message 'Started logging to $HOME/.tmux/log/tmux-#W.log'
bind-key } pipe-pane \; display-message 'Ended logging to $HOME/.tmux/log/tmux-#W.log'


