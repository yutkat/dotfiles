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
set complete+=k             " 補完に辞書ファイル追加
let mapleader = "\<Space>"


"--------------------------------------------------------------"
"          Function Definition                                 "
"--------------------------------------------------------------"
" neocompleteの対応を確認する
function! s:meet_neocomplete_requirements()
    return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction


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
NeoBundle 'justmao945/vim-clang'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
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
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'yegappan/mru'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'terryma/vim-expand-region'
NeoBundle 'fuenor/im_control.vim'  " ibus 制御
NeoBundle 'violetyk/cake.vim'
" 補完時のESCと干渉するため Raimondi/delimitMateに乗り換え
"NeoBundle 'Townk/vim-autoclose'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'fidian/hexmode'
NeoBundle 'tpope/vim-endwise', {
\ 'autoload' : { 'insert' : 1,}
\ }
NeoBundle 'mattn/emmet-vim'
NeoBundle 'grep.vim'
NeoBundle 't9md/vim-quickhl'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundleLazy 'junegunn/vim-easy-align', {
  \ 'autoload': {
  \   'commands' : ['EasyAlign'],
  \   'mappings' : ['<Plug>(EasyAlign)'],
  \ }}
NeoBundleLazy "Shougo/unite.vim", {
\   'autoload' : {
\       'commands' : [ "Unite" ]
\   }
\}
NeoBundleLazy 'Shougo/vimfiler', {
\   'depends' : ["Shougo/unite.vim"],
\   'autoload' : {
\       'commands' : [ "VimFilerTab", "VimFiler", "VimFilerExplorer" ]
\   }
\}
NeoBundleLazy 'Shougo/vimshell', {
\   'autoload' : { 'commands' : [ 'VimShellBufferDir' ] },
\   'depends': [ 'Shougo/vimproc' ],
\ }

" ColorSheme
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'tomasr/molokai'
NeoBundle 'nanotech/jellybeans.vim'
"NeoBundle 'bling/vim-airline'
NeoBundle 'itchyny/lightline.vim'

if s:meet_neocomplete_requirements()
    NeoBundle 'Shougo/neocomplete.vim'
    NeoBundleFetch 'Shougo/neocomplcache.vim'
else
    NeoBundleFetch 'Shougo/neocomplete.vim'
    NeoBundle 'Shougo/neocomplcache.vim'
endif

"NeoBundle 'jelera/vim-javascript-syntax'

" YankRing と重複
"NeoBundle 'ctrlp.vim'
"NeoBundle 'YankRing.vim'

" neocomplcache と競合
"NeoBundle 'AutoComplPop'
"NeoBundle 'Shougo/vimproc'

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
" +レジスタ：Ubuntuの[Ctrl-v]で貼り付けられるもの unnamedplus
" *レジスタ：マウス中クリックで貼り付けられるもの unnamed
set clipboard=unnamedplus

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
  set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''} " Gitブランチ名を表示
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
set encoding=utf-8
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8


"--------------------------------------------------------------"
"          Coloring                                            "
"--------------------------------------------------------------"
" 色付け
syntax on " シンタックスカラーリングオン

" カラースキーム
set t_Co=256
try
    let g:hybrid_use_Xresources = 1
    colorscheme hybrid
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme desert
endtry

" 行番号のハイライト
set cursorline
hi clear CursorLine

" ポップアップメニューの色変える
highlight Pmenu ctermbg=lightcyan ctermfg=black
highlight PmenuSel ctermbg=blue ctermfg=black
highlight PmenuSbar ctermbg=darkgray
highlight PmenuThumb ctermbg=lightgray

" 読み取り専用をわかりやすく
function! CheckRo()
  if &readonly
    colorscheme morning
  endif
endfunction


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

noremap ? <Del>

" コピー
nnoremap Y y$


" インクリメント設定
noremap + <C-a>
noremap - <C-x>

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
nmap <Leader><Leader> V


"--------------------------------------------------------------"
"          autocmd                                             "
"--------------------------------------------------------------"
if has('autocmd')
  augroup CheckRo
    autocmd! CheckRo
    autocmd BufReadPost * call CheckRo()
  augroup END
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
  augroup END
endif


