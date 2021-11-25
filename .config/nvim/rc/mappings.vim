"==============================================================
"          Key mapping
"==============================================================

"-------------------------------------------------------------------------------------------------+
" Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator | Terminal | Lang-Arg |
" ================================================================================================+
" map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |    -     |    -     |
" nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |    -     |    -     |
" map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    -     |
" imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |    -     |    -     |
" cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |    -     |    -     |
" vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |    -     |    -     |
" xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |    -     |    -     |
" smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |    -     |    -     |
" omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |    -     |    -     |
" tmap / tnoremap  |    -   |   -    |    -    |   -    |   -    |    -     |    @     |    -     |
" lmap / lnoremap  |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    @     |
"-------------------------------------------------------------------------------------------------+

" custom leader
noremap <SubLeader> <Nop>
map , <SubLeader>
"<coc>
noremap ; <Nop>
"sandwich & <spector>
nnoremap s <Nop>
xnoremap s <Nop>
nnoremap S <Nop>
xnoremap S <Nop>
"<make>
noremap m <Nop>
"<fuzzy-finder>
nnoremap z <Nop>
" harpoon
nnoremap ' <Nop>
" switch buffer
nnoremap H <Nop>
nnoremap L <Nop>
" columnmove. use gJ
nnoremap J <Nop>
nnoremap K <Nop>
" coc
nnoremap M <Nop>
" clever-f
nnoremap t <Nop>
nnoremap T <Nop>
" not use
nnoremap Q <Nop>
" not use. use :10 or gG or GG
nnoremap G <Nop>
nmap    G <git>
" not use, use CC
nnoremap C <Nop>
" not use, use DD
nnoremap D <Nop>
" not use, use YY
nnoremap Y <Nop>
" multicursor, use RR
nnoremap R <Nop>
" close
nnoremap X <Nop>
" operator-replace
nnoremap U <Nop>
"<fuzzy-finder>
nnoremap Z <Nop>
" use 0
nnoremap ! <Nop>
" barbar
nnoremap @ <Nop>
nnoremap # <Nop>
" g; g,
nnoremap ^ <Nop>
nnoremap & <Nop>
" coc
nnoremap ? <Nop>
" not use
nnoremap ~ <Nop>
" <C-x>
nnoremap _ <Nop>
" not use
nnoremap = <Nop>
" milfeulle
nnoremap <C-a> <Nop>
noremap <C-g> <Nop>
" buffer close
nnoremap <C-x> <Nop>
" coc
nnoremap <C-s> <Nop>
" not use
nnoremap <C-q> <Nop>
" switch window
nnoremap <C-h> <Nop>
nnoremap <C-j> <Nop>
nnoremap <C-k> <Nop>
nnoremap <C-l> <Nop>
" not use
"nnoremap <C-c> <Nop>
" floaterm
nnoremap <C-z> <Nop>
" nnoremap <C-m> <Nop> " = <CR>
" noremap <CR> <Nop> " use quickfix
if exists('*reg_recording')
  nnoremap <expr> qq reg_recording() is# '' ? 'qq' : 'q'
  nnoremap q <Nop>
endif

nnoremap gh <Nop>
nnoremap gj <Nop>
nnoremap gk <Nop>
nnoremap gl <Nop>
nnoremap gn <Nop>
nnoremap gm <Nop>
nnoremap go <Nop>
nnoremap gq <Nop>
nnoremap gr <Nop>
nnoremap gs <Nop>
nnoremap gw <Nop>
nnoremap g^ <Nop>
nnoremap g? <Nop>
nnoremap gQ <Nop>
nnoremap gR <Nop>
nnoremap gT <Nop>

" remap
nnoremap gK K
nnoremap g~ ~
nnoremap g@ @
nnoremap g= =
nnoremap gzz zz
nnoremap g? ?
nnoremap gG G
nnoremap GG G
noremap gJ J
nnoremap X <Cmd>close<CR>

" move cursor
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
xnoremap <expr> j v:count ? 'j' : 'gj'
xnoremap <expr> k v:count ? 'k' : 'gk'

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-s> <C-w>p

" Focus floating window with <C-w><C-w>
function! s:focus_floating() abort
  if !empty(nvim_win_get_config(win_getid()).relative)
    wincmd p
    return
  endif
  for winnr in range(1, winnr('$'))
    let winid = win_getid(winnr)
    let conf = nvim_win_get_config(winid)
    if conf.focusable && !empty(conf.relative)
      call win_gotoid(winid)
      return
    endif
  endfor
