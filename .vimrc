"=============================================================="
"               .vimrc                                         "
"=============================================================="

"--------------------------------------------------------------"
"          Initial Configuration                               "
"--------------------------------------------------------------"
set nocompatible            " 必ず最初に書く
set viminfo='20,<50,s10,h,! " YankRing用に!を追加
set shellslash              " Windowsでディレクトリパスの区切り文字に / を使えるようにする
set lazyredraw              " マクロなどを実行中は描画を中断
"colorscheme desert          " カラースキーム


"--------------------------------------------------------------"
"          NeoBundle                                           "
"--------------------------------------------------------------"
" Note: Skip initialization for vim-tiny or vim-small.
" 使用するプロトコルを変更する
let g:neobundle_default_git_protocol='https'
 
if !1 | finish | endif

if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'rails.vim'
NeoBundle 'SrcExpl'
NeoBundle 'Trinity'
NeoBundle 'neocomplcache'
NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'Shougo/unite.vim'
"NeoBundle 'YankRing.vim'
NeoBundle 'ujihisa/unite-locate'
NeoBundle 'tpope/vim-surround'
NeoBundle 'taglist.vim'
NeoBundle 'ZenCoding.vim'
NeoBundle 'The-NERD-tree'
NeoBundle 'The-NERD-Commenter'
NeoBundle 'fugitive.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-localrc'
NeoBundle 'dbext.vim'
NeoBundle 'Gist.vim'
NeoBundle 'motemen/hatena-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/unite-advent_calendar'
NeoBundle 'open-browser.vim'
NeoBundle 'troydm/easybuffer.vim'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'LeafCage/yankround.vim'
" ibus 制御
NeoBundle 'fuenor/im_control.vim.git'
"NeoBundle 'jelera/vim-javascript-syntax'

"vimのバージョンが古いため 
"NeoBundle 'violetyk/cake.vim'

"neocomplcacheと併用できないため
"NeoBundle 'Shougo/neocomplcache-clang'

" YankRing と重複
"NeoBundle 'ctrlp.vim'

" euc だと使えない
"NeoBundle 'Shougo/vimproc'

" neocomplcache と競合
"NeoBundle 'AutoComplPop'

" インデックス範囲外のエラーが出る
"NeoBundle 'ref.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


"--------------------------------------------------------------"
"          Base Configuration                                  "
"--------------------------------------------------------------"
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

" ファイル関連
set nobackup   " バックアップ取らない
set autoread   " 他で書き換えられたら自動で読み直す
set noswapfile " スワップファイル作らない
set hidden     " 編集中でも他のファイルを開けるようにする

" OSのクリップボードを使う
set clipboard+=unnamed
set clipboard=unnamed

" ビープ音除去
set vb t_vb=


"--------------------------------------------------------------"
"          Display Settings                                    "
"--------------------------------------------------------------"
set display=lastline  " 長い行も一行で収まるように
set showmatch         " 括弧の対応をハイライト
set matchtime=1       " 括弧の対を見つけるミリ秒数
set showcmd           " 入力中のコマンドを表示
set number            " 行番号表示
set wrap              " 画面幅で折り返す
"set list              " 不可視文字表示
"set listchars=tab:>  " 不可視文字の表示方法
set notitle           " タイトル書き換えない
set scrolloff=5       " 行送り
set pumheight=10      " 補完候補の表示数

" ステータスライン関連
set laststatus=2
"set statusline=%t\ %m%r%h%w[%Y][%{&fenc}][%{&ff}]<%F>%=%c,%l%11p%%
"set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=%l,%c%V%8P
" ステータスラインの表示
  set statusline=%<     " 行が長すぎるときに切り詰める位置
  set statusline+=[%n]  " バッファ番号
  set statusline+=%m    " %m 修正フラグ
  set statusline+=%r    " %r 読み込み専用フラグ
  set statusline+=%h    " %h ヘルプバッファフラグ
  set statusline+=%w    " %w プレビューウィンドウフラグ
  set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  " fencとffを表示
  set statusline+=%y    " バッファ内のファイルのタイプ
  set statusline+=\     " 空白スペース
if winwidth(0) >= 130
  set statusline+=%F    " バッファ内のファイルのフルパス
else
  set statusline+=%t    " ファイル名のみ
