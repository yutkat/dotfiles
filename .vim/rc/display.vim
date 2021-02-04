
"==============================================================
"         Display Settings                                  {{{
"==============================================================

" ColorScheme
if has('syntax') && !exists('g:syntax_on')
  syntax enable " シンタックスカラーリングオン
endif
set t_Co=256
set background=dark

" true color support
let colorterm=$COLORTERM
if colorterm==?'truecolor' || colorterm==?'24bit' || colorterm==?'rxvt' || colorterm==?''
  if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
endif

" colorscheme pluginconfig -> colorscheme
set nocursorline


set display=lastline  " 長い行も一行で収まるように
set noshowmode
set showmatch         " 括弧の対応をハイライト
set matchtime=1       " 括弧の対を見つけるミリ秒数
set showcmd           " 入力中のコマンドを表示
set number            " 行番号表示
set relativenumber
set wrap              " 画面幅で折り返す
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
set foldmethod=manual
set foldlevel=1
set foldlevelstart=99
set foldcolumn=0

function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

" Cursor style
if has('nvim')
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
else
  " insert mode - line
  let &t_SI .= WrapForTmux("\<Esc>[5 q")
  " common - block
  let &t_EI .= WrapForTmux("\<Esc>[1 q")
  if (v:version == 704 && has('patch687')) || v:version >= 705
    " replace mode - underline
    let &t_SR .= WrapForTmux("\<Esc>[3 q")
  endif
endif

if exists('&cursorlineopt')
  set cursorlineopt=number
endif

" }}}