endfunction
nnoremap <silent> <C-w><C-w> :<C-u>call <SID>focus_floating()<CR>

" jump cursor
"nnoremap <silent> <expr> <Tab> v:count ? '0<Bar>' : '10l'
"nnoremap <silent> <expr> <CR>  &buftype ==# 'quickfix' ? "\<CR>" : v:count ? '0jzz' : '10jzz'

" Automatically indent with i and A made by ycino
nnoremap <expr> i len(getline('.')) ? "i" : '"_cc'
nnoremap <expr> A len(getline('.')) ? "A" : '"_cc'

" toggle 0, ^ made by ycino
nnoremap <silent> <expr> 0 getline('.')[0 : col('.') - 2] =~# '^\s\+$' ? '0' : '^'
"nnoremap <silent> <expr> $ getline('.')[col('.') : -1] =~# '^\s\+$' ? '$' : 'g_'

" high-functioning undo
" nnoremap u g-
" nnoremap <C-r> g+

" undo behavior
inoremap <BS> <C-g>u<BS>
inoremap <CR> <C-g>u<CR>
inoremap <DEL> <C-g>u<DEL>
inoremap <C-w> <C-g>u<C-w>

" Emacs style
cnoremap <C-a> <Home>
if !exists('g:vscode')
  cnoremap <C-e> <End>
endif
cnoremap <C-f> <right>
cnoremap <C-b> <left>
inoremap <C-d> <Del>
"inoremap <C-h> <BS>
inoremap <C-s> <BS>
inoremap <C-a> <home>
inoremap <C-e> <End>
inoremap <C-f> <right>
inoremap <C-b> <left>

inoremap <C-h> <left>
inoremap <C-l> <right>
inoremap <C-k> <up>
inoremap <C-j> <Down>

" remap join
" nnoremap U J

" remap H M L
nnoremap gH H
nnoremap gM M
nnoremap gL L

" function key
imap <F1>  <Esc><F1>
imap <F2>  <Esc><F2>
imap <F3>  <Esc><F3>
imap <F4>  <Esc><F4>
imap <F5>  <Esc><F5>
imap <F6>  <Esc><F6>
imap <F7>  <Esc><F7>
imap <F8>  <Esc><F8>
imap <F9>  <Esc><F9>
imap <F10> <Esc><F10>
imap <F11> <Esc><F11>
imap <F12> <Esc><F12>
cmap <F1>  <Esc><F1>
cmap <F2>  <Esc><F2>
cmap <F3>  <Esc><F3>
cmap <F4>  <Esc><F4>
cmap <F5>  <Esc><F5>
cmap <F6>  <Esc><F6>
cmap <F7>  <Esc><F7>
cmap <F8>  <Esc><F8>
cmap <F9>  <Esc><F9>
cmap <F10> <Esc><F10>
cmap <F11> <Esc><F11>
cmap <F12> <Esc><F12>

map <F13> <S-F1>
map <F14> <S-F2>
map <F15> <S-F3>
map <F16> <S-F4>
map <F17> <S-F5>
map <F18> <S-F6>
map <F19> <S-F7>
map <F20> <S-F8>
map <F21> <S-F9>
map <F22> <S-F10>
map <F23> <S-F11>
map <F24> <S-F12>
map <F25> <C-F1>
map <F26> <C-F2>
map <F27> <C-F3>
map <F28> <C-F4>
map <F29> <C-F5>
map <F30> <C-F6>
map <F31> <C-F7>
map <F32> <C-F8>
map <F33> <C-F9>
map <F34> <C-F10>
map <F35> <C-F11>
map <F36> <C-F12>
map <F37> <C-S-F1>

" ハイライト消す
nnoremap gq <Cmd>nohlsearch<CR>

" mode
nnoremap RR R

