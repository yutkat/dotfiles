#==============================================================#
##          Prompt Configuration                              ##
#==============================================================#

###     git      ###
function rprompt-git-current-branch {
	local name st color gitdir action
	if [[ "$PWD" =~ /\.git(/.*)?$ ]]; then
		return
	fi
	name=$(git symbolic-ref HEAD 2> /dev/null)
	name=${name##refs/heads/}
	if [[ -z $name ]]; then
		return
	fi

	gitdir=$(git rev-parse --git-dir 2> /dev/null)
	if ! builtin command -v VCS_INFO_get_data_git > /dev/null 2>&1; then
		autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
	fi
	action=$(VCS_INFO_git_getaction "$gitdir") && action="($action)"

	st=$(git status 2> /dev/null)
	if echo "$st" | grep -q "^nothing to"; then
		color=%F{green}
	elif echo "$st" | grep -q "^nothing added"; then
		color=%F{yellow}
	elif echo "$st" | grep -q "^# Untracked"; then
		color=%B%F{red}
	else
		color=%F{red}
	fi
	echo "($color$name$action%f%b)"
}

# 戻り値で%の色を変える
function __show_status() {
	exit_status=${pipestatus[*]}
	local SETCOLOR_DEFAULT="%f"
	local SETCOLOR=${SETCOLOR_DEFAULT}
	local s
	for s in $(echo -en "${exit_status}"); do
		if [ "${s}" -eq 147 ] ; then
			SETCOLOR=${SETCOLOR_DEFAULT}
			break
		elif [ "${s}" -gt 100 ] ; then
			SETCOLOR="%F{red}"
			break
		elif [ "${s}" -gt 0 ] ; then
			SETCOLOR="%F{yellow}"
		fi
	done
	if [ "${SETCOLOR}" != "${SETCOLOR_DEFAULT}" ]; then
		echo -ne "${SETCOLOR}(${exit_status// /|})%f%b"
	else
		echo -ne "${SETCOLOR}%f%b"
	fi
}
#pct=$'%0(?||%147(?||%F{red}))%#%f'


# 左プロンプト
PROMPT='[%n@%m:%.$(rprompt-git-current-branch)]${WINDOW:+"[$WINDOW]"}$(__show_status)%# '
## <エスケープシーケンス>
## prompt_bang が有効な場合、!=現在の履歴イベント番号, !!='!' (リテラル)
# ${WINDOW:+"[$WINDOW]"} = screen 実行時にスクリーン番号を表示 (prompt_subst が必要)
# %B = underline
# %/ or %d = ディレクトリ (0=全て, -1=前方からの数)
# %~ = ディレクトリ
# %h or %! = 現在の履歴イベント番号
# %L = 現在の $SHLVL の値
# %M = マシンのフルホスト名
#  %m = ホスト名の最初の `.' までの部分
# %S (%s) = 突出モードの開始 (終了)
# %U (%u) = 下線モードの開始 (終了)
# %B (%b) = 太字モードの開始 (終了)
# %t or %@ = 12 時間制, am/pm 形式での現在時刻
# %n or $USERNAME = ユーザー ($USERNAME は環境変数なので setopt prompt_subst が必要)
# %N = シェル名
# %i = %N によって与えられるスクリプト, ソース, シェル関数で, 現在実行されている行の番号 (debug用)
# %T = 24 時間制での現在時刻
# %* = 24 時間制での現在時刻, 秒付き
# %w = `曜日-日' の形式での日付
# %W = `月/日/年' の形式での日付
# %D = `年-月-日' の形式での日付
# %D{string} = strftime 関数を用いて整形された文字列 (man 3 strftime でフォーマット指定が分かる)
# %l = ユーザがログインしている端末から, /dev/ プレフィックスを取り除いたもの
# %y = ユーザがログインしている端末から, /dev/ プレフィックスを取り除いたもの (/dev/tty* はソノママ)
# %? = プロンプトの直前に実行されたコマンドのリターンコード
# %_ = パーサの状態
# %E = 行末までクリア
# %# = 特権付きでシェルが実行されているならば `#', そうでないならば `%' == %(!.#.%%)
# %v = psvar 配列パラメータの最初の要素の値
# %{...%} = リテラルのエスケープシーケンスとして文字列をインクルード
# %(x.true-text.false-text) = 三つ組の式
# %<string<, %>string>, %[xstring] = プロンプトの残りの部分に対する, 切り詰めの振る舞い
#         `<' の形式は文字列の左側を切り詰め, `>' の形式は文字列の右側を切り詰めます
# %c, %., %C = $PWD の後ろ側の構成要素

#PROMPT=ubst が必要
# 右プロンプト

# ShellScript Debug
# PS4 for zsh script is overwritten by ~/.zshenv
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
export PROMPT4='+%N:%i> '
