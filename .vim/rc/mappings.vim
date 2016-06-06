
"==============================================================
"          Key mapping                                      {{{
"==============================================================

" 表示行単位で移動
noremap j gj
noremap k gk
vnoremap j gj
vnoremap k gk

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

" ハイライト消す
nnoremap <silent> gh :nohlsearch<CR>

"noremap  <Del>

" コピー
nnoremap Y y$

" インクリメント設定
noremap + <C-a>
noremap - <C-x>

vnoremap ,y "+y
vnoremap ,d "+d
nnoremap ,p "+p
nnoremap ,P "+P
vnoremap ,p "+p
vnoremap ,P "+P

" xはレジスタに登録しない
nnoremap x "_x

if &term =~ "screen*"
  set <C-Left>=[1;5D
  set <C-Right>=[1;5C
  " noremap <Esc>[1;5D <C-Left>
  " noremap <Esc>[1;5C <C-Right>
  " noremap! <Esc>[1;5D <C-Left>
  " noremap! <Esc>[1;5C <C-Right>
endif

" Enable metakey
"execute "set <M-p>=\ep"
"execute "set <M-n>=\en"

" move changes
nnoremap <F3> g;zz
nnoremap <F4> g,zz

" refresh
nnoremap <F5> <C-l>

" move tab
" nnoremap <F6> gt
" nnoremap <F7> gT

" move buffer
nnoremap <F10> :bprev<CR>
nnoremap <F11> :bnext<CR>

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

" change paragraph
"nnoremap (  {zz
"nnoremap )  }zz
"nnoremap ]] ]]zz
"nnoremap [[ [[zz
"nnoremap [] []zz
"nnoremap ][ ][zz

" For replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

" Use <C-l> to clear the highlighting of :set hlsearch.
if maparg('<C-l>', 'n') ==# ''
  nnoremap <silent> <C-l> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Undoable<C-w> <C-u>
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>

" Change current directory
nnoremap ,cd :lcd %:p:h<CR>:pwd<CR>

" Delete buffer
nnoremap ,bd :bdelete<CR>

" Delete all marks
nnoremap ,md :delmarks!<CR>

" Change encoding
nnoremap ,eu :e ++enc=utf-8<CR>
nnoremap ,es :e ++enc=cp932<CR>
nnoremap ,ee :e ++enc=euc-jp<CR>
nnoremap ,ej :e ++enc=iso-2022-jp<CR>

" tags jump
nnoremap <C-]> g<C-]>

" useful search
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

" Edit macro
nnoremap ,me  :<C-u><C-r><C-r>='let @'. v:register .' = '. string(
      \ getreg(v:register))<CR><C-f><left>

" indent
xnoremap <  <gv
xnoremap >  >gv

nnoremap [[ []%
nnoremap ]] ][][%

" }}}

