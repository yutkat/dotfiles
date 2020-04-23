
"==============================================================
"          Key mapping                                      {{{
"==============================================================

" custom leader
noremap <SubLeader> <Nop>
map , <SubLeader>
nnoremap s <Nop>
xnoremap s <Nop>
noremap m <Nop>
noremap z <Nop>
noremap <C-g> <Nop>

" 表示行単位で移動
noremap <expr> j v:count ? 'j' : 'gj'
noremap <expr> k v:count ? 'k' : 'gk'
vnoremap <expr> j v:count ? 'j' : 'gj'
vnoremap <expr> k v:count ? 'k' : 'gk'

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h

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
cnoremap <C-e> <End>

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
nnoremap <silent> gh :nohlsearch<CR>

" コピー
nnoremap Y y$
vnoremap gy y`>

" paste
nnoremap ,p ]p

" インクリメント設定
noremap + <C-a>
noremap - <C-x>
nnoremap <C-a> <Nop>
nnoremap <C-x> <Nop>

vnoremap <SubLeader>y "+y
vnoremap <SubLeader>d "+d
nnoremap <SubLeader>p "+p
nnoremap <SubLeader>P "+P
vnoremap <SubLeader>p "+p
vnoremap <SubLeader>P "+P

" x,dはレジスタに登録しない
noremap x "_x
nnoremap <SubLeader>d "_d
nnoremap <SubLeader>D "_D

" move changes
nnoremap <C-F2> g;zz
nnoremap <C-F3> g,zz

" refresh Use <F5> to clear the highlighting of :set hlsearch.
if maparg('<F5>', 'n') ==# ''
  nnoremap <silent> <F5> :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-l>
endif

" move tab
" nnoremap <S-F2> gT
" nnoremap <S-F3> gt

" move buffer
nnoremap <F2> :bprev<CR>
nnoremap <F3> :bnext<CR>
nnoremap <C-S-Left> :bprev<CR>
nnoremap <C-S-Right> :bnext<CR>

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

" switch quickfix/location list
nnoremap <SubLeader>q   :copen<CR>
nnoremap <SubLeader>l   :lopen<CR>

" Go to tab by number
nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 6gt
nnoremap <Leader>7 7gt
nnoremap <Leader>8 8gt
nnoremap <Leader>9 9gt
nnoremap <Leader>0 :tablast<CR>

" Tab move(alt-left/right)
nnoremap <silent> <S-PageUp> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <S-PageDown> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" change paragraph
"nnoremap (  {zz
"nnoremap )  }zz
"nnoremap ]] ]]zz
"nnoremap [[ [[zz
"nnoremap [] []zz
"nnoremap ][ ][zz

" For search
nnoremap gV/ /\v
noremap * g*N
noremap # g#n
noremap g* *N
noremap g# #n
vnoremap * y/<C-R>"<CR>N
vnoremap z/ <ESC>/\%V
vnoremap z? <ESC>?\%V

" For replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
nnoremap gR gD:%s/<C-R>///gc<left><left><left>
nnoremap <SubLeader>s :%s/\<<C-r><C-w>\>/
vnoremap <SubLeader>s :s/\%V

" Undoable<C-w> <C-u>
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>

" Change current directory
nnoremap <SubLeader>cd :lcd %:p:h<CR>:pwd<CR>

" Delete buffer
nnoremap <SubLeader>bd :bdelete<CR>
nnoremap <S-F4> :edit #<CR>

" Delete all marks
nnoremap <SubLeader>md :delmarks!<CR>

" Change encoding
nnoremap <SubLeader>eu :e ++enc=utf-8<CR>
nnoremap <SubLeader>es :e ++enc=cp932<CR>
nnoremap <SubLeader>ee :e ++enc=euc-jp<CR>
nnoremap <SubLeader>ej :e ++enc=iso-2022-jp<CR>

" tags jump
nnoremap <C-]> g<C-]>

" split goto
nnoremap -gf :split<Esc>gf
nnoremap <Bar>gf :vsplit<Esc>gf
nnoremap -<C-]> :split<Esc>g<C-]>
nnoremap <Bar><C-]> :vsplit<Esc>g<C-]>

" useful search
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
cnoremap <C-s> <HOME><Bslash><lt><END><Bslash>><CR>

" Edit macro
nnoremap <SubLeader>me  :<C-u><C-r><C-r>='let @'. v:register .' = '. string(
      \ getreg(v:register))<CR><C-f><left>

" indent
xnoremap <  <gv
xnoremap >  >gv

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
nnoremap ZO zO
nnoremap Zc zc
nnoremap ZC zc
nnoremap ZR zR
nnoremap ZM zM
nnoremap Za za
nnoremap ZA zA
nnoremap Z<Space> zMzvzz

" }}}

