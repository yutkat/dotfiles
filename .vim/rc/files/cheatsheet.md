# Cheat Sheet

# Vim

## よく忘れるコマンド

http://www3.kcn.ne.jp/~okina/vim_blank.html

### surroundで複数行囲む

1. Shift + v
2. `:normal yss'` ('で囲むとき)
3. インデントがあるとうまく行かないので一度左に詰めるようにする

### Quickfixの過去履歴を表示

- chi
- 戻るとき: col

### カーソル下の単語削除

daw	カーソル位置の単語を削除(空白含む) (d + a word)

diw	カーソル位置の単語を削除 (d + inner word)


###  g で始まるコマンドというかキーマップまとめ

http://h-miyako.hatenablog.com/entry/2015/01/31/185620


### 自動的にマークされる

^      最後に挿入モードを抜けた場所

.      最後に変更を加えた場所

' or ` 最後にジャンプした時にいた場所

"      バッファを終了した時にいた場所

0～9   vimを終了する時にいた場所


http://d.hatena.ne.jp/xaxe/20070122


### 繰り返し

- @:	コマンドの繰り返し
- ;	移動の繰り返し(右方向)
- ,	移動の繰り返し(左方向)
- &	sコマンドの繰り返し
- .	編集の繰り返し
- '.	最後の編集位置へ
- gv	最後のv選択位置へ
- v選択後 o	選択範囲の最初/最後へ
- <C-^>	直近開いたバッファへ
- @@ macro(record)の繰り返し

### 以前の編集点に戻る

`. カーソル位置へジャンプする

g;  編集位置をさかのぼる


### コマンドモードの履歴を検索

ctrl-f



### 画面操作

H	画面の一番上の行へ移動

L	画面の一番下の行へ移動

Ctrl-e	1 行下にスクロール

Ctrl-y	1 行上にスクロール

Ctrl-f	1 画面下にスクロール

Ctrl-b	1 画面上にスクロール

Ctrl-d	半画面下にスクロール

Ctrl-u	半画面上にスクロール


### 補完コマンド

|  補完機能|  キーマップ|
|---|---|
|1. 行全体|CTRL-X CTRL-L|
|1. 行全体|CTRL-X CTRL-L|
|2. 現在のファイルのキーワード|CTRL-X CTRL-N|
|3. 'dictionary'のキーワード|CTRL-X CTRL-K|
|4. 'thesaurus'のキーワード, thesaurus-style|CTRL-X CTRL-T|
|5. 編集中と外部参照しているファイルのキーワード|CTRL-X CTRL-I|
|6. タグ|CTRL-X CTRL-]|
|7. ファイル名|CTRL-X CTRL-F|
|8. 定義もしくはマクロ|CTRL-X CTRL-D|
|9. Vimのコマンドライン|CTRL-X CTRL-V|
|10. ユーザ定義補完|CTRL-X CTRL-U|
|11. オムニ補完|CTRL-X CTRL-O|
|12. スペリング補完|CTRL-X s|
|13. 'complete'のキーワード|CTRL-N|

補完を中止したいときは「CTRL-E」を押すといいらしい。


### 最後に実行したコマンドを実行する

@:


### 最後に実行した編集を実行する

&



### カーソルの移動位置を戻す

元いた場所に戻る: <C-o>

元いた場所に進む: <C-i>



### 矩形選択での上書き

ctrl+vで領域選択後

c	矩形を置換

***rでなくてc***



### バッファの移動

バッファ番号 CTRL+^

もしくは

:buffer バッファ番号

:b バッファ番号


http://blog.livedoor.jp/nakamura_tech/archives/51363029.html



### 直前に開いていたファイルを開く

C-^ ... 一つ前に開いていたファイルに移動


### ヘッダファイルを開く

「Ctrl-w gf」タブでファイルを開く。

タブとして開くので、ノーマルモードで「gt」で移動



### ウィンドウ操作

Ctrl W + R - To rotate windows up/left.

Ctrl W + r - To rotate windows down/right.

Ctrl W + L - Move the current window to the "far right"

Ctrl W + H - Move the current window to the "far left"

Ctrl W + J - Move the current window to the "very bottom"

Ctrl W + K - Move the current window to the "very top"

Ctrl W + x OR Ctrl W + Ctrl x - Rotates the current focused window with

" 横分割 -> 縦分割への切り替え

CTRL-W t CTRL-W H

" 縦分割 -> 横分割への切り替え

CTRL-W t CTRL-W K

" カレントウィンドウをタブとして移動する

CTRL-W T


:vertical {cmd}

垂直分割をするようにします。例えば、:vertical split は :vsplit のような動作になります。

:leftabove {cmd} :aboveleft {cmd}

水平分割なら上に、垂直分割なら左に新しいウィンドウを作ります。

:rightbelow {cmd} :belowright {cmd}

水平分割なら下に、垂直分割なら右に新しいウィンドウを作ります。

:topleft {cmd}

水平分割なら画面の一番上に、垂直分割なら画面の一番左に、それぞれ幅、高さが最大になるように新しいウィンドウを作ります。

:botright {cmd}

水平分割なら画面の一番下に、垂直分割なら画面の一番右に、それぞれ幅、高さが最大になるように新しいウィンドウを作ります。


### コマンドモード中にペースト

<C-R>" ：コマンドモード中にヤンクからペーストを行う

Rはレジスタと覚える

デフォルトレジスタ「"」


<C-R>/：コマンドモード中にコマンド欄で検索した文字をペースト


Ctrl-W x：ウィンドウを入れ替える


### バッファ

<C-o>：元いた場所にも取る

<C-i>：元いた場所に進む


#### バッファの設定

http://leafcage.hateblo.jp/entry/2013/11/21/083830


### マーク

ma：現在のカーソル位置をマーク名 a に保存

'a：マーク名 a の位置に移動


### 折りたたみ

zo：カーソル下にある折りたたみをひとつ開く

zO：カーソル下にある折りたたみを全て開く

zc：カーソル下にある折りたたみをひとつ閉じる

zC：カーソル下にある折りたたみを全て閉じる

zf ： 選択した範囲が折り畳み


### 表示更新

Ctrl+l


### 矩形貼り付け

1. Ctrl+vで矩形選択モードにする

2. 範囲選択したあとにCtrl+Iで入力モードにする

3. Ctrl+rを押して"入力でヤンクした内容をペースト

4. ESCで抜けて複数行に反映


### 矩形置換

`:'<,'>:s/\%Vhoge/foo/g`

*pattern-atoms*


### 辞書に追加

]s	次のスペルミスの箇所へ移動

[s	前のスペルミスの箇所へ移動

z=	正しいスペルの候補を表示し、選択した単語でスペルミスを修正

zg	カーソル下の単語を正しいスペルとして辞書登録

zw	カーソル下の単語を誤ったスペルとして辞書登録


### 一時的に計算する

insertモードで
<C-r>=