endif
  set statusline+=%=    " 左寄せ項目と右寄せ項目の区切り
  set statusline+=%{fugitive#statusline()}  " Gitのブランチ名を表示
  set statusline+=\ \   " 空白スペース2個
  set statusline+=%1l   " 何行目にカーソルがあるか
  set statusline+=/
  set statusline+=%L    " バッファ内の総行数
  set statusline+=,
  set statusline+=%c    " 何列目にカーソルがあるか
  set statusline+=%V    " 画面上の何列目にカーソルがあるか
  set statusline+=\ \   " 空白スペース2個
  set statusline+=%P    " ファイル内の何％の位置にあるか
"set statusline=%<%F %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v(ASCII=%03.3b,HEX=%02.2B) %l/%L(%P)%m


"--------------------------------------------------------------"
"          Encode Settings                                     "
"--------------------------------------------------------------"
" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif


"--------------------------------------------------------------"
"          Coloring                                            "
"--------------------------------------------------------------"
" 色付け
syntax on " シンタックスカラーリングオン

set complete+=k    " 補完に辞書ファイル追加
"filetype indent on " ファイルタイプによるインデントを行う
filetype plugin on " ファイルタイプごとのプラグインを使う

" ポップアップメニューの色変える
highlight Pmenu ctermbg=lightcyan ctermfg=black 
highlight PmenuSel ctermbg=blue ctermfg=black 
highlight PmenuSbar ctermbg=darkgray 
highlight PmenuThumb ctermbg=lightgray


"--------------------------------------------------------------"
"          Key Configuration                                   "
"--------------------------------------------------------------"
" 表示行単位で移動
noremap j gj
noremap k gk
vnoremap j gj
vnoremap k gk

cnoremap <c-a> <Home>
cnoremap <c-e> <End>

" ハイライト消す
nmap <silent> gh :nohlsearch<CR>

noremap  <Del>

" コピー
nnoremap Y y$

" インクリメント設定
noremap + <C-a>
noremap - <C-x>


"--------------------------------------------------------------"
"          autocmd                                             "
"--------------------------------------------------------------"
if has('autocmd')
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    autocmd! vimrcEx
  
    " 前回終了したカーソル行に移動
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
    " ======== Undo ======== "
    " アンドゥ
    if has('persistent_undo')
      set undodir=./.vimundo,~/.vim/vimundo
    "    autocmd BufReadPre ~/* setlocal undofile
        autocmd BufRead ~/* setlocal undofile
    endif
    " ======== バイナリモード ======== "
    "バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin ファイルを開くと発動します）
    autocmd BufReadPre  *.bin let &binary =1
    autocmd BufReadPost * if &binary | silent %!xxd -g 1
    autocmd BufReadPost * set ft=xxd | endif
    autocmd BufWritePre * if &binary | %!xxd -r | endif
    autocmd BufWritePost * if &binary | silent %!xxd -g 1
    autocmd BufWritePost * set nomod | endif
  augroup END
endif


"--------------------------------------------------------------"
"          Special Configuration                                   "
"--------------------------------------------------------------"
" ======== 貼り付け設定 ======== "
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function! XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif


" ======== 強制保存 ======== "
" w!!でスーパーユーザとして保存
"cmap w!! w !sudo tee > /dev/null %


" ======== 自動ペーストモード ======== "
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function! XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

" ======== Mouse Setting ======== "
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=""
  " For screen.
  if &term =~ "^screen"
      augroup MyAutoCmd
          autocmd VimLeave * :set mouse=
       augroup END
   
      " screenでマウスを使用するとフリーズするのでその対策
      set ttymouse=xterm2
  endif
   
  if has('gui_running')
      " Show popup menu if right click.
      set mousemodel=popup
      " Don't focus the window when the mouse pointer is moved.
      set nomousefocus
      " Hide mouse pointer on insert mode.
      set mousehide
  endif
endif


"--------------------------------------------------------------"
"          Function Definition                                 "
"--------------------------------------------------------------"
" 読み取り専用をわかりやすく
function! CheckRo()
  if &readonly
    colorscheme delek
  else
    colorscheme default
  endif
endfunction
au BufReadPost * call CheckRo()


"--------------------------------------------------------------"
"          Plugin Settings                                     "
"--------------------------------------------------------------"
" ======== Trinity ======== " 
nmap <F8>   :TrinityToggleAll<CR> 
nmap <F9>   :TrinityToggleSourceExplorer<CR> 
nmap <F10>  :TrinityToggleTagList<CR> 
nmap <F11>  :TrinityToggleNERDTree<CR> 
nmap <C-j> <C-]>

" ======== yankround ======== " 
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 100
let g:yankround_dir = '~/.cache/yankround'
nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>

" ======== SrcExpl ======== " 
let Tlist_Exit_OnlyWindow = 1
nmap <F8> :SrcExplToggle<CR> 
let g:SrcExpl_winHeight = 8 
let g:SrcExpl_refreshTime = 2000 
let g:SrcExpl_gobackKey = "<SPACE>" 
let g:SrcExpl_pluginList = [ 
        \ "__Tag_List__", 
        \ "_NERD_tree_", 
        \ "Source_Explorer" 
    \ ] 
let g:SrcExpl_searchLocalDef = 1 
let g:SrcExpl_isUpdateTags = 0
let g:SrcExpl_updateTagsKey = "<F12>" 
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ." 

" ======== cscope  ======== "
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=0
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
  " else add database pointed to by environment 
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
  set csverb
  set cscopequickfix=s-,c-,d-,i-,t-,e-
endif

" ======== Taglist ======== " 
let Tlist_Show_One_File = 1                   " 現在表示中のファイルのみのタグしか表示しない
let Tlist_Exit_OnlyWindow = 1                 " taglistのウインドウだけならVimを閉じる

" ======== neocomplcache ======== "
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_max_list = 30
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_enable_smart_case = 1

" ======== clang ---------- "
" neocomplcache 側の設定
let g:neocomplcache_force_overwrite_completefunc=1

if !exists("g:neocomplcache_force_omni_patterns")
    let g:neocomplcache_force_omni_patterns = {}
endif

" omnifunc が呼び出される場合の正規表現パターンを設定しておく
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|::'


" clang_complete 側の設定
" clang_complete の自動呼び出しは必ず切っておいて下さい
" これを設定しておかなければ補完がおかしくなります
let g:clang_complete_auto=0

" ======== quickrun ======== "
set splitbelow "新しいウィンドウを下に開く

let g:quickrun_config = {
\  'c': {
\    'command': 'make run',
\    'exec': ['make run']
\  }
\}

" ======== im_control.vim ======== "
" 「日本語入力固定モード」切替キー
inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
" PythonによるIBus制御指定
let IM_CtrlIBusPython = 1

" <ESC>押下後のIM切替開始までの反応が遅い場合はttimeoutlenを短く設定してみてください。
set timeout timeoutlen=3000 ttimeoutlen=10

