
#--------------------------------------------------------------#
##          Base Configuration                                ##
#--------------------------------------------------------------#

HOSTNAME=`hostname`
HISTFILE=$ZHOMEDIR/.zsh_history      # ヒストリ保存ファイル
HISTSIZE=10000                    # メモリ内の履歴の数
SAVEHIST=100000                   # 保存される履歴の数
LISTMAX=1000                      # 補完リストを尋ねる数 (1=黙って表示, 0=ウィンドウから溢れるときは尋ねる)
KEYTIMEOUT=1

# root のコマンドはヒストリに追加しない
if [ $UID = 0 ]; then
  unset HISTFILE
  SAVEHIST=0
fi

# ls /usr/local/etc などと打っている際に、C-w で単語ごとに削除
# default  : ls /usr/local → ls /usr/ → ls /usr → ls /
# この設定 : ls /usr/local → ls /usr/ → ls /
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>|'

# core
ulimit -c unlimited

# ファイル作成時のパーミッション
umask 022

# zsh関数のサーチパス
fpath=($ZHOMEDIR/zfunc(N-/) $fpath)

# カレントディレクトリ中にサブディレクトリが無い場合に cd が検索するディレクトリのリスト
cdpath=($HOME)

# run-help が呼ばれた時、zsh の内部コマンドの場合は該当する zsh のマニュアル表示
[ -n "`alias run-help`" ] && unalias run-help
autoload run-help

# 拡張子ごとのカラーリング
[ -f $ZHOMEDIR/dircolors ] && eval $(dircolors $ZHOMEDIR/dircolors)

