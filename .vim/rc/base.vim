
"==============================================================
"          Base Configuration                               {{{
"==============================================================

let mapleader = "\<Space>"
let maplocalleader = "\\"

if !empty(&viminfo)
  if has('nvim')
    set viminfo='50,<1000,s100,\"1000,!,n$HOME/.vim/info/nviminfo " YankRing用に!を追加
  else
    set viminfo='50,<1000,s100,\"1000,!,n$HOME/.vim/info/viminfo " YankRing用に!を追加
  endif
endif
set shellslash   " Windowsでディレクトリパスの区切り文字に / を使えるようにする
"set lazyredraw  " vim-anzuの検索結果が見えなくなることがあるためOFF
set complete+=k  " 補完に辞書ファイル追加
set completeopt=menuone
if (v:version == 704 && has('patch775')) || v:version >= 705
  set completeopt+=noselect,noinsert
endif
set history=500
set timeout timeoutlen=500 ttimeoutlen=10

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

" 単語区切り設定 setting by vim-polyglot
" set iskeyword=48-57,192-255

" コマンド補完
set wildmenu           " コマンド補完を強化
set wildmode=longest,list,full " リスト表示，最長マッチ

" 検索関連
set wrapscan   " 最後まで検索したら先頭へ戻る
"set nowrapscan " 最後まで検索しても先頭に戻らない
set ignorecase " 大文字小文字無視
set smartcase  " 大文字ではじめたら大文字小文字無視しない
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト

" ウィンドウ関連
set splitbelow
set splitright

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
set nomodeline

" OSのクリップボードを使う
" +レジスタ：Ubuntuの[Ctrl-v]で貼り付けられるもの unnamedplus
" *レジスタ：マウス中クリックで貼り付けられるもの unnamed
if has('nvim') || (((exists('$DISPLAY') && executable('pbcopy'))
      \   || (exists('$DISPLAY') && executable('xclip'))
      \   || (exists('$DISPLAY') && executable('xsel')))
      \   && has('clipboard')
      \ )
  set clipboard&
  set clipboard^=unnamedplus,unnamed
endif

" ビープ音除去
set vb t_vb=
set noerrorbells
set novisualbell

" ファイルのディレクトリに移動
"set autochdir

" tags
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif


" smart indent for long line
" if v:version >= 800
"   set breakindent
" endif


" }}}

