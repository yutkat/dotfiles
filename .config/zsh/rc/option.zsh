
#==============================================================#
##          Options                                           ##
#==============================================================#

unsetopt promptcr            # 改行のない出力をプロンプトで上書きするのを防ぐ
setopt extended_history      # 履歴ファイルに開始時刻と経過時間を記録
setopt append_history        # 履歴を追加 (毎回 .zhistory を作るのではなく)
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_space     # スペースで始まるコマンド行はヒストリリストから削除
# (→ 先頭にスペースを入れておけば、ヒストリに保存されない)
unsetopt hist_verify         # ヒストリを呼び出してから実行する間に一旦編集可能を止める
setopt hist_reduce_blanks    # 余分な空白は詰めて記録<-teratermで履歴かおかしくなる
setopt hist_save_no_dups     # ヒストリファイルに書き出すときに、古いコマンドと同じものは無視する。
setopt hist_no_store         # historyコマンドは履歴に登録しない
setopt hist_expand           # 補完時にヒストリを自動的に展開
#setopt hist_allow_clobber    # リダイレクトしたとき、履歴上で `|>`置き換える。しんせつ！
#setopt hist_beep             # アクセスした履歴が存在しないときに、ビープ音を鳴らす

#setopt hist_expire_dups_first # 履歴リストのイベント数が上限(HISTSIZE)に達したときに、
# 古いものではなく重複したイベントを削除する
# HIST_IGNORE_ALL_DUPS 設定してればいらない気。
#setopt hist_fcntl_lock       # よくわからんけど、ファイルロックに関する設定。man によるとパフォーマンスが向上するらしい。
#setopt hist_find_no_dups     # ラインエディタでヒストリ検索するときに、一度見つかったものは後続で表示しない。
#setopt hist_lex_words        # デフォルトで zshの履歴は空白で単語分割される。
# このオプションがONの場合は、通常のコマンドラインと同様の方法で分割される。
# らしい。 少し試しましたが違いがわからなかった。
#setopt hist_no_functions     # 関数定義のコマンドを履歴リストに追加しない。というか次の(ry
# 以下の三つは それぞれ排他的な(同時にONにすべきじゃない)オプション
#setopt inc_append_history;    # 履歴リストにイベントを登録するのと同時に、履歴ファイルにも書き込みを行う(追加する)。
#setopt inc_append_history_time # コマンド終了時に、履歴ファイルに書き込む
# つまりコマンドの経過時間が正しく記録される
# 逆に言うと `INC_APPEND_HISTORY` × `EXTENDED_HISTORY` の併用では**経過時間が全て0で記録される**
setopt share_history;       # 各端末で履歴(ファイル)を共有する = 履歴ファイルに対して参照と書き込みを行う。
# 書き込みは 時刻(タイムスタンプ) 付き
# 今までONにしてたが、よくよく考えるとあまりいいオプションじゃないかもしれない。

setopt list_packed           # コンパクトに補完リストを表示
setopt auto_remove_slash     # 補完で末尾に補われた / を自動的に削除
setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
unsetopt menu_complete       # 補完の際に、可能なリストを表示してビープを鳴らすのではなく、
# 最初にマッチしたものをいきなり挿入、はしない
setopt auto_list             # ^Iで補完可能な一覧を表示する(補完候補が複数ある時に、一覧表示)
setopt auto_menu             # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt auto_resume           # サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム

#setopt auto_correct          # 補完時にスペルチェック
#setopt correct               # スペルミスを補完
#setopt correct_all           # コマンドライン全てのスペルチェックをする

setopt auto_cd               # ディレクトリのみで移動
setopt no_beep               # コマンド入力エラーでBeepを鳴らさない
#setopt beep
#setopt brace_ccl             # ブレース展開機能を有効にする -> HEAD@{1}とかが展開されてしまう
#setopt bsd_echo
setopt complete_in_word
setopt equals                # =COMMAND を COMMAND のパス名に展開
setopt nonomatch             # グロブ展開でnomatchにならないようにする
setopt glob
setopt extended_glob         # 拡張グロブを有効にする
unsetopt flow_control        # (shell editor 内で) C-s, C-q を無効にする
setopt no_flow_control       # C-s/C-q によるフロー制御を使わない
setopt hash_cmds             # 各コマンドが実行されるときにパスをハッシュに入れる
setopt no_hup                # ログアウト時にバックグラウンドジョブをkillしない
setopt ignore_eof            # C-dでログアウトしない
#setopt no_checkjobs          # ログアウト時にバックグラウンドジョブを確認しない

setopt long_list_jobs        # 内部コマンド jobs の出力をデフォルトで jobs -L にする
setopt magic_equal_subst     # コマンドラインの引数で --PREFIX=/USR などの = 以降でも補完できる
setopt mail_warning
setopt multios               # 複数のリダイレクトやパイプなど、必要に応じて TEE や CAT の機能が使われる
setopt numeric_glob_sort     # 数字を数値と解釈してソートする
setopt path_dirs             # コマンド名に / が含まれているとき PATH 中のサブディレクトリを探す
setopt print_eight_bit       # 補完候補リストの日本語を適正表示
setopt short_loops           # FOR, REPEAT, SELECT, IF, FUNCTION などで簡略文法が使えるようになる

setopt auto_name_dirs
#setopt sun_keyboard_hack     # SUNキーボードでの頻出 typo ` をカバーする
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示
#setopt cdable_vars          # ディレクトリが見つからない場合に先頭に~をつけて試行する
unsetopt sh_word_split

setopt auto_pushd            # 普通に cd するときにもディレクトリスタックにそのディレクトリを入れる
setopt pushd_ignore_dups     # ディレクトリスタックに重複する物は古い方を削除
setopt pushd_to_home         # pushd 引数ナシ == pushd $HOME
setopt pushd_silent          # pushd,popdの度にディレクトリスタックの中身を表示しない
setopt pushdminus            # + - の動作を入れ替える

setopt rm_star_wait          # rm * を実行する前に確認
#setopt rm_star_silent        # rm * を実行する前に確認しない
setopt notify                # バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる

#setopt no_clobber            # リダイレクトで上書きを禁止
unsetopt no_clobber
#setopt no_unset              # 未定義変数の使用禁止
setopt interactive_comments  # コマンド入力中のコメントを認める
setopt chase_links           # シンボリックリンクはリンク先のパスに変換してから実行
#setopt print_exit_value      # 戻り値が 0 以外の場合終了コードを表示
#setopt single_line_zle       # デフォルトの複数行コマンドライン編集ではなく、１行編集モードになる
#setopt xtrace                # コマンドラインがどのように展開され実行されたかを表示する
setopt noflowcontrol

setopt nolistambiguous # メニューを出す