" yank
nnoremap d<Space> diw
nnoremap c<Space> ciw
nnoremap y<Space> yiw
nnoremap CC C
nnoremap DD D
nnoremap YY y$
xnoremap gy y`>
nnoremap <LocalLeader>y "+y
nnoremap <LocalLeader>d "+d
xnoremap <LocalLeader>y "+y
xnoremap <LocalLeader>d "+d
" lambdalisue's yank for slack
function! s:yank_without_indent() abort
  normal! gvy
  let content = getreg(v:register, 1, v:true)
  let leading = min(map(copy(content), { _, v -> len(matchstr(v, '^\s*')) }))
  call map(content, { _, v -> v[leading:] })
  call setreg(v:register, content, getregtype(v:register))
endfunction
xnoremap <SubLeader>y <Esc>:<C-u>call <SID>yank_without_indent()<CR>

" paste
nnoremap p ]p
xnoremap p ]p
nnoremap gp p
xnoremap gp p
nnoremap gP P
xnoremap gP P
nnoremap <LocalLeader>p "+p
nnoremap <LocalLeader>P "+P
xnoremap <LocalLeader>p "+p
xnoremap <LocalLeader>P "+P

" x,dはレジスタに登録しない
noremap x "_x
nnoremap <SubLeader>d "_d
nnoremap <SubLeader>D "_D

" インクリメント設定
noremap + <C-a>
noremap _ <C-x>

" move changes
nnoremap <C-F2> g;zz
nnoremap <C-F3> g,zz
nnoremap ^ g;zz
nnoremap & g,zz

" refresh Use <F5> to clear the highlighting of :set hlsearch.
if maparg('<F5>', 'n') ==# ''
  nnoremap <F5> :<C-u>nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-l>
endif
nnoremap <Esc> <Cmd>nohlsearch<CR><C-L><Esc>

" move buffer
nnoremap <F2> <Cmd>if vimrc#is_normal_buffer() <Bar> execute "bprev" <Bar> endif <CR>
nnoremap <F3> <Cmd>if vimrc#is_normal_buffer() <Bar> execute "bnext" <Bar> endif <CR>
nnoremap H <Cmd>if vimrc#is_normal_buffer() <Bar> execute "bprev" <Bar> endif <CR>
nnoremap L <Cmd>if vimrc#is_normal_buffer() <Bar> execute "bnext" <Bar> endif <CR>
nnoremap <C-S-Left> <Cmd>if vimrc#is_normal_buffer() <Bar> execute "bprev" <Bar> endif <CR>
nnoremap <C-S-Right>:<Cmd>if vimrc#is_normal_buffer() <Bar> execute "bnext" <Bar> endif <CR>

nnoremap [q           :cprevious<CR>
nnoremap ]q           :cnext<CR>
nnoremap [Q           :cfirst<CR>
nnoremap ]Q           :clast<CR>
nnoremap [l           :lprevious<CR>
nnoremap ]l           :lnext<CR>
nnoremap [L           :lfirst<CR>
nnoremap ]L           :llast<CR>
nnoremap [b           :bprevious<CR>
nnoremap ]b           :bnext<CR>
nnoremap [B           :bfirst<CR>
nnoremap ]B           :blast<CR>
nnoremap [t           :tabprevious<CR>
nnoremap ]t           :tabnext<CR>
nnoremap [T           :tabfirst<CR>
nnoremap ]T           :tablast<CR>
nnoremap [;           g;zz
nnoremap ];           g,zz

" switch quickfix/location list
nnoremap <SubLeader>q   <Cmd>copen<CR>
nnoremap <SubLeader>l   <Cmd>lopen<CR>

" Tab
nnoremap g<C-x> <Cmd>tabclose<CR>

" Go to tab by number
"nnoremap <Leader>1 1gt
"nnoremap <Leader>2 2gt
"nnoremap <Leader>3 3gt
"nnoremap <Leader>4 4gt
"nnoremap <Leader>5 5gt
"nnoremap <Leader>6 6gt
"nnoremap <Leader>7 7gt
"nnoremap <Leader>8 8gt
"nnoremap <Leader>9 9gt
"nnoremap <Leader>0 :tablast<CR>

" Tab move(alt-left/right)
"nnoremap <S-PageUp> <Cmd>execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
"nnoremap <S-PageDown> <Cmd>execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" move tab
"nnoremap <S-F2> gT
"nnoremap <S-F3> gt

" change paragraph
"nnoremap (  {zz
"nnoremap )  }zz
"nnoremap ]] ]]zz
"nnoremap [[ [[zz
"nnoremap [] []zz
"nnoremap ][ ][zz

" For search
nnoremap g/ /\v
noremap * g*N
" noremap # g#n
noremap g* *N
noremap g# #n
xnoremap * y/<C-R>"<CR>N
xnoremap / <ESC>/\%V
xnoremap ? <ESC>?\%V

" For replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
nnoremap gR gD:%s/<C-R>///gc<left><left><left>
nnoremap <SubLeader>s :%s/\<<C-r><C-w>\>/
xnoremap <SubLeader>s :s/\%V

" Undoable<C-w> <C-u>
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>
inoremap <Space> <C-g>u<Space>

" Change current directory
nnoremap <SubLeader>cd <Cmd>lcd %:p:h<CR>:pwd<CR>

" Delete buffer
nnoremap <SubLeader>bd <Cmd>bdelete<CR>
nnoremap <C-x> <Cmd>bdelete<CR>
nnoremap <S-F4> <Cmd>edit #<CR>

" Delete all marks
nnoremap <SubLeader>md <Cmd>delmarks!<CR>

" Change encoding
nnoremap <SubLeader>eu <Cmd>e ++enc=utf-8<CR>
nnoremap <SubLeader>es <Cmd>e ++enc=cp932<CR>
nnoremap <SubLeader>ee <Cmd>e ++enc=euc-jp<CR>
nnoremap <SubLeader>ej <Cmd>e ++enc=iso-2022-jp<CR>

" tags jump
nnoremap <C-]> g<C-]>

" goto
nnoremap gf gF
nnoremap <C-w>f <C-w>F
nnoremap <C-w>gf <C-w>F
nnoremap <C-w><C-f> <C-w>F
nnoremap <C-w>g<C-f> <C-w>F

" split goto
nnoremap -gf        <Cmd>split<CR>gF
nnoremap <Bar>gf    <Cmd>vsplit<CR>gF
nnoremap -<C-]>     <Cmd>split<CR>g<C-]>
nnoremap <Bar><C-]> <Cmd>vsplit<CR>g<C-]>

"split
nnoremap -     <Cmd>split<CR>
nnoremap <Bar> <Cmd>vsplit<CR>
nnoremap --    <Cmd>split<CR>
nnoremap <Bar><Bar> <Cmd>vsplit<CR>

" useful search
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
cnoremap <C-s> <HOME><Bslash><lt><END><Bslash>>
cnoremap <C-d> <HOME><Del><Del><END><BS><BS>

" Edit macro
nnoremap <SubLeader>me  <Cmd><C-r><C-r>='let @'. v:register .' = '. string(
      \ getreg(v:register))<CR><C-f><left>

" indent
xnoremap <  <gv
xnoremap >  >gv

nnoremap ( {
nnoremap ) }
nnoremap [[ [m
nnoremap ]] ]m

" expand path
cmap <C-x> <C-r>=expand('%:p:h')<CR>/
" expand file (not ext)
cmap <C-z> <C-r>=expand('%:p:r')<CR>

" completion
inoremap <expr><CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr><Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr><PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr><PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
inoremap <expr><TAB>      pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>    pumvisible() ? "\<C-p>" : "\<S-TAB>"

" fold
" nnoremap Zo zo " -> use l
nnoremap gzO zO
nnoremap gzc zc
nnoremap gzC zc
nnoremap gzR zR
nnoremap gzM zM
nnoremap gza za
nnoremap gzA zA
nnoremap gz<Space> zMzvzz

" command history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <Up>   <C-p>
cnoremap <Down> <C-n>

" quit
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" command window
execute "set cedit=\<C-c>"

" operator
onoremap <Space> iw
onoremap a" 2i"
onoremap a' 2i'
onoremap a` 2i`
" -> In double-quote, you can't delete with ]} and ])
onoremap { [{i{<Esc>
onoremap ( [(i(<Esc>
onoremap [ T[
onoremap < T<
nnoremap << <<
onoremap } ]}
onoremap ) ])
onoremap ] t]
onoremap > t>
nnoremap >> >>
onoremap " t"
onoremap ' t'
onoremap ` t`
onoremap _ t_
onoremap - t-

" from monaqa's vimrc
noremap <SubLeader>) ])
noremap <SubLeader>} ]}
xnoremap <SubLeader>] i]o``
xnoremap <SubLeader>( i)``
xnoremap <SubLeader>{ i}``
xnoremap <SubLeader>[ i]``
nnoremap d<SubLeader>] vi]o``d
nnoremap d<SubLeader>( vi)``d
nnoremap d<SubLeader>{ vi}``d
nnoremap d<SubLeader>[ vi]``d
nnoremap c<SubLeader>] vi]o``c
nnoremap c<SubLeader>( vi)``c
nnoremap c<SubLeader>{ vi}``c
nnoremap c<SubLeader>[ vi]``c

" control code
inoremap <C-q> <C-r>=nr2char(0x)<Left>

xnoremap <silent> . :normal! .<CR>
xnoremap <silent> @ :<C-u>execute ":'<,'>normal! @" . nr2char(getchar())<CR>
