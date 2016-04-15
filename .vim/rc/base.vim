
"--------------------------------------------------------------
"          Base Configuration                               {{{
"--------------------------------------------------------------

if !empty(&viminfo)
  set viminfo='50,<1000,s100,\"50,!,n$HOME/.vim/info/viminfo " YankRing用に!を追加
endif
set shellslash              " Windowsでディレクトリパスの区切り文字に / を使えるようにする
set lazyredraw              " マクロなどを実行中は描画を中断
set complete+=k             " 補完に辞書ファイル追加
set history=500

" タブ周り
" tabstopはTab文字を画面上で何文字分に展開するか
" shiftwidthはcindentやautoindent時に挿入されるインデントの幅
" softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
set tabstop=4 shiftwidth=4 softtabstop=0
set expandtab              " タブを空白文字に展開
"set autoindent smartindent " 自動インデント，スマートインデント

" 入力補助
set backspace=indent,eol,start " バックスペースでなんでも消せるように
set formatoptions+=m           " 整形オプション，マルチバイト系を追加
"set formatoptions+=j " Delete comment character when joining commented lines

" コマンド補完
set wildmenu           " コマンド補完を強化
set wildmode=longest,list,full " リスト表示，最長マッチ

" 検索関連
"set wrapscan   " 最後まで検索したら先頭へ戻る
set nowrapscan " 最後まで検索しても先頭に戻らない
set ignorecase " 大文字小文字無視
set smartcase  " 大文字ではじめたら大文字小文字無視しない
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト

" ファイル関連
"set nobackup   " バックアップ取らない
set autoread   " 他で書き換えられたら自動で読み直す
set noswapfile " スワップファイル作らない
set hidden     " 編集中でも他のファイルを開けるようにする
set backup
set backupdir     =$HOME/.vim/backup/
set backupext     =-vimbackup
set backupskip    =
set directory     =$HOME/.vim/swap/
set updatecount   =100
set undofile
set undodir       =$HOME/.vim/undo/

" OSのクリップボードを使う
" +レジスタ：Ubuntuの[Ctrl-v]で貼り付けられるもの unnamedplus
" *レジスタ：マウス中クリックで貼り付けられるもの unnamed
set clipboard&
set clipboard^=unnamedplus,unnamed

" ビープ音除去
set vb t_vb=

" ファイルのディレクトリに移動
"set autochdir

" tags
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

" Encode Settings
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,euc-jp,iso-2022-jp,cp932,sjis
set fileformats=unix,dos,mac

" }}}

