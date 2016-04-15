
"--------------------------------------------------------------
"         Display Settings                                  {{{
"--------------------------------------------------------------

set display=lastline  " 長い行も一行で収まるように
set showmatch         " 括弧の対応をハイライト
set matchtime=1       " 括弧の対を見つけるミリ秒数
set showcmd           " 入力中のコマンドを表示
set number            " 行番号表示
set wrap              " 画面幅で折り返す
"set list              " 不可視文字表示
"set listchars=tab:>  " 不可視文字の表示方法
set notitle           " タイトル書き換えない
if !&scrolloff
  set scrolloff=5
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set pumheight=10      " 補完候補の表示数
" 折りたたみ設定
"set foldmethod=marker
"set foldcolumn=5

" }}}

