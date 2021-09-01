
#==============================================================#
##          Completion                                        ##
#==============================================================#

setopt prompt_subst          # プロンプトに escape sequence (環境変数) を通す

# see http://zsh.sourceforge.net/Doc/Release/Completion-System.html

# :completion:function:completer:command:argument:tag

# オプション補完で解説部分を表示
zstyle ':completion:*' verbose yes
# 補完方法の設定。指定した順番に実行する。
## _oldlist 前回の補完結果を再利用する。
## _complete: 普通の補完関数
## _ignored: 補完候補にださないと指定したものも補完候補とする。
## _match: *などのグロブによってコマンドを補完できる
## _prefix: カーソル以降を無視してカーソル位置までで補完する。
## _approximate: 似ている補完候補も補完候補とする。
## _expand: グロブや変数の展開を行う。もともとあった展開と比べて、細かい制御が可能
## _history: 履歴から補完を行う。_history_complete_wordから使われる
## _correct: ミススペルを訂正した上で補完を行う。
zstyle ':completion:*' completer _oldlist _complete _ignored
zstyle ':completion:*:messages' format '%F{yellow}%d'
zstyle ':completion:*:warnings' format '%B%F{red}No matches for:''%F{white}%d%b'
zstyle ':completion:*:descriptions' format '%B%F{white}--- %d ---%f%b'
zstyle ':completion:*:corrections' format ' %F{green}%d (errors: %e) %f'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' recent-dirs-insert both
# 補完候補を色分け (GNU ls の色定義を流用)
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*' special-dirs true
# 補完の時に大文字小文字を区別しない (但し、大文字を打った場合は小文字に変換しない)
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
# 一部のコマンドライン定義は、展開時に時間のかかる処理を行う -- apt-get, dpkg (Debian), rpm (Redhat), urpmi (Mandrake), perlの-Mオプション, bogofilter (zsh 4.2.1以降), fink, mac_apps (MacOS X)(zsh 4.2.2以降)
zstyle ':completion:*' use-cache true
# 補完候補を ←↓↑→ で選択 (補完候補が色分け表示される)
# zstyle show completion menu if 1 or more items to select
zstyle ':completion:*:default' menu select=1
# カレントディレクトリに候補がない場合のみ cdpath 上のディレクトリを候補
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
# 補完リストの順番指定
zstyle ':completion:*:cd:*' group-order local-directories path-directories
# psコマンドを補完する
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
# sudoコマンドを補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
# 変数の添字を補完する
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
# manの補完をセクション番号別に表示させる
zstyle ':completion:*:manuals' separate-sections true
# 更新日順に表示する
zstyle ':completion:*' file-sort 'modification'

# make completion is slow
zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:make::' tag-order targets:
zstyle ':completion:*:*:*make:*:targets' command awk \''/^[a-zA-Z0-9][^\/\t=]+:/ {print $1}'\' \$file
#zstyle ':completion:*:*:make:*:targets' ignored-patterns '*.o'
#zstyle ':completion:*:*:*make:*:*' tag-order '!targets !functions !file-patterns'
#zstyle ':completion:*:*:*make:*:*' avoid-completer '_files'