"--------------------------------------------------------------"
"          Special Configuration                                   "
"--------------------------------------------------------------"
" ======== 貼り付け設定 ======== "
if &term =~ "xterm" || &term =~ "screen"
  function! WrapForTmux(s)
    if !exists('$TMUX')
      return a:s
    endif

    let tmux_start = "\<Esc>Ptmux;"
    let tmux_end = "\<Esc>\\"

    return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
  endfunction

  let &t_SI .= WrapForTmux("\<Esc>[?2004h")
  let &t_EI .= WrapForTmux("\<Esc>[?2004l")

  function! XTermPasteBegin(ret)
    set pastetoggle=<Esc>[201~
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  " ノーマルモードはオフする
  "noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  "cnoremap <special> <Esc>[200~ <nop>
  "cnoremap <special> <Esc>[201~ <nop>
endif


" ======== 強制保存 ======== "
" w!!でスーパーユーザとして保存
"cmap w!! w !sudo tee > /dev/null %


" ======== Mouse Setting ======== "
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=""
  " For screen.
  if &term =~ "^screen"
      augroup MyAutoCmd
          autocmd! MyAutoCmd
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
"          Plugin Settings                                     "
"--------------------------------------------------------------"
" ======== neocomplete ======== "
if s:meet_neocomplete_requirements()
    " 新しく追加した neocomplete の設定
    ""Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      "return neocomplete#close_popup() . "\<CR>"
      " For no inserting <CR> key.
      return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

    " For cursor moving in insert mode(Not recommended)
    "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
    "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
    "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
    "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
    " Or set this.
    "let g:neocomplete#enable_cursor_hold_i = 1
    " Or set this.
    "let g:neocomplete#enable_insert_char_pre = 1

    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1

    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
    "
else

" ======== neocomplcache ======== "
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_max_list = 30
    let g:neocomplcache_auto_completion_start_length = 2
    let g:neocomplcache_enable_smart_case = 1

endif

" ======== unite ======== "
let s:bundle = neobundle#get('unite.vim')
function! s:bundle.hooks.on_post_source(bundle)
let g:unite_enable_start_insert=1
let g:unite_source_file_mru_limit = 200
endfunction
unlet s:bundle

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

" ======== clang ======== "
let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++1z -stdlib=libc++ --pedantic-errors'

" ======== quickrun ======== "
set splitbelow "新しいウィンドウを下に開く

let g:quickrun_config={'*': {'split': ''}}
let g:quickrun_config._={ 'runner':'vimproc',
\       "runner/vimproc/updatetime" : 10,
\       "outputter/buffer/close_on_empty" : 1,
\ }

" ======== im_control.vim ======== "
" 「日本語入力固定モード」切替キー
inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
" PythonによるIBus制御指定
let IM_CtrlIBusPython = 1

" <ESC>押下後のIM切替開始までの反応が遅い場合はttimeoutlenを短く設定してみてください。
set timeout timeoutlen=3000 ttimeoutlen=10

" ======== Vimfiler ======== "
let s:bundle = neobundle#get('vimfiler')
function! s:bundle.hooks.on_post_source(bundle)
let g:vimfiler_as_default_explorer = 1
endfunction
unlet s:bundle

" ======== vim-quickhl ======== "
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

nmap <Space>j <Plug>(quickhl-cword-toggle)
nmap <Space>] <Plug>(quickhl-tag-toggle)
map H <Plug>(operator-quickhl-manual-this-motion)

" ======== vim-expand-region ======== "
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" ======== vim-easy-align ======== "
let s:bundle = neobundle#get('vim-easy-align')
function! s:bundle.hooks.on_post_source(bundle)
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
endfunction
unlet s:bundle

" ======== The-NERD-Commenter ======== "
let NERDSpaceDelims = 1
let NERDShutUp = 1

" ======== vim-easymotion ======== "
" Disable default mappings
" If you are true vimmer, you should explicitly map keys by yourself.
" Do not rely on default bidings.
let g:EasyMotion_do_mapping = 0

" Or map prefix key at least(Default: <Leader><Leader>)
" map <Leader> <Plug>(easymotion-prefix)

" Jump to anywhere you want by just `4` or `3` key strokes without thinking!
" `s{char}{char}{target}`
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
" Of course, you can map to any key you want such as `<Space>`
" map <Space>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" `JK` Motions: Extend line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" keep cursor column with `JK` motions
let g:EasyMotion_startofline = 0

let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
" Show target key with upper case to improve readability
let g:EasyMotion_use_upper = 1
" Jump to first match with enter & space
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1

" Extend search motions with vital-over command line interface
" Incremental highlight of all the matches
" Now, you don't need to repetitively press `n` or `N` with EasyMotion feature
" `<Tab>` & `<S-Tab>` to scroll up/down a page with next match
" :h easymotion-command-line
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)

" 1 ストローク選択を優先する
let g:EasyMotion_grouping=1

" カラー設定変更
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade  ctermbg=none ctermfg=blue

" jamessan's
"set statusline=   " clear the statusline for when vimrc is reloaded
"set statusline+=%-3.3n\                      " buffer number
"set statusline+=%f\                          " file name
"set statusline+=%h%m%r%w                     " flags
"set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
"set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
"set statusline+=%{&fileformat}]              " file format
"set statusline+=%=                           " right align
"set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
"set statusline+=%b,0x%-8B\                   " current char
"set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset


" ======== lightline ======== "
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! MyModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! MyFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd! AutoSyntastic
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" ======== vim-trailing-whitespace ======== "
augroup TrailWhiteSpace
  autocmd! TrailWhiteSpace
  autocmd BufWritePre * :FixWhitespace
augroup END


