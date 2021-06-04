" Magic buffer-picking mode
nnoremap <Leader>b <Cmd>BufferPick<CR>
nnoremap <F4> <Cmd>BufferClose<CR>
nnoremap <C-X> <Cmd>BufferClose<CR>
nnoremap <S-F4> <Cmd>BufferClose<CR>
nnoremap <C-F4> <Cmd>BufferClose<CR>
" Move to previous/next
nnoremap <silent>    H :BufferPrevious<CR>
nnoremap <silent>    L :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <C-S-F2> :BufferMovePrevious<CR>
nnoremap <silent>    <C-S-F3> :BufferMoveNext<CR>
nnoremap <silent>    @ :BufferMovePrevious<CR>
nnoremap <silent>    # :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <Space>1 <Cmd>BufferGoto 1<CR>
nnoremap <Space>2 <Cmd>BufferGoto 2<CR>
nnoremap <Space>3 <Cmd>BufferGoto 3<CR>
nnoremap <Space>4 <Cmd>BufferGoto 4<CR>
nnoremap <Space>5 <Cmd>BufferGoto 5<CR>
nnoremap <Space>6 <Cmd>BufferGoto 6<CR>
nnoremap <Space>7 <Cmd>BufferGoto 7<CR>
nnoremap <Space>8 <Cmd>BufferGoto 8<CR>
nnoremap <Space>9 <Cmd>BufferLast<CR>

if ! exists('bufferline')
  let bufferline = {}
endif
" Show a shadow over the editor in buffer-pick mode
let bufferline.shadow = v:true
" Enable/disable animations
let bufferline.animation = v:true
" Enable/disable icons
let bufferline.icons = 'both'
" let bufferline.icons = v:true
" Enable/disable close button
let bufferline.closable = v:false
" Enables/disable clickable tabs
"  - left-click: go to buffer
"  - middle-click: delete buffer
let bufferline.clickable = v:false
" If set, the letters for each buffer in buffer-pick mode will be
" assigned based on their name. Otherwise or in case all letters are
" already assigned, the behavior is to assign letters in order of
" usability (see order below)
let bufferline.semantic_letters = v:true
" Sets the maximum padding width with which to surround each tab
let bufferline.maximum_padding = 0

" romgrk/doom-one.vim
highlight BufferCurrent guifg=#E6E6E6 guibg=#282c34
highlight BufferCurrentIndex guifg=#E6E6E6 guibg=#282c34
highlight BufferCurrentMod guifg=#ECBE7B guibg=#282c34
highlight BufferCurrentSign guifg=#51afef guibg=#282c34
highlight BufferCurrentTarget gui=bold guifg=#ff6c6b guibg=#282c34
" highlight BufferVisible guifg=#E6E6E6 guibg=#282c34
highlight BufferVisible guifg=#73797e guibg=#282c34
highlight BufferVisibleIndex guifg=#73797e guibg=#282c34
highlight BufferVisibleMod guifg=#ECBE7B guibg=#282c34
highlight BufferVisibleSign guifg=#3f444a guibg=#282c34
highlight BufferVisibleTarget gui=bold guifg=#ff6c6b guibg=#282c34
highlight BufferInactive guifg=#73797e guibg=#1c1f24
highlight BufferInactiveIndex guifg=#73797e guibg=#1c1f24
highlight BufferInactiveMod guifg=#ECBE7B guibg=#1c1f24
highlight BufferInactiveSign guifg=#3f444a guibg=#1c1f24
highlight BufferInactiveTarget gui=bold guifg=#ff6c6b guibg=#1c1f24
highlight BufferTabpages gui=bold guifg=#51afef guibg=#3E4556
highlight BufferTabpageFill gui=bold guifg=#3f444a guibg=#1c1f24

augroup vimrc_barbar
  autocmd!
  autocmd TermOpen * setlocal nobuflisted
  autocmd FileType qf setlocal nobuflisted
augroup END
