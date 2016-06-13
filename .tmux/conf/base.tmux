#--------------------------------------------------------------#
##          Base                                              ##
#--------------------------------------------------------------#

set-option -g status on
set-option -g status-interval 2

# prefixキーをC-\に変更する
set-option -g prefix 'C-\'
unbind C-b

# デフォルトシェル
set-option -g default-shell $SHELL
set-option -g default-command $SHELL

# ウィンドウのインデックスを1から始める
set-option -g base-index 1
# ペインのインデックスを1から始める
set-window-option -g pane-base-index 1
if '[ $(echo "`tmux -V | cut -d" " -f2` >= "1.7"" | bc) -eq 1 ]' \
  'set-option -g renumber-windows on'

# ウィンドウ履歴の最大行数
set-option -g history-limit 5000

# メッセージ表示秒数
set-option -g display-time 1000

# 代替画面バッファを使わないようにする(親端末のTERMがxtermの場合)
#set-option -g terminal-overrides 'xterm*:smcup@:rmcup@'
set-option -g terminal-overrides 'xterm*:colors=256'

# viのキーバインドを使用する
set-window-option -g mode-keys vi
# クリップボード共有を有効にする
set-option -g default-command "reattach-to-user-namespace -l $SHELL"

# ヴィジュアルノーティフィケーションを有効にする
set-window-option -g monitor-activity on
set-option -g visual-activity off

# bell
set-option -g bell-action none
set-option -g visual-bell off
set-option -g bell-on-alert off

# Escの効きがいいらしい
set-option -s escape-time 0

# ペイン同時入力切り替え
set-option -g synchronize-panes off

# マウス操作切替
if '[ $(echo "`tmux -V | cut -d" " -f2` >= "2.1"" | bc) -eq 1 ]' \
  'set-option -g mouse off' \
  'set-option -g mode-mouse          off ; \
   set-option -g mouse-select-pane   off ; \
   set-option -g mouse-resize-pane   off ; \
   set-option -g mouse-select-window off'

# 矢印キーでペインを移動する
set-window-option -g xterm-keys on

# emacs key bindings in tmux command prompt (prefix + :) are better than
# vi keys, even for vim users
set -g status-keys emacs

# focus events enabled for terminals that support them
set -g focus-events on

# super useful when using "grouped sessions" and multi-monitor setup
setw -g aggressive-resize on

